class ActivationDay < ApplicationRecord
    belongs_to :team
    belongs_to :day_of_week
end
