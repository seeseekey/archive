//
//  FormAbout.cs
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
using System.Reflection;

namespace Juliette
{
    public partial class FormAbout: Form
	{
		uint ClickCounter = 0;

        public FormAbout()
        {
            InitializeComponent();
        }

        private void btnOK_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void lblWeblink_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process.Start("http://www.seeseekey.net");
        }

		private void FormAbout_Load(object sender, EventArgs e)
		{
			Assembly InstAssembly=Assembly.GetExecutingAssembly();

			//Versionnummer			
			lblAppVersion.Text+=" "+InstAssembly.GetName().Version.ToString();

			//Produktname
			object o=InstAssembly.GetCustomAttributes(typeof(System.Reflection.AssemblyProductAttribute), true)[0];
			lblAppName.Text=((System.Reflection.AssemblyProductAttribute)(o)).Product.ToString();

			//Copyright
			o=InstAssembly.GetCustomAttributes(typeof(System.Reflection.AssemblyCopyrightAttribute), true)[0];
			lblCopyright.Text=((System.Reflection.AssemblyCopyrightAttribute)(o)).Copyright.ToString();
		}
    }
}
