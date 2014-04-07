require 'spec_helper'

describe Line do
  it { should have_many :stops }
  it { should have_many(:stations).through :stops }
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
end
