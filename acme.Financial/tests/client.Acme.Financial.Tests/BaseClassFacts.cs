using System;
using System.Net;
using System.Threading.Tasks;
using Xunit;

namespace client.Acme.Financial.Tests
{
    public class BaseClassFacts
    {
		private static Uri host = new Uri("http://localhost");
		private static NetworkCredential credential = new NetworkCredential("integration@quandis.com", "Integration2018!");

		public class GetJson: BaseClassFacts
		{
			[Fact]
			public async Task ReturnsJson()
			{
				var person = new qbo.Person(host, credential);
				var result = await person.GetJsonAsync("Search", "LastName=Patrick");
				Assert.NotNull(result);
			}

		}

		public class GetDataSet : BaseClassFacts
		{
			[Fact]
			public async Task ReturnsDataSet()
			{
				var person = new qbo.Person(host, credential);
				var result = await person.GetDataSetAsync("Search", "Person=integration@quandis.com");
				Assert.NotNull(result);
				Assert.Single(result.Tables);
			}

		}

	}
}
