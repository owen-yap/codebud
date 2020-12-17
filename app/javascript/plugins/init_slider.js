const initSlider = () => {
  // check if page have slider  before loading this
  const slider = document.getElementById("question_min_price");
  const output = document.getElementById('price');
  // If there is a slider

  if (slider) {
    output.innerHTML = slider.value;
  }
  // add listener for change in the range, if so, change html output
  slider.addEventListener("change", (event) => {
    output.innerHTML = slider.value;
  });
};

export { initSlider };
