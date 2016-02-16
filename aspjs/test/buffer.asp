<!--#INCLUDE VIRTUAL="/aspjs/head.asp"-->
<!--#INCLUDE VIRTUAL="/aspjs_modules/assert/index.asp"-->
<%

var assert = require('assert');

describe('JScript', function() {
	it('basics', function() {
		assert.ok(/^\d{4}\-\d\d\-\d\d[tT]\d\d:\d\d:\d\d\.\d{3}Z$/.test(new Date().toISOString()));
		assert.ok(/asdf/g instanceof RegExp);
		assert.ok([] instanceof Array);
		assert.ok(null !== undefined);
		assert.ok(null == undefined);
		assert.ok(undefined == undefined);
		assert.ok(undefined === undefined);
	})
});

describe('Buffer', function() {
	it('creation', function() {
		assert.strictEqual(new Buffer([0x00, 0xFF]).toString('hex'), '00ff');
		assert.strictEqual(new Buffer(5).toString('hex'), '0000000000');
		assert.strictEqual(new Buffer('ěščřžýáíé').toString('hex'), 'c49bc5a1c48dc599c5bec3bdc3a1c3adc3a9');
		assert.strictEqual(new Buffer('c49bc5a1c48dc599c5bec3bdc3a1c3adc3a9', 'hex').toString(), 'ěščřžýáíé');
	});
	
	it('methods', function() {
		assert.strictEqual(Buffer.isBuffer(new Buffer(0)), true);
		assert.strictEqual(new Buffer([0x12, 0xFF]).fill(0x01).toString('hex'), '0101');
		assert.strictEqual(Buffer.concat([new Buffer([0x12, 0xFF]), new Buffer([0xAA, 0x33])]).toString('hex'), '12ffaa33');
		assert.strictEqual(new Buffer([0x01]).equals(new Buffer([0x01])), true);
	});
});

%>
<!--#INCLUDE VIRTUAL="/aspjs/foot.asp"-->
