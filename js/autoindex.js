const path = location.pathname;
const dir = path.split('/').slice(-2,-1);

const updateFileTitles = () => {
	document.querySelectorAll('[data-autoindex-title-filename]').forEach(node => {
		let filename = node.dataset.autoindexTitleFilename;
		console.log(filename, node);
		fetch(filename, {headers: {range: 'bytes=0-4095'}})
			.then(res => res.text())
			.then(text => new DOMParser().parseFromString(text, 'text/html').title.split(' | ').slice(0,-1).join(' | '))
			.then(title => node.innerHTML = title)
		;
	});
};

addEventListener('DOMContentLoaded', updateFileTitles);

addEventListener('DOMContentLoaded', () => {
	document.title = `Index of ${dir}`;
	document.querySelectorAll('[data-autoindex-title-dirname]').forEach(node => {
		node.innerHTML = path;
	});
});

const addTableEntry = (path, title) => {
	const table = document.querySelector('tbody');
	const tr = document.createElement('tr');
	const td_path = document.createElement('td');
	const td_title = document.createElement('td');
	td_path.innerHTML = `<a href="${path}">${path}</a>`;
	td_title.innerHTML = title;
	if (!path.match(/\/$/)) td_title.dataset.autoindexTitleFilename = path;
	tr.append(td_path);
	tr.append(td_title);
	table.prepend(tr);
};

addEventListener('DOMContentLoaded', () => {
	addTableEntry('../', '(up one level)');
	fetch(`../${dir}.md`).then(res => {
		if (res.ok) {
			addTableEntry(`../${dir}.md`, '');
			updateFileTitles();
		}
	});
});
