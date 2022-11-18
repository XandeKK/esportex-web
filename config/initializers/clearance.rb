Clearance.configure do |config|
  config.mailer_sender = ENV["MAILER_SENDER"]
  config.rotate_csrf_on_sign_in = true
  config.routes = false
  config.signed_cookie = true
end
