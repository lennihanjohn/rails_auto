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

        parse_date = Date.strptime(params[:date], '%m/%d/%Y')
        day_of_date = parse_date.strftime("%A")
        business_hour = DayOfWeek.find_by_day_of_week(day_of_date).day_of_business_hour
        @start_at = business_hour.open_at.strftime("%H:%M %p")
        @close_at = business_hour.close_at.strftime("%H:%M %p")
        @values =(@start_at.to_i..@close_at.to_i).step(30.minutes)
            
        @business_hour = @values.map{ |t| [ Time.at(t).utc.to_datetime.strftime("%H:%M %p"), Time.at(t).utc.to_datetime.strftime("%H:%M %p") ]}
        p '............'
        p @start_at
        p @close_at
        p @values
        p @business_hour
        p '............'
        respond_to do |format|
            format.js
        end
    end

    private
    def booking_params
        params.require(:booking).permit(:is_active, :repair_date, :start_at, :end_at)
    end

    def get_time_period()
        @values =(DateTime.parse("12:00 AM").to_i..DateTime.parse("11:59 PM").to_i).step(30.minutes)
            
        @time_period = @values.map{ |t| [ Time.at(t).utc.to_datetime.strftime("%H:%M %p"), Time.at(t).utc.to_datetime.strftime("%H:%M %p") ]}
    end
end
