//
//  TextInputbox.cs
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
using System.Text;

namespace Juliette
{
    public class TextInputbox: System.Windows.Forms.Form
    {
        #region Windows Contols and Constructor
        private System.Windows.Forms.Label lblPrompt;
        private System.Windows.Forms.Button btnOK;
        private System.Windows.Forms.TextBox txtInput;
        /// <summary>
        /// Required designer variable.
        ///
        private System.ComponentModel.Container components=null;

        public TextInputbox()
        {
            //
            // Required for Windows Form Designer support
            //
            InitializeComponent();

            //
            // TODO: Add any constructor code after InitializeComponent call
            //
        }

        #endregion

        #region Dispose

        /// <summary>
        /// Clean up any resources being used.
        ///
        protected override void Dispose(bool disposing)
        {
            if(disposing)
            {
                if(components != null)
                {
                    components.Dispose();
                }
            }
            base.Dispose(disposing);
        }

        #endregion

        #region Windows Form Designer generated code
        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        ///
        private void InitializeComponent()
        {
			this.lblPrompt=new System.Windows.Forms.Label();
			this.btnOK=new System.Windows.Forms.Button();
			this.txtInput=new System.Windows.Forms.TextBox();
			this.SuspendLayout();
			// 
			// lblPrompt
			// 
			this.lblPrompt.Anchor=((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top|System.Windows.Forms.AnchorStyles.Left)
						|System.Windows.Forms.AnchorStyles.Right)));
			this.lblPrompt.BackColor=System.Drawing.SystemColors.Control;
			this.lblPrompt.Font=new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
			this.lblPrompt.Location=new System.Drawing.Point(12, 9);
			this.lblPrompt.Name="lblPrompt";
			this.lblPrompt.Size=new System.Drawing.Size(374, 21);
			this.lblPrompt.TabIndex=3;
			// 
			// btnOK
			// 
			this.btnOK.DialogResult=System.Windows.Forms.DialogResult.OK;
			this.btnOK.Location=new System.Drawing.Point(308, 32);
			this.btnOK.Name="btnOK";
			this.btnOK.Size=new System.Drawing.Size(78, 21);
			this.btnOK.TabIndex=1;
			this.btnOK.Text="&OK";
			this.btnOK.Click+=new System.EventHandler(this.btnOK_Click);
			// 
			// txtInput
			// 
			this.txtInput.Location=new System.Drawing.Point(12, 33);
			this.txtInput.Name="txtInput";
			this.txtInput.Size=new System.Drawing.Size(290, 20);
			this.txtInput.TabIndex=0;
			// 
			// TextInputbox
			// 
			this.AcceptButton=this.btnOK;
			this.AutoScaleBaseSize=new System.Drawing.Size(5, 13);
			this.ClientSize=new System.Drawing.Size(398, 66);
			this.Controls.Add(this.txtInput);
			this.Controls.Add(this.btnOK);
			this.Controls.Add(this.lblPrompt);
			this.FormBorderStyle=System.Windows.Forms.FormBorderStyle.FixedDialog;
			this.MaximizeBox=false;
			this.MinimizeBox=false;
			this.Name="TextInputbox";
			this.StartPosition=System.Windows.Forms.FormStartPosition.CenterScreen;
			this.Text="InputBox";
			this.Load+=new System.EventHandler(this.InputBox_Load);
			this.ResumeLayout(false);
			this.PerformLayout();

        }
        #endregion

        #region Private Variables
        string formCaption = string.Empty;
        string formPrompt = string.Empty;
        string inputResponse = string.Empty;
        string defaultValue = string.Empty;
        #endregion

        #region Public Properties
		/// <summary>
		/// Caption des Formulares
		/// </summary>
        public string FormCaption
        {
            get
            {
                return formCaption;
            }
            set
            {
                formCaption = value;
            }
        } // property FormCaption

		/// <summary>
		/// Beschreibungstext was der User eingeben soll
		/// </summary>
        public string FormPrompt
        {
            get
            {
                return formPrompt;
            }
            set
            {
                formPrompt = value;
            }
        } // property FormPrompt

		/// <summary>
		/// R�ckgabewer des Formulares
		/// </summary>
        public string InputResponse
        {
            get
            {
                return inputResponse;
            }
            set
            {
                inputResponse = value;
            }
        } // property InputResponse

		/// <summary>
		/// Standardwert
		/// </summary>
        public string DefaultValue
        {
            get
            {
                return defaultValue;
            }
            set
            {
                defaultValue = value;
            }
        } // property DefaultValue

        #endregion

        #region Form and Control Events
        private void InputBox_Load(object sender, System.EventArgs e)
        {
			this.AcceptButton=btnOK;

            this.txtInput.Text = defaultValue;
            this.lblPrompt.Text = formPrompt;
            this.Text = formCaption;
            this.txtInput.SelectionStart = 0;
            this.txtInput.SelectionLength = this.txtInput.Text.Length;
            this.txtInput.Focus();
        }


        private void btnOK_Click(object sender, System.EventArgs e)
        {
            InputResponse = this.txtInput.Text;
            this.Close();
        }

        private void button1_Click(object sender, System.EventArgs e)
        {
            this.Close();
        }

        public string ShowDialog(string prompt, string title, string defaultValue)
        {
            //InputBoxDialog ib = new TextInputbox();
            FormPrompt = prompt;
            FormCaption = title;
            DefaultValue = defaultValue;
            ShowDialog();
            string s = InputResponse;
            Close();
            return s;
        }
        #endregion
    }
}
