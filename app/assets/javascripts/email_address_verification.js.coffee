$ ->
  email_input = $('#user_email')
  email_input.on 'input', (e) ->
    if e.target.defaultValue == e.target.value
      $('#email-address-field').removeClass('active')
    else
      $('#email-address-field').addClass('active')