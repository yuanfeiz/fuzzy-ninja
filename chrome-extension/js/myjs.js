
chrome.extension.onRequest.addListener(function(request, sender, sendResponse){
		conn(request.data, request.id);
        sendResponse("ok");
});

var play = function () {
	console.log("1");
	document.getElementsByClassName("ywp-play-pause")[0].click();
}

var prev = function() {
	document.getElementsByClassName("ywp-prev")[0].click();
}
var next = function() {
	document.getElementsByClassName("ywp-next")[0].click();
}
var silent = function() {
	document.getElementsByClassName("ywp-volume")[0].click();
}
var fullScreen  = function() {
	document.getElementsByClassName("ywp-expand-collapse-xl")[0].click();
}

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
				var obj = { cmdType: 'login', sourceType: 'client',  codeID: code};
				socket.send(JSON.stringify(obj));
			  });
		
			  socket.onerror = function(event) {
				log('ERROR: ' + event.message);
			  };
		
			  socket.onmessage = function(event) {
				log('MEAGE: ' + event.data);
				if (event.data == "play") {
					play();
				}
				else if (event.data == "prev") {
					prev();
				}
				else if (event.data == "next") {
					next();
				}
				else if (event.data == "silent") {
					silent();
				}
				else if (event.data == "fullScreen") {
					fullScreen();
				}

				// var obj = { cmdType: 'matching', sourceType: 'mobile', mobileID: '777777', codeID: '88888', cmd: '100000'};
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
