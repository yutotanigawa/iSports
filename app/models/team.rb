class Team < ApplicationRecord
    belongs_to user
    belongs_to genre
    has_many :bookmarks, dependent: :destroy
    has_many :users, through: :favorites

    def bookmark_by?(user)
        bookmarks.where(user_id: user.id).exists?
    end
end
