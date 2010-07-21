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
