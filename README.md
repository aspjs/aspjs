# asp.js

Brings nodejs-like coding to ASP Classic.

**Features:**
- Nodejs-like API.
- Express-like routing.
- Server console.
- Error stack traces.
- Buffer support.
- Callback-style code support.
- Built-in async, mssql, request, nodemailer, sessions, cookies.

## Quick Example

/_config.asp

```asp
<%

app.set("credentials", {
	user: "...",
	password: "...",
	server: "localhost",
	database: "..."
});

%>
```

/_router.asp

```asp
<%

app.get("/", function(req, res, next) {
	res.render("/index.asp");
});

%>
```

/index.asp

```asp
<!--#INCLUDE VIRTUAL="/aspjs/head.asp"-->
<!--#INCLUDE VIRTUAL="/aspjs_modules/mssql/index.asp"-->
<%

var sql = require("mssql");
var conn = new sql.Connection(app.get("dbconfig"), function(err) {
	new sql.Request(conn).query("select getdate() as date", function(err, recordset) {
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

* [Async](#async)
* [Application](#application)
* [Buffer](#buffer)
* [Console](#console)
* [Events](#console)
* [Globals](#globals)
* [JSON](#json)
* [Path](#path)
* [Process](#process)
* [Request](#request)
* [Response](#response)
* [Util](#util)

### Modules

* [Assert](https://github.com/aspjs/aspjs-assert)
* [Audit](https://github.com/aspjs/aspjs-audit)
* [File System](https://github.com/aspjs/aspjs-fs)
* [HTTP Request](https://github.com/aspjs/aspjs-request)
* [Mailer](https://github.com/aspjs/aspjs-mailer)
* [SQL Server](https://github.com/aspjs/aspjs-mssql)

## Debugging

<a name="debugging" />
### Console

The entire contents of the console is redirected to browser's console. A simple page with `console.log("env", app.get("env"));` results in:

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

<a name="async" />
### Async ([docs](https://github.com/caolan/async))

Implemented:

- async.each(arr, iteratee, callback)
- async.forEachOf(obj, iteratee, callback)

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

<a name="globals" />
### Globals ([docs](https://nodejs.org/api/globals.html))

Implemented:

- require.cache
- require(module)

<a name="json" />
### JSON ([docs](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON))

Implemented:

- Class Method: JSON.parse(string[, reviver])
- Class Method: JSON.stringify(value[, replacer[, space]])

<a name="path" />
### Util ([docs](https://nodejs.org/api/path.html))

Implemented:

- path.basename(path)

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
- req.params
- req.port
- req.protocol
- req.query
- req.secure
- req.session
- req.url
- req.xhr

<a name="response" />
### Response ([docs](http://expressjs.com/en/4x/api.html#res))

Implemented:

- res.cookie(name, value, [options])
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

<a name="license" />
## License

Copyright (c) 2016 Patrik Simek

The MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
