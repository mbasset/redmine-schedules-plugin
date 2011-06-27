class ScheduleMailer < Mailer

  # Delivers the schedule for the current user for today.
  def daily_schedule(user)
    recipients user.mail
    subject "Your personalized daily schedule!"
    content_type "text/html"

    user = user
    date = Date.today
    projects = Project.find(:all, :conditions => Project.allowed_to_condition(user, :view_schedules))
    calendar = Redmine::Helpers::Calendar.new(date, current_language, :week)

    daily_entries = nil
    entries = nil

    unless projects.empty?
      restrictions = "(date BETWEEN '#{calendar.startdt}' AND '#{calendar.enddt}')"
      restrictions << " AND user_id = #{user.id}"
      restrictions << " AND project_id IN ("+projects.collect {|project| project.id.to_s }.join(',')+")"

      entries = ScheduleEntry.find(:all, :conditions => restrictions)

      daily_restrictions = "(date = '#{date}')"
      daily_restrictions << " AND user_id = #{user.id}"
      daily_restrictions << " AND project_id IN ("+projects.collect {|project| project.id.to_s }.join(',')+")"

      daily_entries = ScheduleEntry.find(:all, :conditions => restrictions)
    end

    body(
      :user => user,
      :date => date,
      :daily_entries => daily_entries,
      :entries => entries,
      :calendar => calendar,
      :availabilities => Hash.new
    )
  end

  def future_changed(user_source, user_target, project, date, hours)
    recipients user_target.mail
    subject "Schedule changed"

    body(
      :user => user_source,
      :project => project,
      :date => date,
      :hours => hours
    )
  end

end