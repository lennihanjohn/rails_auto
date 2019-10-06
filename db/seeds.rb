# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(email: 'admin@mail.com', password: 'password')
DayOfWeek.create(day_of_week: "Monday", day_of_business_hour_attributes: {open_at: DateTime.now.change({ hour: 16, min: 0, sec: 0 }), close_at: DateTime.now.change({ hour: 22, min: 0, sec: 0 })})
DayOfWeek.create(day_of_week: "Tuesday", day_of_business_hour_attributes: {open_at: DateTime.now.change({ hour: 16, min: 0, sec: 0 }), close_at: DateTime.now.change({ hour: 22, min: 0, sec: 0 })}) 
DayOfWeek.create(day_of_week: "Wednesday", day_of_business_hour_attributes: {open_at: DateTime.now.change({ hour: 16, min: 0, sec: 0 }), close_at: DateTime.now.change({ hour: 22, min: 0, sec: 0 })})  
DayOfWeek.create(day_of_week: "Thursday", day_of_business_hour_attributes: {open_at: DateTime.now.change({ hour: 16, min: 0, sec: 0 }), close_at: DateTime.now.change({ hour: 22, min: 0, sec: 0 })}) 
DayOfWeek.create(day_of_week: "Friday", day_of_business_hour_attributes: {open_at: DateTime.now.change({ hour: 16, min: 0, sec: 0 }), close_at: DateTime.now.change({ hour: 22, min: 0, sec: 0 })}) 
DayOfWeek.create(day_of_week: "Saturday", day_of_business_hour_attributes: {open_at: DateTime.now.change({ hour: 12, min: 0, sec: 0 }), close_at: DateTime.now.change({ hour: 22, min: 0, sec: 0 })}) 
DayOfWeek.create(day_of_week: "Sunday", day_of_business_hour_attributes: {open_at: DateTime.now.change({ hour: 12, min: 0, sec: 0 }), close_at: DateTime.now.change({ hour: 22, min: 0, sec: 0 })}) 


#  open_at        :datetime
#  close_at       :datetime
#  is_overlap     :boolean