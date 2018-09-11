<xsl:stylesheet version="1.0" exclude-result-prefixes="format" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:format="urn:qbo3-formatting" xmlns:security="urn:qbo3-security" xmlns:data="urn:qbo3-data">
	<xsl:import href="Theme.xslt" />
	<xsl:import href="Acme/CreditApplication.Select.xslt" />
	<xsl:output method="html" indent="yes" doctype-system="html" />
	<xsl:param name="BaseHref" />
	<xsl:variable name="apos">
		<xsl:text>'</xsl:text>
	</xsl:variable>
	<xsl:template match="/">
		<html>
			<head>
				<xsl:call-template name="Head">
					<xsl:with-param name="Title">
						<xsl:call-template name="ModuleLabel">
							<xsl:with-param name="Object">CreditApplication</xsl:with-param>
						</xsl:call-template>
						<xsl:text xml:space="preserve"> Summary</xsl:text>
					</xsl:with-param>
				</xsl:call-template>
			</head>
			<body class="navbar-left">
				<xsl:call-template name="MainMenu">
					<xsl:with-param name="Object">CreditApplication</xsl:with-param>
					<xsl:with-param name="ObjectID" select="//CreditApplicationID[1]" />
				</xsl:call-template>
				<div class="navbar-fixed-left" data-behavior="Navigate">
					<div class="tabbable tabs-left">
						<ul class="nav nav-tabs">
							<li class="active">
								<a data-target="panelSummary">
									<xsl:text>Summary</xsl:text>
								</a>
							</li>
							<xsl:if test="(security:hasPermission('DecisionDelaySearch') and security:hasPermission('CreditApplicationDecisionDelaySearch')) or (security:hasPermission('AttachmentSearch') and security:hasPermission('CreditApplicationAttachmentSearch'))">
								<li>
									<a data-target="panelActivity">
										<xsl:text>Activity</xsl:text>
									</a>
								</li>
							</xsl:if>
							<xsl:if test="(security:hasPermission('ImportFormProject') and security:hasPermission('CreditApplicationImportFormProject')) or (security:hasPermission('DecisionDelaySearch') and security:hasPermission('CreditApplicationDecisionDelaySearch'))">
								<li>
									<a data-target="panelDecision">
										<xsl:text>Workflow</xsl:text>
									</a>
								</li>
							</xsl:if>
							<xsl:if test="security:hasPermission('MessageSearch') and security:hasPermission('CreditApplicationMessageSearch')">
								<li>
									<a data-target="panelMessage">
										<xsl:text>Messages</xsl:text>
									</a>
								</li>
							</xsl:if>
							<xsl:if test="security:hasPermission('AttachmentSearch') and security:hasPermission('CreditApplicationAttachmentSearch')">
								<li>
									<a data-target="panelAttachment">
										<xsl:text>Documents</xsl:text>
									</a>
								</li>
							</xsl:if>
							<xsl:if test="security:hasPermission('ProcessSearch') and security:hasPermission('CreditApplicationProcessSearch')">
								<li>
									<a data-target="panelProcess">
										<xsl:text>Processes</xsl:text>
									</a>
								</li>
							</xsl:if>
							<li>
								<a data-target="panelGeneric">
									<xsl:text>Miscellaneous</xsl:text>
								</a>
							</li>
						</ul>
					</div>
				</div>
				<div class="container-fluid">
					<div class="row-fluid" id="panelSummary">
						<xsl:for-each select="//CreditApplicationItem[1]">
							<ul class="nav nav-tabs" data-behavior="BS.Tabs" data-bs-tabs-options="{{'tabs-selector': 'li[class!=dropdown]'}}">
								<li>
									<a href="#select" data-toggle="tab" onclick="qbo3.behavior.fireEvent('renderCreditApplicationSummary');">
										<xsl:call-template name="ModuleLabel">
											<xsl:with-param name="Object">CreditApplication</xsl:with-param>
										</xsl:call-template>
										<xsl:text xml:space="preserve"> Summary</xsl:text>
									</a>
								</li>
								<xsl:if test="Object != '' and ObjectID != '' and (Object != 'CreditApplication' or ObjectID != CreditApplicationID) and security:hasPermission(concat(Object, 'Summary')) and security:hasPermission(concat('CreditApplication', Object, 'Summary'))">
									<li>
										<a href="#parent{Object}" data-toggle="tab">
											<xsl:call-template name="ModuleLabel">
												<xsl:with-param name="Object">
													<xsl:value-of select="Object" />
												</xsl:with-param>
											</xsl:call-template>
											<xsl:text xml:space="preserve"> Summary</xsl:text>
										</a>
									</li>
								</xsl:if>
							</ul>
							<div class="tab-content">
								<div id="select" class="tab-pane" data-behavior="ObjectBind" data-objectbind-options="{{ 'class': 'qbo3.CreditApplicationObject', 'remember': false, 'data': {{'ID': '{CreditApplicationID}' }} }}">
									<xsl:call-template name="CreditApplicationSelect" />
								</div>
								<xsl:if test="Object != '' and ObjectID != '' and (Object != 'CreditApplication' or ObjectID != CreditApplicationID) and security:hasPermission(concat(Object, 'Summary')) and security:hasPermission(concat('CreditApplication', Object, 'Summary'))">
									<div id="parent{Object}" class="tab-pane" data-behavior="ObjectBind" data-objectbind-options="{{ 'class': 'qbo3.{Object}Object', 'method': 'Select', 'cacheKey': '{Object}-CreditApplication-{CreditApplicationID}', 'data': {{ '{Object}ID': '{ObjectID}' }} }}" />
								</xsl:if>
							</div>
						</xsl:for-each>
					</div>
					<xsl:if test="(security:hasPermission('DecisionDelaySearch') and security:hasPermission('CreditApplicationDecisionDelaySearch')) or (security:hasPermission('AttachmentSearch') and security:hasPermission('CreditApplicationAttachmentSearch'))">
						<div class="row-fluid" id="panelActivity">
							<ul class="nav nav-tabs" data-behavior="BS.Tabs" data-bs-tabs-options="{{'cookieName':'PanelActivity-CreditApplication', 'tabs-selector': 'li[class!=dropdown]', 'sections-selector': '+.tab-content &gt; div.tab-pane'}}">
								<xsl:if test="security:hasPermission('DecisionDelaySearch') and security:hasPermission('CreditApplicationDecisionDelaySearch')">
									<li>
										<a href="#activityDecisionDelay" class="total" data-toggle="tab">
											<xsl:text>Delays</xsl:text>
										</a>
									</li>
								</xsl:if>
								<xsl:if test="security:hasPermission('AttachmentSearch') and security:hasPermission('CreditApplicationAttachmentSearch')">
									<li>
										<a href="#activityAttachment" class="total" data-toggle="tab">
											<xsl:text>Attachments</xsl:text>
										</a>
									</li>
								</xsl:if>
							</ul>
							<div class="tab-content">
								<xsl:for-each select="//CreditApplicationItem[1]">
									<xsl:if test="security:hasPermission('DecisionDelaySearch') and security:hasPermission('CreditApplicationDecisionDelaySearch')">
										<div id="activityDecisionDelay" class="tab-pane" data-behavior="ObjectBind" data-objectbind-options="{{ 'class': 'qbo3.DecisionDelayObject', 'method': 'Search', 'cacheKey': 'DecisionDelay-CreditApplication-{//CreditApplicationID[1]}', 'data': {{ 'Object' : 'CreditApplication', 'ObjectID': '{//CreditApplicationID[1]}' }} }}" />
									</xsl:if>
									<xsl:if test="security:hasPermission('AttachmentSearch') and security:hasPermission('CreditApplicationAttachmentSearch')">
										<div id="activityAttachment" class="tab-pane" data-behavior="ObjectBind" data-objectbind-options="{{ 'class': 'qbo3.AttachmentObject', 'method': 'Search', 'cacheKey': 'Attachment-CreditApplication-{//CreditApplicationID[1]}', 'data': {{ 'Object' : 'CreditApplication', 'ObjectID': '{//CreditApplicationID[1]}' }} }}" />
									</xsl:if>
								</xsl:for-each>
							</div>
						</div>
					</xsl:if>
					<xsl:if test="(security:hasPermission('ImportFormProject') and security:hasPermission('CreditApplicationImportFormProject')) or (security:hasPermission('DecisionDelaySearch') and security:hasPermission('CreditApplicationDecisionDelaySearch'))">
						<div class="row-fluid" id="panelDecision">
							<ul class="nav nav-tabs" data-behavior="BS.Tabs" data-bs-tabs-options="{{'cookieName':'PanelDecision-CreditApplication', 'tabs-selector': 'li[class!=dropdown]', 'sections-selector': '+.tab-content &gt; div.tab-pane'}}">
								<xsl:if test="security:hasPermission('ImportFormProject') and security:hasPermission('CreditApplicationImportFormProject')">
									<li>
										<a href="#tasks" class="total" data-toggle="tab">
											<xsl:text>Tasks</xsl:text>
										</a>
									</li>
								</xsl:if>
								<xsl:if test="security:hasPermission('DecisionDelaySearch') and security:hasPermission('CreditApplicationDecisionDelaySearch')">
									<li>
										<a href="#holds" class="total" data-toggle="tab">
											<xsl:text>Holds</xsl:text>
										</a>
									</li>
								</xsl:if>
							</ul>
							<div class="tab-content">
								<xsl:for-each select="//CreditApplicationItem[1]">
									<xsl:if test="security:hasPermission('ImportFormProject') and security:hasPermission('CreditApplicationImportFormProject')">
										<div id="tasks" class="tab-pane" data-behavior="ObjectBind" data-objectbind-options="{{ 'class': 'qbo3.ImportFormObject', 'method': 'Project', 'listen': ['DecisionProcess'], 'cacheKey': 'tasks-CreditApplication-{//CreditApplicationID[1]}', 'data': {{ 'Object': 'CreditApplication', 'ObjectID' : '{//CreditApplicationID[1]}', 'DecisionID': '{CurrentDecisionID}', 'OrderBy': 'EstimatedCompletion' }} }}" />
									</xsl:if>
									<xsl:if test="security:hasPermission('DecisionDelaySearch') and security:hasPermission('CreditApplicationDecisionDelaySearch')">
										<div id="holds" class="tab-pane" data-behavior="ObjectBind" data-objectbind-options="{{ 'class': 'qbo3.DecisionDelayObject', 'method': 'Search', 'cacheKey': 'holds-CreditApplication-{//CreditApplicationID[1]}', 'data': {{ 'DecisionID' : '{CurrentDecisionID}', 'AppliesTo': 'CreditApplication', 'OrderBy': 'DecisionDelayID', 'Object': 'CreditApplication', 'ObjectID': '{CreditApplicationID}', 'TreeChildObject': 'Attachment' }} }}" />
									</xsl:if>
								</xsl:for-each>
							</div>
						</div>
					</xsl:if>
					<xsl:if test="security:hasPermission('MessageSearch') and security:hasPermission('CreditApplicationMessageSearch')">
						<xsl:call-template name="PanelGeneric">
							<xsl:with-param name="Object">CreditApplication</xsl:with-param>
							<xsl:with-param name="ObjectID" select="//CreditApplicationID[1]" />
							<xsl:with-param name="TreeDescendantsExclude" />
							<xsl:with-param name="TreeKeysExclude">CurrentDecisionID ProcessTemplateID</xsl:with-param>
							<xsl:with-param name="PanelInclude">Message</xsl:with-param>
							<xsl:with-param name="PanelID">panelMessage</xsl:with-param>
							<xsl:with-param name="RenderTotal">1</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="security:hasPermission('AttachmentSearch') and security:hasPermission('CreditApplicationAttachmentSearch')">
						<xsl:call-template name="PanelGeneric">
							<xsl:with-param name="Object">CreditApplication</xsl:with-param>
							<xsl:with-param name="ObjectID" select="//CreditApplicationID[1]" />
							<xsl:with-param name="TreeDescendantsExclude" />
							<xsl:with-param name="TreeKeysExclude">CurrentDecisionID ProcessTemplateID</xsl:with-param>
							<xsl:with-param name="PanelInclude">Attachment</xsl:with-param>
							<xsl:with-param name="PanelID">panelAttachment</xsl:with-param>
							<xsl:with-param name="RenderTotal">1</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="security:hasPermission('ProcessSearch') and security:hasPermission('CreditApplicationProcessSearch')">
						<div class="row-fluid" id="panelProcess">
							<xsl:for-each select="//CreditApplicationItem[1]">
								<ul class="nav nav-tabs" data-behavior="BS.Tabs" data-bs-tabs-options="{{'tabs-selector': 'li[class!=dropdown]'}}">
									<li>
										<a href="#processes" class="total" data-toggle="tab" onclick="qbo3.behavior.fireEvent('renderProcess');">Related Processes</a>
									</li>
								</ul>
								<div class="tab-content">
									<div id="processes" class="tab-pane" data-behavior="ObjectBind" data-objectbind-options="{{ 'class': 'qbo3.ProcessObject', 'method': 'Search', 'cacheKey': 'RelatedProcessSearch-CreditApplication-{CreditApplicationID}', 'data': {{ 'Object': '{Object}', 'ObjectID': '{ObjectID}', 'ProcessID!': '{ProcessID}', 'OrderBy': '-DateOpened', 'Title': 'Processes for {CreditApplication}' }} }}" />
								</div>
							</xsl:for-each>
						</div>
					</xsl:if>
					<xsl:call-template name="PanelGeneric">
						<xsl:with-param name="Object" select="'CreditApplication'" />
						<xsl:with-param name="ObjectID" select="//CreditApplicationID[1]" />
						<xsl:with-param name="TreeKeysExclude">CurrentDecisionID ProcessTemplateID</xsl:with-param>
						<xsl:with-param name="PanelExclude">ImportForm,Message,Attachment</xsl:with-param>
					</xsl:call-template>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>