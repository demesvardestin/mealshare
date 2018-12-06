class MessageUpdate
   
    def self.alert_receiver(message, sender, receiver)
        twilio, twilio_phone = self.twilio
        message_header = "#{sender.first_name} has sent you a message on DinnerHost: \n\n"
        message_footer = "\n\nGo to dinnerhost.co/inbox to reply."
        twilio.messages.create(
            body: message_header + message.extended_content_snipet + message_footer,
            to: receiver.phone_number,
            from: twilio_phone
        )
    end
    
    def self.twilio
        twilio = self.initialize_twilio
        # twilio_phone = ENV["TWILIO_PHONE"]
        twilio_phone = "14758975257"
        return twilio, twilio_phone
    end
    
    def self.twilio_token
        ENV["TWILIO_TOKEN"]
    end
    
    def self.initialize_twilio
        # account_sid = ENV["TWILIO_SID"]
        account_sid = "AC2cda4ab0af4f648febfc6a78c7cffbff"
        # auth_token = ENV["TWILIO_TOKEN"]
        auth_token = "a2025ab98a508c234bf9f2511b583074"
        return Twilio::REST::Client.new account_sid, auth_token
    end
    
    def self.invite_chef(number, referrer)
        twilio, twilio_phone = self.twilio
        link = "http://senzzu-rx-demo07.c9users.io/referral?ref#{referrer.referral_code}"
        message = "#{referrer.first_name} has invited you to join DinnerHost! As a DinnerHost cook, you can get booked and paid to prepare your best dishes for customers near you. To get started, go to #{link}."
        twilio.messages.create(
            body: message,
            to: number,
            from: twilio_phone
        )
    end
    
    def self.credit_applied(referrer)
        twilio, twilio_phone = self.twilio
        name = referrer.first_name
        message = "Hi #{name}, a $20 credit has been applied to your DinnerHost account for future reservations! Explore more delicious listings at dinnerhost.co"
        twilio.messages.create(
            body: message,
            to: referrer.phone_number,
            from: twilio_phone
        )
    end
    
end