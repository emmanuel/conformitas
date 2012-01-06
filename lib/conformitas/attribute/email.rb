module Conformitas
  module Attribute
    class Email < ::Virtus::Attribute::String
      accept_options :format

      format :email_address

    end
  end
end
