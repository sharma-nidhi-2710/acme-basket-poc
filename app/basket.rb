require_relative "widget"
require_relative "services/offers/red_widget_half_price"
require_relative "services/delivery/standard"

class Basket
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
    widget = @widgets[code]
    @items << widget if widget
    self
  end

  def total
    subtotal = raw_subtotal
    discounted = @offers.reduce(subtotal) do |current_subtotal, offer|
      offer.apply(@items, current_subtotal)
    end

    charge = @delivery.calculate(discounted)
    total = discounted + charge
    total.round(2)
  end

  private

  def raw_subtotal
    @items.sum { |i| i.price.to_f }.round(2)
  end
end
