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

    def create
        @errors = []
        reverse_date = get_reserve_date(params[:booking][:repair_date])

        @all_existing_bookings = Booking.where(repair_date: reverse_date)
        if @all_existing_bookings.count > 0
            
        end
        # find or create user account by phone number 
        if params['phone_number'].present?
            @user = User.find_or_create_by(email: params['email']) 
            #update user info if new record or email matches
            @user.update(name: params['name'], phone_number: params['phone_number'], address: params['address']) if @user.phone_number.nil? || params['phone_number'] == @user.phone_number 
            @errors << @user.errors.full_messages.map { |msg| content_tag(:li, msg) }
            @vehicle = Vehicle.find_or_create_by(vin: params[:vehicle_vin])
            @vehicle.update(vin: params[:vehicle_vin], 
                            year: params[:vehicle_year],
                            make: params[:vehicle_make],
                            model: params[:vehicle_model]
                            ) if @vehicle.user.nil? || @user == @vehicle.user 
            @errors << @vehicle.errors.full_messages.map { |msg| content_tag(:li, msg) }
        end
        @booking = Booking.new
        @type_of_repairs = TypeOfRepair.all
    end

    def check_date
        reverse_date = get_reserve_date(params[:date]).strftime("%A")  
        business_hour = DayOfWeek.find_by_day_of_week(reverse_date).day_of_business_hour
        @start_at = business_hour.open_at.strftime("%H:%M %p")
        @close_at = business_hour.close_at.strftime("%H:%M %p")
        @values =(DateTime.parse(@start_at).to_i..DateTime.parse(@close_at).to_i).step(30.minutes)
        @business_hour = @values.map{ |t| [ Time.at(t).utc.to_datetime.strftime("%H:%M %p"), Time.at(t).utc.to_datetime.strftime("%H:%M %p") ]}
        respond_to do |format|
            format.js
        end
    end

    private
    def booking_params
        params.require(:booking).permit(:is_active, :repair_date, :start_at, :end_at)
    end

    def get_reserve_date(date)
        return Date.strptime(date, '%m/%d/%Y')
    end
end
