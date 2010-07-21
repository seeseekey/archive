namespace Juliette
{
	partial class FormDocument
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
			this.label1=new System.Windows.Forms.Label();
			this.tbLabel=new System.Windows.Forms.TextBox();
			this.label2=new System.Windows.Forms.Label();
			this.rtbDescription=new System.Windows.Forms.RichTextBox();
			this.label3=new System.Windows.Forms.Label();
			this.dtpDate=new System.Windows.Forms.DateTimePicker();
			this.label4=new System.Windows.Forms.Label();
			this.lbImageData=new System.Windows.Forms.ListBox();
			this.btnRemove=new System.Windows.Forms.Button();
			this.btnImageUp=new System.Windows.Forms.Button();
			this.btnImageDown=new System.Windows.Forms.Button();
			this.btnFile=new System.Windows.Forms.Button();
			this.btnScan=new System.Windows.Forms.Button();
			this.btnOK=new System.Windows.Forms.Button();
			this.btnCancel=new System.Windows.Forms.Button();
			this.openFileDialog=new System.Windows.Forms.OpenFileDialog();
			this.btnScanSource=new System.Windows.Forms.Button();
			this.SuspendLayout();
			// 
			// label1
			// 
			this.label1.AutoSize=true;
			this.label1.Location=new System.Drawing.Point(12, 9);
			this.label1.Name="label1";
			this.label1.Size=new System.Drawing.Size(155, 13);
			this.label1.TabIndex=0;
			this.label1.Text="Bezeichnung des Dokumentes:";
			// 
			// tbLabel
			// 
			this.tbLabel.Location=new System.Drawing.Point(15, 25);
			this.tbLabel.Name="tbLabel";
			this.tbLabel.Size=new System.Drawing.Size(407, 20);
			this.tbLabel.TabIndex=1;
			// 
			// label2
			// 
			this.label2.AutoSize=true;
			this.label2.Location=new System.Drawing.Point(12, 57);
			this.label2.Name="label2";
			this.label2.Size=new System.Drawing.Size(158, 13);
			this.label2.TabIndex=2;
			this.label2.Text="Beschreibung des Dokumentes:";
			// 
			// rtbDescription
			// 
			this.rtbDescription.Location=new System.Drawing.Point(15, 73);
			this.rtbDescription.Name="rtbDescription";
			this.rtbDescription.Size=new System.Drawing.Size(407, 175);
			this.rtbDescription.TabIndex=3;
			this.rtbDescription.Text="";
			// 
			// label3
			// 
			this.label3.AutoSize=true;
			this.label3.Location=new System.Drawing.Point(12, 251);
			this.label3.Name="label3";
			this.label3.Size=new System.Drawing.Size(124, 13);
			this.label3.TabIndex=4;
			this.label3.Text="Datum des Dokumentes:";
			// 
			// dtpDate
			// 
			this.dtpDate.Location=new System.Drawing.Point(15, 267);
			this.dtpDate.Name="dtpDate";
			this.dtpDate.Size=new System.Drawing.Size(407, 20);
			this.dtpDate.TabIndex=7;
			// 
			// label4
			// 
			this.label4.AutoSize=true;
			this.label4.Location=new System.Drawing.Point(438, 9);
			this.label4.Name="label4";
			this.label4.Size=new System.Drawing.Size(130, 13);
			this.label4.TabIndex=8;
			this.label4.Text="Bilddaten der Dokumente:";
			// 
			// lbImageData
			// 
			this.lbImageData.FormattingEnabled=true;
			this.lbImageData.IntegralHeight=false;
			this.lbImageData.Location=new System.Drawing.Point(441, 25);
			this.lbImageData.Name="lbImageData";
			this.lbImageData.Size=new System.Drawing.Size(313, 201);
			this.lbImageData.TabIndex=9;
			// 
			// btnRemove
			// 
			this.btnRemove.Location=new System.Drawing.Point(441, 232);
			this.btnRemove.Name="btnRemove";
			this.btnRemove.Size=new System.Drawing.Size(75, 23);
			this.btnRemove.TabIndex=10;
			this.btnRemove.Text="Löschen";
			this.btnRemove.UseVisualStyleBackColor=true;
			this.btnRemove.Click+=new System.EventHandler(this.btnRemove_Click);
			// 
			// btnImageUp
			// 
			this.btnImageUp.Location=new System.Drawing.Point(522, 232);
			this.btnImageUp.Name="btnImageUp";
			this.btnImageUp.Size=new System.Drawing.Size(32, 23);
			this.btnImageUp.TabIndex=11;
			this.btnImageUp.Text="/\\";
			this.btnImageUp.UseVisualStyleBackColor=true;
			this.btnImageUp.Click+=new System.EventHandler(this.btnImageUp_Click);
			// 
			// btnImageDown
			// 
			this.btnImageDown.Location=new System.Drawing.Point(560, 232);
			this.btnImageDown.Name="btnImageDown";
			this.btnImageDown.Size=new System.Drawing.Size(32, 23);
			this.btnImageDown.TabIndex=12;
			this.btnImageDown.Text="\\/";
			this.btnImageDown.UseVisualStyleBackColor=true;
			this.btnImageDown.Click+=new System.EventHandler(this.btnImageDown_Click);
			// 
			// btnFile
			// 
			this.btnFile.Location=new System.Drawing.Point(679, 261);
			this.btnFile.Name="btnFile";
			this.btnFile.Size=new System.Drawing.Size(75, 23);
			this.btnFile.TabIndex=13;
			this.btnFile.Text="Aus Datei...";
			this.btnFile.UseVisualStyleBackColor=true;
			this.btnFile.Click+=new System.EventHandler(this.btnFile_Click);
			// 
			// btnScan
			// 
			this.btnScan.Location=new System.Drawing.Point(679, 232);
			this.btnScan.Name="btnScan";
			this.btnScan.Size=new System.Drawing.Size(75, 23);
			this.btnScan.TabIndex=14;
			this.btnScan.Text="Scannen...";
			this.btnScan.UseVisualStyleBackColor=true;
			this.btnScan.Click+=new System.EventHandler(this.btnScan_Click);
			// 
			// btnOK
			// 
			this.btnOK.Location=new System.Drawing.Point(598, 296);
			this.btnOK.Name="btnOK";
			this.btnOK.Size=new System.Drawing.Size(75, 23);
			this.btnOK.TabIndex=15;
			this.btnOK.Text="OK";
			this.btnOK.UseVisualStyleBackColor=true;
			this.btnOK.Click+=new System.EventHandler(this.btnOK_Click);
			// 
			// btnCancel
			// 
			this.btnCancel.DialogResult=System.Windows.Forms.DialogResult.Cancel;
			this.btnCancel.Location=new System.Drawing.Point(679, 296);
			this.btnCancel.Name="btnCancel";
			this.btnCancel.Size=new System.Drawing.Size(75, 23);
			this.btnCancel.TabIndex=16;
			this.btnCancel.Text="Abbrechen";
			this.btnCancel.UseVisualStyleBackColor=true;
			this.btnCancel.Click+=new System.EventHandler(this.btnCancel_Click);
			// 
			// openFileDialog
			// 
			this.openFileDialog.Multiselect=true;
			// 
			// btnScanSource
			// 
			this.btnScanSource.Location=new System.Drawing.Point(598, 232);
			this.btnScanSource.Name="btnScanSource";
			this.btnScanSource.Size=new System.Drawing.Size(75, 23);
			this.btnScanSource.TabIndex=17;
			this.btnScanSource.Text="Quelle...";
			this.btnScanSource.UseVisualStyleBackColor=true;
			this.btnScanSource.Click+=new System.EventHandler(this.btnScanSource_Click);
			// 
			// FormDocument
			// 
			this.AcceptButton=this.btnOK;
			this.AutoScaleDimensions=new System.Drawing.SizeF(6F, 13F);
			this.AutoScaleMode=System.Windows.Forms.AutoScaleMode.Font;
			this.CancelButton=this.btnCancel;
			this.ClientSize=new System.Drawing.Size(764, 328);
			this.Controls.Add(this.btnScanSource);
			this.Controls.Add(this.btnCancel);
			this.Controls.Add(this.btnOK);
			this.Controls.Add(this.btnScan);
			this.Controls.Add(this.btnFile);
			this.Controls.Add(this.btnImageDown);
			this.Controls.Add(this.btnImageUp);
			this.Controls.Add(this.btnRemove);
			this.Controls.Add(this.lbImageData);
			this.Controls.Add(this.label4);
			this.Controls.Add(this.dtpDate);
			this.Controls.Add(this.label3);
			this.Controls.Add(this.rtbDescription);
			this.Controls.Add(this.label2);
			this.Controls.Add(this.tbLabel);
			this.Controls.Add(this.label1);
			this.FormBorderStyle=System.Windows.Forms.FormBorderStyle.FixedDialog;
			this.MaximizeBox=false;
			this.MinimizeBox=false;
			this.Name="FormDocument";
			this.StartPosition=System.Windows.Forms.FormStartPosition.CenterScreen;
			this.Text="FormDocument";
			this.ResumeLayout(false);
			this.PerformLayout();

		}

		#endregion

		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.TextBox tbLabel;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.RichTextBox rtbDescription;
		private System.Windows.Forms.Label label3;
		private System.Windows.Forms.DateTimePicker dtpDate;
		private System.Windows.Forms.Label label4;
		private System.Windows.Forms.ListBox lbImageData;
		private System.Windows.Forms.Button btnRemove;
		private System.Windows.Forms.Button btnImageUp;
		private System.Windows.Forms.Button btnImageDown;
		private System.Windows.Forms.Button btnFile;
		private System.Windows.Forms.Button btnScan;
		private System.Windows.Forms.Button btnOK;
		private System.Windows.Forms.Button btnCancel;
		private System.Windows.Forms.OpenFileDialog openFileDialog;
		private System.Windows.Forms.Button btnScanSource;
	}
}