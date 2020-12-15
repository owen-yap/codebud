import consumer from "./consumer";
import { fetchWithToken } from "../utils/fetch_with_token";

const initChatroomCable = () => {
  console.log('chatroom cable loaded');
  const input = document.querySelector('#new_message')
  if (input) {
    input.addEventListener('submit', (e) => {
      const url = input.action
      // prevent refresh and auto submit
      e.preventDefault();

      //target the text input
      const word = document.querySelector("#message_content")
      // now need to send the info on the form via fetch manually to messages#create
      fetchWithToken(url, {
        method: "POST",
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: JSON.stringify({ message: {content: word.value} })
      })
    // clear the form
      word.value = "" ;
    });
  }
  // check if this page have a message container
  const messagesContainer = document.getElementById('messages');
  if (messagesContainer) {
    const id = messagesContainer.dataset.questionId;
    const current_user = messagesContainer.dataset.currentUserId;
    // listening for broadcast in channel , MessageChannel for this qn
    consumer.subscriptions.create({ channel: 'MessageChannel', id: id }, {
      received(data) {
        // called when data is broadcast in the cable
        messagesContainer.insertAdjacentHTML('beforeend', data);
        const lastmsg = messagesContainer.children[messagesContainer.children.length - 1];
        if (lastmsg.dataset.userId === current_user) {
          lastmsg.classList.add("msgblue")
        }
        else {
          lastmsg.scrollIntoView({behavior: "smooth", block: "end"});
        }
      }
    });
  }
}

export { initChatroomCable };
