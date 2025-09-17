require_relative "widget"
require_relative "services/offers/red_widget_half_price"
require_relative "services/delivery/standard"
require_relative "../errors/invalid_product_code_error"

class Basket
  class InvalidProductCodeError < StandardError; end

  attr_reader :items, :widgets, :offers, :delivery

  # widgets: hash of code => Widget instance
  # offers: array of offer objects that respond to `apply(items, subtotal)`
  # delivery: delivery strategy that responds to `calculate(amount)`
  def initialize(widgets:, offers: [], delivery:)
    @widgets  = widgets
    @offers   = offers
    @delivery = delivery
    @items    = []
  end

  def add(code)
    raise ArgumentError, "Product code must be a String" unless code.is_a?(String)

    product = @widgets[code]
    raise InvalidProductCodeError, "Unknown product code: #{code}" unless product

    @items << product
  end

  def total
    subtotal   = raw_subtotal
    discounted = apply_offers(subtotal)
    delivery   = @delivery.calculate(discounted)
    (discounted + delivery).round(2)
  end

  private

  def raw_subtotal
    @items.sum { |i| i.price.to_f }.round(2)
  end

  def apply_offers(subtotal)
    @offers.reduce(subtotal) do |current_subtotal, offer|
      offer.apply(@items, current_subtotal)
    end
  end
end
