require 'clockwork'
require './b_logic_executer'

include Clockwork

# every 10.minutes, 'gmail_post_to_slack' do
#   job_executer = JobExecuter.new(ENV['GMAIL_ACOUNT_NAME'], ENV['SLACK_WEBHOOK_URL'])
#   job_executer.gmail_post_to_slack
# end

every 3.minutes, 'notice_kpi' do
  blogic = BLogicExecuter.new(ENV['SLACK_WEBHOOK_URL'])
  blogic.notice_kpi_to_slack(ENV['SPREAD_ID'], 'KPI!A1:D8')
end
