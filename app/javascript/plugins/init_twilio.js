const { connect, createLocalVideoTrack } = require('twilio-video');
const rooms = [];

const showRemoteVideo = (track) => {
  const videoElement = document.getElementById('remote-video');
  videoElement.appendChild(track.attach());
  videoElement.classList.remove('waiting');
  videoElement.classList.add('connected');
}

const disconnectVideo = () => {
  const videoElement = document.getElementById('remote-video');
  setVideoVisible(false);
  videoElement.classList.remove('connected');
  videoElement.classList.add('waiting');
  rooms.forEach(room => room.disconnect());
}

const buddyConnected = (buddy) => {
  console.log("buddy connected");
  buddy.tracks.forEach(publication => {
    if (publication.isSubscribed) {
      const track = publication.track;
      showRemoteVideo(track);
    }
  });

  buddy.on('trackSubscribed', track => {
    showRemoteVideo(track);
  });
}

const selfDisconnected = (room) => {
  room.localParticipant.tracks.forEach(publication => {
    const attachedElements = publication.track.detach();
    attachedElements.forEach(element => element.remove());
  });
}

const selfConnected = (room) => {
  room.participants.forEach(participant => {
    participant.tracks.forEach(publication => {
      if (publication.track) {
        showRemoteVideo(publication.track);
      }
    });

    participant.on('trackSubscribed', track => {
      showRemoteVideo(track);
    });
  });
}

const connectToRoom = (token) => {
  connect(token.token, {
    name: token.room,
    audio: true,
    video: { width: 640 }
  }).then(room => {
    console.log(`Successfully joined a Room: ${room}`);
    rooms.push(room)
    selfConnected(room);
    room.on('participantConnected', buddyConnected);
    room.on('disconnected', selfDisconnected);
  }, error => {
    console.error('Failed to acquire media:', error.name, error.message);
  });
}

const addLocalVideo = () => {
  createLocalVideoTrack().then((track) => {
    let video = document.getElementById('local-video')
    video.appendChild(track.attach())
  })
}

const setVideoVisible = (visible) => {
  const element = document.getElementById("remote-video");
  if (visible) {
    element.style.display = "flex";
  } else {
    element.style.display = "none";
  }
}

const setUpTwilio = () => {
  const $tokens = document.getElementById("twilio-tokens")
  if (!$tokens) {
    return
  }

  let tokens = $tokens.dataset.twilioTokens
  if (tokens.length < 1) {
    return
  }

  tokens = JSON.parse(tokens)

  const userId = document.cookie
    .split('; ')
    .find(row => row.startsWith('user_id'))
    .split('=')[1];
  const token = tokens[userId]
  setVideoVisible(true)
  addLocalVideo()
  connectToRoom(token)


  // we need to find all the buddies call buttons (start video chat)



  const $hangUpButtons = document.querySelectorAll(".round-hang-up")
  $hangUpButtons.forEach((button) => {
    button.addEventListener('click', (e) => {
      disconnectVideo();
    })
  })
};

export { setUpTwilio }
