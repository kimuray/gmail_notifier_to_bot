require './gmail_operator'
require './slack_bot'

class JobExecuter
  def initialize(email, webhook_url)
    @gmail_operator = GmailOperator.new(email)
    @slack_bot = SlackBot.new(webhook_url)
  end

  attr_reader :gmail_operator, :slack_bot

  def gmail_post_to_slack
    posts = gmail_operator.get_messages(max_results: 1)
    posts.each do |post|
      slack_bot.post_message(post)
    end
  end
end
