<%

var app;

(function(){
	var params = {};
	var settings = {
		env: 'development'
	};
	
	app = {
		found: false,
		all: function all() {
			if (arguments.length <= 1) return this;
			
			var keys = [], route = Array.prototype.shift.call(arguments);
			var path = require('path-to-regexp')(route, keys);
			var req = Object.clone(this.request), res = Object.clone(this.response);
			req.params = {};
			res.render = function(url, locals) {
				if (/\.asp$/.test(url)) {
					return this.execute(url, {params: app.request.params});
				} else {
					return app.response.render(url);
				};
			};
			
			matches = path.exec(this.request.url);
			if (matches) {
				__asp.info('routing to '+ route);
				stack = Array.prototype.slice.call(arguments);
				this.found = true;

				async.forEachOf(keys, function(key, index, next) {
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
		set: function set(key, value) {
			settings[key] = value;
			return this;
		}
	};
})();

%>
