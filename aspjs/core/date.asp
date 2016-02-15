<%

;(function(){
	Date.isDate = function isDate(date) {
		return Object.prototype.toString.call(date) === '[object Date]';
	};
	
	Date.prototype.toISOString = function toISOString() {
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
	};
	
	Date.prototype.toJSON = function() {
		return this.toISOString();
	};
	
	Date.now = function() {
		return new Date().getTime();
	};
})();

%>
