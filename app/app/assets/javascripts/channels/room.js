App.room = App.cable.subscriptions.create("RoomChannel", {
  connected: function () {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function () {
    // Called when the subscription has been terminated by the server
  },

  received: function (data) {
    console.log(data["chat"])
    $('.chat-stream').append(data["chat"]);
    $('.chat-stream').animate({
      scrollTop: $('.chat-stream')[0].scrollHeight
    }, 'fast');
  },

  speak: function (chat) {
    return this.perform('speak', {
      chat: chat
    });
  }
});