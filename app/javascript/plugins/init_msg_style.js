const initMsgStyle = () => {
  // check if this page have a message container
  const messagesContainer = document.getElementById('messages');
  if (messagesContainer) {
   // find the student
   const current_user = messagesContainer.dataset.currentUserId;
   // array of messages
   const msgs= document.querySelectorAll('.message-container');
   msgs.forEach((msg)=> {
    if (msg.dataset.userId === current_user) {
      msg.classList.add("msgblue")
    }
   });
  }
};
export { initMsgStyle };
