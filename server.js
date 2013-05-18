var http = require('http'),
faye = require('./faye/node/faye-node');
var	WebSocket = require('./faye/node/wb/websocket');

var mapClientID2Socket = [];
var mapMobileID2Socket = [];
var mapClient2Mobile = [];

var port = 7000;

var server = http.createServer();

server.on('upgrade', function(request, socket, body) {
  if (WebSocket.isWebSocket(request)) {
    var ws = new WebSocket(request, socket, body);
    console.log('new connection');
    ws.on('message', function(event) {


     var data = JSON.parse(event.data);
     console.log(data);
     console.log(data.cmdType);
     switch(data.cmdType)
     {
      case 'login':
      console.log('login cmdType');
      if( data.sourceType == "client" )
      {
       mapClientID2Socket[data.codeID.toString()] = ws;	
       ws.send("login OK");
     }
     break;
     case 'matching':
     if( data.sourceType == "mobile" )
     {
       console.log("mobile");
       mapMobileID2Socket[data.mobileID.toString()] = ws;

       if( mapClientID2Socket[data.codeID.toString()] )
       {
        console.log("found");
        // mapClientID2Socket[data.codeID.toString()].send("match sucessfully");
        ws.send({status: "ok"});
        mapClientID2Socket[data.codeID.toString()].send(data.cmd);
      }
    }
    break;
    default:
    console.log('error cmdType');
    break;
  }
});

    ws.on('close', function(event) {
      console.log('close', event.code, event.reason);
      ws = null;
    });
  }
});


server.listen(port);

console.log( 'Listening on ' + port );