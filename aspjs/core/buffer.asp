<%

var Buffer = function Buffer(buffer, encoding) {
	encoding = encoding || 'binary';

	switch (encoding) {
		case 'binary':
			this._buffer = buffer;
			break;
		
		case 'hex':
			var dom = Server.CreateObject("Microsoft.XMLDOM");
			var elm = dom.createElement('tmp');
			elm.dataType = 'bin.hex';
			elm.text = buffer;
			this._buffer = elm.nodeTypedValue;
			break;
		
		case 'base64':
			var dom = Server.CreateObject("Microsoft.XMLDOM");
			var elm = dom.createElement('tmp');
			elm.dataType = 'bin.base64';
			elm.text = buffer;
			this._buffer = elm.nodeTypedValue;
			break;
		
		default:
			throw new Error("Unknown ecoding.");
	};

	if (this._buffer != null) {
		console.log('asdf');
		var stream = Server.createobject("ADODB.Stream");
		stream.type = adTypeBinary;
		stream.open();
		stream.write(this._buffer);
		this.length = stream.size;
	} else {
		this.length = 0;
	};
};

(function(){
	Buffer.define({
		file: 'buffer.asp'
	}, {
		inspect: function inspect() {
			var str = [], max = 50;
			if (this.length > 0) {
				str.push(this.toString('hex').substr(0, max * 2).match(/.{2}/g).join(' '));
				if (this.length > max) str.push(' ... ');
			}
			return '<Buffer ' + str.join('') + '>';
		},
		slice: function slice(start, length) {
			start = start || 0;
			length = length || this.length;
			
			start = Math.min(Math.max(0, start), this.length);
			length = Math.min(Math.max(0, length), this.length - start);
	
			var stream = Server.createobject("ADODB.Stream");
			stream.type = adTypeBinary;
			stream.open();
			stream.write(this._buffer);
			stream.position = start;
			return new Buffer(stream.read(length));
		},
		toString: function toString(encoding) {
			encoding = encoding || 'utf8';
		
			switch (encoding) {
				case 'hex':
					var dom = Server.CreateObject("Microsoft.XMLDOM");
					var elm = dom.createElement('tmp');
					elm.dataType = 'bin.hex';
					elm.nodeTypedValue = this._buffer;
					return elm.text;
		
				case 'base64':
					var dom = Server.CreateObject("Microsoft.XMLDOM");
					var elm = dom.createElement('tmp');
					elm.dataType = 'bin.base64';
					elm.nodeTypedValue = this._buffer;
					return elm.text;
				
				case 'utf8':
				case 'utf-8':
					var stream = Server.createobject("ADODB.Stream");
					stream.type = adTypeBinary;
					stream.open();
					stream.write(this._buffer);
					stream.position = 0;
					stream.type = adTypeText;
					stream.charSet = 'utf-8';
					return stream.readText();
				
				default: return null;
			};
		},
		valueOf: function valueOf() {
			return this._buffer;
		},
		toJSON: function toJSON() {
			return this.toString('base64');
		}
	});
	
	Buffer.isBuffer = function isBuffer(obj) {
		return obj.constructor.name() === 'Buffer';
	};
})();

%>
