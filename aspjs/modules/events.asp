<%

require.define('events', 'events.asp', function(exports, module, __filename, __dirname){
	var EventEmitter = function EventEmitter() {
		this._events = {};
	};
	
	EventEmitter.define({
		file: '/aspjs/core/events.asp'
	}, {
		emit: function emit() {
			var type = Array.prototype.shift.call(arguments);
			
			if (this._events[type]) {
				var listeners = this._events[type].slice(0);
				
				for (var i = 0, l = listeners.length; i < l; i++) {
					listeners[i].apply(null, arguments);
				};
			};
			
			return this;
		},
		on: function on(type, handler) {
			if (!this._events[type]) this._events[type] = [];
			
			if (this._events.indexOf(handler) === -1) {
				this._events.push(handler);
			};
			
			return this;
		},
		once: function once(event, handler) {
			var self = this;
			var fce = function intermediateHandler() {
				self.removeListener(event, fce);
				handler.apply(null, arguments);
			};
			
			return this.on(event, fce);
		},
		removeListener: function off(event, handler) {
			if (this._events[event]) {
				if (!this._events[event]) return this;
				var index = this._events[event].indexOf(handler);
				if (index !== -1) {
					this._events[event].splice(index, 1);
				};
			};
			
			return this;
		}
	});
	
	module.exports = {
		EventEmitter: EventEmitter
	};
});

%>
