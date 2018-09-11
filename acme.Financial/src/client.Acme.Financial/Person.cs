using qbo.Enumerations;
using System;
using System.Net;

namespace qbo
{
	public class Person : BaseClass<Person>
	{
		public Person(Uri host, NetworkCredential credential) :
			base(host, credential, Endpoints.Security.Person)
		{

		}
	}
}
