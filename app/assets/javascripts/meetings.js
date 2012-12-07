$(document).ready(function() {
  $("[data-behaviour~='datepicker']").datepicker({
    "format": "yyyy-mm-dd",
    "weekStart": 1,
    "autoclose": true
  });
});