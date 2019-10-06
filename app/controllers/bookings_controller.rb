class BookingsController < ApplicationController
    def index
        @bookings = Booking.all.includes(:user).order(repair_date: :desc, start_at: :desc).paginate(page: params[:page])
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
        has_space = true
        reserve_date = get_reserve_date(params[:booking][:repair_date])
        start_at = DateTime.strptime("#{reserve_date.strftime("%m-%d-%Y")} #{params[:reserve_time]}",  '%m-%d-%Y %H:%M').asctime.in_time_zone
        repair_type = TypeOfRepair.find_by(id: params[:repair][:type])
        end_at = start_at + (repair_type.repair_time).hour

        @all_existing_bookings = Booking.where(repair_date: reserve_date)
        if @all_existing_bookings.count > 0
            @all_existing_bookings.each do |booking|
                has_space = false if not (booking.end_at <= start_at || end_at <= booking.start_at)
            end
        end
        
        @errors << "Please pick the service type!" if repair_type.nil?
        @errors << "Someone booked on the time. Please pick another service time or date!" unless has_space

        # find or create user account by phone number 
        if params['phone_number'].present? && has_space && !@errors.any?
            @user = User.find_or_create_by(email: params['email']) 
            #update user info if new record or email matches
            password = Devise.friendly_token.first(6)
            @user.update(name: params['name'], phone_number: params['phone_number'], address: params['address'], password: password) if @user.phone_number.nil? || params['phone_number'] == @user.phone_number 
            @vehicle = Vehicle.find_or_create_by(user: @user, vin: params[:vehicle_vin])
            p  'vehicle: ' + @vehicle.errors.full_messages.inspect

            @errors << @vehicle.errors.full_messages.map { |msg| content_tag(:li, msg) } unless @vehicle.save(  vin: params[:vehicle_vin], 
                                                                                                                year: params[:vehicle_year],
                                                                                                                make: params[:vehicle_make],
                                                                                                                model: params[:vehicle_model],
                                                                                                                user: @user
                                                                                                                ) if @errors.empty? && (@vehicle.user.nil? || @user == @vehicle.user )
            if @errors.empty? 
                @booking = Booking.new(user: @user, repair_date: reserve_date, start_at: start_at, end_at: end_at, desc: params[:desc], auto_history_attributes: {user: @user, vehicle: @vehicle} ) 
                @errors << @booking.errors.full_messages.map { |msg| content_tag(:li, msg) } unless  @booking.save
            end
        end

        @bookings = Booking.all.includes(:user).order(repair_date: :desc, start_at: :desc).paginate(page: params[:page])
        respond_to do |format|
            format.js
        end
    end

    def check_date
        repair_time = TypeOfRepair.find_by(id: params[:service_type]).repair_time
        reserve_date = get_reserve_date(params[:date]) 
        business_hour = DayOfWeek.find_by_day_of_week(reserve_date.strftime("%A") ).day_of_business_hour
        @values =(DateTime.parse(business_hour.open_at.strftime("%H:%M")).to_i..DateTime.parse(business_hour.close_at.strftime("%H:%M")).to_i).step(30.minutes)
        @business_hour = find_all_avaiable_start_times(reserve_date, @values, repair_time)
        respond_to do |format|
            format.js
        end
    end

    private

    def find_all_avaiable_start_times(reserve_date, values, repair_time)
        avaiable_start_time = []
        @all_existing_bookings = Booking.where(repair_date: reserve_date)
        is_more_than_one = @all_existing_bookings.count > 0
        values.each do |time|
            #parse reserve_date into time with timezone
            start_at = DateTime.parse(Time.at(time).utc.to_datetime.strftime("%H:%M")).change(year: reserve_date.year, month: reserve_date.month, day: reserve_date.day).asctime.in_time_zone
            end_at = start_at + (repair_time).hour
            has_space = true
            if is_more_than_one 
                @all_existing_bookings.each do |booking|
                    has_space = false if not (booking.end_at <= start_at || end_at <= booking.start_at)
                    avaiable_start_time << Time.at(time).utc.to_datetime.strftime("%H:%M") if has_space
                end
            else
                avaiable_start_time << Time.at(time).utc.to_datetime.strftime("%H:%M") if has_space
            end
        end
        return avaiable_start_time.uniq
    end

    def booking_params
        params.require(:booking).permit(:is_active, :repair_date, :start_at, :end_at)
    end

    def get_reserve_date(date)
        return Date.strptime(date, '%m/%d/%Y')
    end
end
