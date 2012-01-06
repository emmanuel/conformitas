require File.expand_path('../../../spec_helper', File.dirname(__FILE__))
require 'conformitas'

describe Conformitas::Attribute::Email do
  let(:class_under_test) do
    Class.new do
      include Conformitas::InputController

      attribute :email, Conformitas::Attribute::Email
    end
  end

  subject { class_under_test.new(attributes) }

  describe "when initialized with a value that doesn't look like an email" do
    let(:attributes) { { email: 'foo' } }

    it 'is invalid' do
      refute_predicate subject, :valid?
    end
  end

  describe "when initialized with a value that looks like an email address" do
    describe 'with a standard TLD' do
      let(:attributes) { { email: 'foo@domain.com' } }

      it 'is valid' do
        assert_predicate subject, :valid?
      end
    end

    describe 'with a standard TLD' do
      let(:attributes) { { email: 'foo@domain.com' } }

      it 'is valid' do
        assert_predicate subject, :valid?
      end
    end
  end
end
