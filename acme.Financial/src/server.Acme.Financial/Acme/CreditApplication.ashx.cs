
using qbo.Application;
using System;
using System.Web;

namespace server.Acme.Financial
{
	/// <summary>
	/// Class for managing
	/// </summary>
	public class CreditApplication : HttpAsyncHandler
	{
		/// <summary>
		/// Name of the implementing page; used to determine starting point of Operation.
		/// </summary>
		protected override string BasePage
		{
			get { return "CreditApplication.ashx"; }
		}
		private AbstractObject _BaseObject;
		/// <summary>
		/// Return the base object a handler is wrapping.
		/// E.g. Contact.ashx wraps a qbo.Application.ContactObject.
		/// E.g. Loan.ashx wraps a qbo.Mortgage.Servicing.LoanObject.
		/// </summary>
		protected override AbstractObject BaseObject
		{
			get
			{
				if (_BaseObject == null)
				{
					_BaseObject = new CreditApplicationObject(User);
					_BaseObject.Alert += delegate (string alert) { RaiseAlert(alert); };
				}
				return _BaseObject;
			}
		}
		/// <summary>
		/// Processes inbound requests.
		/// This method should be overridden by derived classes to handle custom class methods.
		/// E.g. Contact.ashx should override to bind a Geocode operation to the qbo.Application.ContactObject.Geocode method.
		/// </summary>
		/// <param name="context">HttpContext passed from ASP.NET subsystem.</param>
		public override void ProcessRequest(HttpContext context)
		{
			try
			{
				DateTime start = DateTime.Now;
				switch (Operation)
				{
					default:
						base.ProcessRequest(context);
						break;
				}
				SetExecutionTime(start, DateTime.Now, context);
			}
			catch (System.Exception err)
			{
				RaiseError(err);
			}
		}
	}
}