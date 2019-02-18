using Microsoft.VisualStudio.TestTools.UnitTesting;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using qbo.Application.Utilities.Extensions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace server.Acme.Financial.Tests
{
    [TestClass]
    public class AlphaVantageTests
    {
        [TestMethod]
        public async Task ReturnsJson()
        {
            // Wire the AlphaVantage plugin to an existing QBO class
            var plugin = new AlphaVantage()
            {
                ServiceConfig = new qbo.Application.Configuration.Service()
                {
                    Name = "StockQuote",
                    Type = typeof(AlphaVantage)
                }
            };
            var result = await plugin.InvokeAsync("Symbol=MSFT".ToProperties());
            Assert.IsInstanceOfType(result.Response, typeof(JsonReader));
            var json = JObject.Load(result.Response as JsonReader);


        }
    }
}
