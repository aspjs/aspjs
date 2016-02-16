<%

;(function(){
	Number.define({
		file: '/aspjs/core/number.asp'
	}, {
		toHex: function() {
			var hex = this.toString(16);
			return '0'.repeat(2 - hex.length) + hex;
		}
	});
})();

%>
