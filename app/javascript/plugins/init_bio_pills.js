const initBioPills = () => {
  // JS for turning checkboxes into pills
  const newBioForm = document.querySelector('form#new_bio');
  const editBioForm = document.querySelector('form#edit_skills');


  if (newBioForm || editBioForm) {
    const skillCheckboxArray = document.querySelectorAll('.skills-item > input');
    // iterate etc
    // apply skills-selector class to all checkboxes
    skillCheckboxArray.forEach((checkbox) => {
      checkbox.classList.add("skills-selector");
    });
  }
}

export { initBioPills };