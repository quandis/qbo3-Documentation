using qbo.Application;
using qbo.Application.Configuration;
using qbo.Application.Interfaces;
using qbo.Application.Services;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace server.Acme.Financial
{
	/// <summary>
	/// This is a bare-bones example of an <see cref="IService"/> plugin.
	/// </summary>
	public class HelloWorld : IService
	{
		public Service ServiceConfig
		{
			get { return null; }
			set { }
		}
		public AbstractObject Parent
		{
			get { return null; }
			set { }
		}

		public IDictionary<string, object> Parameters
		{
			get { return null; }
			set { }
		}


		public IAsyncResult BeginInvoke(AsyncCallback callback, object state)
		{
			throw new NotImplementedException();
		}

		public IServiceResult EndInvoke(IAsyncResult result)
		{
			throw new NotImplementedException();
		}

		public IServiceResult Invoke(IDictionary<string, object> parameters)
		{
			throw new NotImplementedException();
		}


		/// <summary>
		/// This returns a simple XmlReader with Hello World as the content.
		/// If you want to deal with the Request or Response streams directly, you can return void, and access the streams
		/// </summary>
		/// <param name="parameters">Dictionary of parameters pass to the method signature call.</param>
		/// <returns>
		/// An <see cref="IServiceResult"/>, with the <see cref="IServiceResult.Response"/> being void, a DataSet, XmlReader, <see cref="AbstractObject"/> or <see cref="IAbstractCollection"/>.
		/// </returns>
		public async Task<IServiceResult> InvokeAsync(IDictionary<string, object> parameters)
		{
			// Pretend to do real work
			await Task.Delay(1);

			var result = new ServiceResult()
			{
				Success = true,
				Response = XDocument.Parse("<Message>Hello World</Message>").CreateReader()
			};

			return result;
		
		}
	}
}