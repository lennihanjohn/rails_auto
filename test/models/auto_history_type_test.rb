# == Schema Information
#
# Table name: auto_history_types
#
#  id                :bigint           not null, primary key
#  auto_history_id   :bigint
#  type_of_repair_id :bigint
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'test_helper'

class AutoHistoryTypeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
