<%
(function(){
	if (__app.response) return;

	__app.response = {
		headers: {},
		clear: function clear() {
			Response.clear();
			return this;
		},
		cookie: function cookie(name, value, options) {
			var keys = [];
			keys.push(encodeURIComponent(name) +'='+ encodeURIComponent(value));
			keys.push('Path=/');

			if (options.maxAge) keys.push('Max-Age='+ (options.maxAge / 1000));
			if (options.httpOnly) keys.push('HttpOnly');
			if (options.secure) keys.push('Secure');
			if (options.domain) keys.push('Domain='+ encodeURIComponent(options.domain));

			this.set('set-cookie', keys.join('; '));
		},
		end: function end(msg) {
			if (msg) this.send(msg);
			__asp.finalize(true);
			Response.end();
			return this;
		},
		error: function error(err) {
			this.clear();
			this.status(400);
			err.name = err.name; // make name enumerable
			Session('__aspjs_error') = err;
			Response.end();
			return this;
		},
		execute: function execute(script, options) {
			__asp.info('executing '+ script);
			try {
				options = options || {};
				options.app = __app;
				options.parent = __script.name;
				options.script = script;
				Session('__aspjs_execute') = options;
				Server.execute(script);
			} catch (ex) {
				ex = new Error('Failed to execute \''+ script +'\'. '+ ex.message);
				ex.stack = ex.stack || Error.captureStackTrace();
				throw ex;
			};
			__asp.info('executed '+ script);
			return this;
		},
		flush: function flush() {
			Response.flush();
			return this;
		},
		get: function(name) {
			if (name.toLowerCase() === 'content-type' && !this.headers['content-type']) return 'text/html; charset=UTF-8';
			return this.headers[name.toLowerCase()];
		},
		json: function json(json) {
			this.set('content-type', 'application/json; charset=utf-8');
			this.send(JSON.stringify(json));
			this.end();
			return this;
		},
		location: function type(url) {
			this.set("Location", url);
			return this;
		},
		send: function send(msg) {
			if (Buffer.isBuffer(msg)) {
				Response.binaryWrite(msg._buffer);
			} else {
				Response.write(msg);
			};
			return this;
		},
		sendFile: function sendFile(path) {
			this.set('content-type', require('mime').lookup(path));
			Server.transfer(path);
		},
		set: function set(field, value) {
			if ('object' === typeof field) {
				for (var name in field) {
					this.headers[name.toLowerCase()] = field[name];
					Response.addHeader(name.toLowerCase(), field[name]);
				};
			} else {
				this.headers[field.toLowerCase()] = value;
				Response.addHeader(field.toLowerCase(), value);
			};
			return this;
		},
		status: function status(code) {
			if (!code) return parseInt(Response.Status);
			
			switch (parseInt(code)) {
				case 301: Response.Status = "301 Moved Permanently"; return this;
				case 302: Response.Status = "302 Found"; return this;
				case 400: Response.Status = "400 Bad request"; return this;
				case 403: Response.Status = "403 Forbidden"; return this;
				case 404: Response.Status = "404 Not found"; return this;
				case 500: Response.Status = "500 Internal Error"; return this;
				default: Response.Status = String(code); return this;
			};
		},
		redirect: function redirect(code, url) {
			if ('string' === typeof code) {
				url = code;
				code = 302;
			};
			
			this.clear();
			this.status(code);
			this.location(url);
			this.end();
			return this;
		},
		render: function render(script, locals) {
			var ext = script.match(/\.([^\.\\\/]+)$/), self = this;
			if (ext) {
				ext = ext[1];
			} else {
				ext = 'asp';
				script += '.asp';
			}
			
			if (script.substr(0, 1) !== '/') script = __app.get('views') +'/'+ script;

			if (ext === 'asp' || ext === 'inc') {
				return this.execute(script, {
					locals: locals
				});
			} else {
				if (__app.engines[ext]) {
					__app.render(script, locals, function(err, data) {
						if (err) return self.error(err);
						self.send(data);
					});
				} else {
					try {
						Server.execute(script);
					} catch (ex) {
						ex = new Error('Failed to execute \''+ script +'\'. '+ ex.message);
						ex.stack = ex.stack || Error.captureStackTrace();
						throw ex;
					};
				};
				return this;
			};
		},
		transfer: function(path) {
			if ('number' === typeof path) {
				this.clear();
				this.status(path);
				Response.end();
			} else {
				__asp.info('transfering to '+ script);
				try {
					options.parent = __script.name;
					options.script = script;
					Session('__aspjs_transfer') = options;
					Server.transfer(script);
				} catch (ex) {
					ex = new Error('Failed to transfer to \''+ script +'\'. '+ ex.message);
					ex.stack = ex.stack || Error.captureStackTrace();
					throw ex;
				};
			};
		},
		type: function type(type) {
			this.set("Content-Type", type);
			return this;
		}
	};
})();

%>
