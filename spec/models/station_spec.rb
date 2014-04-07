require 'spec_helper'

describe Station do
  it { should have_many :stops }
  it { should have_many(:lines).through :stops }
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
end
