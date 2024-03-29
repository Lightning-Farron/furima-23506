import consumer from "./consumer"

consumer.subscriptions.create("MessageChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    //Called when there's incoming data on the websocket for this channel
    const html = `
                  <p>
                  ${data.user_name}
                  ${data.content.text}
                  </p>`;
    const messages = document.getElementById('messages');
    const newMessage = document.getElementById('message_text');
    messages.insertAdjacentHTML('afterbegin', html);
    newMessage.value='';
    const inputElement = document.getElementById('sub');
    inputElement.disabled = false;
  }
})
