import consumer from "./consumer";
import { fetchWithToken } from "../utils/fetch_with_token";
import { initMsgStyle } from "../plugins/init_msg_style";

const initChatroomCable = () => {
  console.log("chatroom cable loaded");

  const word = document.querySelector("#message_content");
  const messagesContainer = document.getElementById("messages");
  if (messagesContainer) {
    const id = messagesContainer.dataset.questionId;
    const current_user = messagesContainer.dataset.currentUserId;
    // listening for broadcast in channel , MessageChannel for this qn

    consumer.subscriptions.create(
      { channel: "MessageChannel", id: id },
      {
        received({ html, message }) {
          // called when data is broadcast in the cable
          messagesContainer.insertAdjacentHTML("beforeEnd", html);
          word.value = "";
          const messageElement = document.querySelector(
            `#message-${message.id}`
          );
          messageElement.scrollIntoView({
            behavior: "smooth",
          });
        },
      }
    );
  }
};

export { initChatroomCable };
