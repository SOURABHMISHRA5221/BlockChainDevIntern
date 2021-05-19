const EventEmiter = require('events');


class ExtendedEvent extends EventEmiter{

      emitSignal(){

        this.emit('Signal',{'task':'hello'});

      }

}

module.exports = ExtendedEvent;