require 'google/apis/gmail_v1'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'
require 'base64'

class GmailOperator

  OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
  APPLICATION_NAME = 'Gmail API Ruby Quickstart'
  CLIENT_SECRETS_PATH = 'client_secret.json'
  CREDENTIALS_PATH = File.join(Dir.pwd, '.credentials',
                               "gmail-ruby-quickstart.yaml")
  SCOPE = Google::Apis::GmailV1::AUTH_GMAIL_READONLY

  def initialize(email)
    @service = Google::Apis::GmailV1::GmailService.new
    @service.client_options.application_name = APPLICATION_NAME
    @service.authorization = authorize
    @email = email
  end

  attr_reader :service, :email

  def get_messages(user_id=nil, max_results: 1)
    results = []
    user_id ||= 'me'
    api_result = service.list_user_messages(user_id, label_ids: 'UNREAD', max_results: max_results)
    api_result.messages.each do |message|
      payload = service.get_user_message(user_id, message.id).payload
      if payload.parts
        body = payload.parts[0].body.data.force_encoding('UTF-8')
      else
        body = payload.body.data.force_encoding('UTF-8')
      end
      results << body
      # service.modify_message(user_id, message.id)
    end
    results
  end

  private

  def authorize
    FileUtils.mkdir_p(File.dirname(CREDENTIALS_PATH))

    client_id = Google::Auth::ClientId.from_file(CLIENT_SECRETS_PATH)
    token_store = Google::Auth::Stores::FileTokenStore.new(file: CREDENTIALS_PATH)
    authorizer = Google::Auth::UserAuthorizer.new(
      client_id, SCOPE, token_store)
    user_id = 'default'
    credentials = authorizer.get_credentials(user_id)
    if credentials.nil?
      url = authorizer.get_authorization_url(
        base_url: OOB_URI)
      puts "Open the following URL in the browser and enter the " +
             "resulting code after authorization"
      puts url
      code = gets
      credentials = authorizer.get_and_store_credentials_from_code(
        user_id: user_id, code: code, base_url: OOB_URI)
    end
    credentials
  end
end
