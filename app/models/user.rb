# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  name                   :string(255)
#  phone_number           :string(255)
#  address                :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :vehicles
  has_many :bookings
  has_many :auto_histories

  def active_for_authentication?
    super && self.id == 1 # i.e. super && self.is_active
  end

  def inactive_message
    "sorry you are not authorized to login."
  end
  
  def self.search(search)
      self.joins(:vehicles).where("email like ? Or name like ? Or phone_number like ? or vehicles.vin", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
  end
end
