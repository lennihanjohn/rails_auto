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

    def check_date
        p '............'
        p params[:date]
        p '............'
        parse_date = Date.strptime(params[:date], '%m/%d/%Y')
        day_of_date = parse_date.strftime("%A")
        p DayOfWeek.find_by_day_of_week(day_of_date).day_of_business_hour
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
