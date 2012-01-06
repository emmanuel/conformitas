require File.expand_path('../../spec_helper', File.dirname(__FILE__))
require 'conformitas'

describe Conformitas::InputController do
  let(:class_under_test) {
    Class.new do
      include Conformitas::InputController

      attribute :name,          String
      attribute :birthdate,     Date
      attribute :occupation,    String
    end
  }
  let(:attributes) { {
    'name'         => 'Spike Jonze',
    'birthdate'    => 'October 22, 1969',
    'occupation'   => 'Director, producer, actor',
  } }
  let(:updated_attributes) { {
    'name'       => 'Harrison Ford',
    'birthdate'  => 'July 13, 1942',
    'occupation' => 'Actor, producer',
  } }
  subject { class_under_test.new(attributes) }

  describe 'when bound to data' do
    it 'retains the originally provided values via #original_attributes' do
      assert_same attributes, subject.original_attributes
    end

    it 'silently ignores mass-assignment after initialization' do
      subject.attributes = updated_attributes

      assert_equal attributes['name'],                  subject.name
      assert_equal Date.parse(attributes['birthdate']), subject.birthdate
      assert_equal attributes['occupation'],            subject.occupation
    end
  end

  describe 'when not bound to data' do
    let(:attributes) { {} }

    it 'retains the originally provided values via #original_attributes' do
      assert_equal Hash.new, subject.original_attributes
    end

    it 'silently ignores mass-assignment after initialization' do
      subject.attributes = updated_attributes

      assert_equal nil, subject.name
      assert_equal nil, subject.birthdate
      assert_equal nil, subject.occupation
    end
  end

  it 'sets all attribute instance writers to private' do
    assert_includes class_under_test.private_instance_methods, :name=
    assert_includes class_under_test.private_instance_methods, :birthdate=
    assert_includes class_under_test.private_instance_methods, :occupation=
  end

  it 'does not respond to attribute writer methods' do
    refute_operator class_under_test, :respond_to?, :name=
    refute_operator class_under_test, :respond_to?, :birthdate=
    refute_operator class_under_test, :respond_to?, :occupation=
  end

  it 'does not permit assignment after initialization' do
    assert_raises(NoMethodError) { subject.name       = updated_attributes['name'] }
    assert_raises(NoMethodError) { subject.birthdate  = updated_attributes['birthdate'] }
    assert_raises(NoMethodError) { subject.occupation = updated_attributes['occupation'] }
  end

end
