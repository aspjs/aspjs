<%

;(function(){
	Function.prototype.name = function name() {
		if (this.__name__) return this.__name__;
		var match = this.toString().match(/^\n?function\s*([^\(\s]*)\s*\(/);
		return match ? match[1] : '';
	};
	
	Function.prototype.toStack = function toStack() {
		var name = this.name() || '<anonymous>';
		var klass = this.__class__ ? (this.__class__.name() +'.') : '';
		var ctor = this.__constructor__ === true ? '.constructor' : '';
		var module = (this.__class__ ? this.__class__.__module__ : this.__module__) || '';
		var file = this.__file__ || '';
		return '  at '+ klass + name + ctor + (file || module ? (' ('+ module + (module && file ? '/' : '') + file +')') : '');
	};
	
	Function.prototype.define = function define(options, proto) {
		if (arguments.length === 1) {
			proto = options;
			options = {};
		};
		
		if (options.inherits) require('util').inherits(this, options.inherits);
		if (this === this.prototype.constructor) this.__constructor__ = true;
		if (options.file) this.__file__ = options.file;
		
		if (Object.prototype.hasOwnProperty.call(proto, 'toString')) {
			this.prototype['toString'] = proto['toString'];
			proto['toString'].__name__ = 'toString';
			proto['toString'].__class__ = this;
			if (options.file) proto['toString'].__file__ = options.file;
		};
		
		if (Object.prototype.hasOwnProperty.call(proto, 'valueOf')) {
			this.prototype['valueOf'] = proto['valueOf'];
			proto['valueOf'].__name__ = 'valueOf';
			proto['valueOf'].__class__ = this;
			if (options.file) proto['valueOf'].__file__ = options.file;
		};
	
		for (var name in proto) {
			this.prototype[name] = proto[name];
			
			if ('function' === typeof proto[name]) {
				proto[name].__name__ = name;
				proto[name].__class__ = this;
				if (options.file) proto[name].__file__ = options.file;
			};
		};
	};
})();

%>
