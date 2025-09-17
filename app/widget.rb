class Widget
  attr_reader :code, :name, :price

  def initialize(code:, name:, price:)
    @code  = code
    @name  = name
    @price = price.to_f
  end
end
