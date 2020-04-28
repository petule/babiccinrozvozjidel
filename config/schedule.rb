set :output, "log/cron.log"

every 10.minutes do
	runner "RicEshop::Cart.cleanup"
	runner "RicEshop::Cart.cleanup_closed_restaurants"
	runner "RicUser::Session.cleanup"
end