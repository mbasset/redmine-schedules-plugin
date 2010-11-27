class ScheduleDefault < ActiveRecord::Base

	belongs_to :user
	serialize :weekday_hours
	validates_uniqueness_of :user_id
	
  SHOW_FULL_ISSUE_LIST = {
    'No' => '0',
    'Yes' => '1'
  }
	
	
	def initialize
		super
		self.weekday_hours = [0,0,0,0,0,0,0]
	end
end
