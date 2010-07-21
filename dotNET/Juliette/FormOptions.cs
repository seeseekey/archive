using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Xml;

namespace Juliette
{
	public partial class FormOptions : Form
	{
		public FormOptions()
		{
			InitializeComponent();
		}

		private void btnDBBrowse_Click(object sender, EventArgs e)
		{
			OpenFileDialog.Filter="Juliette Dateien (*.jdf)|*.jdf";
			OpenFileDialog.DefaultExt="jdf";

			if (OpenFileDialog.ShowDialog()==DialogResult.OK)
			{
				tbStandardDB.Text=OpenFileDialog.FileName;
			}
		}

		private void btnCancel_Click(object sender, EventArgs e)
		{
			Close();
		}

		private void btnOK_Click(object sender, EventArgs e)
		{
			Globals.Options.WriteElement("xml.Application.StandardDB", OpenFileDialog.FileName);
			Globals.Options.Save(Globals.OptionsXmlFilename);
			Close();
		}

		private void FormOptions_Load(object sender, EventArgs e)
		{
			tbStandardDB.Text=Globals.Options.GetElementAsString("xml.Application.StandardDB");
		}

		private void btnRemovePath_Click(object sender, EventArgs e)
		{
			tbStandardDB.Text="";
		}
	}
}
