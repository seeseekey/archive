namespace Juliette
{
    partial class FormAbout
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if(disposing && (components != null))
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
			System.ComponentModel.ComponentResourceManager resources=new System.ComponentModel.ComponentResourceManager(typeof(FormAbout));
			this.PictureBoxLogo=new System.Windows.Forms.PictureBox();
			this.lblAppName=new System.Windows.Forms.Label();
			this.lblAppVersion=new System.Windows.Forms.Label();
			this.lblCopyright=new System.Windows.Forms.Label();
			this.lblAllRights=new System.Windows.Forms.Label();
			this.btnOK=new System.Windows.Forms.Button();
			this.lblWeblink=new System.Windows.Forms.Label();
			((System.ComponentModel.ISupportInitialize)(this.PictureBoxLogo)).BeginInit();
			this.SuspendLayout();
			// 
			// PictureBoxLogo
			// 
			this.PictureBoxLogo.Image=((System.Drawing.Image)(resources.GetObject("PictureBoxLogo.Image")));
			this.PictureBoxLogo.Location=new System.Drawing.Point(0, 1);
			this.PictureBoxLogo.Name="PictureBoxLogo";
			this.PictureBoxLogo.Size=new System.Drawing.Size(312, 233);
			this.PictureBoxLogo.TabIndex=0;
			this.PictureBoxLogo.TabStop=false;
			// 
			// lblAppName
			// 
			this.lblAppName.AutoSize=true;
			this.lblAppName.Font=new System.Drawing.Font("Microsoft Sans Serif", 18F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
			this.lblAppName.Location=new System.Drawing.Point(320, 8);
			this.lblAppName.Name="lblAppName";
			this.lblAppName.Size=new System.Drawing.Size(147, 29);
			this.lblAppName.TabIndex=1;
			this.lblAppName.Text="lblAppName";
			// 
			// lblAppVersion
			// 
			this.lblAppVersion.AutoSize=true;
			this.lblAppVersion.Font=new System.Drawing.Font("Microsoft Sans Serif", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
			this.lblAppVersion.Location=new System.Drawing.Point(320, 40);
			this.lblAppVersion.Name="lblAppVersion";
			this.lblAppVersion.Size=new System.Drawing.Size(75, 24);
			this.lblAppVersion.TabIndex=2;
			this.lblAppVersion.Text="Version";
			// 
			// lblCopyright
			// 
			this.lblCopyright.AutoSize=true;
			this.lblCopyright.Font=new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
			this.lblCopyright.Location=new System.Drawing.Point(320, 80);
			this.lblCopyright.Name="lblCopyright";
			this.lblCopyright.Size=new System.Drawing.Size(61, 13);
			this.lblCopyright.TabIndex=3;
			this.lblCopyright.Text="lblCopyright";
			// 
			// lblAllRights
			// 
			this.lblAllRights.AutoSize=true;
			this.lblAllRights.Font=new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
			this.lblAllRights.Location=new System.Drawing.Point(320, 96);
			this.lblAllRights.Name="lblAllRights";
			this.lblAllRights.Size=new System.Drawing.Size(124, 13);
			this.lblAllRights.TabIndex=4;
			this.lblAllRights.Text="Alle Rechte vorbehalten!";
			// 
			// btnOK
			// 
			this.btnOK.BackColor=System.Drawing.SystemColors.Control;
			this.btnOK.Location=new System.Drawing.Point(323, 210);
			this.btnOK.Name="btnOK";
			this.btnOK.Size=new System.Drawing.Size(248, 23);
			this.btnOK.TabIndex=5;
			this.btnOK.Text="OK";
			this.btnOK.UseVisualStyleBackColor=false;
			this.btnOK.Click+=new System.EventHandler(this.btnOK_Click);
			// 
			// lblWeblink
			// 
			this.lblWeblink.AutoSize=true;
			this.lblWeblink.Cursor=System.Windows.Forms.Cursors.Hand;
			this.lblWeblink.Font=new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Underline, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
			this.lblWeblink.ForeColor=System.Drawing.Color.DarkBlue;
			this.lblWeblink.Location=new System.Drawing.Point(320, 128);
			this.lblWeblink.Name="lblWeblink";
			this.lblWeblink.Size=new System.Drawing.Size(134, 13);
			this.lblWeblink.TabIndex=6;
			this.lblWeblink.Text="http://www.seeseekey.net";
			this.lblWeblink.Click+=new System.EventHandler(this.lblWeblink_Click);
			// 
			// FormAbout
			// 
			this.AutoScaleDimensions=new System.Drawing.SizeF(6F, 13F);
			this.AutoScaleMode=System.Windows.Forms.AutoScaleMode.Font;
			this.BackColor=System.Drawing.Color.White;
			this.ClientSize=new System.Drawing.Size(575, 235);
			this.Controls.Add(this.lblWeblink);
			this.Controls.Add(this.btnOK);
			this.Controls.Add(this.lblAllRights);
			this.Controls.Add(this.lblCopyright);
			this.Controls.Add(this.lblAppVersion);
			this.Controls.Add(this.lblAppName);
			this.Controls.Add(this.PictureBoxLogo);
			this.FormBorderStyle=System.Windows.Forms.FormBorderStyle.FixedSingle;
			this.Icon=((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
			this.MaximizeBox=false;
			this.MinimizeBox=false;
			this.Name="FormAbout";
			this.StartPosition=System.Windows.Forms.FormStartPosition.CenterParent;
			this.Text="Über...";
			this.Load+=new System.EventHandler(this.FormAbout_Load);
			((System.ComponentModel.ISupportInitialize)(this.PictureBoxLogo)).EndInit();
			this.ResumeLayout(false);
			this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.PictureBox PictureBoxLogo;
        private System.Windows.Forms.Label lblAppName;
        private System.Windows.Forms.Label lblAppVersion;
        private System.Windows.Forms.Label lblCopyright;
        private System.Windows.Forms.Label lblAllRights;
        private System.Windows.Forms.Button btnOK;
		private System.Windows.Forms.Label lblWeblink;

    }
}