using qbo.Enumerations;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Data;
using System.IO;
using System.Net;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Web;
using System.Xml.Linq;

namespace qbo
{
	public class Client
	{
		private Uri host;
		private NetworkCredential credential;

		public string AbsolutePath(string relativePath, string method = null)
		{
			return string.Format("{0}/{1}/{2}", host.AbsoluteUri, relativePath, method);
		}

		public Client(string host, NetworkCredential credential) : this(new Uri(host), credential)
		{ }

		public Client(Uri host, NetworkCredential credential)
		{
			this.host = host;
			this.credential = credential;
		}

		protected async Task<JToken> GetJson(string relativePath, string method, string queryString = "")
		{
			JToken token = null;
			using (var streamReader = await GetResponseText(relativePath, method, OutputType.Json, queryString))
			{
					using (var jsonReader = new JsonTextReader(streamReader))
					{
						token = JObject.ReadFrom(jsonReader);
					}
			}
			return token;
		}

		protected async Task<XDocument> GetXDocument(string relativePath, string method, string queryString = "")
		{
			XDocument xml = null;
			using (var stream = await GetResponse(relativePath, method, OutputType.Xml, queryString))
			{
				await XDocument.LoadAsync(stream, LoadOptions.None, default(CancellationToken));
			}
			return xml;
		}

		protected async Task<DataSet> GetDataSet(string relativePath, string method, string queryString = "")
		{
			DataSet data = new DataSet();
			using (var stream = await GetResponse(relativePath, method, OutputType.Xml, queryString))
			{
				data.ReadXml(stream);
			}
			return data;
		}

		protected async Task<Stream> GetResponse(string relativePath, string method, string output, string queryString)
		{
			CacheStream cache = null;

			// var uri = string.Format("{0}?{1}&Output=Json", AbsolutePath(relativePath, method), queryString);
			var uri = string.Format("{0}?Output={1}", AbsolutePath(relativePath, method), output);
			var request = WebRequest.CreateHttp(uri);

			var postData = HttpUtility.ParseQueryString(queryString);
			request.Method = "POST";
			request.ContentType = "application/x-www-form-urlencoded";
			request.Credentials = credential;

			byte[] data = Encoding.UTF8.GetBytes(postData.ToString());
			request.ContentLength = data.Length;
			using (var stream = request.GetRequestStream())
			{
				stream.Write(data, 0, data.Length);
			}

			using (var response = await request.GetResponseAsync())
			{
				using (var responseStream = response.GetResponseStream())
				{
					cache = new CacheStream(responseStream);
				}
			}
			return cache;
		}

		protected async Task<StreamReader> GetResponseText(string relativePath, string method, string outputType, string queryString)
		{
			return new StreamReader(await GetResponse(relativePath, method, outputType, queryString));
		}

	}
}
