class Assassin < ActiveRecord::Base
	attr_accessor :remember_token
	before_save { self.email = email.downcase }
  	validates :name, presence: true, length: { maximum: 50 }
  	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  	validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  	has_secure_password
  	validates :password, presence: true, length: {minimum: 6 }

  	def Assassin.digest(string)
  		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    	BCrypt::Password.create(string, cost: cost)
  	end

  	# Returns a random token.
  	def Assassin.new_token
   		SecureRandom.urlsafe_base64
 	end

 	def remember
 		self.remember_token = Assassin.new_token
 		update_attribute(:remember_digest, Assassin.digest(remember_token))
 	end

 	def authenticated?(remember_token)
 		return false if remember_digest.nil?
 		BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    def forget
    	update_attribute(:remember_digest, nil)
    end
end
