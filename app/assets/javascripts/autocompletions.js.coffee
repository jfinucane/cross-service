
a = navigator.userAgent
agent = 'windows'
agent = 'ipad' if a.match(/ipad/i)
agent = 'macintosh' if a.match(/macintosh/i)
agent = 'android' if a.match(/android/i)
agent = 'iphone' if a.match(/iphone/i)
  
jQuery ->
  change_word = (x) -> 
    console.log 'The word is -'+x.trim()+'-'
    $('#word').val x.trim()
  $("#results").addClass 'hide'
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
          $('#results').removeClass('hide').html(data)
          $('td').click () ->  change_word(this.innerHTML)
          response []  
  $('#word').autocomplete
    source: (request,response) -> ajax_call request, response
    minLength: 2,
    select: (event,ui) -> $('#word').attr 'value', this.value

  $('#word_service').change () ->
      word = $('#word').attr('value')  
      return if word.length < 2
      $.ajax 
        url: build_url word
        dataType: "jsonp"
        minLength: 2
        data:
          pagesize: 20,
          dictionary: $('DICTIONARY').text()
        success: (data) ->
          $('#results').removeClass('hide').html(data)
          $('td').click () ->  change_word(this.innerHTML)
  

     