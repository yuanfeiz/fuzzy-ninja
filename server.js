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

    ws.on('message', function(event) {
      ws.send(event.data);
      console.log("incoming data: " + event.data);
    });

    ws.on('close', function(event) {
      console.log('close', event.code, event.reason);
      ws = null;
    });
  }
});

server.listen(port);

console.log( 'Listening on ' + port );
