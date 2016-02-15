<%

;(function(){
	Array.define({
		file: 'array.asp'
	}, {
		filter: function filter(callback, context) {
			var array = this.slice(0), filter = [];
			
			for (var i = 0, l = array.length; i < l; i++) {
				if (callback.call(context, array[i])) filter.push(array[i]);
			}
		
			return filter;
		},
		indexOf: function indexOf(item) {
			for (var i = 0, l = this.length; i < l; i++) {
				if (i in this && this[i] === item) return i;
			};
			return -1;
		},
		map: function map(callback, context) {
			var array = this.slice(0), map = [];
			
			for (var i = 0, l = array.length; i < l; i++) {
				map.push(callback.call(context, array[i]));
			}
		
			return map;
		}
	})
	
	Array.isArray = function isArray(arr) {
		return Object.prototype.toString.call(arr) === '[object Array]';
	};
})();

%>
