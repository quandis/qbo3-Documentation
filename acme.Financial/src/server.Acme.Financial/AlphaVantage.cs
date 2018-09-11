using Newtonsoft.Json;
using qbo.Application.Interfaces;
using qbo.Application.Services;
using qbo.Application.Utilities.Extensions;
using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Threading.Tasks;

namespace server.Acme.Financial
{
	/// <summary>
	/// Sample financial data interface to <see href="https://www.alphavantage.co/"/>.
	/// </summary>
	public class AlphaVantage : AbstractService
	{
		private static string ApiUrl = "https://www.alphavantage.co/query?apikey={0}&function={1}&symbol={2}";

		private string _ApiKey;

		/// <summary>
		/// The ApiKey will use a QBO credential if present, otherwise an application setting.
		/// This is a free service; we don't really care about different ApiKeys between environments.
		/// </summary>
		private string ApiKey
		{
			get
			{
				if (_ApiKey == null)
				{
					var credential = CredentialCache.GetCredential(new Uri(ApiUrl), "Basic");
					_ApiKey = (credential != null)
						? credential.Password
						: Properties.Settings.Default.AlphaVantageApiKey;
				}
				return _ApiKey;
			}
		}

		/// <summary>
		/// The AlphaVantage API offers different endpoints; let's support them all.
		/// </summary>
		/// <param name="parameters">Parameters passed by method signature.</param>
		public override async Task<IServiceResult> InvokeAsync(IDictionary<string, object> parameters)
		{
			// Let's figure out which stock function to call based on the QBO URL
			// Eg. Organization/StockIntraDay?Symbol=MFST
			string timeSeries;
			switch (ServiceConfig.Name)
			{
				case "StockIntraDay":
					timeSeries = "TIME_SERIES_INTRADAY";
					break;
				case "StockDaily":
					timeSeries = "TIME_SERIES_DAILY";
					break;
				case "StockWeekly":
					timeSeries = "TIME_SERIES_WEEKLY";
					break;
				default:
					timeSeries = "GLOBAL_QUOTE";
					break;
			}
			var url = string.Format(ApiUrl, ApiKey, timeSeries, parameters.GetEntry<string>("Symbol"));

			var result = new ServiceResult();

			var request = WebRequest.Create(url);

			try
			{
				using (var response = await request.GetResponseAsync())
				{
					using (var stream = response.GetResponseStream())
					{
						using (var reader = new StreamReader(stream))
						{
							var json = await reader.ReadToEndAsync();
							// Consider cleaning up their JSON here - lots of spaces.

							// Convert to XmlReader
							var xml = JsonConvert.DeserializeXNode(json);
							result.Response = xml.CreateReader();
							result.Success = true;
						}
					}
				}
			}
			catch (System.Exception ex)
			{
				result.Success = false;
				result.Exception = ex;
			}

			return result;
		}

		/// <summary>
		/// In case we hit a sync code path, cover the sync call. But async is better.
		/// </summary>
		public override IServiceResult Invoke(IDictionary<string, object> parameters)
		{
			return InvokeAsync(parameters).Result;
		}


	}
}