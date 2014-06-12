class AttendanceSheet < ActiveRecord::Base
  has_many :attendances
  accepts_nested_attributes_for :attendances
end