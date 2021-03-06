require 'virtus'
require 'aequitas/virtus_integration'

module Conformitas
  module InputController
    attr_reader :original_attributes

    class << self
      def included(base)
        super

        base.class_eval do
          include ::Virtus
          include ::Aequitas::VirtusIntegration
          # TODO: find a better way to override Virtus & Aequitas methods
          include InstanceMethods
          extend ClassMethods
        end
      end

      private :included
    end

    module InstanceMethods
      def initialize(attributes = {})
        @original_attributes = attributes
        # TODO: is there a better way to instruct Virtus to set
        #   attributes in initialize, but not afterward?
        attributes.to_hash.each do |name, value|
          attribute_set(name, value) if respond_to?("#{name}=", true)
        end
      end
    end # module InstanceMethods

    module ClassMethods
      def attribute(name, type, options = {})
        options[:writer] = :private
        super
      end
    end # module ClassMethods

  end # module InputController
end # module Conformitas
