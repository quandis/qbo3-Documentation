<xsl:stylesheet version="1.0" exclude-result-prefixes="format" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:format="urn:qbo3-formatting" xmlns:security="urn:qbo3-security" xmlns:data="urn:qbo3-data">
	<xsl:import href="Theme.xslt" />
	<xsl:output method="html" indent="yes" doctype-system="html" />
	<!-- Standard Parameters -->
	<xsl:variable name="DimensionLabel">
		<xsl:call-template name="DimensionLabel">
			<xsl:with-param name="Object">CreditApplication</xsl:with-param>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="DimensionColumn">
		<xsl:value-of select="format:lastPart($Dimension, '.')" />
	</xsl:variable>
	<xsl:template match="/">
		<div class="table-responsive pre-scrollable">
			<table class="table grid">
				<thead>
					<tr>
						<th colspan="2">
							<div class="title pull-left">
								<xsl:text>Dashboard</xsl:text>
							</div>
							<div class="pull-right">
								<div class="btn-group btn-group-table">
									<button type="button" class="btn" title="Refresh" onclick="qbo3.getObject(this).refresh({{'nocache':''}});">
										<i class="icon-refresh" />
									</button>
								</div>
								<div class="btn-group btn-group-table">
									<button class="btn dropdown-toggle" data-toggle="dropdown">
										<i class="glyphicon glyphicon-option-horizontal" />
									</button>
									<ul class="dropdown-menu">
										<xsl:variable name="Dimensions" select="data:moduleDimensions('qbo/CreditApplication', 1)" />
										<xsl:variable name="Filters" select="data:moduleFilters('qbo/CreditApplication')" />
										<xsl:call-template name="RenderMenuDimensions">
											<xsl:with-param name="Dimensions">
												<xsl:value-of select="$Dimensions" />
											</xsl:with-param>
											<xsl:with-param name="Dimension" select="$Dimension" />
											<xsl:with-param name="SqlFilters" select="$SqlFilters" />
											<xsl:with-param name="Object">CreditApplication</xsl:with-param>
										</xsl:call-template>
										<xsl:if test="$Dimensions!='' and $Filters!=''">
											<li class="divider" />
										</xsl:if>
										<xsl:call-template name="RenderMenuFilters">
											<xsl:with-param name="Filters">
												<xsl:value-of select="$Filters" />
											</xsl:with-param>
										</xsl:call-template>
										<xsl:if test="$Dimensions!='' or $Filters!=''">
											<li class="divider" />
										</xsl:if>
										<li data-trigger="help" data-help-options="{{ 'page': 'Acme/CreditApplication.ashx/Dashboard' }}">
											<a>
												<i class="icon-question-sign" /> Help
											</a>
										</li>
									</ul>
								</div>
							</div>
						</th>
					</tr>
					<tr>
						<th>
							<xsl:call-template name="DimensionLabel">
								<xsl:with-param name="Object">CreditApplication</xsl:with-param>
							</xsl:call-template>
						</th>
						<th>Count</th>
					</tr>
				</thead>
				<tbody>
					<xsl:for-each select="//CreditApplicationItem">
						<xsl:if test="*[name() = concat($DimensionColumn, 'Group')] = 0">
							<xsl:call-template name="DataRow" />
						</xsl:if>
					</xsl:for-each>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="2">
							<span class="rendertime" />
						</td>
					</tr>
				</tfoot>
			</table>
		</div>
	</xsl:template>
	<xsl:template name="DataRow">
		<xsl:param name="Label">
			<xsl:choose>
				<xsl:when test="count(*[name()=substring-before($DimensionColumn, 'ID')]) = 1">
					<xsl:value-of select="*[name()=substring-before($DimensionColumn, 'ID')]" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="*[name()=$DimensionColumn]" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>
		<xsl:param name="Filter">
			<xsl:choose>
				<xsl:when test="*[name() = concat($DimensionColumn, 'Group')] = 0">
					<xsl:value-of select="$DimensionColumn" />
					<xsl:text>: '</xsl:text>
					<xsl:value-of select="*[name()=$DimensionColumn]" />
					<xsl:text>',</xsl:text>
				</xsl:when>
			</xsl:choose>
			<xsl:if test="$Dimension = 'SmartWorklistID'">
				<xsl:text>'SqlFilters': 'Worklist',</xsl:text>
			</xsl:if>
			<xsl:if test="$Dimension = 'ImportFormTemplateID'">
				<xsl:text>'SqlFilters': 'Form',</xsl:text>
			</xsl:if>
		</xsl:param>
		<tr title="{$Filter}">
			<td>
				<a onclick="qbo3.behavior.fireEvent('search', ['Search', {{ {$Filter} 'HtmlTitle': 'All CreditApplications: {$DimensionLabel} = {format:isNull($Label, '--')}' }}, {{invokeOnly: true}}]);">
					<xsl:value-of select="format:isNull($Label, '--')" />
				</a>
			</td>
			<td class="number">
				<xsl:value-of select="CreditApplicationCount" />
			</td>
		</tr>
	</xsl:template>
</xsl:stylesheet>