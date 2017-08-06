<%

var require = function require(module) {
	if (!require.cache[module]) throw new Error("Module '"+ module +"' is not loaded.");
	return require.cache[module];
};

require.cache = {};

var define = function define(name, factory) {
	if (require.cache[name]) return;
	
	var module = {exports: {}};
	factory(require, module.exports, module, Server.mapPath('/aspjs_modules/'+ name +'/index.asp'), Server.mapPath('/aspjs_modules/'+ name));
	require.cache[name] = module.exports;
	
	if ('function' === typeof module.exports) {
		module.exports.__file__ = '/aspjs_modules/'+ name +'/index.asp';
	} else if ('object' === typeof module.exports) {
		for (var key in module.exports) {
			if ('function' === typeof module.exports[key]) {
				module.exports[key].__name__ = module.exports[key].name() || key;
				module.exports[key].__file__ = '/aspjs_modules/'+ name +'/index.asp';
			};
		};
	};
};
%>
