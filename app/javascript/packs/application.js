// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")
require("trix")
require("@rails/actiontext")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";

// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';
import { initFlatpickr } from '../plugins/init_flatpickr';
import { initAnime } from './../plugins/init_anime.js';
import { initBioPills } from '../plugins/init_bio_pills';
import { initChatroomCable } from '../channels/chatroom_channel'
import { initFormattingToPreBlocks } from '../plugins/init_prism'
import { initMsgStyle } from '../plugins/init_msg_style'
import { setUpTwilio } from '../plugins/init_twilio'
import { initStarRating } from '../plugins/init_star_rating';
import { initSlider } from '../plugins/init_slider';

// when the page have fully loaded then call these js plugins so the dom are fully loaded and can be targeted
document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  // initSelect2();
  initAnime();
  initFlatpickr();
  initBioPills();
  initChatroomCable();
  initFormattingToPreBlocks();
  Prism.highlightAll();
  // initMsgStyle();
  setUpTwilio();
  initStarRating();
  initSlider();
});
