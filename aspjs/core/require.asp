<%

var require = function require(module) {
	if (!require.cache[module]) throw new Error("Module '"+ module +"' is not loaded.");
	return require.cache[module];
};

(function(){
	require.cache = {};
	require.define = function define(name, filename, load) {
		var module = {exports: {}};
		load(module.exports, module, filename, '/aspjs_modules/'+ name, filename);
		require.cache[name] = module.exports;
		
		if ('function' === typeof module.exports) {
			module.exports.__file__ = '/aspjs_modules/'+ name +'/'+ filename;
		} else if ('object' === typeof module.exports) {
			for (var key in module.exports) {
				if ('function' === typeof module.exports[key]) {
					module.exports[key].__name__ = module.exports[key].name() || key;
					module.exports[key].__file__ = '/aspjs_modules/'+ name +'/'+ filename;
				};
			};
		};
	};
})();

%>
