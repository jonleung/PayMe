stripe_testing = false

if stripe_testing == true
  #Test Secret Key
  Stripe.api_key = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  #Test Publishable Key
  STRIPE_PUBLIC_KEY = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
else
  #Live Secret Key
  Stripe.api_key = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  #Test Publishable Key
  STRIPE_PUBLIC_KEY = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"    
end
  



