var http = require('http'),
    faye = require('./faye/node/faye-node');
var	WebSocket = require('./faye/node/wb/websocket');

var port = 8000;

var server = http.createServer();

server.on('upgrade', function(request, socket, body) {
  if (WebSocket.isWebSocket(request)) {
    var ws = new WebSocket(request, socket, body);

    ws.on('message', function(event) {
      ws.send(event.data+"asasdasdasds");
    });

    ws.on('close', function(event) {
      console.log('close', event.code, event.reason);
      ws = null;
    });
  }
});

server.listen(port);

console.log( 'Listening on ' + port );