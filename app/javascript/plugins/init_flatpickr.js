import flatpickr from "flatpickr";

const initFlatpickr = () => {

  const startTimeInput = document.getElementById('question_start_time');

  const endTimeInput = document.getElementById('question_end_time');

  // check if the page have these elements, ie time picker
  if (startTimeInput && endTimeInput) {
    // to not enable user to select end time before start time selected
    endTimeInput.disabled = true;

    // flatpicker.js.org/options   default time picker is not enabled
    const startDateFp = flatpickr(startTimeInput, {
      minDate: "today",
      enableTime: true,
      dateFormat: "d-m-Y, h:i K"  // time formatting
    });

    // to check -> console.log('im in the file');

    startTimeInput.addEventListener("change", (event) => {
      // startDateFp.selectedDates[0]);
      // Mon Dec 14 2020 12:00:00 GMT+0800

      if (startTimeInput != "") {
        endTimeInput.disabled = false;
      }
      flatpickr(endTimeInput, {
        minDate: startDateFp.selectedDates[0],
        enableTime: true,
        dateFormat: "d-m-Y, h:i K"  // time formatting
      });

    });

  };
};

export { initFlatpickr };
