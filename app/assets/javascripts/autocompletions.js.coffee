
a = navigator.userAgent
agent = 'windows'
agent = 'ipad' if a.match(/ipad/i)
agent = 'macintosh' if a.match(/macintosh/i)
agent = 'android' if a.match(/android/i)
agent = 'iphone' if a.match(/iphone/i)
  
jQuery ->
  $("#results").addClass 'Hide'
  HOST = $('#PLATFORM_HOST').text().replace(/^\s*/,'').replace(/\n/,'');
  word_service = () ->
    $('#word_service option:selected')[0].value 
  build_url = (term) ->
    gterm = term.replace(/\?/g, '*')
    url = 'http://' + word_service() + '.' + HOST + '/' + gterm + '.json'
  ajax_call = (request,response) ->
    $.ajax
      url: build_url request.term
      dataType: 'jsonp'
      data:
        pagesize: 20
        dictionary: $('#DICTIONARY').text()
      success: (data) ->
        if word_service() != 'suggestions'
          msg = data
          $('#results').addClass 'hide'
        else
          msg = [label: 'See Below']
          $('#results').removeClass('hide').html('')
        response msg  
  $('#device').text 'on your ' + agent
  $('#word').autocomplete
    source: (request,response) -> ajax_call request, response
    minLength: 2,
    select: (event,ui) -> $('#word').attr 'value', this.value

  $('#word_service').change () ->
      word = word = $('#word').attr('value')  
      return if word.length < 2
      $.ajax 
        url: build_url word
        dataType: "jsonp"
        minLength: 2
        data:
          pagesize: 20,
          dictionary: $('DICTIONARY').text()
        success: (data) ->
          $('#results').removeClass('hide').html('')
          if word_service() == 'suggestions' 
            $(data).appendTo $('#results')
          else
          $.map data, 
            (item) -> $('<span>'+item+'</span><br/>').appendTo $('#results')   