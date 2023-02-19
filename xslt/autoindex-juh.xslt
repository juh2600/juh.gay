<?xml version="1.0" encoding="UTF-8"?>
<!-- https://serverfault.com/a/890856/521894 -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<html>
			<head>
				<meta charset="utf-8" />
				<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes" />
				<title>FIXME $dirname</title>
				<link rel="stylesheet" href="/css/tweaks.css" />
				<link rel="stylesheet" href="https://cdn.jtreed.org/css/core.css" />
				<link rel="icon" href="https://cdn.jtreed.org/img/logo.svg" />
			</head>
			<body>
				<main>
					<h1>FIXME $dirname</h1>
					<table>
						<thead>
							<tr>
								<th>filename</th>
								<th>title</th>
							</tr>
						</thead>
						<tbody>
							<xsl:for-each select="list/*">
								<xsl:variable name="filename">
									<xsl:value-of select="."/>
								</xsl:variable>
								<xsl:variable name="type">
									<xsl:value-of select="local-name(.)"/>
								</xsl:variable>
								<xsl:choose>
									<xsl:when test="$type='file'">
										<tr>
											<td><a href="{$filename}"><xsl:value-of select="$filename" /></a></td>
											<td>FIXME $title</td>
										</tr>
									</xsl:when>
									<xsl:when test="$type='directory'">
										<tr>
											<td><a href="{$filename}"><xsl:value-of select="$filename" />/</a></td>
											<td>--</td>
										</tr>
									</xsl:when>
									<xsl:otherwise>
										<tr>
											<td><a href="{$filename}"><xsl:value-of select="$filename" /></a></td>
											<td><!-- unknown inode type has no title --></td>
										</tr>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
						</tbody>
					</table>
				</main>
				<nav>
					<ul></ul>
				</nav>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
