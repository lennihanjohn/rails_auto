# == Schema Information
#
# Table name: type_of_repairs
#
#  id          :bigint           not null, primary key
#  name        :string(255)
#  desc        :text(65535)
#  repair_time :integer
#  price       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class TypeOfRepair < ApplicationRecord
    # belongs_to :auto_history_type
    validates_presence_of :name, :desc, :repair_time, :price
    validates_uniqueness_of :name

    def self.search(search)
        self.where("name like ?", "%#{search}%" )
    end

    def service_detail
        return self.name + ' - ' + self.repair_time.to_s + 'hr(s)'
    end

end
