document.addEventListener("DOMContentLoaded", function() {
  const selectAllCheckbox = document.getElementById("select-all");
  const trackerCheckboxes = document.querySelectorAll(".tracker-checkbox");

  if (selectAllCheckbox) {
    selectAllCheckbox.addEventListener("change", function() {
      trackerCheckboxes.forEach(function(checkbox) {
        checkbox.checked = selectAllCheckbox.checked;
      });
    });
  }
});
