<%

var console;

(function(){
	var buffer = Session('__aspjs_console') || [];
	var util = require('util');
	
	var Console = function Console() {};
	Console.define({
		file: 'console.asp'
	}, {
		log: function log() {
			var text = '<!-- [aspjs:log] '+ Array.prototype.slice.call(arguments, 0).map(function itemHandler(item) {
				return util.inspect(item);
			}).join(' ') +' -->\n';
			
			buffer.push(text);
			if (this.flush) Response.Write(text);
			Session('__aspjs_console') = buffer;
		},
		warn: function warn() {
			var text = '<!-- [aspjs:warn] '+ Array.prototype.slice.call(arguments, 0).map(function itemHandler(item) {
				return util.inspect(item);
			}).join(' ') +' -->\n';
			
			buffer.push(text);
			if (this.flush) Response.Write(text);
			Session('__aspjs_console') = buffer;
		},
		error: function error() {
			var text = '<!-- [aspjs:error] '+ Array.prototype.slice.call(arguments, 0).map(function itemHandler(item) {
				return util.inspect(item);
			}).join(' ') +' -->\n';
			
			buffer.push(text);
			if (this.flush) Response.Write(text);
			Session('__aspjs_console') = buffer;
		}
	});
	
	console = new Console();
	console.flush = false;

	__asp.info = function info() {
		var text = '<!-- [aspjs:info] '+ Array.prototype.slice.call(arguments, 0).map(function itemHandler(item) {
			return util.inspect(item);
		}).join(' ') +' -->\n';
		
		buffer.push(text);
		if (this.flush) Response.Write(text);
		Session('__aspjs_console') = buffer;
	};
})();

%>
