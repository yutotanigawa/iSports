class UsersController < ApplicationController
    def index
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
    end

    def edit
    end

    def update
    end

    def search
    end

    def cancel
    end

    def withdraw
    end
end
