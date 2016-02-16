<%

;(function(){
	Date.define({
		file: '/aspjs/core/date.asp'
	}, {
		toISOString: function toISOString() {
			function pad(number) {
				if (number < 10) {
					return '0' + number;
				};
				return number;
			};
			
			return this.getUTCFullYear() +
			'-' + pad(this.getUTCMonth() + 1) +
			'-' + pad(this.getUTCDate()) +
			'T' + pad(this.getUTCHours()) +
			':' + pad(this.getUTCMinutes()) +
			':' + pad(this.getUTCSeconds()) +
			'.' + (this.getUTCMilliseconds() / 1000).toFixed(3).slice(2, 5) +
			'Z';
		},
		toJSON: function() {
			return this.toISOString();
		}
	});
	
	Date.isDate = function isDate(date) {
		return Object.prototype.toString.call(date) === '[object Date]';
	};

	Date.now = function now() {
		return new Date().getTime();
	};
})();

%>
