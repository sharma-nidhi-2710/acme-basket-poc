module Offers
  # "Buy one red widget, get the second half price"
  class RedWidgetHalfPrice
    RED_CODE = "R01"

    def apply(items, subtotal)
      red_widgets = items.select { |i| i.code == RED_CODE }
      return subtotal if red_widgets.empty?

      # price per red widget (assume all R01 same price)
      price = red_widgets.first.price
      pairs = red_widgets.count / 2
      # each pair gives half-price on second -> discount = price / 2 per pair
      discount = pairs * (price / 2.0)

      (subtotal - discount).round(2)
    end
  end
end
