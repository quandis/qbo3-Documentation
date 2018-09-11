using qbo.Application.Configuration;
using qbo.Application.Interfaces;
using qbo.Process;
using System;
using System.Runtime.Serialization;
using System.Xml.Serialization;

namespace server.Acme.Financial
{
	/// <summary>
	/// Class for managing
	/// </summary>
	[DataContract(Name = "CreditApplicationItem", Namespace = "")]
	public partial class CreditApplicationObject : ProcessObject
	{
		/// <summary>
		/// Primary key for a record.
		/// </summary>
		[XmlIgnore]
		public override Int64? ID
		{
			get { return _CreditApplicationID; }
			set { CreditApplicationID = value; }
		}
		private static ObjectConfiguration _Configuration;
		/// <summary>
		/// Configuration properties for this class.
		/// </summary>
		[XmlIgnore]
		public override ObjectConfiguration Configuration
		{
			get
			{
				if (CreditApplicationObject._Configuration == null)
					CreditApplicationObject._Configuration = ObjectConfiguration.GetSection("qbo/CreditApplication");
				return CreditApplicationObject._Configuration;
			}
			set { CreditApplicationObject._Configuration = value; }
		}
		/// <summary>
		/// Used for XmlSerialization
		/// </summary>
		public CreditApplicationObject()
		: base()
		{
		}

		/// <summary>
		/// Standard Constructor
		/// </summary>
		public CreditApplicationObject(IPerson user)
		: base(user)
		{
		}


		/// <summary>
		/// Returns an ApplicationSetting from this namespace if available.
		/// </summary>
		/// <param name="setting">Application setting to return.</param>
		/// <returns>ApplicationSetting from this namespace.</returns>
		public override string Setting(string setting)
		{
			if (Properties.Settings.Default.Properties[setting] != null)
				return Properties.Settings.Default[setting].ToString();
			else
				return base.Setting(setting);
		}

		/// <summary>
		/// Returns a resource from this namespace, if available.
		/// </summary>
		/// <remarks>This is used by AbstractObject.cs to dynamically update table structures. The SQL scripts for table creation and column updating should exist in the project's Properties > Resources file, named CreateTable{TableName}.</remarks>
		/// <param name="resource">Name of string resource to return.</param>
		/// <returns>String resource.</returns>
		public override string Resource(string resource)
		{
			return Properties.Resources.ResourceManager.GetString(resource);
		}
	}
}