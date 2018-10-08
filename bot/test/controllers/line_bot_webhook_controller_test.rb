require 'test_helper'

class LineBotWebhookControllerTest < ActionDispatch::IntegrationTest
  test "should get callback" do
    get line_bot_webhook_callback_url
    assert_response :success
  end

end
