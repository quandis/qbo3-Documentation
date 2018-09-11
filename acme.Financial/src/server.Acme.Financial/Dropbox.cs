using qbo.Application.Interfaces;
using qbo.Attachment;
using qbo.Attachment.Interfaces;
using qbo.Attachment.Configuration;
using System;
using System.Collections.Generic;
using System.IO;
using Dropbox.Api;
using System.Net;
using Dropbox.Api.Files;
using System.Threading.Tasks;
using qbo.Application.Utilities.Extensions;

namespace server.Acme.Financial
{
	/// <summary>
	/// A simple <see cref="IFileObject"/> to interface with Dropbox.
	/// <see href="https://www.dropbox.com/developers/documentation/dotnet#tutorial"/>
	/// </summary>
	public class Dropbox : qbo.Attachment.FileObjects.AbstractFile
	{
		private string _RootFolder;

		private DropboxClient _Client;
		/// <summary>
		/// Create the <see cref="DropboxClient"/> based on the <see cref="NetworkCredential"/> set up in QBO.
		/// The <see cref="NetworkCredential"/> is fetched from <see cref="CredentialCache"/> based on the <see cref="IFileObject.Uri"/>.
		/// </summary>
		public DropboxClient Client
		{
			get
			{
				if (_Client == null)
					_Client = new DropboxClient(Credential.Password);
				return _Client;
			}
		}


		/// <summary>
		/// The <see cref="FileObject.Uri"/> must be in the format https://dropbox.com/{rootFolder}.
		/// All files will be written to and read from this <see cref="_RootFolder"/>.
		/// </summary>
		/// <param name="fileObject">Configuration entry containing the Dropbox URL.</param>
		/// <param name="user">User context, just in case we want to limit permissions here.</param>
		public Dropbox(FileObject fileObject, IPerson user) : base(fileObject, user)
		{
			_RootFolder = Uri.SubstringAfter("https://dropbox.com");
			// Make sure we have a trailing slash to comply with Dropbox's pathing requirements.
			if (!_RootFolder.EndsWith("/")) _RootFolder += "/";
		}

		/// <summary>
		/// Exercise left to the reader ;-)
		/// </summary>
		public override void Delete(string relativePath)
		{
			throw new NotImplementedException();
		}

		/// <summary>
		/// Exercise left to the reader ;-)
		/// </summary>
		public override List<AttachmentInfo> List(string relativePath, string pattern, int depth)
		{
			throw new NotImplementedException();
		}

		/// <summary>
		/// Reads a file from Dropbox.
		/// </summary>
		/// <param name="stream">Stream to write file to. <see cref="qbo.Attachment.AttachmentObject"/> will set this stream up for us.</param>
		/// <param name="relativePath">Relative path to the file; e.g. /MyFolder/Readme.md</param>
		/// <returns><see cref="AttachmentInfo"/> metadata about file that was written.</returns>
		public override async Task<AttachmentInfo> ReadFileAsync(Stream stream, string relativePath)
		{
			AttachmentInfo info = null;
			using (var response = await Client.Files.DownloadAsync(Path.Combine(_RootFolder, relativePath)))
			{
				using (var content = await response.GetContentAsStreamAsync())
				{
					await TransferAsync(content, stream);
				}
				info = ToInfo(response.Response);
			}
			return info;
		}

		/// <summary>
		/// Exercise left to the reader ;-)
		/// </summary>
		public override void Rename(string oldPath, string newPath)
		{
			throw new NotImplementedException();
		}

		/// <summary>
		/// Writes a file to Dropbox.
		/// </summary>
		/// <param name="stream">Stream containing the file to write. <see cref="qbo.Attachment.AttachmentObject"/> will handle setting this stream up and tearing it down.</param>
		/// <param name="relativePath">Relative path to the file; e.g. /MyFolder/Readme.md</param>
		/// <returns><see cref="AttachmentInfo"/> metadata about file that was written.</returns>
		public override async Task<AttachmentInfo> WriteFileAsync(Stream stream, string relativePath)
		{
			var info = await Client.Files.UploadAsync(Path.Combine(_RootFolder, relativePath), null, false, DateTime.Now, false, null, stream);
			return ToInfo(info);
		}

		/// <summary>
		/// Sugar for converting <see cref="FileMetadata"/> to <see cref="AttachmentInfo"/>.
		/// </summary>
		public AttachmentInfo ToInfo(FileMetadata metadata)
		{
			return new AttachmentInfo()
			{
				Length = (long)metadata.Size,
				LengthCompressed = unchecked((long)metadata.Size + long.MinValue),
				Name = metadata.Name,
				RelativePath = metadata.PathDisplay
			};
		}


		/// <summary>
		/// Don't bother with this; we're async now.
		/// </summary>
		public override AttachmentInfo WriteFile(Stream stream, string relativePath)
		{
			throw new NotImplementedException();
		}

		/// <summary>
		/// Don't bother with this; we're async now.
		/// </summary>
		public override AttachmentInfo ReadFile(Stream stream, string relativePath)
		{
			throw new NotImplementedException();
		}
	}
}