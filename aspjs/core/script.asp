<%

var script = __script = {
	name: __asp.payload ? __asp.payload.script : String(Request.ServerVariables('URL')),
	parent: __asp.payload ? __asp.payload.parent : undefined
}

%>