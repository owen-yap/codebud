const initSlider = () => {
  // check if page have slider  before loading this
  const slider = document.getElementById("question_budget");
  const bubble = document.getElementById("price");
  // If there is a slider

  if (slider) {
    bubble.innerHTML = slider.value;
    slider.addEventListener("input", () => {
      setBubble(slider, bubble);
    });
  }
  // add listener for change in the range, if so, change html output
  // slider.addEventListener("change", (event) => {
  //   bubble.innerHTML = slider.value;
  // });

  function setBubble(slider, bubble) {
    const val = slider.value;
    const min = slider.min ? slider.min : 0;
    const max = slider.max ? slider.max : 100;
    const newVal = Number(((val - min) * 100) / (max - min));
    bubble.innerHTML = val;

    // Sorta magic numbers based on size of the native UI thumb
    bubble.style.left = `calc(${newVal}% + (${8 - newVal * 0.15}px))`;
  }
};

export { initSlider };
