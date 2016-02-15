<%

var process = new (require('events').EventEmitter);
process.env = {};
process.version = __asp.version;
process.versions = {
	aspjs: __asp.version,
	jscript: ScriptEngineMajorVersion() +'.'+ ScriptEngineMinorVersion() +'.'+ ScriptEngineBuildVersion()
};

%>
