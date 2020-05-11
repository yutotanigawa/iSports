class TeamsController < ApplicationController

    def index
        @teams = Team.all
        @genre = Genre.all
            # パラメータとして都道府県を受け取っている場合は絞って検索する
            if params[:prefecture].present?
            @teams = @teams.get_by_prefecture(params[:prefecture])
            end
            if params[:frequency].present?
            @teams = @teams.get_by_frequency(params[:frequency])
            end
            if params[:genre_id].present?
            @teams = @teams.get_by_genre_id(params[:genre_id])
            end
            if params[:day_of_week].present?
            @teams = @teams.get_by_day_of_week(params[:day_of_week])
            end
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
    end

    def update
    end

    def destroy
    end

    def bookmarks
        @teams = current_user.bookmark_teams
    end

    private
    def team_params
        params.require(:team).permit(:genre_id, :user_id, :name, :introduction,:team_image, :prefecture, :frequency, :publication_status, day_of_week:[])
    end
end
