var fs = require('fs');
var dummyjson = require('dummy-json');
var template = '[{{#repeat 100}}  { "x": {{number 100}}, "y": {{number 100}} } {{/repeat}}]';
var result = dummyjson.parse(template);
console.log(result);

fs.appendFile('data.json', result, function (err) {});