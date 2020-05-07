class TeamsController < ApplicationController

    def index
        @teams = Team.all
    end

    def show
        @team = Team.find(params[:id])
    end

    def new
        @user = current_user
        @team = Team.new
    end

    def create
        @team = Team.new(team_params)
        @user = current_user
        @team.user_id = current_user.id
        @team.save
        redirect_to teams_path
    end

    def update
    end

    def destroy
    end

    def applications
    end

    private
    def team_params
        params.require(:team).permit(:genre_id, :user_id, :name, :introduction,:team_image, :prefecture, :frequency, :publication_status, day_of_week:[])
    end
end
