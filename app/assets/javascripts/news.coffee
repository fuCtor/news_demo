# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


#
$ ->
  jQuery('#news_date').datetimepicker
    format: 'd.m.Y H:i T'
    lang:'ru'

  updateChecker = ->
    date = Date.parse($('#news').data('until'))
    if date < Date.now()
      window.location.reload()

  if $('#news').length > 0
    setInterval(updateChecker, 10000)