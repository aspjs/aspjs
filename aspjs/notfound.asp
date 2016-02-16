<% var __asp = {forceMaster: true}; %>
<!--#INCLUDE FILE="head.asp"-->
<%

__asp.info('not found');

app.response.clear();
app.response.status(404);

%>
<!--#INCLUDE VIRTUAL="/_notfound.asp"-->
<!--#INCLUDE FILE="foot.asp"-->
