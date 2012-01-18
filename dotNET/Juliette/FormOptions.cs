//
//  FormOptions.cs
//
//  Copyright (c) 2011 by seeseekey <seeseekey@googlemail.com>
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.

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
