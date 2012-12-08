# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
a = navigator.userAgent
agent = 'windows'
agent = 'ipad' if a.match(/ipad/i)
agent = 'macintosh' if a.match(/macintosh/i)
agent = 'android' if a.match(/android/i)
agent = 'iphone' if a.match(/iphone/i)
  
jQuery -> 
  $('#device').text agent
  