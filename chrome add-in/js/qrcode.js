 console.log(-1);
 $(document).ready(
 	function()
 	{
<<<<<<< HEAD
 		/*console.log(0);
        chrome.tabs.getSelected(null, 
        	function(tab) {
            	chrome.tabs.sendRequest(tab.id,function(response){
            			console.log(1);
                		jQuery(function(){
							Query('#output').qrcode({width: 128,height: 128,text: "Size doesn't matter"});
						});
                	});
					
            });*/
			
			chrome.tabs.getSelected(null, function(tab) 
			{
				alert(tab.id);
            	chrome.tabs.sendRequest(tab.id, {data: 3333}, 
				function(response){
                	console.log(response);
					    });
			
			});
=======
		
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
        
>>>>>>> origin/nodejs
    });

