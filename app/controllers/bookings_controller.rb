class BookingsController < ApplicationController
    def index
        @bookings = Booking.all.includes(:user).order("repair_date desc").paginate(page: params[:page])
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
        has_space = true
        reserve_date = get_reserve_date(params[:booking][:repair_date])
        start_at = DateTime.parse(params[:reserve_time])
        repair_type = TypeOfRepair.find_by(id: params[:repair][:type])
        if repair_type.nil?
            @errors = "Please pick the service type!"
        end
        end_at = start_at + (repair_type.repair_time).to_i.hour

        p "reserve date #{reserve_date} -- #{start_at} -- #{end_at}"

        @all_existing_bookings = Booking.where(repair_date: reserve_date)
        if @all_existing_bookings.count > 0
            @all_existing_bookings.each do |booking|
                has_space = false if not (booking.end_at <= start_at || end_at <= booking.start_at)
            end
        end
        unless has_space
            @errors = "Someone booked on the time. Please pick another service time or date!"
        end
        # find or create user account by phone number 
        if params['phone_number'].present? && has_space
            @user = User.find_or_create_by(email: params['email']) 
            #update user info if new record or email matches
            password = Devise.friendly_token.first(6)
            @user.update(name: params['name'], phone_number: params['phone_number'], address: params['address'], password: password) if @user.phone_number.nil? || params['phone_number'] == @user.phone_number 
            @vehicle = Vehicle.find_or_create_by(vin: params[:vehicle_vin])
            @vehicle.update(vin: params[:vehicle_vin], 
                            year: params[:vehicle_year],
                            make: params[:vehicle_make],
                            model: params[:vehicle_model],
                            user: @user
                            ) if @vehicle.user.nil? || @user == @vehicle.user 
            @booking = Booking.new(user: @user, repair_date: reserve_date, start_at: params[:reserve_time], end_at: end_at )
            if !@booking.save
                @booking.errors.full_messages.map { |msg| content_tag(:li, msg) }
            end
        end

        @bookings = Booking.all.includes(:user).paginate(page: params[:page])
        respond_to do |format|
            format.js
        end
    end

    def check_date
        reserve_date = get_reserve_date(params[:date]).strftime("%A")  
        business_hour = DayOfWeek.find_by_day_of_week(reserve_date).day_of_business_hour
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
