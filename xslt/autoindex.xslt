<?xml version="1.0" encoding="UTF-8"?>
<!-- https://serverfault.com/a/890856/521894 -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<html>
			<head>
				<link href=https://cdn.jtreed.org/css/core.css rel=stylesheet />
			</head>
			<body>
				<h3>Dafshabbat</h3>
				<table border="0">
					<tr bgcolor="#9acd32">
						<th>name</th>
						<th>size</th>
						<th>date</th>
					</tr>
					<xsl:for-each select="list/*">
						<xsl:sort select="@mtime"/>

						<xsl:variable name="name">
							<xsl:value-of select="."/>
						</xsl:variable>
						<xsl:variable name="size">
							<xsl:if test="string-length(@size) &gt; 0">
								<xsl:if test="number(@size) &gt; 0">
									<xsl:choose>
										<xsl:when test="round(@size div 1024) &lt; 1"><xsl:value-of select="@size" /></xsl:when>
										<xsl:when test="round(@size div 1048576) &lt; 1"><xsl:value-of select="format-number((@size div 1024), '0.0')" />K</xsl:when>
										<xsl:otherwise><xsl:value-of select="format-number((@size div 1048576), '0.00')" />M</xsl:otherwise>
									</xsl:choose>
								</xsl:if>
							</xsl:if>
						</xsl:variable>
						<xsl:variable name="date">
							<xsl:value-of select="substring(@mtime,9,2)"/>-<xsl:value-of select="substring(@mtime,6,2)"/>-<xsl:value-of select="substring(@mtime,1,4)"/><xsl:text> </xsl:text>
							<xsl:value-of select="substring(@mtime,12,2)"/>:<xsl:value-of select="substring(@mtime,15,2)"/>:<xsl:value-of select="substring(@mtime,18,2)"/>
						</xsl:variable>

						<tr>
							<td><a href="{$name}"><xsl:value-of select="."/></a></td>
							<td align="right"><xsl:value-of select="$size"/></td>
							<td><xsl:value-of select="$date"/></td>
						</tr>

					</xsl:for-each>
				</table>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
