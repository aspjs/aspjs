<%
var global = this;
var __asp = __asp || {};
var __globals = Session('__aspjs_globals') = Session('__aspjs_globals') || {};

;(function(){
	__asp.version = '0.4.0';
	__asp.epoch = new Date().getTime();
	__asp.master = true;
	__asp.natives = {};
	__asp.finalize = function finalize(forced) {
		process.emit('unload');
		
		for (var key in __app.request.session) {
			if (__app.request.session[key] != null) {
				Session(key) = __app.request.session[key];
			} else {
				Session.Contents.Remove(key);
			}
		};
		
		if (__asp.master || forced) {
			__asp.info('rendered in '+ (Date.now() - __asp.epoch) +'ms');
			
			if (!__app.response.headers['content-type']) __app.response.set('content-type', 'text/html; charset=UTF-8');
			if (__app.get('env') !== 'production' && /^text\/html/.test(__app.response.get('content-type'))) {
				Response.write('<script type="text/javascript" src="/aspjs/client.js"></script>');
				if (!console.flush) __app.response.send(Session('__aspjs_console').join(''));
			};
			
			Session.Contents.Remove('__aspjs_epoch');
			Session.Contents.Remove('__aspjs_console');
			Session.Contents.Remove('__aspjs_globals');
		};
	};
	
	var epoch = Session('__aspjs_epoch');
	var payload = Session('__aspjs_execute');

	if (payload) {
		__asp.master = false;
		__asp.payload = payload;
		Session.contents.remove('__aspjs_execute');
	} else {
		payload = Session('__aspjs_transfer');
		if (payload) {
			__asp.master = true;
			__asp.payload = payload;
			Session.contents.remove('__aspjs_transfer');
		};
	};
	
	if (__asp.forceMaster) {
		__asp.master = true;
		__asp.payload = undefined;
	};
	
	if (epoch) {
		__asp.epoch = epoch;
	} else if (__asp.master) {
		Session('__aspjs_epoch') = __asp.epoch;
		__asp.introduce = true;
	};
})();

%>
<!--#INCLUDE FILE="core/function.asp"-->
<!--#INCLUDE FILE="core/json.asp"-->
<!--#INCLUDE FILE="core/object.asp"-->
<!--#INCLUDE FILE="core/error.asp"-->
<!--#INCLUDE FILE="core/array.asp"-->
<!--#INCLUDE FILE="core/date.asp"-->
<!--#INCLUDE FILE="core/string.asp"-->
<!--#INCLUDE FILE="core/number.asp"-->
<!--#INCLUDE FILE="core/regexp.asp"-->
<!--#INCLUDE FILE="core/buffer.asp"-->
<!--#INCLUDE FILE="core/require.asp"-->
<!--#INCLUDE FILE="modules/async.asp"-->
<!--#INCLUDE FILE="modules/util.asp"-->
<!--#INCLUDE FILE="modules/mime.asp"-->
<!--#INCLUDE FILE="modules/events.asp"-->
<!--#INCLUDE FILE="modules/path.asp"-->
<!--#INCLUDE FILE="core/console.asp"-->
<!--#INCLUDE FILE="core/process.asp"-->
<!--#INCLUDE FILE="core/script.asp"-->
<!--#INCLUDE FILE="core/app.asp"-->
<!--#INCLUDE FILE="core/request.asp"-->
<!--#INCLUDE FILE="core/response.asp"-->
<%
if (__asp.introduce) {
	__asp.info('asp.js v'+ __asp.version);
	//__asp.info('open sessions: '+ Application('sessions'));
	__app.response.set('x-powered-by', app.get('x-powered-by'));
};
%>
<!--#INCLUDE VIRTUAL="/_config.asp"-->
