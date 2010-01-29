<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" version="1.0" encoding="utf-8" indent="yes"/>

<xsl:template match="/plist/array">
	<html>
		<head>
			<style type='text/css'>

				body, td {
					font-family: sans-serif;
					font-size: 10pt;
				}

				.code {
					font-family: monospace;
					white-space: pre;
				}

				td.shortcut {
					text-align: center;
				}
				
				td, th {
					padding: 2px;
					vertical-align: top;
				}
				
				td {
					border: 1px solid #aaa;
				}
				
				th {
					background-color: #aaa;
					text-align: left;
					color: white;
					border: 1px solid #aaa;
				}
				
				table {
					border-collapse: collapse;
				}

			</style>
		
		</head>
		<body>
			<table>
			<tr>
				<th>Name</th>
				<th>Completion Prefix</th>
				<th>Shortcut</th>
				<th>Cycle List</th>
				<!--<th>Code</th>-->
			</tr>
			<xsl:apply-templates select="dict[string[preceding-sibling::key[1][. = 'IsMenuItem']][. = 'YES']]">
				<xsl:sort select="@name_lc" data-type="text" order="ascending"/>
			</xsl:apply-templates>
			</table>
		</body>
	</html>
</xsl:template>

<xsl:template match="dict">
	<tr>
		<td><xsl:value-of select="string[preceding-sibling::key[1][. = 'Name']]"/></td>
		<td class='code'><xsl:value-of select="string[preceding-sibling::key[1][. = 'CompletionPrefix']]"/></td>
		<td class='shortcut'><xsl:value-of select="@shortcut"/></td>
		<td><xsl:apply-templates select = 'array[preceding-sibling::key[1][. = "CycleList"]]/string'/></td>
		<!--
		<td class='code'>
			<xsl:apply-templates select='string[preceding-sibling::key[1][. = "TextString"]]'/>
		</td>
		-->
	</tr>
	
</xsl:template>

<xsl:template match='array[preceding-sibling::key[1][. = "CycleList"]]/string'>
	<xsl:variable name="currentId" select="./text()" />
	<xsl:value-of select="//dict[string[preceding-sibling::key[1][. = 'Identifier']] = $currentId]/string[preceding-sibling::key[1][. = 'Name']]"/><br/>
</xsl:template>



</xsl:stylesheet>