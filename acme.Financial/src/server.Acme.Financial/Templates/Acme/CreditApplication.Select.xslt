<xsl:stylesheet version="1.0" exclude-result-prefixes="format" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:format="urn:qbo3-formatting" xmlns:security="urn:qbo3-security" xmlns:data="urn:qbo3-data">
	<xsl:import href="Theme.xslt" />
	<xsl:output method="html" indent="yes" doctype-system="html" />
	<xsl:param name="BaseHref" />
	<xsl:template match="/">
		<xsl:for-each select="//CreditApplicationItem[1]">
			<xsl:call-template name="CreditApplicationSelect" />
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="CreditApplicationSelect">
		<form id="CreditApplicationSelect" class="form-horizontal grid">
			<legend>
				<xsl:value-of select="CreditApplication" />
			</legend>
			<div class="row-fluid">
				<div class="span6">
					<div class="control-group">
						<label>Credit Application</label>
						<div class="controls">
							<span>
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
							</span>
						</div>
					</div>
					<div class="control-group">
						<label>Process</label>
						<div class="controls">
							<span>
								<xsl:choose>
									<xsl:when test="security:hasPermission('ProcessSummary') and count(ProcessID)=1 and ProcessID!=''">
										<a href="Process/Process.ashx/Summary?ID={ProcessID}">
											<xsl:value-of select="Process" />
										</a>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="Process" />
									</xsl:otherwise>
								</xsl:choose>
							</span>
						</div>
					</div>
					<div class="control-group">
						<label>Some Custom Field</label>
						<div class="controls">
							<span>
								<xsl:value-of select="SomeCustomField" />
							</span>
						</div>
					</div>
					<div class="control-group">
						<label>Process</label>
						<div class="controls">
							<span>
								<xsl:value-of select="Process" />
							</span>
						</div>
					</div>
					<div class="control-group">
						<label>Process Template</label>
						<div class="controls">
							<span>
								<xsl:choose>
									<xsl:when test="security:hasPermission('ProcessTemplateSummary') and count(ProcessTemplateID)=1 and ProcessTemplateID!=''">
										<a href="Process/ProcessTemplate.ashx/Summary?ID={ProcessTemplateID}">
											<xsl:value-of select="ProcessTemplate" />
										</a>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="ProcessTemplate" />
									</xsl:otherwise>
								</xsl:choose>
							</span>
						</div>
					</div>
					<div class="control-group">
						<label>Status</label>
						<div class="controls">
							<span>
								<xsl:value-of select="Status" />
							</span>
						</div>
					</div>
					<div class="control-group">
						<label>Process Type</label>
						<div class="controls">
							<span>
								<xsl:value-of select="ProcessType" />
							</span>
						</div>
					</div>
					<div class="control-group">
						<label>Priority</label>
						<div class="controls">
							<span>
								<xsl:value-of select="Priority" />
							</span>
						</div>
					</div>
					<div class="control-group">
						<label>Client</label>
						<div class="controls">
							<span>
								<xsl:choose>
									<xsl:when test="security:hasPermission('ClientSummary') and count(ClientID)=1 and ClientID!=''">
										<a href="Contact/Organization.ashx/Summary?ID={ClientID}">
											<xsl:value-of select="Client" />
										</a>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="Client" />
									</xsl:otherwise>
								</xsl:choose>
							</span>
						</div>
					</div>
					<div class="control-group">
						<label>Client Person</label>
						<div class="controls">
							<span>
								<xsl:choose>
									<xsl:when test="security:hasPermission('ClientPersonSummary') and count(ClientPersonID)=1 and ClientPersonID!=''">
										<a href="Security/Person.ashx/Summary?ID={ClientPersonID}">
											<xsl:value-of select="ClientPerson" />
										</a>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="ClientPerson" />
									</xsl:otherwise>
								</xsl:choose>
							</span>
						</div>
					</div>
					<div class="control-group">
						<label>Vendor</label>
						<div class="controls">
							<span>
								<xsl:choose>
									<xsl:when test="security:hasPermission('VendorSummary') and count(VendorID)=1 and VendorID!=''">
										<a href="Contact/Organization.ashx/Summary?ID={VendorID}">
											<xsl:value-of select="Vendor" />
										</a>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="Vendor" />
									</xsl:otherwise>
								</xsl:choose>
							</span>
						</div>
					</div>
					<div class="control-group">
						<label>Vendor Person</label>
						<div class="controls">
							<span>
								<xsl:choose>
									<xsl:when test="security:hasPermission('VendorPersonSummary') and count(VendorPersonID)=1 and VendorPersonID!=''">
										<a href="Security/Person.ashx/Summary?ID={VendorPersonID}">
											<xsl:value-of select="VendorPerson" />
										</a>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="VendorPerson" />
									</xsl:otherwise>
								</xsl:choose>
							</span>
						</div>
					</div>
					<div class="control-group">
						<label>Assigned Organization</label>
						<div class="controls">
							<span>
								<xsl:choose>
									<xsl:when test="security:hasPermission('AssignedOrganizationSummary') and count(AssignedOrganizationID)=1 and AssignedOrganizationID!=''">
										<a href="Contact/Organization.ashx/Summary?ID={AssignedOrganizationID}">
											<xsl:value-of select="AssignedOrganization" />
										</a>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="AssignedOrganization" />
									</xsl:otherwise>
								</xsl:choose>
							</span>
						</div>
					</div>
					<div class="control-group">
						<label>Assigned Person</label>
						<div class="controls">
							<span>
								<xsl:choose>
									<xsl:when test="security:hasPermission('AssignedPersonSummary') and count(AssignedPersonID)=1 and AssignedPersonID!=''">
										<a href="Security/Person.ashx/Summary?ID={AssignedPersonID}">
											<xsl:value-of select="AssignedPerson" />
										</a>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="AssignedPerson" />
									</xsl:otherwise>
								</xsl:choose>
							</span>
						</div>
					</div>
					<div class="control-group">
						<label>Date Opened</label>
						<div class="controls">
							<span>
								<xsl:value-of select="format:formatDate(DateOpened)" />
							</span>
						</div>
					</div>
					<div class="control-group">
						<label>Opened Reason</label>
						<div class="controls">
							<span>
								<xsl:value-of select="OpenedReason" />
							</span>
						</div>
					</div>
					<div class="control-group">
						<label>Date Closed</label>
						<div class="controls">
							<span>
								<xsl:value-of select="format:formatDate(DateClosed)" />
							</span>
						</div>
					</div>
					<div class="control-group">
						<label>Closed Reason</label>
						<div class="controls">
							<span>
								<xsl:value-of select="ClosedReason" />
							</span>
						</div>
					</div>
					<div class="control-group">
						<label>Cost Ledger</label>
						<div class="controls">
							<span>
								<xsl:choose>
									<xsl:when test="security:hasPermission('CostLedgerSummary') and count(CostLedgerID)=1 and CostLedgerID!=''">
										<a href="Accounting/Ledger.ashx/Summary?ID={CostLedgerID}">
											<xsl:value-of select="CostLedger" />
										</a>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="CostLedger" />
									</xsl:otherwise>
								</xsl:choose>
							</span>
						</div>
					</div>
					<div class="control-group">
						<label>ROI Score</label>
						<div class="controls">
							<span>
								<xsl:choose>
									<xsl:when test="security:hasPermission('ROIScoreSummary') and count(ROIScoreID)=1 and ROIScoreID!=''">
										<a href="Score/Score.ashx/Summary?ID={ROIScoreID}">
											<xsl:value-of select="ROIScore" />
										</a>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="ROIScore" />
									</xsl:otherwise>
								</xsl:choose>
							</span>
						</div>
					</div>
					<div class="control-group">
						<label>Current Decision</label>
						<div class="controls">
							<span>
								<xsl:choose>
									<xsl:when test="security:hasPermission('CurrentDecisionSummary') and count(CurrentDecisionID)=1 and CurrentDecisionID!=''">
										<a href="Decision/Decision.ashx/Summary?ID={CurrentDecisionID}">
											<xsl:value-of select="CurrentDecision" />
										</a>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="CurrentDecision" />
									</xsl:otherwise>
								</xsl:choose>
							</span>
						</div>
					</div>
					<div class="control-group">
						<label>Date Due</label>
						<div class="controls">
							<span>
								<xsl:value-of select="format:formatDate(DateDue)" />
							</span>
						</div>
					</div>
				</div>
				<div class="span6">
					<!--Move some fields into here-->
				</div>
			</div>
			<div class="form-actions">
				<xsl:call-template name="ButtonByPermission">
					<xsl:with-param name="Permission">CreditApplicationUpdate</xsl:with-param>
					<xsl:with-param name="Icon">icon-edit icon-white</xsl:with-param>
					<xsl:with-param name="Label">Edit</xsl:with-param>
					<xsl:with-param name="Class">btn btn-primary</xsl:with-param>
					<xsl:with-param name="OnClick">
						<xsl:text>qbo3.getObject(this).push('Edit', {'ID': '</xsl:text>
						<xsl:value-of select="CreditApplicationID" />
						<xsl:text>'});</xsl:text>
					</xsl:with-param>
				</xsl:call-template>
			</div>
		</form>
	</xsl:template>
</xsl:stylesheet>