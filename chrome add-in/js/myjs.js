
chrome.extension.onRequest.addListener(function(request, sender, sendResponse){
		conn(request.data, request.id);
        sendResponse("ok");
});

function conn( code, id )
{
		try
		{
			  Socket = window.MozWebSocket || window.WebSocket,
			  protos = ['foo', 'bar', 'xmpp'],
			  socket = new Socket('ws://localhost:7000/', protos),
			  index  = 0;
		
			  var log = function(text) {
				  console.log(text);
			  };
			  		
			  socket.addEventListener('open', function() {
				log('OPEN: ' + socket.protocol);
				var obj = { cmdType: 'login', sourceType: 'client',  codeID: code+id.toString()};
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
		}
}
