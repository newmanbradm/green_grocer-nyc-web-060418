def consolidate_cart(cart)
  cart_hash = {}
  
  cart.each do |item|
    item.each do |type, values|
      if cart_hash.include?(type)
        cart_hash[type][:count] += 1
      else
        cart_hash[type] = {}
        values.each do |key, value|
          cart_hash[type][key] = value
          cart_hash[type][:count] = 1
        end
      end
    end
  end
  cart_hash
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    name = coupon[:item]
    if cart[name] && cart[name][:count] >= coupon[:num]
      if cart["#{name} W/COUPON"]
        cart["#{name} W/COUPON"][:count] += 1
      else
        cart["#{name} W/COUPON"] = {:count => 1, :price => coupon[:cost]}
        cart["#{name} W/COUPON"][:clearance] = cart[name][:clearance]
      end
      cart[name][:count] -= coupon[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item_in_cart|
  	if item_in_cart[1][:clearance] == true
  		item_in_cart[1][:price] = item_in_cart[1][:price] - (item_in_cart[1][:price] * 0.2)
  	end
  end
  cart
end

def checkout(cart, coupons)
consolidated_cart = consolidate_cart(cart)
applied_coupons = apply_coupons(consolidated_cart, coupons)
final_cart = apply_clearance(applied_coupons)
final_cost = 0

 final_cart.each do |name, attributes|
  final_cost += attributes[:price] * attributes[:count]
  end
 	if final_cost > 100
 		final_cost = final_cost * 0.9
  end
 final_cost
end
