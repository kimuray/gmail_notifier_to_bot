require './gmail_operator'
require './spread_operator'
require './slack_bot'
require './sheet_value_shaper'

class BLogicExecuter
  def initialize(webhook_url)
    @slack_bot = SlackBot.new(webhook_url)
  end

  attr_reader :gmail_operator, :spread_operator, :slack_bot

  def gmail_post_to_slack(email)
    set_gmail_operator(email)
    posts = gmail_operator.get_messages(max_results: 1)
    posts.each do |post|
      slack_bot.post_message(post)
    end
  end

  def notice_kpi_to_slack(spreadsheet_id, range)
    set_spread_operator(spreadsheet_id, range)
    values = spread_operator.get_values
    kpi = SheetValueShaper.kpi_str(values)
    slack_bot.post_message(kpi)
  end

  private

  def set_gmail_operator(email)
    @gmail_operator = GmailOperator.new(email)
  end

  def set_spread_operator(spreadsheet_id, range)
    @spread_operator = SpreadOperator.new(spreadsheet_id, range)
  end
end
