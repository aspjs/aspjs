<%

var setImmediate = function setImmediate(callback) {
	__asp.timers.push({id: ++__asp.timers.counter, cb: callback, stack: Error.captureStackTrace()});
}

var clearImmediate = function clearImmediate(timer) {
	for (var i = 0, l = __asp.timers.length; i < l; i++) {
		if (__asp.timers[i].id === timer) {
			__asp.timers.splice(i, 1);
			return;
		}
	};
}

setImmediate.__file__ = clearImmediate.__file__ = 'timers.asp';
var setTimeout = setImmediate, clearTimeout = clearImmediate;

%>
