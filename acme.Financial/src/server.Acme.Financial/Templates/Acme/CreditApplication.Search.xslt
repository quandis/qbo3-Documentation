<!-- The following columns were specified in the generation of this XSLT: CreditApplicationID,CreditApplication,SomeCustomField-->
<xsl:stylesheet version="1.0" exclude-result-prefixes="format" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:format="urn:qbo3-formatting" xmlns:security="urn:qbo3-security" xmlns:data="urn:qbo3-data">
	<xsl:import href="Theme.xslt" />
	<xsl:output method="html" indent="yes" doctype-system="html" />
	<!-- Standard Parameters -->
	<xsl:param name="HtmlTitle">Credit Applications</xsl:param>
	<xsl:param name="RecordStart">0</xsl:param>
	<xsl:param name="DisplaySize">25</xsl:param>
	<xsl:param name="OrderBy">'CreditApplication'</xsl:param>
	<xsl:param name="SmartSearch" />
	<!-- Table-specific parameters -->
	<xsl:param name="CreditApplicationID" />
	<xsl:param name="CreditApplication" />
	<xsl:param name="SomeCustomField" />
	<!-- Label parameters -->
	<xsl:param name="Tag" />
	<xsl:variable name="RecordCount">
		<xsl:choose>
			<xsl:when test="count(//RecordCount) = 0">0</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="//RecordCount[1]" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:key name="MatchColumn" match="//CreditApplicationItem" use="Match/Result/SourceColumn" />
	<xsl:variable name="MatchColumns" select="//CreditApplicationItem[count(key('MatchColumn', Match/Result/SourceColumn)[1]|.) = 1 and count(Match/Result/SourceColumn)=1 and Match/Result/SourceColumn != '' and not(contains(',CreditApplicationID,CreditApplication,SomeCustomField,', concat(',', Match/Result/SourceColumn, ',')))]" />
	<xsl:variable name="ColSpan" select="4+count($MatchColumns)" />
	<xsl:template match="/">
		<xsl:call-template name="CreditApplicationSearch" />
	</xsl:template>
	<xsl:template name="CreditApplicationSearch">
		<div class="table-responsive">
			<table class="table grid">
				<thead>
					<!-- Main header with Options menu -->
					<tr>
						<th colspan="{$ColSpan}">
							<div class="title pull-left">
								<xsl:value-of select="$HtmlTitle" />
							</div>
							<div class="pull-right">
								<div class="btn-group btn-group-table">
									<xsl:call-template name="MenuButtonByPermission">
										<xsl:with-param name="Permission">CreditApplicationInsert</xsl:with-param>
										<xsl:with-param name="Icon">icon-plus</xsl:with-param>
										<xsl:with-param name="Label">New CreditApplication</xsl:with-param>
										<xsl:with-param name="OnClick">
											<xsl:text>qbo3.getObject(this).push('Edit');</xsl:text>
										</xsl:with-param>
									</xsl:call-template>
								</div>
								<div class="btn-group btn-group-table">
									<button type="button" class="btn" title="Refresh" onclick="qbo3.getObject(this).refresh({{'nocache':''}});">
										<i class="icon-refresh" />
									</button>
								</div>
								<div class="btn-group btn-group-table">
									<button class="btn dropdown-toggle" data-toggle="dropdown">
										<i class="glyphicon glyphicon-creditapplication" />
									</button>
									<ul class="dropdown-menu">
										<li onclick="this.getParent('thead').getElement('tr[data-behavior=Filter]').toggleClass('hidden');">
											<a>
												<i class="icon-search" />
												<xsl:text xml:space="preserve"> Refine Search</xsl:text>
											</a>
										</li>
										<xsl:variable name="Filters" select="data:moduleFilters('qbo/CreditApplication')" />
										<xsl:if test="$Filters!=''">
											<li class="divider" />
											<xsl:call-template name="RenderMenuFilters">
												<xsl:with-param name="Filters">
													<xsl:value-of select="$Filters" />
												</xsl:with-param>
											</xsl:call-template>
										</xsl:if>
									</ul>
								</div>
								<xsl:call-template name="OptionsMenu">
									<xsl:with-param name="Object">CreditApplication</xsl:with-param>
									<xsl:with-param name="Tag" select="$Tag" />
									<xsl:with-param name="HelpUrl">Acme/CreditApplication.ashx/Search</xsl:with-param>
								</xsl:call-template>
							</div>
						</th>
					</tr>
					<!-- Sortable column headers -->
					<tr data-behavior="OrderBy" data-orderby-current="{$OrderBy}">
						<th data-orderby-column="CreditApplicationID">Credit Application ID</th>
						<th data-orderby-column="CreditApplication">Credit Application</th>
						<th data-orderby-column="SomeCustomField">Some Custom Field</th>
						<xsl:for-each select="$MatchColumns">
							<th data-orderby-disabled="true">
								<xsl:value-of select="format:camelToLabel(Match/Result/SourceColumn)" />
							</th>
						</xsl:for-each>
						<th data-orderby-disabled="true">All</th>
					</tr>
					<tr class="hidden" data-behavior="Filter" data-filter-options="{{}}">
						<td>
							<input type="text" name="CreditApplicationID" value="{$CreditApplicationID}" placeholder="CreditApplicationID" data-filter-suffix="%" />
						</td>
						<td>
							<input type="text" name="CreditApplication" value="{$CreditApplication}" placeholder="CreditApplication" data-filter-suffix="%" />
						</td>
						<td>
							<input type="text" name="SomeCustomField" value="{$SomeCustomField}" placeholder="SomeCustomField" data-filter-suffix="%" />
						</td>
						<xsl:for-each select="$MatchColumns">
							<td />
						</xsl:for-each>
						<td />
					</tr>
				</thead>
				<tbody data-behavior="Selectable TabLauncher" data-selectable-options="{{ 'checkbox': 'ID' }}" data-tablauncher-options="{{'trigger': 'click:relay(i[data-tab])', 'bind': {{ 'class': 'qbo3.CreditApplicationObject', 'method': 'Summary', 'data': {{'Transform': 'CreditApplication.Select.xslt'}} }} }}">
					<xsl:for-each select="//CreditApplicationItem">
						<tr>
							<td>
								<xsl:value-of select="CreditApplicationID" />
							</td>
							<td>
								<xsl:choose>
									<xsl:when test="security:hasPermission('CreditApplicationSummary')">
										<a href="Acme/CreditApplication.ashx/Summary?ID={CreditApplicationID}">
											<xsl:value-of select="CreditApplication" />
										</a>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="CreditApplication" />
									</xsl:otherwise>
								</xsl:choose>
								<xsl:if test="security:hasPermission('CreditApplicationUpdate')">
									<a class="pull-right" title="Edit" onclick="qbo3.getObject(this).push('Edit', {{'CreditApplicationID': '{CreditApplicationID}'}});">
										<i class="icon-edit" />
									</a>
								</xsl:if>
								<xsl:if test="security:hasPermission('CreditApplicationSummary')">
									<a class="pull-right" title="Summary">
										<i class="icon-share" data-tab="{{'title': '{CreditApplication}','id':'items{CreditApplicationID}', 'data': {{'CreditApplicationID': '{CreditApplicationID}' }} }}" />
									</a>
								</xsl:if>
							</td>
							<td>
								<xsl:value-of select="SomeCustomField" />
							</td>
							<xsl:variable name="TableID" select="CreditApplicationID" />
							<xsl:for-each select="$MatchColumns">
								<xsl:variable name="SourceColumn" select="Match/Result/SourceColumn" />
								<td>
									<xsl:value-of select="//CreditApplicationItem[CreditApplicationID=$TableID and Match/Result/SourceColumn=$SourceColumn]/Match/Result/SourceValue" />
								</td>
							</xsl:for-each>
							<td>
								<input type="checkbox" name="ID" value="{CreditApplicationID}" />
							</td>
						</tr>
					</xsl:for-each>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="{$ColSpan}">
							<span data-behavior="Paginate" data-paginate-options="{{'display': '{$DisplaySize}', 'start': '{$RecordStart}', 'count': '{$RecordCount}' }}">
								<xsl:value-of select="''" />
							</span>
							<span class="rendertime">
								<xsl:value-of select="''" />
							</span>
						</td>
					</tr>
				</tfoot>
			</table>
		</div>
	</xsl:template>
</xsl:stylesheet>