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
  
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
