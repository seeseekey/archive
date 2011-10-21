namespace CloudFileSync
{
	partial class FormPreferences
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
			this.label1 = new System.Windows.Forms.Label();
			this.tbFolderToSync = new System.Windows.Forms.TextBox();
			this.btnBrowseSyncFolder = new System.Windows.Forms.Button();
			this.label2 = new System.Windows.Forms.Label();
			this.tbFTPServer = new System.Windows.Forms.TextBox();
			this.tbFTPUser = new System.Windows.Forms.TextBox();
			this.label3 = new System.Windows.Forms.Label();
			this.tbFTPPassword = new System.Windows.Forms.TextBox();
			this.label4 = new System.Windows.Forms.Label();
			this.label5 = new System.Windows.Forms.Label();
			this.cbFTPProtocol = new System.Windows.Forms.ComboBox();
			this.btnOK = new System.Windows.Forms.Button();
			this.folderBrowserDialog = new System.Windows.Forms.FolderBrowserDialog();
			this.SuspendLayout();
			// 
			// label1
			// 
			this.label1.AutoSize = true;
			this.label1.Location = new System.Drawing.Point(12, 9);
			this.label1.Name = "label1";
			this.label1.Size = new System.Drawing.Size(76, 13);
			this.label1.TabIndex = 0;
			this.label1.Text = "Folder to sync:";
			// 
			// tbFolderToSync
			// 
			this.tbFolderToSync.Location = new System.Drawing.Point(12, 25);
			this.tbFolderToSync.Name = "tbFolderToSync";
			this.tbFolderToSync.ReadOnly = true;
			this.tbFolderToSync.Size = new System.Drawing.Size(295, 20);
			this.tbFolderToSync.TabIndex = 1;
			// 
			// btnBrowseSyncFolder
			// 
			this.btnBrowseSyncFolder.Location = new System.Drawing.Point(313, 25);
			this.btnBrowseSyncFolder.Name = "btnBrowseSyncFolder";
			this.btnBrowseSyncFolder.Size = new System.Drawing.Size(91, 20);
			this.btnBrowseSyncFolder.TabIndex = 2;
			this.btnBrowseSyncFolder.Text = "Browse...";
			this.btnBrowseSyncFolder.UseVisualStyleBackColor = true;
			this.btnBrowseSyncFolder.Click += new System.EventHandler(this.btnBrowseSyncFolder_Click);
			// 
			// label2
			// 
			this.label2.AutoSize = true;
			this.label2.Location = new System.Drawing.Point(12, 52);
			this.label2.Name = "label2";
			this.label2.Size = new System.Drawing.Size(62, 13);
			this.label2.TabIndex = 3;
			this.label2.Text = "FTP server:";
			// 
			// tbFTPServer
			// 
			this.tbFTPServer.Location = new System.Drawing.Point(12, 68);
			this.tbFTPServer.Name = "tbFTPServer";
			this.tbFTPServer.Size = new System.Drawing.Size(392, 20);
			this.tbFTPServer.TabIndex = 4;
			// 
			// tbFTPUser
			// 
			this.tbFTPUser.Location = new System.Drawing.Point(12, 112);
			this.tbFTPUser.Name = "tbFTPUser";
			this.tbFTPUser.Size = new System.Drawing.Size(392, 20);
			this.tbFTPUser.TabIndex = 6;
			// 
			// label3
			// 
			this.label3.AutoSize = true;
			this.label3.Location = new System.Drawing.Point(12, 96);
			this.label3.Name = "label3";
			this.label3.Size = new System.Drawing.Size(53, 13);
			this.label3.TabIndex = 5;
			this.label3.Text = "FTP user:";
			// 
			// tbFTPPassword
			// 
			this.tbFTPPassword.Location = new System.Drawing.Point(12, 158);
			this.tbFTPPassword.Name = "tbFTPPassword";
			this.tbFTPPassword.PasswordChar = '*';
			this.tbFTPPassword.Size = new System.Drawing.Size(392, 20);
			this.tbFTPPassword.TabIndex = 8;
			// 
			// label4
			// 
			this.label4.AutoSize = true;
			this.label4.Location = new System.Drawing.Point(12, 142);
			this.label4.Name = "label4";
			this.label4.Size = new System.Drawing.Size(78, 13);
			this.label4.TabIndex = 7;
			this.label4.Text = "FTP password:";
			// 
			// label5
			// 
			this.label5.AutoSize = true;
			this.label5.Location = new System.Drawing.Point(12, 185);
			this.label5.Name = "label5";
			this.label5.Size = new System.Drawing.Size(71, 13);
			this.label5.TabIndex = 9;
			this.label5.Text = "FTP protocol:";
			// 
			// cbFTPProtocol
			// 
			this.cbFTPProtocol.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
			this.cbFTPProtocol.FormattingEnabled = true;
			this.cbFTPProtocol.Items.AddRange(new object[] {
            "FTPS",
            "FTP"});
			this.cbFTPProtocol.Location = new System.Drawing.Point(12, 201);
			this.cbFTPProtocol.Name = "cbFTPProtocol";
			this.cbFTPProtocol.Size = new System.Drawing.Size(392, 21);
			this.cbFTPProtocol.TabIndex = 10;
			// 
			// btnOK
			// 
			this.btnOK.Location = new System.Drawing.Point(329, 228);
			this.btnOK.Name = "btnOK";
			this.btnOK.Size = new System.Drawing.Size(75, 23);
			this.btnOK.TabIndex = 11;
			this.btnOK.Text = "O&K";
			this.btnOK.UseVisualStyleBackColor = true;
			this.btnOK.Click += new System.EventHandler(this.btnOK_Click);
			// 
			// FormPreferences
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(412, 258);
			this.Controls.Add(this.btnOK);
			this.Controls.Add(this.cbFTPProtocol);
			this.Controls.Add(this.label5);
			this.Controls.Add(this.tbFTPPassword);
			this.Controls.Add(this.label4);
			this.Controls.Add(this.tbFTPUser);
			this.Controls.Add(this.label3);
			this.Controls.Add(this.tbFTPServer);
			this.Controls.Add(this.label2);
			this.Controls.Add(this.btnBrowseSyncFolder);
			this.Controls.Add(this.tbFolderToSync);
			this.Controls.Add(this.label1);
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow;
			this.Name = "FormPreferences";
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
			this.Text = "Preferences";
			this.Load += new System.EventHandler(this.FormPreferences_Load);
			this.ResumeLayout(false);
			this.PerformLayout();

		}

		#endregion

		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.TextBox tbFolderToSync;
		private System.Windows.Forms.Button btnBrowseSyncFolder;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.TextBox tbFTPServer;
		private System.Windows.Forms.TextBox tbFTPUser;
		private System.Windows.Forms.Label label3;
		private System.Windows.Forms.TextBox tbFTPPassword;
		private System.Windows.Forms.Label label4;
		private System.Windows.Forms.Label label5;
		private System.Windows.Forms.ComboBox cbFTPProtocol;
		private System.Windows.Forms.Button btnOK;
		private System.Windows.Forms.FolderBrowserDialog folderBrowserDialog;
	}
}