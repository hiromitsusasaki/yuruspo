module LineBot
  class ResponseEvent
    attr_accessor :responser, :event

    def initialize(_event, _responser)
      @responser = _responser
      @event = _event
    end

    def send
      @responser.send(self)
    end
  end
end
