class UsersController < ApplicationController
    before_action :authenticate_user!

    def index
        users = User.where(valid_status: "active").all.reverse_order
        @users = users.page(params[:page]).per(5)

        # パラメータとして都道府県を受け取っている場合は絞って検索する
        if params[:prefecture].present?
        @users = @users.get_by_prefecture(params[:prefecture])
        end
        # パラメータとして性別を受け取っている場合は絞って検索する
        if params[:gender_status].present?
        @users = @users.get_by_gender_status(params[:gender_status])
        end

        if params[:min_age].present? && [:max_age].present?
            unless params[:min_age] == ""
                # 指定された年齢となる生年月日をyyyymmdd形式の文字列へと変換
                younger_birth_ymd = calc_younger_birthday(params[:min_age]).to_s
            else
                # 最小の年齢として0歳にした
                younger_birth_ymd = calc_min_birthday("0").to_s
            end
            unless params[:search_max_age] == ""
                older_birth_ymd = calc_older_birthday(params[:max_age]).to_s
            else
                # 最大の年齢として十分な150歳に設定
                older_birth_ymd = calc_min_birthday("150").to_s
            end
                # yyyymmdd形式の生年月日を日付形式に変換
                younger_birthday = Time.parse(younger_birth_ymd)
                older_birthday = Time.parse(older_birth_ymd)
            # 条件に当てはまるUserを検索
            @users = User.where(birth_date: older_birthday..younger_birthday).page(params[:page]).per(5)
        end
    end

    def show
        @user = User.find(params[:id])
        @permission_teams = @user.teams.where(publication_status: "permission").all.reverse_order
        @teams = @user.teams.all
        #以下メッセージ機能の記述
        @currentUserEntry=Entry.where(user_id: current_user.id)
        @userEntry=Entry.where(user_id: @user.id)
        unless @user.id == current_user.id
        @currentUserEntry.each do |cu|
            @userEntry.each do |u|
                if cu.room_id == u.room_id then
                @isRoom = true
                @roomId = cu.room_id
                end
            end
        end
            if @isRoom
            else
                @room = Room.new
                @entry = Entry.new
            end
        end
    end

    def edit
        @user = current_user
    end

    def update
        @user = User.find(params[:id])
        @user.update(user_params)
        redirect_to user_path(@user.id)
    end


    def cancel
        @user = current_user
    end

	def withdraw
		@user = current_user
		@user.withdraw!
		reset_session
		redirect_to root_path
	end


    # 指定された年齢となる生年月日をyyyymmdd形式の文字列へと変換
    def calc_younger_birthday(age)
        Date.today.strftime("%Y%m%d").to_i - age.to_i * 10000
    end
    # 渡された年齢であるギリギリの生年月日をyyyymmdd形式で出力
    def calc_older_birthday(age)
        Date.today.strftime("%Y%m%d").to_i - age.to_i * 10000 - 9999
    end

    private
    def user_params
        params.require(:user).permit(:name, :profile_image, :introduction, :prefecture, :gender_status)
    end
end
