class UsersController < ApplicationController
    def index
        @users = User.all.paginate(page: params[:page])
        respond_to do |format|
            format.html 
            format.js
        end
    end

end
