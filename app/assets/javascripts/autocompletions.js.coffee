jQuery ->

  HOST = $('#PLATFORM_HOST').text().replace(/^\s*/,'').replace(/\n/,'');
  word_service = () -> $('#word_service option:selected')[0].value 
  build_url = (term) ->
    gterm = term.replace(/\?/g, '*')
    url = 'http://' + word_service() + '.' + HOST + '/' + gterm + '.json'
  f1 = () -> $(this).addClass('pale')
  f2 = () -> $(this).removeClass('pale')
          
  look_up = () -> 
    word = $('#word').attr('value')
    if word.length > 0
      $("#results").html('--working--')  
    else
      $("#results").html('--enter a word--') 
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
        $('td').hover f1, f2 

  change_word = (x) -> 
    word = x.trim()
    $('#word').val word
    look_up()

  $('#word_service').change () -> look_up()
  $('#word').keyup () -> look_up()

 
     