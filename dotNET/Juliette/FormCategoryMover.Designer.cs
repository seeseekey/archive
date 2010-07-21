namespace Juliette
{
	partial class FormCategoryMover
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
			this.components=new System.ComponentModel.Container();
			System.ComponentModel.ComponentResourceManager resources=new System.ComponentModel.ComponentResourceManager(typeof(FormCategoryMover));
			this.tvCategories=new System.Windows.Forms.TreeView();
			this.ilTreeview=new System.Windows.Forms.ImageList(this.components);
			this.btnOK=new System.Windows.Forms.Button();
			this.btnCancel=new System.Windows.Forms.Button();
			this.SuspendLayout();
			// 
			// tvCategories
			// 
			this.tvCategories.ImageIndex=0;
			this.tvCategories.ImageList=this.ilTreeview;
			this.tvCategories.Location=new System.Drawing.Point(12, 12);
			this.tvCategories.Name="tvCategories";
			this.tvCategories.SelectedImageIndex=0;
			this.tvCategories.Size=new System.Drawing.Size(330, 265);
			this.tvCategories.TabIndex=0;
			// 
			// ilTreeview
			// 
			this.ilTreeview.ImageStream=((System.Windows.Forms.ImageListStreamer)(resources.GetObject("ilTreeview.ImageStream")));
			this.ilTreeview.TransparentColor=System.Drawing.Color.Transparent;
			this.ilTreeview.Images.SetKeyName(0, "root.ico");
			this.ilTreeview.Images.SetKeyName(1, "kategorie.ico");
			this.ilTreeview.Images.SetKeyName(2, "subkategorie.ico");
			this.ilTreeview.Images.SetKeyName(3, "document.ico");
			// 
			// btnOK
			// 
			this.btnOK.Location=new System.Drawing.Point(186, 283);
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
			this.btnCancel.Location=new System.Drawing.Point(267, 283);
			this.btnCancel.Name="btnCancel";
			this.btnCancel.Size=new System.Drawing.Size(75, 23);
			this.btnCancel.TabIndex=2;
			this.btnCancel.Text="Abbrechen";
			this.btnCancel.UseVisualStyleBackColor=true;
			this.btnCancel.Click+=new System.EventHandler(this.btnCancel_Click);
			// 
			// FormCategoryMover
			// 
			this.AcceptButton=this.btnOK;
			this.AutoScaleDimensions=new System.Drawing.SizeF(6F, 13F);
			this.AutoScaleMode=System.Windows.Forms.AutoScaleMode.Font;
			this.CancelButton=this.btnCancel;
			this.ClientSize=new System.Drawing.Size(354, 311);
			this.Controls.Add(this.btnCancel);
			this.Controls.Add(this.btnOK);
			this.Controls.Add(this.tvCategories);
			this.FormBorderStyle=System.Windows.Forms.FormBorderStyle.FixedDialog;
			this.MaximizeBox=false;
			this.MinimizeBox=false;
			this.Name="FormCategoryMover";
			this.StartPosition=System.Windows.Forms.FormStartPosition.CenterScreen;
			this.Text="CategoryMover";
			this.Load+=new System.EventHandler(this.FormCategoryMover_Load);
			this.ResumeLayout(false);

		}

		#endregion

		private System.Windows.Forms.TreeView tvCategories;
		private System.Windows.Forms.Button btnOK;
		private System.Windows.Forms.Button btnCancel;
		private System.Windows.Forms.ImageList ilTreeview;
	}
}