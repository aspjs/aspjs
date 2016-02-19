<%

app.request = {
	body: {},
	cookies: {},
	headers: {},
	hostname: String(Request.ServerVariables('HTTP_HOST')),
	ip: String(Request.ServerVariables('REMOTE_ADDR')),
	method: String(Request.ServerVariables('REQUEST_METHOD')),
	port: parseInt(Request.ServerVariables('SERVER_PORT')),
	protocol: Request.ServerVariables('HTTPS') === 'on' ? 'https' : 'http',
	query: {},
	secure: Request.ServerVariables('HTTPS') === 'on',
	script: String(Request.ServerVariables('URL')),
	url: String(Request.ServerVariables('URL')),
	xhr: false
};

(function(){
	var e = new Enumerator(Request.ServerVariables), i;
	while (!e.atEnd()) {
		i = e.item();
		if (i.substr(0, 5) === 'HTTP_') {
			app.request.headers[i.substr(5).toLowerCase().replace(/_/g, '-')] = String(Request.ServerVariables(i));
		};
		e.moveNext();
	};
	
	if (app.request.headers['x-original-url']) {
		app.request.url = app.request.headers['x-original-url'];
		var q = app.request.url.indexOf('?');
		if (q !== -1) app.request.url = app.request.url.substr(0, q);
	};
	if (app.request.headers['x-requested-with'] === 'XMLHttpRequest') app.request.xhr = true;
	
	var e = new Enumerator(Request.Cookies), i;
	while (!e.atEnd()) {
		i = e.item();
		app.request.cookies[i] = String(Request.Cookies(i));
		e.moveNext();
	};
	
	var e = new Enumerator(Request.QueryString), i;
	while (!e.atEnd()) {
		i = e.item();
		app.request.query[i] = String(Request.QueryString(i));
		e.moveNext();
	};
	
	if (/^multipart\/form\-data/i.test(app.request.headers['content-type'])) {
		var Upload = Server.CreateObject("Persits.Upload.1");
		Upload.save();
		
		var e = new Enumerator(Upload.Form), i;
		while (!e.atEnd()) {
			i = e.item();
			app.request.body[i] = String(Upload.Form(i));
			e.moveNext();
		};
		
		var e = new Enumerator(Upload.Files), i;
		while (!e.atEnd()) {
			i = e.item();
			app.request.body[i.name] = {
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
			app.request.body[i] = String(Request.Form(i));
			e.moveNext();
		};
	};
	
	if (__asp.payload) {
		app.request.script = __asp.payload.script;
		app.request.parent = __asp.payload.parent;
		app.request.params = __asp.payload.params;
	};
})();

%>
