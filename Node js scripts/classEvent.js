

const ExtendEve = require('./ExtendedEve');
var eve = new ExtendEve();

eve.on('Signal', (arg)=>{
     
    console.log('Thanks',arg);

});

eve.emitSignal();