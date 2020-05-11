class Admins::TeamsController < ApplicationController
    def index
        @teams = Team.all
        if params[:publication_status].present?
            @teams = @teams.get_by_publication_status(params[:publication_status])
        end
        if params[:genre_id].present?
            @teams = @teams.get_by_genre_id(params[:genre_id])
        end
        if params[:prefecture].present?
            @teams = @teams.get_by_prefecture(params[:prefecture])
        end
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
