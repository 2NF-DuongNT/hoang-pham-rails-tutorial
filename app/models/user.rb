class User < ApplicationRecord
    attr_accessor :remember_token
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    enum genders: [ "Male", "Female", "N/A" ]

    validates :name, presence: true,length: {maximum: Settings.name_maximum}  #presence: true không được để trống
    validates :age, presence: true
    validate :age_limit
    validates :email, presence: true,length: {maximum: Settings.email_maximum},
        format: { with: VALID_EMAIL_REGEX },
        #uniqueness: {case_sensitive: false} #khong phan biet chu hoa va chu thuong
        uniqueness: true
    validates :password, length: {minimum: Settings.password_minimum}
    has_secure_password
    
    before_save :downcase_email
    
    private

        def age_limit
            if self.age
                age = Date.today.year - self.age.year
                if(age>100 || age<18)
                    errors.add :age, "must be between 18 and 100"
                end
            end
        end

        def downcase_email
            self.email.downcase
        end

    public

        def User.digest(string)
            cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                        BCrypt::Engine.cost
            BCrypt::Password.create(string, cost: cost)
        end
            
        #return random token
        def User.new_token
            SecureRandom.urlsafe_base64
        end

        def remember
            self.remember_token = User.new_token
            update_attribute(:remember_digest, User.digest(remember_token))
        end

        def authenticated?(remember_token)
            return false if remember_digest.nil?
            BCrypt::Password.new(remember_digest).is_password?(remember_token)
        end

        def forget
            update_attribute(:remember_digest, nil)
        end

end
