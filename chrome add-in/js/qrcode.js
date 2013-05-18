 console.log(-1);
 $(document).ready(
 	function()
 	{
		
		var rand = Math.random().toString();
		localStorage['rand'] = localStorage['rand'] || rand;
		
		var code = localStorage['rand'];
		
		jQuery(
		function(){
			Query('#output').qrcode({width: 128,height: 128,text: code});
		}
		);
       
		try
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
				var obj = { cmdType: 'login', sourceType: 'client',  codeID: code};
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
        
    });

