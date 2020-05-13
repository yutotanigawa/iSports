class HomesController < ApplicationController
    def top
        @teams = Team.limit(5).order(" created_at DESC ").where(publication_status: "permission")
    end
    def about
    end
end
