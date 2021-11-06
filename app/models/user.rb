class User < ApplicationRecord
    has_secure_password
    has_secure_token :confirmation_token
    
    validates :username, 
    format: {with: /\A[a-zA-Z0-9_]{2,20}\z/, message: 'ne doit contenir que des caractere alphanumerique ou des underscores'},
    uniqueness: {case_sensitive: false }

    validates :email, format: {with: /\A[^@\s]+@[^@\s]+\z/},
    uniqueness: {case_sensitive: false }
    
end
