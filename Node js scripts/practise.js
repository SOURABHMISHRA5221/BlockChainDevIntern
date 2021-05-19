/*
var message = "HI";
console.log(message);
*/


/*
var path  = require('path');
var pathObject = path.parse(__filename);
console.log(pathObject);
*/

/*
const total  =require('os');
const t = total.totalmem();
console.log(total.totalmem());
console.log(total.freemem());
console.log(`total free mem:${t}`);
*/

/*
var fs = require('fs');
const file = fs.readdirSync('./');
console.log(file);
*/

/*
var fs = require('fs');
fs.readdir('./',function(err,files){
    if (err) console.log(err);
    else console.log('Results :- ',files);
});
*/

/*
var event = require('events');
var emitter = new event();
emitter.on('Signal',(arg) => {
   console.log(arg);

});
emitter.emit('Signal',{'msg':'Hello World!!'});
*/


/*

var emitter = require('events');

class extended extends emitter{
     
    em(){

       this.emit('Signal',{'ID':7});
    }
    
    lis(a){
      this.on(a,(b)=>{
         console.log(b);
      });

    }

}

var e = new extended();

e.lis('Signal');

e.em();

*/


var http = require('http');

const server = http.createServer((req,res)=>{
     if ( req.url ==='/'){
      res.write('Hello World!!!!');
      res.end();

    }
    if ( req.url === '/other'){
      res.write('Hello Other!!\n');
      res.write(JSON.stringify([1,2,3]));
      res.end();
     }

});

server.listen(3000);
console.log("Available at 3000");