<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:format="urn:qbo3-formatting" xmlns:data="urn:qbo3-data">
	<xsl:import href="Theme.xslt" />
	<xsl:output method="html" indent="yes" doctype-system="html" />
	<!-- Standard Parameters -->
	<xsl:param name="Title">
		<xsl:value-of select="CreditApplication" />
		<xsl:text> Summary</xsl:text>
	</xsl:param>
	<xsl:template match="//CreditApplicationItem[1]">
		<xsl:call-template name="CreditApplicationEdit" />
	</xsl:template>
	<xsl:template name="CreditApplicationEdit">
		<form class="grid form-horizontal" data-behavior="Validator">
			<fieldset>
				<legend>
					<xsl:value-of select="$Title" />
				</legend>
				<input type="hidden" name="CreditApplicationID" value="{CreditApplicationID}" />
				<input type="hidden" name="Object" value="{Object}" />
				<input type="hidden" name="ObjectID" value="{ObjectID}" />
				<div class="row-fluid">
					<div class="span6">
						<div class="control-group">
							<label for="CreditApplication">Credit Application</label>
							<div class="controls">
								<input type="text" id="CreditApplication" name="CreditApplication" class=" required" value="{CreditApplication}" />
							</div>
						</div>
						<div class="control-group">
							<label for="SomeCustomField">Some Custom Field</label>
							<div class="controls">
								<input type="text" id="SomeCustomField" name="SomeCustomField" class="" value="{SomeCustomField}" />
							</div>
						</div>
						<div class="control-group">
							<label for="Process">Process</label>
							<div class="controls">
								<input type="text" id="Process" name="Process" class=" required" value="{Process}" />
							</div>
						</div>
						<div class="control-group">
							<label for="ProcessTemplateID">Process Template</label>
							<div class="controls">
								<select id="ProcessTemplateID" name="ProcessTemplateID" data-behavior="Dropdown" data-dropdown-options="{{'url': 'Process/ProcessTemplate.ashx/ListWhere?ProcessTemplate=%&amp;output=Json', 'selected': '{ProcessTemplateID}', 'jsonEval': 'ProcessTemplateCollection.ProcessTemplateItem', 'value': 'ProcessTemplateID', 'text': 'ProcessTemplate' }}">
									<option value="">--</option>
								</select>
							</div>
						</div>
						<div class="control-group">
							<label for="Status">Status</label>
							<div class="controls">
								<select id="Status" name="Status" data-behavior="Dropdown" data-dropdown-options="{{ 'type': 'ObjectStatus' , 'selected': '{Status}', 'data': {{ 'Object': 'CreditApplication' }} }}">
									<option value="">--</option>
								</select>
							</div>
						</div>
						<div class="control-group">
							<label for="ProcessType">Process Type</label>
							<div class="controls">
								<select id="ProcessType" name="ProcessType" data-behavior="Dropdown" data-dropdown-options="{{'type': 'ObjectType', 'selected': '{ProcessType}', 'data': {{ 'Object': 'CreditApplication.ProcessType' }} }}">
									<option value="">--</option>
								</select>
							</div>
						</div>
						<div class="control-group">
							<label for="Priority">Priority</label>
							<div class="controls">
								<input type="text" id="Priority" name="Priority" class="qbo-int" value="{Priority}" />
							</div>
						</div>
						<div class="control-group">
							<label for="ClientID">Client</label>
							<div class="controls">
								<select id="ClientID" name="ClientID" data-behavior="Dropdown" data-dropdown-options="{{'url': 'Contact/Organization.ashx/ListWhere?Organization=%&amp;output=Json', 'selected': '{ClientID}', 'jsonEval': 'OrganizationCollection.OrganizationItem', 'value': 'OrganizationID', 'text': 'Organization' }}">
									<option value="">--</option>
								</select>
							</div>
						</div>
						<div class="control-group">
							<label for="ClientPersonID">Client Person</label>
							<div class="controls">
								<select id="ClientPersonID" name="ClientPersonID" data-behavior="Dropdown" data-dropdown-options="{{'url': 'Security/Person.ashx/ListWhere?Person=%&amp;output=Json', 'selected': '{ClientPersonID}', 'jsonEval': 'PersonCollection.PersonItem', 'value': 'PersonID', 'text': 'Person' }}">
									<option value="">--</option>
								</select>
							</div>
						</div>
						<div class="control-group">
							<label for="VendorID">Vendor</label>
							<div class="controls">
								<select id="VendorID" name="VendorID" data-behavior="Dropdown" data-dropdown-options="{{'url': 'Contact/Organization.ashx/ListWhere?Organization=%&amp;output=Json', 'selected': '{VendorID}', 'jsonEval': 'OrganizationCollection.OrganizationItem', 'value': 'OrganizationID', 'text': 'Organization' }}">
									<option value="">--</option>
								</select>
							</div>
						</div>
						<div class="control-group">
							<label for="VendorPersonID">Vendor Person</label>
							<div class="controls">
								<select id="VendorPersonID" name="VendorPersonID" data-behavior="Dropdown" data-dropdown-options="{{'url': 'Security/Person.ashx/ListWhere?Person=%&amp;output=Json', 'selected': '{VendorPersonID}', 'jsonEval': 'PersonCollection.PersonItem', 'value': 'PersonID', 'text': 'Person' }}">
									<option value="">--</option>
								</select>
							</div>
						</div>
						<div class="control-group">
							<label for="AssignedOrganizationID">Assigned Organization</label>
							<div class="controls">
								<select id="AssignedOrganizationID" name="AssignedOrganizationID" data-behavior="Dropdown" data-dropdown-options="{{'url': 'Contact/Collection.ashx/SecureOrganizationMemberList?Collection=CreditApplication Organizations&amp;output=Json', 'selected': '{AssignedOrganizationID}', 'jsonEval': 'CollectionMemberCollection.CollectionMemberItem', 'value': 'SourceObjectID', 'text': 'CollectionMember' }}" data-dropdown-data="{{'cache': '300'}}">
									<option value="">--</option>
								</select>
							</div>
						</div>
						<div class="control-group">
							<label for="AssignedPersonID">Assigned Person</label>
							<div class="controls">
								<select id="AssignedPersonID" name="AssignedPersonID" data-behavior="Dropdown" data-dropdown-options="{{'url': 'Contact/Collection.ashx/SecurePersonMemberList?output=Json', 'selected': '{AssignedPersonID}', 'jsonEval': 'CollectionMemberCollection.CollectionMemberItem', 'text': 'CollectionMember', 'value': 'SourceObjectID', 'data': {{ 'Collection': 'CreditApplication.AssignedPersonID' }} }}" data-dropdown-data="{{'cache': '300'}}">
									<option value="">--</option>
								</select>
							</div>
						</div>
						<div class="control-group">
							<label for="DateOpened">Date Opened</label>
							<div class="controls">
								<input type="text" id="DateOpened" name="DateOpened" class="qbo-date" value="{format:formatDate(DateOpened)}" />
							</div>
						</div>
						<div class="control-group">
							<label for="OpenedReason">Opened Reason</label>
							<div class="controls">
								<select id="OpenedReason" name="OpenedReason" data-behavior="Dropdown" data-dropdown-options="{{'type': 'ObjectType', 'selected': '{OpenedReason}', 'data': {{ 'Object': 'CreditApplication.OpenedReason' }} }}">
									<option value="">--</option>
								</select>
							</div>
						</div>
						<div class="control-group">
							<label for="DateClosed">Date Closed</label>
							<div class="controls">
								<input type="text" id="DateClosed" name="DateClosed" class="qbo-date" value="{format:formatDate(DateClosed)}" />
							</div>
						</div>
						<div class="control-group">
							<label for="ClosedReason">Closed Reason</label>
							<div class="controls">
								<select id="ClosedReason" name="ClosedReason" data-behavior="Dropdown" data-dropdown-options="{{'type': 'ObjectType', 'selected': '{ClosedReason}', 'data': {{ 'Object': 'CreditApplication.ClosedReason' }} }}">
									<option value="">--</option>
								</select>
							</div>
						</div>
						<div class="control-group">
							<label for="CostLedgerID">Cost Ledger</label>
							<div class="controls">
								<select id="CostLedgerID" name="CostLedgerID" data-behavior="Dropdown" data-dropdown-options="{{'url': 'Accounting/Ledger.ashx/ListWhere?Ledger=%&amp;output=Json', 'selected': '{CostLedgerID}', 'jsonEval': 'LedgerCollection.LedgerItem', 'value': 'LedgerID', 'text': 'Ledger' }}">
									<option value="">--</option>
								</select>
							</div>
						</div>
						<div class="control-group">
							<label for="ROIScoreID">ROI Score</label>
							<div class="controls">
								<select id="ROIScoreID" name="ROIScoreID" data-behavior="Dropdown" data-dropdown-options="{{'url': 'Score/Score.ashx/ListWhere?Score=%&amp;output=Json', 'selected': '{ROIScoreID}', 'jsonEval': 'ScoreCollection.ScoreItem', 'value': 'ScoreID', 'text': 'Score' }}">
									<option value="">--</option>
								</select>
							</div>
						</div>
						<div class="control-group">
							<label for="CurrentDecisionID">Current Decision</label>
							<div class="controls">
								<select id="CurrentDecisionID" name="CurrentDecisionID" data-behavior="Dropdown" data-dropdown-options="{{'url': 'Decision/Decision.ashx/ListWhere?Decision=%&amp;output=Json', 'selected': '{CurrentDecisionID}', 'jsonEval': 'DecisionCollection.DecisionItem', 'value': 'DecisionID', 'text': 'Decision' }}">
									<option value="">--</option>
								</select>
							</div>
						</div>
						<div class="control-group">
							<label for="DateDue">Date Due</label>
							<div class="controls">
								<input type="text" id="DateDue" name="DateDue" class="qbo-date" value="{format:formatDate(DateDue)}" />
							</div>
						</div>
					</div>
					<div class="span6">
						<!--Move some fields into here-->
					</div>
				</div>
				<div class="form-actions">
					<button type="button" class="btn btn-primary save" onclick="qbo3.getObject(this).savePop(null, 'SelectXhtml', {{ID: '{CreditApplicationID}'}});">
						<i class="icon-ok icon-white" />
						<xsl:text> Save</xsl:text>
					</button>
					<button type="button" class="btn" onclick="qbo3.getObject(this).pop('SelectXhtml', {{ID: '{CreditApplicationID}'}});">
						<i class="icon-remove" />
						<xsl:text> Cancel</xsl:text>
					</button>
				</div>
			</fieldset>
		</form>
	</xsl:template>
</xsl:stylesheet>