//
//  FormSearchResults.cs
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

namespace Juliette
{
	public partial class FormSearchResults : Form
	{
		public int SelectedIndex;

		public FormSearchResults()
		{
			InitializeComponent();
		}

		public DialogResult ShowDialog(List<Globals.SearchInfo> list)
		{
			lbResults.Items.Clear();

			foreach (Globals.SearchInfo i in list)
			{
				lbResults.Items.Add(i.DmtLabel);
			}

			return base.ShowDialog();
		}

		private void lbResults_MouseDoubleClick(object sender, MouseEventArgs e)
		{
			SelectedIndex=lbResults.SelectedIndex;
			DialogResult=DialogResult.OK;
		}
	}
}
