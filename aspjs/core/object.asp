<%

;(function(){
	Object.keys = function keys(obj) {
		var res = [];
		for (var prop in obj) {
			if (Object.prototype.hasOwnProperty.call(obj, prop) && !/^__.*__$/.test(prop)) {
				res.push(prop);
			}
		}
		return res;
	};
	
	Object.clone = function clone(obj) {
		var n = {};
		for (var prop in obj) {
			n[prop] = obj[prop];
		};
		return n;
	};
	
	Object.create = (function() {
		var Temp = function() {};
		return function (prototype) {
			if (arguments.length > 1) {
				throw Error('Second argument not supported');
			}
				if (typeof prototype != 'object') {
				throw TypeError('Argument must be an object');
			};
			Temp.prototype = prototype;
			var result = new Temp();
			Temp.prototype = null;
			return result;
		};
	})();
})();

%>
