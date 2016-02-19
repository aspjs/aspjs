<%

var app;

(function(){
	var params = {};
	var settings = {
		env: 'development',
		'views': '/views',
		'view engine': null,
		'x-powered-by': 'asp.js v'+ __asp.version
	};

	app = {
		found: false,
		engines: {},
		all: function all() {
			if (arguments.length <= 1) return this;
			
			var keys = [], route = Array.prototype.shift.call(arguments);
			var path = require('path-to-regexp')(route, keys);
			var req = Object.clone(this.request), res = Object.clone(this.response);
			req.params = {};
			res.render = function render(script, locals) {
				if (/\.(asp|inc)$/.test(script)) {
					return this.execute(script, {params: req.params, locals: locals});
				} else {
					return app.response.render(script, locals);
				};
			};
			
			matches = path.exec(this.request.url);
			if (matches) {
				__asp.info('routing to '+ route);
				stack = Array.prototype.slice.call(arguments);
				this.found = true;

				require('async').forEachOf(keys, function(key, index, next) {
					if (params[key.name]) {
						params[key.name](matches[index + 1], function(err, value) {
							if (err) return next(err);
							req.params[key.name] = value;
							next();
						});
					} else {
						req.params[key.name] = matches[index + 1];
						next();
					};
				}, function(err) {
					if (err) return app.response.error(err);
					
					next = function(err) {
						if (err) return app.response.error(err);
						if (stack.length === 0) {
							app.response.transfer(404);
							return;
						};
						
						stack.shift().call(null, req, res, next);
					};
					next();
				});
			};
			
			return this;
		},
		'delete': function get() {
			if (this.request.method === 'DELETE') this.all.apply(this, arguments);
			return this;
		},
		engine: function engine(ext, callback) {
			if (!Array.isArray(ext)) ext = [ext];
			for (var i = 0, l = ext.length; i < l; i++) this.engines[ext[i]] = callback;
			return this;
		},
		get: function get() {
			if (arguments.length === 1) {
				return settings[arguments[0]];
			};
			
			if (this.request.method === 'GET') this.all.apply(this, arguments);
			return this;
		},
		param: function param(name, callback) {
			params[name] = callback;
		},
		post: function set() {
			if (this.request.method === 'POST') this.all.apply(this, arguments);
			return this;
		},
		render: function render(script, locals, callback) {
			var ext = script.match(/\.([^\.\\\/]+)$/), self = this;
			if (ext) ext = ext[1];

			if (app.engines[ext]) {
				if (script.substr(0, 1) !== '/') script = this.get('views') +'/'+ script;
				app.engines[ext](script, {globals: locals || {}}, callback);
			} else {
				util.defer(callback, new Error("No engine to process '"+ ext +"' files."));
			};
			
			return this;
		},
		set: function set(key, value) {
			settings[key] = value;
			return this;
		}
	};
})();

%>
