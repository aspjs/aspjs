<%

;(function(){
	String.define({
		file: '/aspjs/core/string.asp'
	}, {
		repeat: function repeat(times) {
			if (times === 0) return '';
			var txt = [];
			while (times--) {
				txt.push(this);
			};
			return txt.join('');
		},
		trim: function() {
			return this.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
		}
	});
})();

%>
