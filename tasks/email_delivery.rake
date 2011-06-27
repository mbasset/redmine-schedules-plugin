namespace :email do

  task :daily_schedules => [:environment] do

    User.all.each do |user|
      if user.status == User::STATUS_ACTIVE && user.groups.map(&:lastname).include?("Daily Schedule")
        ScheduleMailer.deliver_daily_schedule(user)
      end
    end

  end

end