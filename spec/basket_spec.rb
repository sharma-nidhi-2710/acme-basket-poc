require 'spec_helper'
require 'basket'

RSpec.describe Basket do
  it 'can be created' do
    expect(Basket.new).to be_a(Basket)
  end
end
