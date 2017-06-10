require 'clockwork'
require './job_executer'

include Clockwork

every 10.minutes, 'gmail_post_to_slack' do
  job_executer = JobExecuter.new(ENV['GMAIL_ACOUNT_NAME'], ENV['SLACK_WEBHOOK_URL'])
  job_executer.gmail_post_to_slack
end
