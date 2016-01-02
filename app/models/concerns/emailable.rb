module Emailable
    extend ActiveSupport::Concern

    def create_reset_digest
        # Reference Account Activations for reason
        # as to why two update_attribute calls
        # instead of single update_attributes call
        self.reset_token = User.new_token
        update_attribute(:reset_digest, User.digest(self.reset_token))
        update_attribute(:reset_sent_at, Time.zone.now)
    end

    def send_password_reset_email
        UserMailer.password_reset(self).deliver_now
    end

    def password_reset_expired?
        self.reset_sent_at < 2.hours.ago
    end

    def send_account_activation_email
        UserMailer.account_activation(self).deliver_now
    end

    private
        def create_activation_digest
            self.activation_token = User.new_token
            self.activation_digest = User.digest(self.activation_token)
        end
end
