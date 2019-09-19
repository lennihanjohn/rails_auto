# == Schema Information
#
# Table name: bookings
#
#  id          :bigint           not null, primary key
#  user_id     :bigint
#  is_active   :boolean
#  repair_date :date
#  start_at    :datetime
#  end_at      :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class BookingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
