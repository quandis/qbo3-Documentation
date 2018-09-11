// CreditApplication class
qbo3.CreditApplicationObject = new Class({
	Extends: qbo3.AbstractObject,
	options: {
		url: 'Acme/CreditApplication.ashx/',
		columns: ['CreditApplicationID', 'CreditApplication', 'ProcessID', 'SomeCustomField']
	}
}); 