$(function() {
	function log( message ) {
	    $( "<div>" ).text( message ).prependTo( "#log" );
	    $( "#results" ).scrollTop( 0 );
	}
  $('#result').addClass('hide');
	var HOST = $('#PLATFORM_HOST').text().replace(/^\s*/,'').replace(/\n/,'');
  function word_service (){return ($('#word_service option:selected')[0].value)}
  function build_url (term){
    url ='http://' + word_service() + '.' + HOST + '/' + term + '.json'; 
    return(url)
  }
	function ajax_call ( request, response ) {
	        $.ajax({
	            url: build_url(request.term),
	            dataType: "jsonp",
	            data: {
	                pagesize: 20,
	                dictionary: 'sowpods'
	            },
	            success: function( data ) {
                 var msg; 
                 if (word_service() != 'suggestions') {
                     msg = data; 
                     $('#results').addClass('hide');
                   }
                  else {
                     msg = [{label: 'See Below'}];
                     $('#results').removeClass('hide').html('');
                     $(data).appendTo($('#results'));
                  }
	            	response (  msg ) }
	        });
	    }
	$( "#word" ).autocomplete({
	    source: function( request, response ) {
	        ajax_call(request,response)	
	    },
	    minLength: 2,
	    select: function( event, ui ) {
	        $('#word').attr('value', this.value)
	    }
	});
	$('#word_service').change(
		function(){
      var word = $('#word').attr('value');
      if (word.length < 2)
        return;
			$.ajax({
        url: build_url(word),
        dataType: "jsonp",
         minLength: 2,
         data: {
                  pagesize: 20,
                  dictionary: 'sowpods'
              },
        success: function( data ) { 
          $('#results').removeClass('hide').html('');
          if (word_service() == 'suggestions') 
            $(data).appendTo($('#results'));
          else
          $.map(data, function(item){
              $('<span>'+item+'</span><br/>').appendTo($('#results')); 
           }); 
        }
      });
		}
	);
});
