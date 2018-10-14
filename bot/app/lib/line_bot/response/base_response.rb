module LineBot
  module Response
    class BaseResponse
      NOT_OVERRIDE = 'not override error'

      def initialize(_line_bot_event)
        @line_bot_event = _line_bot_event
      end

      def send
        raise LineBot::BaseResponse::NOT_OVERRIDE
      end
    end
  end
end