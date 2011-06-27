namespace :email do

  task :daily_schedules => [:environment] do

    User.all.each do |user|
      ScheduleMailer.deliver_daily_schedule(user) if user.status == User::STATUS_ACTIVE
    end

  end

end