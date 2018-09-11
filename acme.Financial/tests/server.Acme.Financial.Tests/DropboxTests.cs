using System;
using System.Net;
using System.Threading.Tasks;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using qbo.Application.Utilities;
using qbo.Attachment.Configuration;

namespace server.Acme.Financial.Tests
{
	[TestClass]
	public class DropboxTests
	{
		private static NetworkCredential credential = new NetworkCredential("sample", "qeFM8pcxMW8AAAAAAAAJLxCTo2h7NdE7ktb775jsyX9MAdPzM3B8I1w-leEq_A5e");

		private FileObject _Config;

		/// <summary>
		/// This is for the test only. In QBO, a FileObject stored in configuration will identify this, including the URI.
		/// Note that multiple FileObject entries can be used to bind to multiple Dropbox accounts.
		/// See server.Acme.Financial > Config > Setup.AcmeFinancial.config.
		/// </summary>
		private FileObject Config
		{
			get
			{
				if (_Config == null) 
					_Config = new FileObject()
					{
						Name = "Dropbox",
						Type = typeof(Dropbox),
						Uri = "https://dropbox.com/AcmeFinancial"
					};
				return _Config;
			}
		}

		[TestMethod]
		public async Task WritesFile()
		{
			await WritesFile(string.Format("{0}", Guid.NewGuid()));
		}

		public async Task WritesFile(string guid = null)
		{
			if (guid == null) guid = string.Format("{0}", Guid.NewGuid());

			// Manually set the test credential; in the real-world, QBO will store them in it's CredentialCache.
			var dropbox = new Dropbox(Config, null) { Credential = credential };

			using (var stream = new CacheStream("Samples/HelloDropbox.html", System.IO.FileMode.Open, System.IO.FileAccess.Read))
			{
				// Make sure we have a unique file, so folks can see the new file in Dropbox
				var info = await dropbox.WriteAsync(stream, string.Format("HelloDropbox.{0}.html", guid));
				Assert.IsNotNull(info);
			}
		}

		[TestMethod]
		public async Task ReadsFile()
		{
			// Make sure we read and write the same filename.
			string guid = string.Format("{0}", Guid.NewGuid());

			// Write a file so we can read it back.
			await WritesFile(guid);

			// Manually set the test credential; in the real-world, QBO will store them in it's CredentialCache.
			var dropbox = new Dropbox(Config, null) { Credential = credential };

			// CacheStream creates a temp file, and deletes the file upon closing. You can debug and inspect it if you want.
			using (var stream = new CacheStream())
			{
				var info = await dropbox.ReadAsync(stream, string.Format("HelloDropbox.{0}.html", guid));
				// Make sure we get info back
				Assert.IsNotNull(info);
				// Make sure there is content.
				Assert.IsTrue(info.Length > 0);
			}


		}
	}
}
