var http = require('http'),
    faye = require('./faye/node/faye-node');

var bayeux = new faye.NodeAdapter({mount: '/faye', timeout: 45});
var port = 8000;

var handleRequest = function(request, response) {
  var path = (request.url === '/') ? '/index.html' : request.url;

  fs.readFile(PUBLIC_DIR + path, function(err, content) {
    var status = err ? 404 : 200;
    try {
      response.writeHead(status, {'Content-Type': 'text/html'});
      response.write(content || 'sdfsdfsf Not found');
      response.end();
    } catch (e) {}
  });
};


var server = http.createServer(handleRequest);

bayeux.attach(server);
server.listen(port);

bayeux.getClient().subscribe('/chat/*', function(message) {
  console.log('[' + message.user + ']: ' + message.message);
});

bayeux.bind('publish', function(clientId, channel, data) {
  console.log('[Publish] ' + clientId + ' -> ' + channel + ' -> ' + data.text);
});

bayeux.bind('subscribe', function(clientId, channel) {
  console.log('[SUBSCRIBE] ' + clientId + ' -> ' + channel);
});

bayeux.bind('unsubscribe', function(clientId, channel) {
  console.log('[UNSUBSCRIBE] ' + clientId + ' -> ' + channel);
});

bayeux.bind('disconnect', function(clientId) {
  console.log('[DISCONNECT] ' + clientId);
});

console.log( 'Listening on ' + port );