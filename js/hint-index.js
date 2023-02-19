addEventListener('DOMContentLoaded', () => {
	let subdir = location.pathname.replace(/\.md$/, '/');
	if (subdir == '/') return;
	fetch(subdir)
		.then(res => {
			if (res.ok) {
				let main = document.querySelector('main');
				let nav = document.createElement('nav');
				nav.innerHTML = `There's a directory here. <a href="${subdir}">Explore it?</a>`;
				nav.classList.add('subdir-nav');
				main.prepend(nav);
			}
		})
	;
});
