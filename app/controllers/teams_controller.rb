class TeamsController < ApplicationController
    before_action :authenticate_user!
    #before_action :day_of_week_string, only: [:create]

    def index
        teams = Team.where(publication_status: "permission").all.reverse_order
        @teams = teams.page(params[:page]).per(5)
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
            if params[:team].present?
                if params[:team][:day_of_week_ids].present?
                    weeks = params[:team][:day_of_week_ids]
                    # 中間テーブルの中から 同じteam_idでday_of_week_idが パラメーター通りのものを抽出し、weeksにおいて同数の条件をさらに抽出？。
                    matchAllWeeks = ActivationDay.where(day_of_week_id: weeks).group(:team_id).having('count(team_id) = ?', weeks.length)
                    # 配列で要素を取り出せるようにする
                    teamIds = matchAllWeeks.map(&:team_id)
                    @teams = @teams.where(id: teamIds)
                end
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
        if @team.save
        else
            render 'new'
        end
    end

    def update
    end

    def destroy
        @user = current_user
        @team = Team.find(params[:id])
        @team.destroy
        redirect_to user_path(@user)
    end

    def bookmarks
        teams = current_user.bookmark_teams
        @teams = teams.page(params[:page]).per(5)
    end

    private
    def team_params
        params.require(:team).permit(:genre_id, :user_id, :name, :introduction,:team_image, :prefecture, :frequency, :address, :latitude, :longitude, :publication_status, {day_of_week_ids: []})
    end

    # def day_of_week_string
    #     puts params[:team][:day_of_week]
    #     params[:team][:day_of_week] = params[:team][:day_of_week].join("/") # to string
    # end
end
