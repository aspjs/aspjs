<% var __asp = {forceMaster: true}; %>
<!--#INCLUDE FILE="core.asp"-->
<!--#INCLUDE FILE="modules/path-to-regexp.asp"-->
<%

if (app.get('env') === 'test') {
	app.get('/test/:test(\\w+)', function(req, res, next) {
		res.render('/aspjs/test/'+ req.params.test +'.asp');
	});
} else {
%>
<!--#INCLUDE VIRTUAL="/_router.asp"-->
<%
};

if (!app.found) {
	__asp.info('no matching route found');
	app.response.transfer(404);
};

%>
<!--#INCLUDE FILE="foot.asp"-->
