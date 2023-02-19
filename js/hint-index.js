addEventListener('DOMContentLoaded', () => {
	let subdir = location.pathname.replace(/\.md$/, '/');
	fetch(subdir)
		.then(res => {
			if (res.ok) {
				let main = document.querySelector('main');
				let nav = document.createElement('nav');
				nav.innerHTML = `There's a directory here. <a href="${subdir}}">Explore it?</a>`;
				main.prepend(nav);
			}
		})
	;
});
