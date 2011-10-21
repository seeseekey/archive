namespace CloudFileSync
{
	partial class FormMain
	{
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.IContainer components=null;

		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		/// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
		protected override void Dispose(bool disposing)
		{
			if(disposing&&(components!=null))
			{
				components.Dispose();
			}
			base.Dispose(disposing);
		}

		#region Windows Form Designer generated code

		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.components = new System.ComponentModel.Container();
			System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FormMain));
			this.notifyIcon = new System.Windows.Forms.NotifyIcon(this.components);
			this.contextMenuStrip = new System.Windows.Forms.ContextMenuStrip(this.components);
			this.preferencesToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.toolStripMenuItem1 = new System.Windows.Forms.ToolStripSeparator();
			this.exitToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.backgroundWorker = new System.ComponentModel.BackgroundWorker();
			this.fileSystemWatcher = new System.IO.FileSystemWatcher();
			this.contextMenuStrip.SuspendLayout();
			((System.ComponentModel.ISupportInitialize)(this.fileSystemWatcher)).BeginInit();
			this.SuspendLayout();
			// 
			// notifyIcon
			// 
			this.notifyIcon.Icon = ((System.Drawing.Icon)(resources.GetObject("notifyIcon.Icon")));
			this.notifyIcon.Text = "CloudFileSync";
			this.notifyIcon.Visible = true;
			// 
			// contextMenuStrip
			// 
			this.contextMenuStrip.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.preferencesToolStripMenuItem,
            this.toolStripMenuItem1,
            this.exitToolStripMenuItem});
			this.contextMenuStrip.Name = "contextMenuStrip";
			this.contextMenuStrip.Size = new System.Drawing.Size(145, 54);
			// 
			// preferencesToolStripMenuItem
			// 
			this.preferencesToolStripMenuItem.Name = "preferencesToolStripMenuItem";
			this.preferencesToolStripMenuItem.Size = new System.Drawing.Size(144, 22);
			this.preferencesToolStripMenuItem.Text = "Preferences...";
			this.preferencesToolStripMenuItem.Click += new System.EventHandler(this.preferencesToolStripMenuItem_Click);
			// 
			// toolStripMenuItem1
			// 
			this.toolStripMenuItem1.Name = "toolStripMenuItem1";
			this.toolStripMenuItem1.Size = new System.Drawing.Size(141, 6);
			// 
			// exitToolStripMenuItem
			// 
			this.exitToolStripMenuItem.Name = "exitToolStripMenuItem";
			this.exitToolStripMenuItem.Size = new System.Drawing.Size(144, 22);
			this.exitToolStripMenuItem.Text = "E&xit";
			this.exitToolStripMenuItem.Click += new System.EventHandler(this.exitToolStripMenuItem_Click);
			// 
			// backgroundWorker
			// 
			this.backgroundWorker.WorkerSupportsCancellation = true;
			this.backgroundWorker.DoWork += new System.ComponentModel.DoWorkEventHandler(this.backgroundWorker_DoWork);
			// 
			// fileSystemWatcher
			// 
			this.fileSystemWatcher.Filter = "*";
			this.fileSystemWatcher.IncludeSubdirectories = true;
			this.fileSystemWatcher.SynchronizingObject = this;
			this.fileSystemWatcher.Changed += new System.IO.FileSystemEventHandler(this.fileSystemWatcher_Changed);
			this.fileSystemWatcher.Created += new System.IO.FileSystemEventHandler(this.fileSystemWatcher_Created);
			this.fileSystemWatcher.Deleted += new System.IO.FileSystemEventHandler(this.fileSystemWatcher_Deleted);
			this.fileSystemWatcher.Renamed += new System.IO.RenamedEventHandler(this.fileSystemWatcher_Renamed);
			// 
			// FormMain
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(518, 273);
			this.Name = "FormMain";
			this.Text = "CloudFileSync";
			this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.FormMain_FormClosing);
			this.Load += new System.EventHandler(this.FormMain_Load);
			this.contextMenuStrip.ResumeLayout(false);
			((System.ComponentModel.ISupportInitialize)(this.fileSystemWatcher)).EndInit();
			this.ResumeLayout(false);

		}

		#endregion

		private System.Windows.Forms.NotifyIcon notifyIcon;
		private System.Windows.Forms.ContextMenuStrip contextMenuStrip;
		private System.Windows.Forms.ToolStripMenuItem exitToolStripMenuItem;
		private System.Windows.Forms.ToolStripMenuItem preferencesToolStripMenuItem;
		private System.Windows.Forms.ToolStripSeparator toolStripMenuItem1;
		private System.ComponentModel.BackgroundWorker backgroundWorker;
		private System.IO.FileSystemWatcher fileSystemWatcher;
	}
}

