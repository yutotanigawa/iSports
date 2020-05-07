class Admins::GenresController < ApplicationController
    before_action :authenticate_admin!

    def index
        @genres = Genre.all.reverse_order
        @genre = Genre.new
    end

    def create
        @genre = Genre.new(genre_params)
        @genre.save
        redirect_to admins_genres_path
    end

    def edit
        @genre = Genre.find(params[:id])
    end

    def update
        @genre = Genre.find(params[:id])
        @genre.update(genre_params)
        redirect_to admins_genres_path
    end

    def destroy
        @genre = Genre.find(params[:id])
        @teams = Team.where(genre_id: @genre)
        @teams.destroy_all
        @genre.destroy
        redirect_to admins_genres_path
    end

    private

    def genre_params
        params.require(:genre).permit(:name)
    end
end
