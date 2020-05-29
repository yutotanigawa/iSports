class DayOfWeek < ApplicationRecord
    has_many :activation_days
    has_many :teams, through: :activation_days
end
