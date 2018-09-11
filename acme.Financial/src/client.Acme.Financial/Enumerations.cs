namespace qbo.Enumerations
{
	public static class OutputType
    {
		public static string Json = "Json";
		public static string Xml = "Xml";
		public static string Excel = "Excel";
    }

	public static class Endpoints
	{
		public static class Contacts
		{
			public static string Contact = "Contact/Contact.ashx";
			public static string ContactTemplate = "Contact/ContactTemplate.ashx";
		}

		public static class Documents
		{
			public static string Attachment = "Attachment/Attachment.ashx";
			public static string AttachmentTemplate = "Attachment/AttachmentTemplate.ashx";
		}
		public static class Security
		{
			public static string Login = "Security/Login.ashx";
			public static string Person = "Security/Person.ashx";
			public static string Role = "Security/SystemRole.ashx";
			public static string Permission = "Security/SystemPermission.ashx";
			public static string Function = "Security/SystemFunction.ashx";
		}
	}


}
