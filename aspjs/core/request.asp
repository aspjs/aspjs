<%

(function(){
	if (__app.request) return;

	__app.request = {
		body: {},
		cookies: {},
		headers: {},
		hostname: String(Request.ServerVariables('HTTP_HOST')),
		ip: String(Request.ServerVariables('REMOTE_ADDR')),
		method: String(Request.ServerVariables('REQUEST_METHOD')),
		port: parseInt(Request.ServerVariables('SERVER_PORT')),
		protocol: Request.ServerVariables('HTTPS') === 'on' ? 'https' : 'http',
		query: {},
		session: {},
		params: {},
		secure: Request.ServerVariables('HTTPS') === 'on',
		url: String(Request.ServerVariables('URL')),
		xhr: false
	};

	var e = new Enumerator(Request.ServerVariables), i;
	while (!e.atEnd()) {
		i = e.item();
		if (i.substr(0, 5) === 'HTTP_') {
			__app.request.headers[i.substr(5).toLowerCase().replace(/_/g, '-')] = String(Request.ServerVariables(i));
		};
		e.moveNext();
	};
	
	if (__app.request.headers['x-original-url']) {
		__app.request.url = __app.request.headers['x-original-url'];
		var q = __app.request.url.indexOf('?');
		if (q !== -1) __app.request.url = __app.request.url.substr(0, q);
	};
	if (__app.request.headers['x-requested-with'] === 'XMLHttpRequest') __app.request.xhr = true;
	
	var e = new Enumerator(Request.Cookies), i;
	while (!e.atEnd()) {
		i = e.item();
		__app.request.cookies[i] = String(Request.Cookies(i));
		e.moveNext();
	};
	
	var e = new Enumerator(Request.QueryString), i;
	while (!e.atEnd()) {
		i = e.item();
		__app.request.query[i] = String(Request.QueryString(i));
		e.moveNext();
	};
	
	var e = new Enumerator(Session.Contents), i;
	while (!e.atEnd()) {
		i = e.item();
		if (!/^__aspjs_/.test(i)) __app.request.session[i] = Session.Contents(i);
		e.moveNext();
	};
	
	if (/^multipart\/form\-data/i.test(__app.request.headers['content-type'])) {
		var Upload = Server.CreateObject("Persits.Upload.1");
		Upload.save();
		
		var e = new Enumerator(Upload.Form), i;
		while (!e.atEnd()) {
			i = e.item();
			try {
				__app.request.body[i] = String(Upload.Form(i));
			} catch (ex) {};
			e.moveNext();
		};
		
		var e = new Enumerator(Upload.Files), i;
		while (!e.atEnd()) {
			i = e.item();
			__app.request.body[i.name] = {
				name: i.name,
				filename: i.fileName,
				mime: i.contentType,
				size: i.size,
				data: new Buffer(i.binary)
			};
			e.moveNext();
		};
	} else {
		var e = new Enumerator(Request.Form), i;
		while (!e.atEnd()) {
			i = e.item();
			__app.request.body[i] = String(Request.Form(i));
			e.moveNext();
		};
	};
})();

%>
