<% var __asp = {forceMaster: true}; %>
<!--#INCLUDE FILE="core.asp"-->
<!--#INCLUDE FILE="modules/path-to-regexp.asp"-->
<!--#INCLUDE VIRTUAL="/_router.asp"-->
<%

if (!app.found) {
	__asp.info('no matching route found');
	app.response.transfer(404);
};

%>
<!--#INCLUDE FILE="foot.asp"-->
