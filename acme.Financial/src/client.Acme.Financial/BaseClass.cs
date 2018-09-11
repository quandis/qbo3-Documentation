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
	public class BaseClass<T>
    {
		// BaseURL for QBO installation
		protected Uri host;
		// Credentials for Basic authentication
		protected NetworkCredential credential;
		// Keep track of the .ashx hander for a given class.
		protected string endpoint;

		#region Constructors
		public BaseClass(Uri host, NetworkCredential credential, string endpoint)
		{
			this.host = host;
			this.credential = credential;			
			this.endpoint = endpoint;
		}

		public BaseClass(string host, NetworkCredential credential, string endpoint) : this(new Uri(host), credential, endpoint)
		{ }

		#endregion Constructors


		dynamic Fields;
		#region Public methods

		public Task<dynamic> SelectAsync(int id)
		{
			var json = GetJsonAsync("Select", string.Format("ID={0}", id));calc
			return Fields;
		}

		public Task<JToken> GetJsonAsync(string method, string queryString = "")
		{
			return GetJsonAsync(endpoint, method, queryString);
		}

		public Task<DataSet> GetDataSetAsync(string method, string queryString = "")
		{
			return GetDataSetAsync(endpoint, method, queryString);
		}

		public Task<XDocument> GetXDocumentAsync(string method, string queryString = "")
		{
			return GetXDocumentAsync(endpoint, method, queryString);
		}

		#endregion Public methods


		public string AbsolutePath(string relativePath, string method = null)
		{
			return string.Format("{0}/{1}/{2}", host.AbsoluteUri, relativePath, method);
		}

		protected async Task<JToken> GetJsonAsync(string relativePath, string method, string queryString = "")
		{
			JToken token = null;
			using (var streamReader = await GetResponseTextAsync(relativePath, method, OutputType.Json, queryString))
			{
				using (var jsonReader = new JsonTextReader(streamReader))
				{
					token = JObject.ReadFrom(jsonReader);
				}
			}
			return token;
		}

		protected async Task<XDocument> GetXDocumentAsync(string relativePath, string method, string queryString = "")
		{
			XDocument xml = null;
			using (var stream = await GetResponseAsync(relativePath, method, OutputType.Xml, queryString))
			{
				await XDocument.LoadAsync(stream, LoadOptions.None, default(CancellationToken));
			}
			return xml;
		}

		protected async Task<DataSet> GetDataSetAsync(string relativePath, string method, string queryString = "")
		{
			DataSet data = new DataSet();
			using (var stream = await GetResponseAsync(relativePath, method, OutputType.Xml, queryString))
			{
				data.ReadXml(stream);
			}
			return data;
		}

		protected async Task<Stream> GetResponseAsync(string relativePath, string method, string output, string queryString)
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

		protected async Task<StreamReader> GetResponseTextAsync(string relativePath, string method, string outputType, string queryString)
		{
			return new StreamReader(await GetResponseAsync(relativePath, method, outputType, queryString));
		}

	}

}

