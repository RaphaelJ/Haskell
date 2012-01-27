var fs = require('fs');
var http = require('http');

fs.readFile('/image.jpeg', function(error, content) {
    http.createServer(function (req, res) {
        res.writeHead(200, {'Content-Type': 'text/jpeg'})
        res.end(content);
    }).listen(8080, "127.0.0.1");
});
