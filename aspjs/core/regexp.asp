<%

;(function(){
	RegExp.isRegExp = function isRegExp(reg) {
		return Object.prototype.toString.call(reg) === '[object RegExp]';
	};
})();

%>
