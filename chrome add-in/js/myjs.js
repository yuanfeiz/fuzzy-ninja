<<<<<<< HEAD

chrome.extension.onRequest.addListener(function(request, sender, sendResponse){
	
		alert(request.data);
        sendResponse("666666666");
});
=======
/*try
{
	  Socket = window.MozWebSocket || window.WebSocket,
	  protos = ['foo', 'bar', 'xmpp'],
	  socket = new Socket('ws://localhost:8000/', protos),
	  index  = 0;

	  var log = function(text) {
		  console.log(text);
	  };

	  socket.addEventListener('open', function() {
		log('OPEN: ' + socket.protocol);
		var obj = { cmdType: 'Actor', sourceType: 'client'};
		socket.send(JSON.stringify(obj));
	  });

	  socket.onerror = function(event) {
		log('ERROR: ' + event.message);
	  };

	  socket.onmessage = function(event) {
		log('MESSAGE: ' + event.data);
	  };

	  socket.onclose = function(event) {
		log('CLOSE: ' + event.code + ', ' + event.reason);
	  };
}
catch( e )
{
	alert(e);
}*/
>>>>>>> origin/nodejs
