class Contact include ActiveModel::Model
    attr_accessor :name, :email, :body
    validates :name, presence: true, length: { maximum: 20 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 30 },
                    format: { with: VALID_EMAIL_REGEX }
    validates :body, presence: true, length: { maximum: 200 }
end
