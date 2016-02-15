<%

;(function(){
	require.define({
		name: 'util',
		file: 'util.asp'
	}, {
		inherits: function inherits(child, parent) {
			for (var key in parent) {
				if (Object.prototype.hasOwnProperty.call(parent, key)) child[key] = parent[key];
			};
			function ctor() {
				this.constructor = child;
			};
			ctor.prototype = parent.prototype;
			child.prototype = new ctor();
			child.__super__ = parent.prototype;
			return child;
		},
		inspect: function inspect(obj, options) {
			options = options || {};
			
			var format = function format(obj, level, wrap) {
				if (obj === undefined) return 'undefined';
				switch (typeof obj) {
					case 'boolean': return obj;
					case 'number': return obj;
					case 'string': return wrap ? JSON.stringify(obj) : obj;
					case 'function':
						if ('function' === typeof obj.inspect) {
							try {
								return format(obj.inspect(), level, false);
							} catch (ex) {
								if (ex.number === -2146823277) {
									// Can't execute code from a freed script
									return Function.prototype.inspect.call(obj);
								} else {
									throw ex;
								}
							};
						};
						return '[function '+ (obj.name() || '<anonymous>') +']'
					case 'object':
						if (!obj) {
							return 'null';
						} else if (Array.isArray(obj)) {
							var txt = [], l = obj.length;
							if (l > 0) {
								for (var i = 0; i < l; i++) {
									txt.push(format(obj[i], level + 1, true));
								};
								return '[\n'+ '  '.repeat(level) + txt.join(',\n' + '  '.repeat(level)) +'\n'+ '  '.repeat(level - 1) +']';
							} else {
								return '[]'
							};
						} else if (Date.isDate(obj)) {
							return obj.toString();
						} else if (RegExp.isRegExp(obj)) {
							return obj.toString();
						} else {
							if ('function' === typeof obj.inspect) {
								try {
									return format(obj.inspect(), level, false);
								} catch (ex) {
									// Can't execute code from a freed script
									if (ex.number !== -2146823277) throw ex;
								};
							};
							var txt = [];
							var keys = Object.keys(obj), l = keys.length;
							if (l > 0) {
								for (var i = 0, l; i < l; i++) {
									txt.push(keys[i] +': '+ format(obj[keys[i]], level + 1, true));
								};
								return '{\n'+ '  '.repeat(level) + txt.join(',\n' + '  '.repeat(level)) +'\n'+ '  '.repeat(level - 1) +'}';
							} else {
								return '{}'
							};
						};
					default:
						return Object.prototype.toString.call(obj)
				}
			};
			return format(obj, 1, options.wrap || false);
		}
	});
	
	require.cache.util.defer = __asp.defer;
})();

%>
