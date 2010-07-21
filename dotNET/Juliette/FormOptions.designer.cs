namespace Juliette
{
	partial class FormOptions
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
			if (disposing&&(components!=null))
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
			this.tcOptions=new System.Windows.Forms.TabControl();
			this.tpCommon=new System.Windows.Forms.TabPage();
			this.btnRemovePath=new System.Windows.Forms.Button();
			this.btnDBBrowse=new System.Windows.Forms.Button();
			this.tbStandardDB=new System.Windows.Forms.TextBox();
			this.label1=new System.Windows.Forms.Label();
			this.OpenFileDialog=new System.Windows.Forms.OpenFileDialog();
			this.btnOK=new System.Windows.Forms.Button();
			this.btnCancel=new System.Windows.Forms.Button();
			this.tcOptions.SuspendLayout();
			this.tpCommon.SuspendLayout();
			this.SuspendLayout();
			// 
			// tcOptions
			// 
			this.tcOptions.Controls.Add(this.tpCommon);
			this.tcOptions.Dock=System.Windows.Forms.DockStyle.Top;
			this.tcOptions.Location=new System.Drawing.Point(0, 0);
			this.tcOptions.Name="tcOptions";
			this.tcOptions.SelectedIndex=0;
			this.tcOptions.Size=new System.Drawing.Size(662, 237);
			this.tcOptions.TabIndex=0;
			// 
			// tpCommon
			// 
			this.tpCommon.Controls.Add(this.btnRemovePath);
			this.tpCommon.Controls.Add(this.btnDBBrowse);
			this.tpCommon.Controls.Add(this.tbStandardDB);
			this.tpCommon.Controls.Add(this.label1);
			this.tpCommon.Location=new System.Drawing.Point(4, 22);
			this.tpCommon.Name="tpCommon";
			this.tpCommon.Padding=new System.Windows.Forms.Padding(3);
			this.tpCommon.Size=new System.Drawing.Size(654, 211);
			this.tpCommon.TabIndex=0;
			this.tpCommon.Text="Allgemeine Einstellungen";
			this.tpCommon.UseVisualStyleBackColor=true;
			// 
			// btnRemovePath
			// 
			this.btnRemovePath.Location=new System.Drawing.Point(424, 24);
			this.btnRemovePath.Name="btnRemovePath";
			this.btnRemovePath.Size=new System.Drawing.Size(92, 20);
			this.btnRemovePath.TabIndex=3;
			this.btnRemovePath.Text="Pfad löschen";
			this.btnRemovePath.UseVisualStyleBackColor=true;
			this.btnRemovePath.Click+=new System.EventHandler(this.btnRemovePath_Click);
			// 
			// btnDBBrowse
			// 
			this.btnDBBrowse.Location=new System.Drawing.Point(522, 24);
			this.btnDBBrowse.Name="btnDBBrowse";
			this.btnDBBrowse.Size=new System.Drawing.Size(129, 20);
			this.btnDBBrowse.TabIndex=2;
			this.btnDBBrowse.Text="Durchsuchen...";
			this.btnDBBrowse.UseVisualStyleBackColor=true;
			this.btnDBBrowse.Click+=new System.EventHandler(this.btnDBBrowse_Click);
			// 
			// tbStandardDB
			// 
			this.tbStandardDB.Location=new System.Drawing.Point(11, 24);
			this.tbStandardDB.Name="tbStandardDB";
			this.tbStandardDB.ReadOnly=true;
			this.tbStandardDB.Size=new System.Drawing.Size(407, 20);
			this.tbStandardDB.TabIndex=1;
			// 
			// label1
			// 
			this.label1.AutoSize=true;
			this.label1.Location=new System.Drawing.Point(8, 8);
			this.label1.Name="label1";
			this.label1.Size=new System.Drawing.Size(174, 13);
			this.label1.TabIndex=0;
			this.label1.Text="Zu öffnende Datenbank beim Start:";
			// 
			// btnOK
			// 
			this.btnOK.Location=new System.Drawing.Point(499, 243);
			this.btnOK.Name="btnOK";
			this.btnOK.Size=new System.Drawing.Size(75, 23);
			this.btnOK.TabIndex=1;
			this.btnOK.Text="OK";
			this.btnOK.UseVisualStyleBackColor=true;
			this.btnOK.Click+=new System.EventHandler(this.btnOK_Click);
			// 
			// btnCancel
			// 
			this.btnCancel.DialogResult=System.Windows.Forms.DialogResult.Cancel;
			this.btnCancel.Location=new System.Drawing.Point(580, 243);
			this.btnCancel.Name="btnCancel";
			this.btnCancel.Size=new System.Drawing.Size(75, 23);
			this.btnCancel.TabIndex=2;
			this.btnCancel.Text="Abbrechen";
			this.btnCancel.UseVisualStyleBackColor=true;
			this.btnCancel.Click+=new System.EventHandler(this.btnCancel_Click);
			// 
			// FormOptions
			// 
			this.AcceptButton=this.btnOK;
			this.AutoScaleDimensions=new System.Drawing.SizeF(6F, 13F);
			this.AutoScaleMode=System.Windows.Forms.AutoScaleMode.Font;
			this.CancelButton=this.btnCancel;
			this.ClientSize=new System.Drawing.Size(662, 273);
			this.Controls.Add(this.btnCancel);
			this.Controls.Add(this.btnOK);
			this.Controls.Add(this.tcOptions);
			this.FormBorderStyle=System.Windows.Forms.FormBorderStyle.FixedDialog;
			this.MaximizeBox=false;
			this.MinimizeBox=false;
			this.Name="FormOptions";
			this.StartPosition=System.Windows.Forms.FormStartPosition.CenterScreen;
			this.Text="Optionen";
			this.Load+=new System.EventHandler(this.FormOptions_Load);
			this.tcOptions.ResumeLayout(false);
			this.tpCommon.ResumeLayout(false);
			this.tpCommon.PerformLayout();
			this.ResumeLayout(false);

		}

		#endregion

		private System.Windows.Forms.TabControl tcOptions;
		private System.Windows.Forms.TabPage tpCommon;
		private System.Windows.Forms.Button btnDBBrowse;
		private System.Windows.Forms.TextBox tbStandardDB;
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.OpenFileDialog OpenFileDialog;
		private System.Windows.Forms.Button btnOK;
		private System.Windows.Forms.Button btnCancel;
		private System.Windows.Forms.Button btnRemovePath;
	}
}