require 'spec_helper'

require_relative '../app/basket'
require_relative '../app/widget'
require_relative '../app/services/offers/red_widget_half_price'
require_relative '../app/services/delivery/standard'

RSpec.describe Basket do
  let(:widgets) do
    {
      "R01" => Widget.new(code: "R01", name: "Red Widget", price: 32.95),
      "G01" => Widget.new(code: "G01", name: "Green Widget", price: 24.95),
      "B01" => Widget.new(code: "B01", name: "Blue Widget", price: 7.95)
    }
  end

  let(:offers)   { [Offers::RedWidgetHalfPrice.new] }
  let(:delivery) { Delivery::Standard.new }
  let(:basket)   { Basket.new(widgets: widgets, offers: offers, delivery: delivery) }

  context "adding widgets" do
    it "adds a widget by code" do
      basket.add("R01")
      expect(basket.instance_variable_get(:@items).map(&:code)).to eq(["R01"])
    end

    it "raises an error for invalid product codes" do
      expect { basket.add("X99") }.to raise_error(Basket::InvalidProductCodeError, "Unknown product code: X99")
    end

    it "raises an error if the product code is not a String" do
      expect { basket.add(123) }.to raise_error(ArgumentError, "Product code must be a String")
    end
  end

  context "totals with delivery and offers" do
    it "calculates total for B01, G01" do
      basket.add("B01")
      basket.add("G01")
      expect(basket.total.round(2)).to eq(37.85)
    end

    it "applies offer: R01, R01 → second half price" do
      basket.add("R01")
      basket.add("R01")
      expect(basket.total.round(2)).to eq(54.38)
    end

    it "calculates total for R01, G01" do
      basket.add("R01")
      basket.add("G01")
      expect(basket.total.round(2)).to eq(60.85)
    end

    it "calculates total for B01, B01, R01, R01, R01" do
      basket.add("B01")
      basket.add("B01")
      basket.add("R01")
      basket.add("R01")
      basket.add("R01")
      expect(basket.total.round(2)).to eq(98.28)
    end
  end
end
