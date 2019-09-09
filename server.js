var request = require('request');

var headers = {
    'Content-Type': 'text/plain'
};
var num=0;
var dataString = 'c|['+num++ +',4]';

var options = {
    url: 'http://localhost:7896/iot/d?k=4jggokgpepnvsb2uv4s40d59ov&i=camCar001',
    method: 'POST',
    headers: headers,
    body: dataString
};

function callback(error, response, body) {
    if (!error && response.statusCode == 200) {
        console.log(body);
    }
}

request(options, callback);

function intervalFunc() {
  console.log('Cant stop me now!');
  request(options, callback);
  
  var fs = require('fs'); 

//  Reading the value from textfile on local machine
//  var num = fs.readFileSync('/media/sf_Shared/plik.txt', 'utf8');

// Testing the server with value increasing by 1 each second
  num++;

  console.log(num);
  dataString = 'c|['+num+',0]';
  options = {
    url: 'http://localhost:7896/iot/d?k=4jggokgpepnvsb2uv4s40d59ov&i=camCar001',
    method: 'POST',
    headers: headers,
    body: dataString
  };
}

setInterval(intervalFunc, 1000);
