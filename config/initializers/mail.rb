ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.smtp_settings = {
     :authentication => :plain,
     :address => ENV['MAILGUN_SMTP_SERVER'],
     :port => 587,
     :domain => "keepsak.es",
     :user_name => ENV['MAILGUN_DAYVIEWCO_SMTP_LOGIN'],
     :password => ENV['MAILGUN_DAYVIEWCO_SMTP_PASSWORD']
}
