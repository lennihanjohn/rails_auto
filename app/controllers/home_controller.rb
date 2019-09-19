class HomeController < ApplicationController

    def index
       
        if current_user.present?
            redirect_to pages_path
        else
            render layout: false
        end
    end
end
