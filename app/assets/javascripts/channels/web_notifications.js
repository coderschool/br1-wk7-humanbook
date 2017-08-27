App.web_notifications = App.cable.subscriptions.create('WebNotificationsChannel', {
  connected: function() {
    // Called when the subscription is ready for use on the server
    console.log('#WebNotifications connected', this);
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log('#WebNotifications received: ', data);
    $('.js-messages-count').html(data.html);
  }
});
