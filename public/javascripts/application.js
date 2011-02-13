// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
console.log("yo face");

jQuery(document).ready(function() {
  console.log("yo face");
  jQuery('.motd').editable('/motds', {
    name: "body",
    indicator: '<img src="/images/waiting.gif" /> loading...',
    cancel: "Cancel",
    submit: "OK"
  });
 });
