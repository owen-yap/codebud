const initBioPills = () => {
  // JS for turning checkboxes into pills
  const bioForm = document.querySelector('form#new_bio');

  if (bioForm) {
    const skillCheckboxArray = document.querySelectorAll('.skills-item > input');
    // iterate etc
    // apply skills-selector class to all checkboxes
    skillCheckboxArray.forEach((checkbox) => {
      checkbox.classList.add("skills-selector");
    });
  }
}

export { initBioPills };