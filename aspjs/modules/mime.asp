<%

require.define('mime', 'mime.asp', function(exports, module, __filename, __dirname){
	module.exports = {
		lookup: function lookup(path) {
			var index = path.lastIndexOf('.');
			if (index === -1) return 'application/octet-stream'
			var ext = path.substr(index + 1);
			
			switch (ext) {
				case 'png': return 'image/png';
				case 'gif': return 'image/gif';
				case 'jpg': case 'jpeg': return 'image/jpeg';
				default: 'application/octet-stream';
			};
		}
	};
});

%>
