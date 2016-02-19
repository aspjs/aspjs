if (!window.aspjs) {
	window.aspjs = {};
	window.document.addEventListener('DOMContentLoaded', function() {
		var iterate = function(node) {
			for (var i = 0, l = node.childNodes.length; i < l; i++) {
				if (node.childNodes[i].nodeType === 8) {
					if (/ \[aspjs:(info|log|warn|error)\] ([\s\S]*) $/.exec(node.childNodes[i].nodeValue)) {
						if (RegExp.$1 === 'info') {
							console[RegExp.$1]('%c[aspjs]%c '+ RegExp.$2, 'font-weight: bold; color: blue;', 'font-weight: normal; color: blue;');
						} else {
							console[RegExp.$1]('%c[aspjs]%c '+ RegExp.$2, 'font-weight: bold;', 'font-weight: normal;');
						};
					};
				} else if (node.childNodes[i].nodeType === 1) {
					iterate(node.childNodes[i]);
				}
			};
		};
		iterate(window.document);
	});
};
