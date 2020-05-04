class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :messages, dependent: :destroy
         has_many :entries, dependent: :destroy
         has_many :teams, dependent: :destroy
         has_many :bookmarks, dependent: :destroy
         has_many :bookmark_teams, through: :bookmarks, source: :teams
end
