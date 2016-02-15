<%

;(function(){
	String.prototype.repeat = function repeat(times) {
		if (times === 0) return '';
		var txt = [];
		while (times--) {
			txt.push(this);
		};
		return txt.join('');
	};
	
	String.prototype.trim = function() {
		return this.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	};
})();

%>
