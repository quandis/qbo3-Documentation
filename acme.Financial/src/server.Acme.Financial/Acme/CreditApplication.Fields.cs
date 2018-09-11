using qbo.Application.Configuration;
using System;
using System.Collections.Generic;
using System.Runtime.Serialization;


namespace server.Acme.Financial
{
	[Table("CreditApplication")]
	public partial class CreditApplicationObject
	{
		protected Int64? _CreditApplicationID;

		/// <summary>
		/// Identity column and primary key for the table.
		/// </summary>
		[Field]
		[DataMember(EmitDefaultValue = false)]
		public virtual Int64? CreditApplicationID
		{
			get
			{
				if (!_CreditApplicationID.HasValue && ID.HasValue && !DirtyProperty["CreditApplicationID"])
					EnsureForeignKeys();
				return _CreditApplicationID;
			}
			set
			{
				if (!EqualityComparer<Int64?>.Default.Equals(_CreditApplicationID, value))
				{
					DirtyProperty["CreditApplicationID"] = true;
				}
				_CreditApplicationID = value;
				if (DirtyProperty["CreditApplicationID"])
					OnIdentityChanged("CreditApplicationID", _ID, value);
				_ID = _CreditApplicationID = value;
			}
		}

		protected string _CreditApplication;

		/// <summary>
		/// Label for the table.
		/// </summary>
		[Fact]
		[DataMember(EmitDefaultValue = false)]
		public string CreditApplication
		{
			get { return _CreditApplication; }
			set
			{
				if (!EqualityComparer<string>.Default.Equals(_CreditApplication, value))
				{
					Dirty = DirtyProperty["CreditApplication"] = true;
				}
				_CreditApplication = value;
			}
		}

		protected string _SomeCustomField;

		/// <summary>
		/// No description present in the database.
		/// </summary>
		[Field]
		[DataMember(EmitDefaultValue = false)]
		public string SomeCustomField
		{
			get { return _SomeCustomField; }
			set
			{
				if (!EqualityComparer<string>.Default.Equals(_SomeCustomField, value))
				{
					Dirty = DirtyProperty["SomeCustomField"] = true;
				}
				_SomeCustomField = value;
			}
		}

	}
}