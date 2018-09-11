<xsl:stylesheet version="1.0" exclude-result-prefixes="format" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:format="urn:qbo3-formatting" xmlns:security="urn:qbo3-security" xmlns:data="urn:qbo3-data">
	<xsl:import href="Theme.xslt" />
	<xsl:import href="Acme/CreditApplication.Search.xslt" />
	<xsl:output method="html" indent="yes" doctype-system="html" />
	<xsl:param name="BaseHref" />
	<xsl:template match="/">
		<html>
			<head>
				<xsl:call-template name="Head">
					<xsl:with-param name="Title">CreditApplications</xsl:with-param>
				</xsl:call-template>
			</head>
			<body>
				<xsl:call-template name="MainMenu">
					<xsl:with-param name="Object">CreditApplication</xsl:with-param>
				</xsl:call-template>
				<div class="container-fluid">
					<xsl:if test="security:hasPermission('CreditApplicationDashboard')">
						<div id="CreditApplicationHomeDashboard" class="row-fluid">
							<div class="span12">
								<ul class="nav nav-tabs" data-behavior="BS.Tabs" data-bs-tabs-options="{{'cookieName': 'CreditApplicationHome', 'tabs-selector': 'li[class!=dropdown][class!=panel-toggle]', 'sections-selector': '+.tab-content &gt; div.tab-pane'}}">
									<xsl:if test="security:hasPermission('CreditApplicationDashboardView')">
										<li>
											<a href="#dashboard" data-toggle="tab">Dashboard</a>
										</li>
									</xsl:if>
									<xsl:if test="security:hasPermission('CreditApplicationDashboardPivot')">
										<li>
											<a href="#pivotstatus" data-toggle="tab" onclick="qbo3.getObject('search').data = {{ }}">Pivot</a>
										</li>
									</xsl:if>
									<xsl:if test="security:hasPermission('CreditApplicationDashboardCharts')">
										<li>
											<a href="#charts" data-toggle="tab" onclick="qbo3.getObject('search').data = {{ }}">Charts</a>
										</li>
									</xsl:if>
									<li class="panel-toggle">
										<a onclick="return false;" class="nopadding" data-behavior="Collapse" data-collapse-options="{{'toggle': 'i', 'hide': '.dashboard-content', 'hiddenClass': 'panel-toggle-hidden', 'event': 'click', 'key': 'CreditApplication.Dashboard'}}">
											<i class="icon-arrow-up" />
										</a>
									</li>
								</ul>
								<div class="tab-content dashboard-content">
									<xsl:if test="security:hasPermission('CreditApplicationDashboardView')">
										<div id="dashboard" class="tab-pane" data-behavior="ObjectBind" data-objectbind-options="{{ 'class': 'qbo3.CreditApplicationObject', 'method': 'Dashboard', 'cacheKey': 'CreditApplication-Home-Dashboard', 'data': {{'Dimension': 'ProcessType'}} }}" />
									</xsl:if>
									<xsl:if test="security:hasPermission('CreditApplicationDashboardPivot')">
										<div class="tab-pane" id="pivotstatus" data-behavior="ObjectBind" data-objectbind-options="{{ 'class': 'qbo3.CreditApplicationObject', 'method':'DashboardPivot', 'cacheKey':'CreditApplication-Home-Pivot', 'data': {{'Dimension': 'Status,ProcessType', 'X':'Status', 'Y':'ProcessType', 'XLabel':'Status', 'YLabel':'ProcessType', 'Table':'CreditApplication'}} }}" />
									</xsl:if>
									<xsl:if test="security:hasPermission('CreditApplicationDashboardCharts')">
										<div class="tab-pane" id="charts" data-behavior="ObjectBind" data-objectbind-options="{{ 'class': 'qbo3.CreditApplicationObject' }}">
											<xsl:call-template name="RenderCharts">
												<xsl:with-param name="Dimensions" select="data:moduleDimensions('qbo/CreditApplication', 1)" />
												<xsl:with-param name="Object">CreditApplication</xsl:with-param>
											</xsl:call-template>
										</div>
									</xsl:if>
								</div>
							</div>
						</div>
					</xsl:if>
					<xsl:if test="security:hasPermission('CreditApplicationSearch')">
						<div class="row-fluid">
							<ul class="nav nav-tabs" data-behavior="BS.Tabs" data-bs-tabs-options="{{'tabs-selector': 'li[class!=dropdown][class!=panel-toggle]', 'sections-selector': '+.tab-content &gt; div.tab-pane'}}">
								<li>
									<a href="#search" data-toggle="tab">CreditApplications</a>
								</li>
							</ul>
							<div class="tab-content">
								<div id="search" class="tab-pane" data-behavior="ObjectBind" data-objectbind-options="{{ 'class':'qbo3.CreditApplicationObject', 'method':'Search', 'render':false, 'listen':['search'], 'cacheKey':'CreditApplication-Home-Search' }}">
									<xsl:call-template name="CreditApplicationSearch" />
								</div>
							</div>
						</div>
					</xsl:if>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>