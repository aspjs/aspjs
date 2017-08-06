<%

var Buffer = function Buffer(buffer, encoding) {
	encoding = (encoding || 'binary').toLowerCase();
	if (encoding === 'binary') {
		if ('string' === typeof buffer) {
			encoding = 'utf8';
		} else if ('number' === typeof buffer) {
			encoding = 'hex';
			buffer = '00'.repeat(buffer);
		} else if (Array.isArray(buffer)) {
			encoding = 'hex';
			buffer = buffer.map(function(octet) { return octet.toHex(); }).join('');
		} else if (Buffer.isBuffer(buffer)) {
			buffer = buffer._buffer;
		};
	};
	
	if (encoding === 'utf8' || encoding === 'utf-8') {
		var hex = [];
		for (var i = 0, l = buffer.length; i < l; i++) {
			if (buffer.charCodeAt(i) <= 0x7F) {
				hex.push(buffer.charCodeAt(i).toHex());
			} else {
				var uri = encodeURIComponent(buffer.charAt(i)).substr(1).split('%');
				for (var ii = 0, ll = uri.length; ii < ll; ii++) {
					hex.push(uri[ii]);
				};
			};
		};
		encoding = 'hex';
		buffer = hex.join('');
	};

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
		file: '/aspjs/core/buffer.asp'
	}, {
		equals: function equals(buffer) {
			return this.toString('hex') === buffer.toString('hex');
		},
		fill: function(value) {
			this._buffer = new Buffer(value.toHex().repeat(this.length), 'hex')._buffer;
			return this;
		},
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
		toByteArray: function toByteArray() {
			return this.toString('hex').match(/.{2}/g).map(function(char) { return parseInt(char, 16) });
		},
		toString: function toString(encoding) {
			encoding = (encoding || 'utf8').toLowerCase();
		
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
		if (!obj || !obj.constructor) return false;
		return obj.constructor.name() === 'Buffer';
	};
	
	Buffer.isEncoding = function isEncoding(encoding) {
		return encoding === 'binary' || encoding === 'utf8' || encoding === 'hex' || encoding === 'base64';
	};
	
	Buffer.concat = function concat(list) {
		return new Buffer(list.map(function(buffer) {
			return buffer.toString('hex');
		}).join(''), 'hex');
	};
})();

%>
