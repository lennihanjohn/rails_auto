class BookingsController < ApplicationController
    def index
        @bookings = Booking.all.paginate(page: params[:page])
        @bookings = params[:search].nil? ? @bookings : @bookings.search(params[:search])
        respond_to do |format|
            format.html 
            format.js
        end
    end

    def new
        @booking = Booking.new
        @type_of_repairs = TypeOfRepair.all

    end

    private
    def booking_params
        params.require(:booking).permit(:is_active, :repair_date, :start_at, :end_at)
    end

    def get_time_period
        @values = (DateTime.parse("12:00 AM").to_i..DateTime.parse("11:59 PM").to_i).step(30.minutes)
        @time_period = @values.map{ |t| [ Time.at(t).utc.to_datetime.strftime("%H:%M %p"), Time.at(t).utc.to_datetime.strftime("%H:%M %p") ]}
    end
end
