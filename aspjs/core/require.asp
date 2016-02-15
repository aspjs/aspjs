<%

var require = function require(module) {
	if (!require.cache[module]) throw new Error("Module '"+ module +"' is not loaded.");
	return require.cache[module];
};

;(function(){
	require.cache = {};
	require.define = function define(options, methods) {
		if (options.private) {
			for (var i = 0, l = options.private.length; i < l; i++) {
				options.private[i].__module__ = options.name;
				if (options.file) options.private[i].__file__ = options.file;
			};
		};
		
		require.cache[options.name] = methods;
		for (var name in methods) {
			if ('function' === typeof methods[name]) {
				methods[name].__name__ = name;
				methods[name].__module__ = options.name;
				if (options.file) methods[name].__file__ = options.file;
			};
		};
	};
})();

%>
