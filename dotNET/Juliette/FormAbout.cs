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