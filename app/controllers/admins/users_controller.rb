class Admins::UsersController < ApplicationController
    def index
        @users = User.all
                    # パラメータとして都道府県を受け取っている場合は絞って検索する
                    if params[:prefecture].present?
                    @users = @users.get_by_prefecture(params[:prefecture])
                    end
                    # パラメータとして性別を受け取っている場合は絞って検索する
                    if params[:gender_status].present?
                    @users = @users.get_by_gender_status(params[:gender_status])
                    end
                    # パラメータとして会員ステータスを受け取っている場合は絞って検索する
                    if params[:valid_status].present?
                        @users = @users.get_by_valid_status(params[:valid_status])
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
                            # 最大の年齢として十分な150歳にした
                            older_birth_ymd = calc_min_birthday("150").to_s
                        end
                            # yyyymmdd形式の生年月日を日付形式に変換
                            younger_birthday = Time.parse(younger_birth_ymd)
                            older_birthday = Time.parse(older_birth_ymd)
                        # 条件に当てはまるUserを検索
                        @users = User.where(birth_date: older_birthday..younger_birthday)
                    end
    end

    def show
        @user = User.find(params[:id])
        @teams = @user.teams.all
    end

    def update
        @user = User.find(params[:id])
        @user.update(user_params)
        redirect_to admins_users_path
    end

    private
    def user_params
        params.require(:user).permit(:valid_status)
    end
end
