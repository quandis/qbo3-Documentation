using System;
using System.IO;

namespace qbo
{
	/// <summary>
	/// Provides a file stream that deletes the underlying file after it's closed.
	/// </summary>
	public class CacheStream : FileStream
	{
		/// <summary>
		/// Default buffer size when iternating through streams.
		/// </summary>
		protected const int BUFFER_SIZE = 4096;

		private static string _ScratchPadFolder;
		/// <summary>
		/// Path to a scratchpad folder for the environment, determined by a 'Core:ScratchPadFolder' default.
		/// </summary>
		/// <example>CacheStream.ScratchPadFolder == "C:\Windows\Temp"</example>
		/// <see>Core:ScratchPadFolder</see>
		public static string ScratchPadFolder
		{
			get
			{
				if (string.IsNullOrEmpty(_ScratchPadFolder))
				{
					_ScratchPadFolder = "c:\\windows\\temp"; 
					Directory.CreateDirectory(_ScratchPadFolder);
				}
				return _ScratchPadFolder;
			}
		}

		/// <summary>
		/// Path to the file used to cache a stream.
		/// </summary>
		private string _Path;

		public string Path
		{
			get { return _Path; }
		}

		/// <summary>
		/// Track whether the object is closing or not.
		/// </summary>
		private bool _Disposed = false;

		#region Constructors

		/// <summary>
		/// Constructor. Create a file using a GUID in the scratchpad folder (C:\Windows\Temp by default).
		/// </summary>
		public CacheStream() : this(System.IO.Path.Combine(new string[] { ScratchPadFolder, Guid.NewGuid().ToString() })) { }

		/// <summary>
		/// Constructor. Assumes FileMode.Create and FileAccess.ReadWrite.
		/// </summary>
		/// <param name="path">Path to the file to create the stream around.</param>
		public CacheStream(string path, FileMode mode = FileMode.Create, FileAccess access = FileAccess.ReadWrite, FileShare share = FileShare.ReadWrite, int buffer = BUFFER_SIZE, bool async = true)
			: base(path, mode, access, share, buffer, async)
		{
			_Path = path;
		}

		/// <summary>
		/// Constructor for easy caching of an existing stream into a CacheStream. Typically used for web responses.
		/// </summary>
		/// <param name="source">Stream to read from.</param>
		/// <remarks>Ensure the source.Position = 0 to property load the stream into a CacheStream.</remarks>
		/// <example>
		/// <code>
		/// using (Stream reader = new CacheStream(webResponse.GetResponseStream()) { ... }
		/// </code>
		/// </example>
		public CacheStream(Stream source) : this(System.IO.Path.Combine(new string[] { ScratchPadFolder, Guid.NewGuid().ToString() }), source) { }

		/// <summary>
		/// Internal constructor to establish a path via the CacheStream(Stream from) constructor.
		/// </summary>
		/// <param name="path">File system path to the cached file.</param>
		/// <param name="source">Stream to read from.</param>
		protected CacheStream(string path, Stream source) : this(path, FileMode.Create, FileAccess.ReadWrite)
		{
			_Path = path;
			Byte[] buffer = new Byte[BUFFER_SIZE];
			using (source)
			{
				int bytesRead = source.Read(buffer, 0, BUFFER_SIZE);
				while (bytesRead > 0)
				{
					Write(buffer, 0, bytesRead);
					bytesRead = source.Read(buffer, 0, BUFFER_SIZE);
				}
			}
			Position = 0;
		}

		#endregion Constructors

		/// <summary>
		/// Overrides the standard FileStream.Dispose method to include deleting the file.
		/// </summary>
		/// <param name="disposing">True if called from Dispose(), false if called from a finalizer.</param>
		protected override void Dispose(bool disposing)
		{
			if (_Disposed)
				return;
			_Disposed = true;
			base.Dispose(disposing);
			if (disposing)
				File.Delete(_Path);
		}

		/// <summary>
		/// Sugar for debugging.
		/// </summary>
		/// <returns></returns>
		public override string ToString()
		{
			return Name;
		}

	}

}
