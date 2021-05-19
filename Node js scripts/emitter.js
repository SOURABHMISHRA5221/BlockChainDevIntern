const EventEmiter = require('events');
var emitter = new EventEmiter();


emitter.on('msg',function(arg){ // can use =>
  console.log('It worked',arg);
});

emitter.emit('msg',{'id':1,'name':'Sourabh'});
//Note: emit will signal this only to listners available above
//{'key':value}for object like dictionary
//Same emitter will emit and recive