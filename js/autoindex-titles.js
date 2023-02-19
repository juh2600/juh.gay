addEventListener('DOMContentLoaded', () => {
	document.querySelectorAll('[data-autoindex-title-filename]').forEach(node => {
		let filename = node.dataset.autoindexTitleFilename;
		console.log(filename, node);
		fetch(filename, {headers: {range: 'bytes=0-4095'}})
			.then(res => res.text())
			.then(text => new DOMParser().parseFromString(text, 'text/html').title.split(' | ').slice(0,-1).join(' | '))
			.then(title => node.innerHTML = title)
		;
	});
});

addEventListener('DOMContentLoaded', () => {
	path = location.pathname;
	dir = path.split('/').slice(-2,-1);
	document.title = `Index of ${dir}`;
	document.querySelectorAll('[data-autoindex-title-dirname]').forEach(node => {
		node.innerHTML = path;
	});
});
