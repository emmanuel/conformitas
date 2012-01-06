require File.expand_path('../../../spec_helper', File.dirname(__FILE__))
require 'conformitas'

describe Conformitas::Attribute::Url do
  let(:class_under_test) do
    Class.new do
      include Conformitas::InputController

      attribute :url, Conformitas::Attribute::Url
    end
  end

  subject { class_under_test.new(attributes) }

  describe "when initialized with a value that doesn't look like an url" do
    let(:attributes) { { url: 'foo' } }

    it 'is invalid' do
      refute_predicate subject, :valid?
    end
  end

  describe "when initialized with a value that looks like an email address" do
    let(:attributes) { { url: 'foo@bar.com' } }

    it 'is invalid' do
      refute_predicate subject, :valid?
    end
  end

  describe "when initialized with a value that looks like an url" do
    describe 'with a standard TLD' do
      let(:attributes) { { url: 'http://www.domain.com' } }

      it 'is valid' do
        assert_predicate subject, :valid?
      end
    end

    describe 'with an ISO country code TLD' do
      let(:attributes) { { url: 'http://domain.me' } }

      it 'is valid' do
        assert_predicate subject, :valid?
      end
    end
  end
end
