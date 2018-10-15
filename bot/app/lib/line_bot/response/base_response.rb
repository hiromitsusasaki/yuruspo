module LineBot
  module Response
    class BaseResponse
      attr_accessor :next

      def initialize
        @next = nil
      end
    end
  end
end