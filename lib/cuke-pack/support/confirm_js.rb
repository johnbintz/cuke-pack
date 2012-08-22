def confirm_js
  page.evaluate_script('window.confirm = function() { return true; }')
  page.evaluate_script('window.alert = function() { return true; }')
end
