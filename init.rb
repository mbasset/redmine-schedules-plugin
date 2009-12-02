require 'redmine'

require_dependency 'schedule_compatibility'

Redmine::Plugin.register :redmine_goyello_schedules do
	name 'Redmine Schedules plugin'
	author 'GOYELLO'
	description 'This plugin provides a feature to allocate users to projects and to track this allocation over time. It does so by creating daily time estimates of hours worked per project per user. Users can schedule their hours directly on the tickets from modal box'
	version '0.4.1.5'
  
	project_module :schedule_module do
		permission :view_schedules,  {:schedules => [:index]}, :require => :member
		permission :edit_own_schedules, {:schedules => [:edit, :user, :project]}, :require => :member
		permission :edit_all_schedules, {}, :require => :member
	end

  settings :default => { 'quickIssueStatus' => -1 },
    :partial => 'settings/redmine_scheduled_settings'
	

  menu :top_menu, :my_schedules, { :controller => 'schedules', :action => 'my_index', :project_id => nil, :user_id => nil }, :after => :my_page, :caption => :label_schedules_my_index, :if => Proc.new { SchedulesController.visible_projects.size > 0 }
  menu :top_menu, :schedules, { :controller => 'schedules', :action => 'index', :project_id => nil, :user_id => nil }, :before => :projects, :caption => :label_bulk_schedules_index, :if => Proc.new { SchedulesController.visible_projects.size > 0 }
  menu :project_menu, :schedules, { :controller => 'schedules', :action => 'index' }, :caption => :label_schedules_index, :after => :activity, :param => :project_id
end
