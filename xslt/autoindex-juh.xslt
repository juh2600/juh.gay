<?xml version="1.0" encoding="UTF-8"?>
<!-- https://serverfault.com/a/890856/521894 -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<html>
			<head>
				<link href="https://cdn.jtreed.org/css/core.css" rel="stylesheet" />
			</head>
			<body>
				<main>
					<h1>FIXME $dirname</h1>
					<table>
						<tr>
							<th>filename</th>
							<th>title</th>
							<th>mtime></th>
						</tr>
					</table>
				</main>
				<nav>
					<ul></ul>
				</nav>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
