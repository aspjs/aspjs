<!--#INCLUDE FILE="head.asp"-->
<%

__asp.info('uncaught exception');

app.response.clear();
app.response.status(500);

var error;

;(function(){
	var last = Session('__aspjs_error');
	if (last) {
		error = new (__asp.natives[last.name || 'Error'])(last.message);
		for (var key in last) {
			if ('function' !== typeof last[key]) error[key] = last[key];
		};
		Session.contents.remove('__aspjs_error');
	} else {
		last = Server.GetLastError();
		if (last.number === 0) {
			error = new Error('Unknown error.');
		} else {
			error = new Error(last.description);
			error.ASPCode = last.ASPCode || '';
			error.ASPDescription = last.ASPDescription || '';
			error.category = last.category || '';
			error.number = last.number & 0xFFFF;
			error.source = last.source || '';
			
			var stack = [];
			if (last.file) stack.push(last.file);
			if (last.line) stack.push(last.line);
			if (last.column && last.column !== -1) stack.push(last.column);
			error.stack = '  at ('+ stack.join(':') +')';
		};
	};
})();

%>
<!--#INCLUDE VIRTUAL="/_error.asp"-->
<!--#INCLUDE FILE="foot.asp"-->
