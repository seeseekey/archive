namespace Juliette.Graphic.TWAIN
{
	partial class TwainPreviewForm
	{
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.IContainer components = null;

		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		/// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
		protected override void Dispose (bool disposing)
		{
			if (disposing && (components != null))
			{
				components.Dispose ();
			}
			base.Dispose (disposing);
		}

		#region Windows Form Designer generated code

		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent ()
		{
			this.pagePreviewPictureBox = new System.Windows.Forms.PictureBox ();
			((System.ComponentModel.ISupportInitialize)(this.pagePreviewPictureBox)).BeginInit ();
			this.SuspendLayout ();
			// 
			// pagePreviewPictureBox
			// 
			this.pagePreviewPictureBox.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
							| System.Windows.Forms.AnchorStyles.Left)
							| System.Windows.Forms.AnchorStyles.Right)));
			this.pagePreviewPictureBox.Location = new System.Drawing.Point (12, 12);
			this.pagePreviewPictureBox.Name = "pagePreviewPictureBox";
			this.pagePreviewPictureBox.Size = new System.Drawing.Size (268, 242);
			this.pagePreviewPictureBox.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
			this.pagePreviewPictureBox.TabIndex = 0;
			this.pagePreviewPictureBox.TabStop = false;
			// 
			// TwainPreviewForm
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF (6F, 13F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size (292, 266);
			this.ControlBox = false;
			this.Controls.Add (this.pagePreviewPictureBox);
			this.Name = "TwainPreviewForm";
			this.ShowIcon = false;
			this.ShowInTaskbar = false;
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
			this.Text = "TwainHiddenForm";
			this.WindowState = System.Windows.Forms.FormWindowState.Minimized;
			((System.ComponentModel.ISupportInitialize)(this.pagePreviewPictureBox)).EndInit ();
			this.ResumeLayout (false);

		}

		#endregion

		private System.Windows.Forms.PictureBox pagePreviewPictureBox;
	}
}