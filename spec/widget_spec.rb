require 'rspec'
require_relative '../app/widget'

RSpec.describe Widget do
  let(:red)   { Widget.new(code: "R01", name: "Red Widget", price: 32.95) }
  let(:green) { Widget.new(code: "G01", name: "Green Widget", price: 24.95) }
  let(:blue)  { Widget.new(code: "B01", name: "Blue Widget", price: 7.95) }

  it "initializes with code, name, and price" do
    expect(red.code).to eq("R01")
    expect(red.name).to eq("Red Widget")
    expect(red.price).to eq(32.95)
  end

  it "creates different widgets with different attributes" do
    expect(green.code).to eq("G01")
    expect(green.name).to eq("Green Widget")
    expect(green.price).to eq(24.95)

    expect(blue.code).to eq("B01")
    expect(blue.name).to eq("Blue Widget")
    expect(blue.price).to eq(7.95)
  end
end
