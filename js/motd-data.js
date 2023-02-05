lines = [
	'foo'
	, 'bar'
	, 'qaz'
];

// one motd for the whole page, per load
const motd = `<q>${lines[Math.floor(Math.random() * lines.length]}</q>`;

const getMotd = () => motd;
