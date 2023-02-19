addEventListener('DOMContentLoaded', () => {
	let subdir = location.pathname.replace(/\.md$/, '/');
	if (subdir == '/') return;
	fetch(subdir)
		.then(res => {
			if (res.ok) {
				let main = document.querySelector('main');
				let nav = document.createElement('nav');
				if (Math.random() < 0.90) {
					nav.innerHTML = `There's a directory here. <a href="${subdir}">Explore it?</a>`;
				} else {
					nav.innerHTML = `You are standing in a page of content south of a nav bar, with poor SEO. <a href="${subdir}">There is a small directory here.</a>`;
				}
				nav.classList.add('subdir-nav');
				main.prepend(nav);
			}
		})
	;
});
