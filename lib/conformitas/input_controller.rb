module Conformitas
  module InputController
    attr_reader :original_attributes

    class << self
      def included(base)
        base.class_eval do
          include Virtus
          include Aequitas
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
        # TODO: is there a way to instruct Virtus to always
        #   set attributes in initialize, but not afterward?
        attributes.to_hash.each { |name, value| attribute_set(name, value) }
        super
      end
    end

    module ClassMethods
      def attribute(name, type, options = {})
        options[:writer] = :private
        super
      end
    end
  end
end
