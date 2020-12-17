const initMsgStyle = () => {
  // check if this page have a message container
  const messagesContainer = document.getElementById('messages');
  if (messagesContainer) {
    // find the current user
    const current_user = messagesContainer.dataset.currentUserId;
    // array of messages
    const msgs = document.querySelectorAll('.message-container');
    msgs.forEach((msg) => {
      if (msg.dataset.userId === current_user) {
        msg.classList.add("msggreen");
      } else {
        msg.classList.add("msgwhite");
        msg.classList.add("ml-auto");
      }
    });
  }
};

export { initMsgStyle };
