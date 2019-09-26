# == Schema Information
#
# Table name: vehicles
#
#  id         :bigint           not null, primary key
#  user_id    :bigint
#  make       :string(255)
#  model      :string(255)
#  color      :string(255)
#  year       :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  vin        :string(255)
#

require 'test_helper'

class VehicleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
