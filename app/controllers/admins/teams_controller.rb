class Admins::TeamsController < ApplicationController
    def index
        @teams = Team.all
    end

    def show
        @team = Team.find(params[:id])
    end

    def update
        @team = Team.find(params[:id])
        @team.update(team_params)
        redirect_to admins_team_path(@team)
    end

    def destroy
        @team = Team.find(params[:id])
        @team.destroy
        redirect_to admins_team_path
    end

    private
    def team_params
        params.require(:team).permit(:publication_status)
    end
end
