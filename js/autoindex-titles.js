document.querySelectorAll('[data-autoindex-title-filename]').forEach(node => {
	let filename = node.dataset.autoIndexTitleFilename;
	fetch(filename, {headers: {range: 'bytes=0-4095'}})
		.then(res => res.text())
		.then(text => new DOMParser().parseFromString(text, 'text/html').title.split(' | ').slice(0,-1).join(' | '))
		.then(title => node.innerHTML = title)
	;
});
