class UsersController < ApplicationController
    def index
        @users = User.all.paginate(page: params[:page])
        @users = params[:search].nil? ? @users : @users.search(params[:search])

        respond_to do |format|
            format.html 
            format.js
        end
    end
    def show
        @user = User.includes(:auto_histories, :bookings).find_by(id: params[:id])
        respond_to do |format|
            format.html 
            format.js
        end
    end
end
