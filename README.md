# asp.js

Brings nodejs-like coding to ASP Classic.

**Features:**
- Nodejs-like API.
- Express-like routing.
- Server console.
- Error stack traces.
- Buffer support.
- Asynchronous code support.
- Built-in mssql, request, nodemailer.

## Quick Example

/_config.asp

```asp
<%

app.set('credentials', {
	user: '...',
	password: '...',
	server: 'localhost',
	database: '...'
});

%>
```

/_router.asp

```asp
<%

app.get('/', function(req, res, next) {
	res.render('/index.asp');
});

%>
```

/index.asp

```asp
<!--#INCLUDE VIRTUAL="/aspjs/head.asp"-->
<!--#INCLUDE VIRTUAL="/aspjs_modules/mssql/index.asp"-->
<%

var sql = require('mssql');
var conn = new sql.Connection(app.get('dbconfig'), function(err) {
	new sql.Request(conn).query('select getdate() as date', function(err, recordset) {
		res.json(recordset);
	});
});
	
%>
<!--#INCLUDE VIRTUAL="/aspjs/foot.asp"-->
```

HTTP Response

```
Content-Length: 37
Content-Type: application/json

[{"date":"2016-02-15T15:17:49.410Z"}]
```

## Requirements

- IIS with installed URL Rewrite 2.0
- Persits ASPUpload for multipart uploads ([www.aspupload.com](http://www.aspupload.com))

## Installation

- Clone this repository or download it from npm (`npm install aspjs`) and make it a home directory for your website.
- In IIS Manager's ASP Configuration panel set `Codepage` to `65001`, `Scripting Language` to `JScript` and `Send Errors To Browser` to `true`.

## Documentation

### Debugging

* [Console](#debugging)
* [Stack Trace](#stack)
* [Inspection](#inspection)

### API

* [Application](#application)
* [Buffer](#buffer)
* [Console](#console)
* [Events](#console)
* [File System](#file-system)
* [Globals](#globals)
* [JSON](#json)
* [Process](#process)
* [Request](#request)
* [Response](#response)
* [Util](#util)

### Modules

* [HTTP Request](#http-request)
* [Mailer](#mailer)
* [SQL Server](#sql-server)

## Debugging

<a name="debugging" />
### Console

The entire contents of the console is redirected to browser's console. A simple page with `console.log('env', app.get('env'));` results in:

![aspjs debugging](https://patriksimek.cz/public/aspjs-debugging.png)

<a name="stack" />
### Stack Trace

You can capture stack traces of caught errors.

![aspjs stack](https://patriksimek.cz/public/aspjs-stack.png)

This can't be done with uncaught exceptions. On the other side, uncaught exceptions comes with location and line number.

![aspjs stack2](https://patriksimek.cz/public/aspjs-stack2.png)

<a name="inspection" />
### Inspection

You can inspect objects the same way you're used to.

```javascript
console.log(myobject);
```

![aspjs inspect](https://patriksimek.cz/public/aspjs-inspect.png)

## API

<a name="application" />
### Application ([docs](http://expressjs.com/en/4x/api.html#app))

Implemented:

- app.all(path, callback[, ...])
- app.delete(path, callback[, ...])
- app.get(name)
- app.get(path, callback[, ...])
- app.param(name, callback)
- app.post(path, callback[, ...])
- app.set(name, value)

<a name="buffer" />
### Buffer ([docs](https://nodejs.org/api/buffer.html))

Implemented:

- new Buffer(array)
- new Buffer(buffer)
- new Buffer(str[, encoding])
- new Buffer(size)
- Class Method: Buffer.concat(array)
- Class Method: Buffer.isBuffer(obj)
- Class Method: Buffer.isEncoding(encoding)
- buffer.equals(buffer)
- buffer.length
- buffer.fill(value)
- buffer.slice([start[, end]])
- buffer.toString([encoding])

<a name="console" />
### Console ([docs](https://nodejs.org/api/console.html))

Implemented:

- console.error([data][, ...])
- console.info([data][, ...])
- console.log([data][, ...])
- console.warn([data][, ...])

<a name="events />
### Events ([docs](https://nodejs.org/api/events.html))

Implemented:

- new EventEmitter()
- emitter.emit(event)
- emitter.on(event, listener)
- emitter.once(event, listener)
- emitter.removeListener(event, listener)

<a name="file-system" />
### File System ([docs](https://nodejs.org/api/fs.html))

Implemented:

- fs.readdir(path, callback)
- fs.readdirSync(path)
- fs.readFle(path[, options], callback)
- fs.readFileSync(path[, options])
- fs.stat(path, callback)
- fs.statSync(path)
- fs.writeFile(path, data[, options], callback)
- fs.writeFileSync(path, data[, options])
- fs.unlink(path, callback)
- fs.unlinkSync(path)

<a name="globals" />
### Globals ([docs](https://nodejs.org/api/globals.html))

Implemented:

- clearImmediate(timer)
- clearTimeout(timer)
- require.cache
- require(module)
- setImmediate(callback)
- setTimeout(callback, ms)

<a name="json" />
### JSON ([docs](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON))

Implemented:

- Class Method: JSON.parse(string[, reviver])
- Class Method: JSON.stringify(value[, replacer[, space]])

<a name="process" />
### Process ([docs](https://nodejs.org/api/process.html))

Implemented:

- process.env
- process.version
- process.versions

<a name="request" />
### Request ([docs](http://expressjs.com/en/4x/api.html#req))

Implemented:

- req.body
- req.cookies
- req.headers
- req.hostname
- req.ip
- req.method
- req.port
- req.protocol
- req.query
- req.secure
- req.url
- req.xhr

<a name="response" />
### Response ([docs](http://expressjs.com/en/4x/api.html#res))

Implemented:

- res.end([data])
- res.get(name)
- res.json(body)
- res.location(path)
- res.redirect([status,] path)
- res.render(path, locals)
- res.send(body)
- res.set(name[, value])
- res.status(code)
- res.type(type)

Additions:

- res.clear()
- res.flush()

<a name="util" />
### Util ([docs](https://nodejs.org/api/util.html))

Implemented:

- util.inspect(object)

## Modules

<a name="http-request" />
### HTTP Request (inspired by [request](node request))

```asp
<!--#INCLUDE VIRTUAL="/aspjs_modules/request/index.asp"-->
<%

var request = require('request');
request.get('http://...', function(err, response, body) {
	// ... error checks
});

request.post({
	url: 'http://...',
	headers: {
		'x-custom-header': 'value'
	},
	body: '', // Object, String or Buffer
	json: true,
	auth: {
		user: 'username',
		pass: 'password'
	},
	timeout: 15000
}, function(err, response, body) {
	// ... error checks
});

%>
```

<a name="mailer" />
### Mailer (inspired by [nodemailer](https://github.com/nodemailer/nodemailer))

```asp
<!--#INCLUDE VIRTUAL="/aspjs_modules/mailer/index.asp"-->
<%

var mailer = require('mailer');
mailer.setup({
	host: 'localhost',
	port: 25
});
mailer.send({
	provider: 'cdo', // 'cdo' (default) or 'persits'
	from: 'from@test.com',
	to: 'to@test.com',
	cc: ['cc1@test.com', 'cc2@test.com'],
	bcc: null,
	subject: 'Subject',
	text: 'Body',
	html: '<b>Body</b>',
	attachments: [
		{
			path: 'http://...', // Absolute path or URL
			filename: 'file.txt',
			cid: 'mycid'
		}
	],
	headers: {
		'x-custom-header': 'value'
	}
}, function(err) {
	// ... error checks
});

%>
```

<a name="sql-server" />
### SQL Server (inspired by [node-mssql](https://github.com/patriksimek/node-mssql))

```asp
<!--#INCLUDE VIRTUAL="/aspjs_modules/mssql/index.asp"-->
<%

var sql = require('mssql');
var conn = new sql.Connection({
	user: '...',
	password: '...',
	server: 'localhost',
	database: '...'
}, function(err) {
	// ... error checks
	
	new sql.Request(conn)
	.input('param', 'asdfasdf')
	.execute('test_sp', function(err, recordset, returnValue) {
		// ... error checks
		
		console.log(recordset);
	});
	
	new sql.Request(conn)
	.query('select newid() as newid', function(err, recordset) {
		// ... error checks
		
		console.log(recordset);
	});
});

%>
```

<a name="license" />
## License

Copyright (c) 2016 Patrik Simek

The MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
