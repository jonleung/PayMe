class Payment < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  
  after_save :send_sms
  
  attr_accessor :stripe_card_token
  
  def save_with_payment
      if valid?
        debugger
        charge = Stripe::Charge.create(amount: (amount*100).to_i, currency: "usd", card: stripe_card_token, description: "#{name}, #{email}")
        save!
      end
    rescue Stripe::InvalidRequestError => e
      logger.error "Stripe error while charging customer: #{e.message}"
      errors.add :base, "There was a problem with your credit card. Your credit card should not have been charged."
      false
  end
  
  def send_sms 

    TWILIO.account.sms.messages.create(
      :from => NUMBER_REGISTERED_WITH_TWILIO,
      :to => NUMBER_TO_RECEIVE_NOTIFICATIONS_ON,
      :body => "#{name} just paid you #{number_to_currency(amount)} Say thanks! #{email}"
    )
  end
  
end
