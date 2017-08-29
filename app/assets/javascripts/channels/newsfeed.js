App.newsfeed = App.cable.subscriptions.create('NewsfeedChannel', {
  connected: function() {
    // Called when the subscription is ready for use on the server
    console.log('newsfeed connected');
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log('newsfeed received', data);
    if (data.script) {
      eval(data.script);
    }
  }
});
