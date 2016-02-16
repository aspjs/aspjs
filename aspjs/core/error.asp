<%

;(function(){
	__asp.natives.Error = Error;
	__asp.natives.TypeError = TypeError;
	__asp.natives.SyntaxError = SyntaxError;
	__asp.natives.EvalError = EvalError;
	__asp.natives.RangeError = RangeError;
	__asp.natives.ReferenceError = ReferenceError;
	__asp.natives.URIError = URIError;
	
	Error.define({
		file: '/aspjs/core/error.asp'
	}, {
		inspect: function inspect() {
			var self = this;
			var keys = Object.keys(this).filter(function(item) {
				return item !== 'name' && item !== 'message' && item !== 'stack' && item !== 'description' && 'function' !== typeof self[item] && self[item];
			});
		
			if (keys.length) {
				keys = keys.map(function(item) {
					return item +': '+ require('util').inspect(self[item], {wrap: true});
				});
				return '{ ['+ this.name +': '+ this.message +']\n  '+ keys.join('\n  ') +' }'+ (this.stack ? ('\n' + this.stack) : '');
			} else {
				return '['+ this.name +': '+ this.message +']' + (this.stack ? ('\n' + this.stack) : '');
			};
		}
	});
	
	Error.captureStackTrace = function captureStackTrace() {
		var txt = [], fce = arguments.callee.caller, seen = [], circular = false;
		while (fce) {
			seen.push(fce);
			
			if (fce === __asp.dispatchDeferred) {
				txt.push('     <async>');
				txt.push(fce.arguments[0].replace(/\n  at <global>$/, ''));
			} else if (fce !== __asp.defer) {
				txt.push(fce.toStack());
			};
			
			fce = fce.caller;
			if (fce && seen.indexOf(fce) !== -1) {
				circular = true;
				break;
			};
		};
		txt.push(circular ? '     <circular>' : '  at <global>');
		return txt.join('\n');
	};
})();

%>
