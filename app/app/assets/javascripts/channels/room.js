App.room = App.cable.subscriptions.create("RoomChannel", {
  connected: function () {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function () {
    // Called when the subscription has been terminated by the server
  },

  received: function (data) {
    alert(data["chat"]["body"])
  },

  speak: function (chat) {
    return this.perform('speak', {
      chat: chat
    });
  }
});