import flatpickr from "flatpickr";

const initFlatpickr = () => {

  const startTimeInput = document.getElementById('question_start_time');

  const endTimeInput = document.getElementById('question_end_time');

  if (startTimeInput && endTimeInput) {

    endTimeInput.disabled = true;

    const startDateFp = flatpickr(startTimeInput, {
      minDate: "today",
      enableTime: true,
      dateFormat: "d-m-Y, h:i K"
    });

    startTimeInput.addEventListener("change", (event) => {

      if (startTimeInput != "") {
        endTimeInput.disabled = false;
      }
      flatpickr(endTimeInput, {
        minDate: startDateFp.selectedDates[0],
        enableTime: true,
        dateFormat: "d-m-Y, h:i K"
      });

    });

  };
};

export { initFlatpickr };
