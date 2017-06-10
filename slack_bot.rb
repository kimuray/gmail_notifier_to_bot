require 'slack/incoming/webhooks'

class SlackBot
  def initialize(webhook_url)
    @slack = Slack::Incoming::Webhooks.new(webhook_url)
  end

  attr_reader :slack

  def post_message(content)
    slack.post(content)
  end
end
