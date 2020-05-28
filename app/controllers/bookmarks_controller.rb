class BookmarksController < ApplicationController
    before_action :authenticate_user!

    def create
        @team = Team.find(params[:team_id])
        bookmark = current_user.bookmarks.build(team_id: params[:team_id])
        bookmark.save
    end

    def destroy
        @team = Team.find(params[:team_id])
        current_user.bookmarks.find_by(team_id: params[:team_id]).destroy
    end

end
