namespace Juliette
{
	partial class FormSearchResults
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
			this.lbResults=new System.Windows.Forms.ListBox();
			this.SuspendLayout();
			// 
			// lbResults
			// 
			this.lbResults.Dock=System.Windows.Forms.DockStyle.Fill;
			this.lbResults.FormattingEnabled=true;
			this.lbResults.Location=new System.Drawing.Point(0, 0);
			this.lbResults.Name="lbResults";
			this.lbResults.Size=new System.Drawing.Size(524, 147);
			this.lbResults.TabIndex=0;
			this.lbResults.MouseDoubleClick+=new System.Windows.Forms.MouseEventHandler(this.lbResults_MouseDoubleClick);
			// 
			// FormSearchResults
			// 
			this.AutoScaleDimensions=new System.Drawing.SizeF(6F, 13F);
			this.AutoScaleMode=System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize=new System.Drawing.Size(524, 147);
			this.Controls.Add(this.lbResults);
			this.FormBorderStyle=System.Windows.Forms.FormBorderStyle.FixedToolWindow;
			this.MaximizeBox=false;
			this.MinimizeBox=false;
			this.Name="FormSearchResults";
			this.Text="Suchresultate";
			this.ResumeLayout(false);

		}

		#endregion

		private System.Windows.Forms.ListBox lbResults;
	}
}