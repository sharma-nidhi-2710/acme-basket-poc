# acme-basket-poc

This is a proof-of-concept implementation of a shopping basket for **Acme Widget Co**, built in **Ruby** with **RSpec**.  
It demonstrates clean object-oriented design, separation of concerns, and extensibility for future offers and delivery rules.  

---

## Features  
- Add widgets to a basket using product codes.  
- Apply delivery charges based on basket total.  
- Support for offers (e.g. *Buy one Red Widget, get the second half price*).  
- Easily extendable with new products, offers, and delivery rules.  
- Fully tested with **RSpec**.  

---

## How to Run  

### Clone the repo  
```bash
git clone https://github.com/<your-username>/acme-widgets-basket.git
cd acme-widgets-basket
```
### Install dependencies
```bash
bundle install
```
### Run the tests
```bash
rspec
```
---
## Assumptions

- Offers apply *before* delivery charges are calculated.
- Only one offer is supported currently: Buy one Red Widget, second at half price.
- For odd number of red widgets, the discount applies only to (count / 2).
- Product codes passed must be strings, invalid codes raise an error.
- Delivery rules:
   - < $50 → $4.95
   - ≥ $50 and < $90 → $2.95
   - ≥ $90 → free
- Empty basket has total of `$0.00` (or whatever behavior you define).
---
## Example Usage

```ruby

# 1. Setup: define catalog, offers, delivery rule
widgets = {
  "R01" => Widget.new(code: "R01", name: "Red Widget",   price: 32.95),
  "G01" => Widget.new(code: "G01", name: "Green Widget", price: 24.95),
  "B01" => Widget.new(code: "B01", name: "Blue Widget",  price: 7.95)
}

offers   = [Offers::RedWidgetHalfPrice.new]
delivery = Delivery::Standard.new

basket = Basket.new(widgets: widgets, offers: offers, delivery: delivery)

# 2. Add items and get total for simple case
basket.add("B01")
basket.add("G01")
puts "Basket: B01 + G01"
puts "Total: $#{basket.total}"   # => $37.85

# 3. Offer case: two red widgets
basket = Basket.new(widgets: widgets, offers: offers, delivery: delivery)
basket.add("R01")
basket.add("R01")
puts "\nBasket: R01 + R01"
puts "Total: $#{basket.total}"   # => $54.37

# 4. Mix of red + other widgets
basket = Basket.new(widgets: widgets, offers: offers, delivery: delivery)
basket.add("R01")
basket.add("G01")
puts "\nBasket: R01 + G01"
puts "Total: $#{basket.total}"   # => $60.85

# 5. More items, with offer + highest delivery threshold
basket = Basket.new(widgets: widgets, offers: offers, delivery: delivery)
basket.add("B01")
basket.add("B01")
basket.add("R01")
basket.add("R01")
basket.add("R01")
puts "\nBasket: B01, B01, R01, R01, R01"
puts "Total: $#{basket.total}"   # => $98.27

# 6. Edge case: invalid product code
basket = Basket.new(widgets: widgets, offers: offers, delivery: delivery)
basket.add("X99")

# Traceback (most recent call last):
#        2: from (irb):2
#        1: from app/basket.rb:20:in `add'
# Basket::InvalidProductCodeError (Unknown product code: X99)
```
