module Delivery
  class Standard
    # Rules:
    # - Orders under $50 => $4.95
    # - Orders under $90 => $2.95
    # - Orders >= $90 => free
    def calculate(amount)
      amt = amount.to_f
      return 0.0  if amt >= 90.0
      return 2.95 if amt >= 50.0
      4.95
    end
  end
end
