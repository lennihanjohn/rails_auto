class TypeOfRepairsController < ApplicationController
    def index
        @type_of_repairs  = TypeOfRepair.all.paginate(page: params[:page])
        @type_of_repairs = params[:search].nil? ? @type_of_repairs : @type_of_repairs.search(params[:search])

        respond_to do |format|
            format.html 
            format.js
        end

    end

    def new
        @type_of_repair = TypeOfRepair.new
        respond_to do |format|
            format.html 
            format.js
        end
    end


    def create
        @type_of_repair = TypeOfRepair.new(type_params)
        if @type_of_repair.save
            @type_of_repairs  = TypeOfRepair.all.paginate(page: params[:page])
        else
            @errors = @type_of_repair.errors.full_messages.join("<br/>").html_safe
        end
        respond_to do |format|
            format.html 
            format.js
        end
    end

    def edit
        @type_of_repair = TypeOfRepair.find_by(id: params[:id])
        respond_to do |format|
            format.html 
            format.js
        end
    end

    def type_params
        params.require(:type_of_repair).permit(:code, :desc, :repair_time, :price)
    end
end
