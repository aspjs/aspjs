<%

define('async', function(require, exports, module){
	module.exports = {
		each: function each(array, iteratee, done) {
			if (array.length === 0) return done(null);
			for (var i = 0, l = array.length, d = l, e = null; i < l; i++) {
				iteratee(array[i], function(err) {
					d--;
					if (e) return;
					if (err) e = err;
					if (e) return done(e);
					if (d === 0) done(null);
				});
			}
		},
		forEachOf: function forEachOf(obj, iteratee, done) {
			if (Array.isArray(obj)) {
				if (obj.length === 0) return done(null);
				for (var i = 0, l = obj.length, d = l, e = null; i < l; i++) {
					iteratee(obj[i], i, function(err) {
						d--;
						if (e) return;
						if (err) e = err;
						if (e) return done(e);
						if (d === 0) done(null);
					});
				};
			};
		}
	};
});

%>
