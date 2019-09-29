class DayOfBusinessHoursController < ApplicationController
    before_action :authenticate_user!
    before_action :get_time_period, only: :edit
    def index
        @business_hours = DayOfWeek.includes(:day_of_business_hour).all
    end
    def edit
        
        @day_of_week = DayOfBusinessHour.find_by(id: params[:id])
        respond_to do |format|
            format.html 
            format.js
        end
    end

    def update
        @day_of_week = DayOfBusinessHour.find_by(id: params[:id])
        if @day_of_week.update(hour_params)
            p " i am update successfully"
            @business_hours = DayOfWeek.includes(:day_of_business_hour).all
        else
            @errors = @day_of_week.errors.full_messages.join("<br/>").html_safe
        end
        respond_to do |format|
            format.html 
            format.js
        end
    end

    private
    def hour_params
        params.require(:day_of_business_hour).permit(:open_at, :close_at, :is_overlap)
    end

    def get_time_period
        @values = (DateTime.parse("12:00 AM").to_i..DateTime.parse("11:59 PM").to_i).step(30.minutes)
        @time_period = @values.map{ |t| [ Time.at(t).utc.to_datetime.strftime("%H:%M %p"), Time.at(t).utc.to_datetime.strftime("%H:%M %p") ]}
    end
end
