/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: MainForm.cs,v $
 *
 * $Revision: 1.3 $
 *
 * This file is part of OpenOffice.org.
 *
 * OpenOffice.org is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License version 3
 * only, as published by the Free Software Foundation.
 *
 * OpenOffice.org is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License version 3 for more details
 * (a copy is included in the LICENSE file that accompanied this code).
 *
 * You should have received a copy of the GNU Lesser General Public License
 * version 3 along with OpenOffice.org.  If not, see
 * <http://www.openoffice.org/license.html>
 * for a copy of the LGPLv3 License.
 *
 ************************************************************************/
using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Data;
using AODL.Document;
using AODL.Document.Content;
using AODL.Document.Forms;
using AODL.Document.Forms.Controls;
using AODL.Document.TextDocuments;
using AODL.Document.Content.Text;


namespace ODFFormsGenerator
{
	/// <summary>
	/// Summary description for Form1.
	/// </summary>
	public class mainForm : System.Windows.Forms.Form
	{
		private System.Windows.Forms.MainMenu mainMenu;
		private System.Windows.Forms.MenuItem menuItem1;
		private System.Windows.Forms.MenuItem menuItem2;
		private System.Windows.Forms.MenuItem menuItem3;
		private System.Windows.Forms.MenuItem menuItem4;
		private System.Windows.Forms.MenuItem menuItem5;
		private System.Windows.Forms.MenuItem menuItem6;
		private System.Windows.Forms.MenuItem menuItem7;
		private System.Windows.Forms.MenuItem menuItem8;
		private System.Windows.Forms.GroupBox groupBox1;
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.Label label3;
		private System.Windows.Forms.Label label4;
		private System.Windows.Forms.Label label5;
		private System.Windows.Forms.MenuItem menuItem9;
		private System.Windows.Forms.OpenFileDialog openFileDialog1;
		private System.Windows.Forms.SaveFileDialog saveFileDialog1;
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.Container components = null;
		private System.Windows.Forms.CheckBox eUsesAODL;
		private System.Windows.Forms.TextBox eAdditional;
		private System.Windows.Forms.NumericUpDown eAge;
		private System.Windows.Forms.ComboBox eGender;
		private System.Windows.Forms.TextBox eSurname;
		private System.Windows.Forms.TextBox eName;

		public TextDocument textDocument;
		public string lastOpenedFile = "";

		public mainForm()
		{
			//
			// Required for Windows Form Designer support
			//
			InitializeComponent();

			//
			// TODO: Add any constructor code after InitializeComponent call
			//
		}

		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		protected override void Dispose( bool disposing )
		{
			if( disposing )
			{
				if (components != null) 
				{
					components.Dispose();
				}
			}
			base.Dispose( disposing );
		}

		#region Windows Form Designer generated code
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.mainMenu = new System.Windows.Forms.MainMenu();
			this.menuItem1 = new System.Windows.Forms.MenuItem();
			this.menuItem2 = new System.Windows.Forms.MenuItem();
			this.menuItem3 = new System.Windows.Forms.MenuItem();
			this.menuItem9 = new System.Windows.Forms.MenuItem();
			this.menuItem4 = new System.Windows.Forms.MenuItem();
			this.menuItem5 = new System.Windows.Forms.MenuItem();
			this.menuItem6 = new System.Windows.Forms.MenuItem();
			this.menuItem7 = new System.Windows.Forms.MenuItem();
			this.menuItem8 = new System.Windows.Forms.MenuItem();
			this.groupBox1 = new System.Windows.Forms.GroupBox();
			this.eUsesAODL = new System.Windows.Forms.CheckBox();
			this.label5 = new System.Windows.Forms.Label();
			this.eAdditional = new System.Windows.Forms.TextBox();
			this.label4 = new System.Windows.Forms.Label();
			this.eAge = new System.Windows.Forms.NumericUpDown();
			this.label3 = new System.Windows.Forms.Label();
			this.eGender = new System.Windows.Forms.ComboBox();
			this.label2 = new System.Windows.Forms.Label();
			this.eSurname = new System.Windows.Forms.TextBox();
			this.label1 = new System.Windows.Forms.Label();
			this.eName = new System.Windows.Forms.TextBox();
			this.openFileDialog1 = new System.Windows.Forms.OpenFileDialog();
			this.saveFileDialog1 = new System.Windows.Forms.SaveFileDialog();
			this.groupBox1.SuspendLayout();
			((System.ComponentModel.ISupportInitialize)(this.eAge)).BeginInit();
			this.SuspendLayout();
			// 
			// mainMenu
			// 
			this.mainMenu.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] {
																					 this.menuItem1,
																					 this.menuItem7});
			// 
			// menuItem1
			// 
			this.menuItem1.Index = 0;
			this.menuItem1.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] {
																					  this.menuItem2,
																					  this.menuItem3,
																					  this.menuItem9,
																					  this.menuItem4,
																					  this.menuItem5,
																					  this.menuItem6});
			this.menuItem1.Text = "&File";
			// 
			// menuItem2
			// 
			this.menuItem2.Index = 0;
			this.menuItem2.Text = "&New";
			this.menuItem2.Click += new System.EventHandler(this.menuItem2_Click);
			// 
			// menuItem3
			// 
			this.menuItem3.Index = 1;
			this.menuItem3.Text = "&Open";
			this.menuItem3.Click += new System.EventHandler(this.menuItem3_Click);
			// 
			// menuItem9
			// 
			this.menuItem9.Index = 2;
			this.menuItem9.Text = "&Save";
			this.menuItem9.Click += new System.EventHandler(this.menuItem9_Click);
			// 
			// menuItem4
			// 
			this.menuItem4.Index = 3;
			this.menuItem4.Text = "Save &as";
			this.menuItem4.Click += new System.EventHandler(this.menuItem4_Click);
			// 
			// menuItem5
			// 
			this.menuItem5.Index = 4;
			this.menuItem5.Text = "-";
			// 
			// menuItem6
			// 
			this.menuItem6.Index = 5;
			this.menuItem6.Text = "E&xit";
			// 
			// menuItem7
			// 
			this.menuItem7.Index = 1;
			this.menuItem7.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] {
																					  this.menuItem8});
			this.menuItem7.Text = "&Help";
			// 
			// menuItem8
			// 
			this.menuItem8.Index = 0;
			this.menuItem8.Text = "&About";
			this.menuItem8.Click += new System.EventHandler(this.menuItem8_Click);
			// 
			// groupBox1
			// 
			this.groupBox1.Controls.Add(this.eUsesAODL);
			this.groupBox1.Controls.Add(this.label5);
			this.groupBox1.Controls.Add(this.eAdditional);
			this.groupBox1.Controls.Add(this.label4);
			this.groupBox1.Controls.Add(this.eAge);
			this.groupBox1.Controls.Add(this.label3);
			this.groupBox1.Controls.Add(this.eGender);
			this.groupBox1.Controls.Add(this.label2);
			this.groupBox1.Controls.Add(this.eSurname);
			this.groupBox1.Controls.Add(this.label1);
			this.groupBox1.Controls.Add(this.eName);
			this.groupBox1.Location = new System.Drawing.Point(16, 16);
			this.groupBox1.Name = "groupBox1";
			this.groupBox1.Size = new System.Drawing.Size(520, 240);
			this.groupBox1.TabIndex = 0;
			this.groupBox1.TabStop = false;
			this.groupBox1.Text = "Demo Form";
			// 
			// eUsesAODL
			// 
			this.eUsesAODL.Location = new System.Drawing.Point(272, 200);
			this.eUsesAODL.Name = "eUsesAODL";
			this.eUsesAODL.Size = new System.Drawing.Size(216, 24);
			this.eUsesAODL.TabIndex = 10;
			this.eUsesAODL.Text = "This person uses AODL :)";
			// 
			// label5
			// 
			this.label5.Location = new System.Drawing.Point(272, 32);
			this.label5.Name = "label5";
			this.label5.Size = new System.Drawing.Size(200, 16);
			this.label5.TabIndex = 9;
			this.label5.Text = "Additional information";
			// 
			// eAdditional
			// 
			this.eAdditional.Location = new System.Drawing.Point(272, 48);
			this.eAdditional.Multiline = true;
			this.eAdditional.Name = "eAdditional";
			this.eAdditional.Size = new System.Drawing.Size(224, 128);
			this.eAdditional.TabIndex = 8;
			this.eAdditional.Text = "";
			// 
			// label4
			// 
			this.label4.Location = new System.Drawing.Point(24, 184);
			this.label4.Name = "label4";
			this.label4.Size = new System.Drawing.Size(96, 16);
			this.label4.TabIndex = 7;
			this.label4.Text = "Age";
			// 
			// eAge
			// 
			this.eAge.Location = new System.Drawing.Point(24, 200);
			this.eAge.Minimum = new System.Decimal(new int[] {
																 16,
																 0,
																 0,
																 0});
			this.eAge.Name = "eAge";
			this.eAge.Size = new System.Drawing.Size(176, 20);
			this.eAge.TabIndex = 6;
			this.eAge.Value = new System.Decimal(new int[] {
															   21,
															   0,
															   0,
															   0});
			// 
			// label3
			// 
			this.label3.Location = new System.Drawing.Point(24, 136);
			this.label3.Name = "label3";
			this.label3.Size = new System.Drawing.Size(96, 16);
			this.label3.TabIndex = 5;
			this.label3.Text = "Gender";
			this.label3.Click += new System.EventHandler(this.label3_Click);
			// 
			// eGender
			// 
			this.eGender.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
			this.eGender.Items.AddRange(new object[] {
														 "Male",
														 "Female"});
			this.eGender.Location = new System.Drawing.Point(24, 152);
			this.eGender.Name = "eGender";
			this.eGender.Size = new System.Drawing.Size(176, 21);
			this.eGender.TabIndex = 4;
			// 
			// label2
			// 
			this.label2.Location = new System.Drawing.Point(24, 80);
			this.label2.Name = "label2";
			this.label2.Size = new System.Drawing.Size(100, 16);
			this.label2.TabIndex = 3;
			this.label2.Text = "Surname";
			// 
			// eSurname
			// 
			this.eSurname.Location = new System.Drawing.Point(24, 96);
			this.eSurname.Name = "eSurname";
			this.eSurname.Size = new System.Drawing.Size(176, 20);
			this.eSurname.TabIndex = 2;
			this.eSurname.Text = "";
			// 
			// label1
			// 
			this.label1.Location = new System.Drawing.Point(24, 32);
			this.label1.Name = "label1";
			this.label1.Size = new System.Drawing.Size(100, 16);
			this.label1.TabIndex = 1;
			this.label1.Text = "Name";
			// 
			// eName
			// 
			this.eName.Location = new System.Drawing.Point(24, 48);
			this.eName.Name = "eName";
			this.eName.Size = new System.Drawing.Size(176, 20);
			this.eName.TabIndex = 0;
			this.eName.Text = "";
			// 
			// openFileDialog1
			// 
			this.openFileDialog1.DefaultExt = "odt";
			this.openFileDialog1.Filter = "odt files|*.odt";
			// 
			// saveFileDialog1
			// 
			this.saveFileDialog1.DefaultExt = "odt";
			this.saveFileDialog1.Filter = "odt files|*.odt";
			// 
			// mainForm
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.ClientSize = new System.Drawing.Size(554, 267);
			this.Controls.Add(this.groupBox1);
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
			this.MaximizeBox = false;
			this.Menu = this.mainMenu;
			this.Name = "mainForm";
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
			this.Text = "ODF Forms demo generator";
			this.Load += new System.EventHandler(this.mainForm_Load);
			this.groupBox1.ResumeLayout(false);
			((System.ComponentModel.ISupportInitialize)(this.eAge)).EndInit();
			this.ResumeLayout(false);

		}
		#endregion

		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		[STAThread]
		static void Main() 
		{
			Application.Run(new mainForm());
		}

		private void menuItem8_Click(object sender, System.EventArgs e)
		{
			MessageBox.Show("Simple ODF Forms demo generator by Oleg Yegorov" +
			"\r\nE-mail: yegorov.oleg@gmail.com", "About", MessageBoxButtons.OK, MessageBoxIcon.Information);
		}

		private void label3_Click(object sender, System.EventArgs e)
		{
		
		}

		private void mainForm_Load(object sender, System.EventArgs e)
		{
			textDocument = new TextDocument();
		}

		private void menuItem4_Click(object sender, System.EventArgs e)
		{
			if (saveFileDialog1.ShowDialog() == DialogResult.OK)
			{
				textDocument.New();
				Paragraph p1 = new Paragraph(textDocument);
				p1.TextContent.Add(new SimpleText(textDocument, "This is a test form generated by the ODF Forms demo generator using the AODL library."));

				Paragraph p2 = new Paragraph(textDocument);

				ODFForm fMain = textDocument.AddNewForm("mainform");
			
				ODFFrame frame = new ODFFrame(fMain, p2.Content, "frame", "5mm", "5mm", "9cm", "5cm");
				frame.Label = "Demo Form";
				frame.AnchorType = AnchorType.Paragraph;

				
				ODFFixedText ft_name = new ODFFixedText(fMain, p2.Content, "ft_name", "8mm", "10mm", "3cm", "4mm");
				ft_name.Label = "Name";

				ODFTextArea name = new ODFTextArea(fMain, p2.Content, "name", "8mm", "14mm", "3cm", "5mm");
				name.CurrentValue = eName.Text;
				name.AnchorType = AnchorType.Paragraph;

				ODFFixedText ft_surname = new ODFFixedText(fMain, p2.Content, "ft_surname", "8mm", "20mm", "3cm", "4mm");
				ft_surname.Label = "Surname";

				ODFTextArea surname = new ODFTextArea(fMain, p2.Content, "surname", "8mm", "24mm", "3cm", "5mm");
				surname.CurrentValue = eSurname.Text;
				surname.AnchorType = AnchorType.Paragraph;

				ODFFixedText ft_gender = new ODFFixedText(fMain, p2.Content, "ft_gender", "8mm", "30mm", "3cm", "4mm");
				ft_gender.Label = "Gender";

				ODFListBox gender = new ODFListBox(fMain, p2.Content, "gender", "8mm", "35mm", "3cm", "5mm");
				
				ODFOption male = new ODFOption(textDocument, "Male");
				if (eGender.SelectedIndex == 0)
					male.CurrentSelected = XmlBoolean.True;
				gender.Options.Add(male);
				ODFOption female = new ODFOption(textDocument, "Female");
				if (eGender.SelectedIndex == 1)
					female.CurrentSelected = XmlBoolean.True;
				gender.Options.Add(female);
				gender.AnchorType = AnchorType.Paragraph;
				gender.DropDown = XmlBoolean.True;
				
				ODFFixedText ft_age = new ODFFixedText(fMain, p2.Content, "ft_age", "8mm", "40mm", "3cm", "4mm");
				ft_age.Label = "Age";
				ODFFormattedText age = new ODFFormattedText(fMain, p2.Content, "age", "8mm", "44mm", "3cm", "5mm");
				age.CurrentValue = eAge.Value.ToString();
				age.MinValue = 16;
				age.MaxValue = 100;


				ODFFixedText ft_addinfo= new ODFFixedText(fMain, p2.Content, "ft_addinfo", "45mm", "10mm", "45mm", "4mm");
				ft_addinfo.Label = "Additional information";

				ODFTextArea addinfo = new ODFTextArea(fMain, p2.Content, "addinfo", "45mm", "14mm", "45mm", "25mm");
				addinfo.CurrentValue = eAdditional.Text;
				addinfo.AnchorType = AnchorType.Paragraph;
				addinfo.Properties.Add(new SingleFormProperty(textDocument, PropertyValueType.Boolean, "MultiLine", "true"));

				ODFCheckBox usesaodl = new ODFCheckBox(fMain, p2.Content, "usesaodl", "45mm", "40mm", "45mm", "25mm");
				if (eUsesAODL.Checked)
					usesaodl.CurrentState = State.Checked;
				usesaodl.Label = "This person uses AODL:)";
				usesaodl.AnchorType = AnchorType.Paragraph;
				
				fMain.Controls.Add(frame);
				fMain.Controls.Add(ft_name);
				fMain.Controls.Add(name);
				fMain.Controls.Add(ft_surname);
				fMain.Controls.Add(surname);
				fMain.Controls.Add(ft_gender);
				fMain.Controls.Add(gender);
				fMain.Controls.Add(ft_age);
				fMain.Controls.Add(age);
				fMain.Controls.Add(ft_addinfo);
				fMain.Controls.Add(addinfo);
				fMain.Controls.Add(usesaodl);

				textDocument.Content.Add(p1);
				textDocument.Content.Add(p2);

				textDocument.SaveTo(saveFileDialog1.FileName);
				lastOpenedFile = saveFileDialog1.FileName;
			}
		}

		private void menuItem3_Click(object sender, System.EventArgs e)
		{
			if (openFileDialog1.ShowDialog() == DialogResult.OK)
			{
				textDocument.Load(openFileDialog1.FileName);
				
				ODFTextArea name = textDocument.FindControlById("name") as ODFTextArea;
				if (name != null)
					eName.Text = name.CurrentValue;
				else
					MessageBox.Show("");
				ODFTextArea surname = textDocument.FindControlById("surname") as ODFTextArea;
				if (surname != null)
					eSurname.Text = surname.CurrentValue;
				
				ODFListBox gender = textDocument.FindControlById("gender") as ODFListBox;
				if (gender != null)
				{
					ODFOption opt = gender.GetOptionByLabel("Male");
					if (opt != null)
					{
						if (opt.CurrentSelected == XmlBoolean.True)
							eGender.SelectedIndex = 0;
					}

					opt = gender.GetOptionByLabel("Female");
					if (opt != null)
					{
						if (opt.CurrentSelected == XmlBoolean.True)
							eGender.SelectedIndex = 1;
					}
				}

				ODFFormattedText age = textDocument.FindControlById("age") as ODFFormattedText;
				if (age != null)
					eAge.Value= int.Parse(age.CurrentValue);
				
				ODFTextArea addinfo = textDocument.FindControlById("addinfo") as ODFTextArea;
				if (addinfo != null)
					eAdditional.Text = addinfo.CurrentValue;

				ODFCheckBox usesaodl = textDocument.FindControlById("usesaodl") as ODFCheckBox;
				if (usesaodl != null)
					eUsesAODL.Checked = (usesaodl.CurrentState == State.Checked);

				lastOpenedFile = openFileDialog1.FileName;
			}
		}

		private void menuItem2_Click(object sender, System.EventArgs e)
		{
			lastOpenedFile = "";
			eName.Text = "";
			eSurname.Text = "";
			eAge.Value = 21;
			eAdditional.Text = "";
			eGender.SelectedIndex = 0;
			eUsesAODL.Checked = false;
			
		}

		private void menuItem9_Click(object sender, System.EventArgs e)
		{
			if (lastOpenedFile == "")
				menuItem4_Click(sender, e);
			else
			{
				ODFTextArea name = textDocument.FindControlById("name") as ODFTextArea;
				if (name != null)
					name.CurrentValue = eName.Text;
				
				ODFTextArea surname = textDocument.FindControlById("surname") as ODFTextArea;
				if (surname != null)
					surname.CurrentValue = eSurname.Text;
				
				ODFListBox gender = textDocument.FindControlById("gender") as ODFListBox;
				if (gender != null)
				{
					ODFOption m = gender.GetOptionByLabel("Male");
					ODFOption f = gender.GetOptionByLabel("Female");
					if (eGender.SelectedIndex == 0)
					{
						if (m != null && f !=null)
						{
							m.CurrentSelected = XmlBoolean.True;
							f.CurrentSelected = XmlBoolean.False;
						}
					}
					else if (eGender.SelectedIndex == 1)
					{
						if (f != null && m !=null)
						{
							f.CurrentSelected = XmlBoolean.True;
							m.CurrentSelected = XmlBoolean.False;
						}
					}
				}

				ODFFormattedText age = textDocument.FindControlById("age") as ODFFormattedText;
				if (age != null)
					age.CurrentValue = eAge.Value.ToString();
				
				ODFTextArea addinfo = textDocument.FindControlById("addinfo") as ODFTextArea;
				if (addinfo != null)
					addinfo.CurrentValue = eAdditional.Text;

				ODFCheckBox usesaodl = textDocument.FindControlById("usesaodl") as ODFCheckBox;
				if (usesaodl != null)
				{
					if (eUsesAODL.Checked)
						usesaodl.CurrentState = State.Checked;
					else
						usesaodl.CurrentState = State.Unchecked;
				}
				textDocument.SaveTo(lastOpenedFile);
			}
		}

		private void button1_Click(object sender, System.EventArgs e)
		{
			
		}
	}
}
