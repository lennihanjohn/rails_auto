class VehiclesController < ApplicationController
    def index
        @vehicles = Vehicle.all.paginate(page: params[:page])
        @vehicles = params[:search].nil? ? @vehicles : @vehicles.search(params[:search])

        respond_to do |format|
            format.html 
            format.js
        end
    end

    def show
        @vehicle = Vehicle.includes(:auto_histories).find_by(id: params[:id])
        respond_to do |format|
            format.html 
            format.js
        end
    end
end
