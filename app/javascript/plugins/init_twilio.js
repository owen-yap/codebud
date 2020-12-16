const { connect, createLocalTracks } = require('twilio-video');

const connectRoom = (token) => {
  connect(token.token, {
    name: token.room,
    audio: true,
    video: { width: 640 }
  }).then(room => {
    console.log(`Successfully joined a Room: ${room}`);
    room.on('participantConnected', participant => {
      console.log(`A remote Participant connected: ${participant}`);
    });
  }, error => {
    console.error(`Unable to connect to Room: ${error.message}`);
  });
}

const captureTracks = (token) => {
  createLocalTracks({
    audio: true,
    video: { width: 640 }
  }).then((localTracks) => {
    const localContainer = document.getElementById("local-video");
    localTracks.forEach((track) => {
      localContainer.appendChild(track.attach());
    });
    return connect(token.token, {
      name: token.room,
      tracks: localTracks
    });
  }).then(room => {
    console.log(`Connected to Room: ${room.name}`);
    displayCurrentRemote(room);
    displayRemote(room);
    document.getElementById('hang-up').addEventListener('click', (e) => {
      disconnectVideo(room);
    });
  });
}

const displayRemote = (room) => {
  room.on('participantConnected', participant => {
    console.log(`Participant "${participant.identity}" connected`);

    participant.tracks.forEach(publication => {
      if (publication.isSubscribed) {
        const track = publication.track;
        document.getElementById('remote-media-div').appendChild(track.attach());
      }
    });

    participant.on('trackSubscribed', track => {
      document.getElementById('remote-media-div').appendChild(track.attach());
    });
  });
}

const displayCurrentRemote = (room) => {
  room.participants.forEach(participant => {
    participant.tracks.forEach(publication => {
      if (publication.track) {
        document.getElementById('remote-media-div').appendChild(publication.track.attach());
      }
    });

    participant.on('trackSubscribed', track => {
      document.getElementById('remote-media-div').appendChild(track.attach());
    });
  });
}

const disconnectVideo = (room) => {
  room.on('disconnected', room => {
    // Detach the local media elements
    room.localParticipant.tracks.forEach(publication => {
      const attachedElements = publication.track.detach();
      attachedElements.forEach(element => element.remove());
    });
  });

  // To disconnect from a Room
  room.disconnect();
  const url = document.getElementById("referrer").dataset.referrer
  window.location.href = url;
}

const setUpTwilio = () => {
  let tokens = document.getElementById("twilio-tokens");
  if (!tokens) {
    return
  }

  tokens = JSON.parse(tokens.dataset.twilioTokens);
  const userId = document.cookie
    .split('; ')
    .find(row => row.startsWith('user_id'))
    .split('=')[1];

  const token = tokens[userId];
  connectRoom(token);
  captureTracks(token);
}
// const rooms = [];

// const connectToRoom = (token) => {
//   connect(token.token, {
//     name: token.room,
//     audio: true,
//     video: { width: 640 }
//   }).then(room => {
//     console.log(`Successfully joined a Room: ${room}`);
//     rooms.push(room);
//     room.on('participantConnected', buddyConnected);
//     // room.on('disconnected', selfDisconnected);
//   }, error => {
//     console.error('Failed to acquire media:', error.name, error.message);
//   });
// }

// const buddyConnected = (buddy) => {
//   console.log("buddy connected");
//   buddy.tracks.forEach(publication => {
//     if (publication.isSubscribed) {
//       const track = publication.track;
//       showRemoteVideo(track);
//     }
//   });
//   buddy.on('trackSubscribed', track => {
//     showRemoteVideo(track);
//   });
// }

// const setVideoVisible = (visible) => {
//   const element = document.getElementById("remote-video");
//   if (visible) {
//     element.style.display = "flex";
//   } else {
//     element.style.display = "none";
//   }
// }

// const showRemoteVideo = (track) => {
//   // Append the remote track to the div and update videoElement class
//   const videoElement = document.getElementById('remote-video');
//   videoElement.appendChild(track.attach());
//   // videoElement.classList.remove('waiting');
//   // videoElement.classList.add('connected');
// }


// const selfDisconnected = (room) => {
//   room.localParticipant.tracks.forEach(publication => {
//     const attachedElements = publication.track.detach();
//     attachedElements.forEach(element => element.remove());
//   });
// }

// const disconnectVideo = () => {
//   // Removes all videos
//   const remoteVideo = document.getElementById('remote-video');
//   setVideoVisible(false);
//   // remoteVideo.classList.remove('connected');
//   // remoteVideo.classList.add('waiting');
//   rooms.forEach((room) => {
//     console.log(room);
//     room.disconnect();
//     room.localParticipant.tracks.forEach((track) => {
//       console.log(track);
//       track.disable();
//       track.stop();
//     });
//   });
// }

// const selfConnected = (room) => {
//   room.participants.forEach(participant => {
//     participant.tracks.forEach(publication => {
//       if (publication.track) {
//         showRemoteVideo(publication.track);
//       }
//     });

//     participant.on('trackSubscribed', track => {
//       showRemoteVideo(track);
//     });
//   });
// }

// const shareScreen = (room) => {
//   // const stream = navigator.mediaDevices.getDisplayMedia();
//   // const screenTrack = createLocalVideoTrack(stream.getTracks()[0]);
//   // room.localParticipant.publishTrack(screenTrack);
//   // showRemoteVideo(screenTrack);

//   navigator.mediaDevices.getDisplayMedia().then(stream => {
//     screenTrack = new Twilio.Video.LocalVideoTrack(stream.getTracks()[0]);
//     room.localParticipant.publishTrack(screenTrack);
//   }).catch(() => {
//     alert('Could not share the screen.')
//   });
// }

// const addLocalVideo = () => {
//   createLocalVideoTrack().then((track) => {
//     let video = document.getElementById('local-video')
//     video.appendChild(track.attach())
//   })
// }

// const setUpTwilio = () => {
//   const $tokens = document.getElementById("twilio-tokens")
//   if (!$tokens) {
//     return
//   }

//   let tokens = $tokens.dataset.twilioTokens
//   if (tokens.length < 1) {
//     return
//   }

//   tokens = JSON.parse(tokens)

//   const userId = document.cookie
//     .split('; ')
//     .find(row => row.startsWith('user_id'))
//     .split('=')[1];
//   const token = tokens[userId];

//   const videoCallButton = document.getElementById('video-call');
//   videoCallButton.addEventListener('click', (e) => {
//     setVideoVisible(true);
//     addLocalVideo();
//     connectToRoom(token);
//     console.log("iansoasc");
//   });

//   const hangUpButton = document.querySelector(".round-hang-up");
//   hangUpButton.addEventListener('click', (e) => {
//     let video = document.getElementById('local-video')
//     disconnectVideo();
//   });

//   const screenShareButton = document.querySelector(".screen-share");
//   screenShareButton.addEventListener('click', (e) => {
//     shareScreen(token.room);
//   });
// };

export { setUpTwilio }
