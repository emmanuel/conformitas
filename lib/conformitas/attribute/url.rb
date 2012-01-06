module Conformitas
  module Attribute
    class Url < ::Virtus::Attribute::String
      accept_options :format

      format :url

    end # class Url
  end # module Attribute
end # module Conformitas
