class Admins::HomesController < ApplicationController
    def top
        range = Date.today.beginning_of_day..Date.today.end_of_day
        @teams = Team.where(created_at: range)
        @users = User.where(created_at: range)
    end

end
