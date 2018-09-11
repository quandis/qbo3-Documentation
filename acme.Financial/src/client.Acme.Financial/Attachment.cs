using qbo.Enumerations;
using System;
using System.Net;

namespace qbo
{
	public class Attachment: BaseClass<Attachment>
    {
		public Attachment(Uri host, NetworkCredential credential): 
			base(host, credential, Endpoints.Documents.Attachment)
		{

		}
    }
}
