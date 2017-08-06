<%

define('path', function(require, exports, module){
	module.exports = {
		sep: '\\',
		
		basename: function(path) {
			return String(path).match(/(?:^|\\|\/)([^\\\/]*)[\\\/]?$/)[1];
		}
	};
});

%>
