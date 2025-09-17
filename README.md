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
