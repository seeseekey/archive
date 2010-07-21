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
 * $Revision: 1.2 $
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
using BillGenerator.Model;
using BillGenerator.Controller;

namespace BillGenerator
{
	/// <summary>
	/// Zusammenfassung für Form1.
	/// </summary>
	public class MainForm : System.Windows.Forms.Form
	{
		/// <summary>
		/// The billing controller.
		/// </summary>
		private BillingController _controller;

		/// <summary>
		/// Gets the billing grid.
		/// </summary>
		/// <value>The billing grid.</value>
		public DataGrid BillingGrid
		{
			get { return this.dataGrid1; }
		}

		/// <summary>
		/// Ruft den Namen des Steuerelements ab oder legt diesen fest.
		/// </summary>
		/// <value></value>
		public string FirstName
		{
			get { return this.tbxName.Text; }
		}

		/// <summary>
		/// Gets the name of the last.
		/// </summary>
		/// <value>The name of the last.</value>
		public string LastName
		{
			get { return this.tbxLastName.Text; }
		}

		/// <summary>
		/// Gets the account ID.
		/// </summary>
		/// <value>The account ID.</value>
		public string AccountID
		{
			get { return this.tbxAccountID.Text; }
		}

		/// <summary>
		/// Gets the street.
		/// </summary>
		/// <value>The street.</value>
		public string Street
		{
			get { return this.tbxStreet.Text; }
		}

		/// <summary>
		/// Gets the city.
		/// </summary>
		/// <value>The city.</value>
		public string City
		{
			get { return this.tbxCity.Text; }
		}


		#region Forms
		private System.Windows.Forms.GroupBox gbxCustomer;
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.TextBox tbxName;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.TextBox tbxLastName;
		private System.Windows.Forms.Label label3;
		private System.Windows.Forms.Label label4;
		private System.Windows.Forms.TextBox tbxStreet;
		private System.Windows.Forms.Label label5;
		private System.Windows.Forms.TextBox tbxCity;
		private System.Windows.Forms.Label label6;
		private System.Windows.Forms.TextBox tbxPhone;
		private System.Windows.Forms.GroupBox gbxBill;
		private System.Windows.Forms.DataGrid dataGrid1;
		private System.Windows.Forms.Button btnAddItem;
		private System.Windows.Forms.Button btnCreateBill;
		private System.Windows.Forms.TextBox tbxAccountID;
		/// <summary>
		/// Erforderliche Designervariable.
		/// </summary>
		private System.ComponentModel.Container components = null;
		#endregion

		/// <summary>
		/// Initializes a new instance of the <see cref="MainForm"/> class.
		/// </summary>
		public MainForm()
		{
			InitializeComponent();
			// init controller
			this._controller = new BillingController(this);
		}

		/// <summary>
		/// Gibt die durch <see cref="T:System.Windows.Forms.Form"/> verwendeten Ressourcen (mit Ausnahme des Speichers) frei.
		/// </summary>
		/// <param name="disposing"><see langword="true"/>, um sowohl verwaltete als auch nicht verwaltete Ressourcen freizugeben. <see langword="false"/>, wenn ausschließlich nicht verwaltete Ressourcen freigegeben werden sollen.</param>
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

		#region Vom Windows Form-Designer generierter Code
		/// <summary>
		/// Erforderliche Methode für die Designerunterstützung. 
		/// Der Inhalt der Methode darf nicht mit dem Code-Editor geändert werden.
		/// </summary>
		private void InitializeComponent()
		{
			this.gbxCustomer = new System.Windows.Forms.GroupBox();
			this.label1 = new System.Windows.Forms.Label();
			this.tbxName = new System.Windows.Forms.TextBox();
			this.label2 = new System.Windows.Forms.Label();
			this.tbxLastName = new System.Windows.Forms.TextBox();
			this.label3 = new System.Windows.Forms.Label();
			this.tbxAccountID = new System.Windows.Forms.TextBox();
			this.label4 = new System.Windows.Forms.Label();
			this.tbxStreet = new System.Windows.Forms.TextBox();
			this.label5 = new System.Windows.Forms.Label();
			this.tbxCity = new System.Windows.Forms.TextBox();
			this.label6 = new System.Windows.Forms.Label();
			this.tbxPhone = new System.Windows.Forms.TextBox();
			this.gbxBill = new System.Windows.Forms.GroupBox();
			this.dataGrid1 = new System.Windows.Forms.DataGrid();
			this.btnAddItem = new System.Windows.Forms.Button();
			this.btnCreateBill = new System.Windows.Forms.Button();
			this.gbxCustomer.SuspendLayout();
			this.gbxBill.SuspendLayout();
			((System.ComponentModel.ISupportInitialize)(this.dataGrid1)).BeginInit();
			this.SuspendLayout();
			// 
			// gbxCustomer
			// 
			this.gbxCustomer.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.gbxCustomer.Controls.Add(this.tbxPhone);
			this.gbxCustomer.Controls.Add(this.label6);
			this.gbxCustomer.Controls.Add(this.tbxCity);
			this.gbxCustomer.Controls.Add(this.label5);
			this.gbxCustomer.Controls.Add(this.tbxStreet);
			this.gbxCustomer.Controls.Add(this.label4);
			this.gbxCustomer.Controls.Add(this.tbxAccountID);
			this.gbxCustomer.Controls.Add(this.label3);
			this.gbxCustomer.Controls.Add(this.tbxLastName);
			this.gbxCustomer.Controls.Add(this.label2);
			this.gbxCustomer.Controls.Add(this.tbxName);
			this.gbxCustomer.Controls.Add(this.label1);
			this.gbxCustomer.Location = new System.Drawing.Point(16, 8);
			this.gbxCustomer.Name = "gbxCustomer";
			this.gbxCustomer.Size = new System.Drawing.Size(672, 128);
			this.gbxCustomer.TabIndex = 0;
			this.gbxCustomer.TabStop = false;
			this.gbxCustomer.Text = "Current Customer";
			// 
			// label1
			// 
			this.label1.Location = new System.Drawing.Point(16, 56);
			this.label1.Name = "label1";
			this.label1.TabIndex = 0;
			this.label1.Text = "Name:";
			// 
			// tbxName
			// 
			this.tbxName.Location = new System.Drawing.Point(112, 56);
			this.tbxName.Name = "tbxName";
			this.tbxName.Size = new System.Drawing.Size(256, 20);
			this.tbxName.TabIndex = 1;
			this.tbxName.Text = "Max";
			// 
			// label2
			// 
			this.label2.Location = new System.Drawing.Point(16, 88);
			this.label2.Name = "label2";
			this.label2.TabIndex = 2;
			this.label2.Text = "Last name:";
			// 
			// tbxLastName
			// 
			this.tbxLastName.Location = new System.Drawing.Point(112, 88);
			this.tbxLastName.Name = "tbxLastName";
			this.tbxLastName.Size = new System.Drawing.Size(256, 20);
			this.tbxLastName.TabIndex = 3;
			this.tbxLastName.Text = "Mustermann";
			// 
			// label3
			// 
			this.label3.Location = new System.Drawing.Point(16, 24);
			this.label3.Name = "label3";
			this.label3.TabIndex = 4;
			this.label3.Text = "Account ID:";
			// 
			// tbxAccountID
			// 
			this.tbxAccountID.Location = new System.Drawing.Point(112, 24);
			this.tbxAccountID.Name = "tbxAccountID";
			this.tbxAccountID.ReadOnly = true;
			this.tbxAccountID.Size = new System.Drawing.Size(256, 20);
			this.tbxAccountID.TabIndex = 5;
			this.tbxAccountID.Text = "HSF-146156456421";
			// 
			// label4
			// 
			this.label4.Location = new System.Drawing.Point(384, 24);
			this.label4.Name = "label4";
			this.label4.TabIndex = 6;
			this.label4.Text = "Street:";
			// 
			// tbxStreet
			// 
			this.tbxStreet.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.tbxStreet.Location = new System.Drawing.Point(464, 24);
			this.tbxStreet.Name = "tbxStreet";
			this.tbxStreet.Size = new System.Drawing.Size(192, 20);
			this.tbxStreet.TabIndex = 7;
			this.tbxStreet.Text = "Any street 78 B";
			// 
			// label5
			// 
			this.label5.Location = new System.Drawing.Point(384, 56);
			this.label5.Name = "label5";
			this.label5.TabIndex = 8;
			this.label5.Text = "City:";
			// 
			// tbxCity
			// 
			this.tbxCity.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.tbxCity.Location = new System.Drawing.Point(464, 56);
			this.tbxCity.Name = "tbxCity";
			this.tbxCity.Size = new System.Drawing.Size(192, 20);
			this.tbxCity.TabIndex = 9;
			this.tbxCity.Text = "22555 Hamburg";
			// 
			// label6
			// 
			this.label6.Location = new System.Drawing.Point(384, 88);
			this.label6.Name = "label6";
			this.label6.TabIndex = 10;
			this.label6.Text = "Phone:";
			// 
			// tbxPhone
			// 
			this.tbxPhone.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.tbxPhone.Location = new System.Drawing.Point(464, 88);
			this.tbxPhone.Name = "tbxPhone";
			this.tbxPhone.Size = new System.Drawing.Size(192, 20);
			this.tbxPhone.TabIndex = 11;
			this.tbxPhone.Text = "+49 40 123456780";
			// 
			// gbxBill
			// 
			this.gbxBill.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
				| System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.gbxBill.Controls.Add(this.dataGrid1);
			this.gbxBill.Location = new System.Drawing.Point(16, 144);
			this.gbxBill.Name = "gbxBill";
			this.gbxBill.Size = new System.Drawing.Size(672, 264);
			this.gbxBill.TabIndex = 1;
			this.gbxBill.TabStop = false;
			this.gbxBill.Text = "Billing items";
			// 
			// dataGrid1
			// 
			this.dataGrid1.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
				| System.Windows.Forms.AnchorStyles.Left) 
				| System.Windows.Forms.AnchorStyles.Right)));
			this.dataGrid1.DataMember = "";
			this.dataGrid1.HeaderForeColor = System.Drawing.SystemColors.ControlText;
			this.dataGrid1.Location = new System.Drawing.Point(8, 24);
			this.dataGrid1.Name = "dataGrid1";
			this.dataGrid1.ReadOnly = true;
			this.dataGrid1.Size = new System.Drawing.Size(656, 232);
			this.dataGrid1.TabIndex = 0;
			// 
			// btnAddItem
			// 
			this.btnAddItem.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
			this.btnAddItem.Location = new System.Drawing.Point(16, 416);
			this.btnAddItem.Name = "btnAddItem";
			this.btnAddItem.TabIndex = 2;
			this.btnAddItem.Text = "Add item";
			this.btnAddItem.Click += new System.EventHandler(this.btnAddItem_Click);
			// 
			// btnCreateBill
			// 
			this.btnCreateBill.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.btnCreateBill.Enabled = false;
			this.btnCreateBill.Location = new System.Drawing.Point(608, 416);
			this.btnCreateBill.Name = "btnCreateBill";
			this.btnCreateBill.TabIndex = 3;
			this.btnCreateBill.Text = "Create Bill";
			this.btnCreateBill.Click += new System.EventHandler(this.btnCreateBill_Click);
			// 
			// MainForm
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.ClientSize = new System.Drawing.Size(704, 454);
			this.Controls.Add(this.btnCreateBill);
			this.Controls.Add(this.btnAddItem);
			this.Controls.Add(this.gbxBill);
			this.Controls.Add(this.gbxCustomer);
			this.MinimumSize = new System.Drawing.Size(700, 400);
			this.Name = "MainForm";
			this.Text = "Sample Bill Generator";
			this.gbxCustomer.ResumeLayout(false);
			this.gbxBill.ResumeLayout(false);
			((System.ComponentModel.ISupportInitialize)(this.dataGrid1)).EndInit();
			this.ResumeLayout(false);

		}
		#endregion

		/// <summary>
		/// Der Haupteinstiegspunkt für die Anwendung.
		/// </summary>
		[STAThread]
		static void Main() 
		{
			Application.Run(new MainForm());
		}

		/// <summary>
		/// Handles the Click event of the btnAddItem control.
		/// </summary>
		/// <param name="sender">The source of the event.</param>
		/// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
		private void btnAddItem_Click(object sender, System.EventArgs e)
		{
			BillingItemForm biForm = new BillingItemForm();
			biForm.OnAddItem += new BillGenerator.BillingItemForm.AddItem(biForm_OnAddItem);
			biForm.ShowDialog();
		}

		/// <summary>
		/// Recieve OnAddItem event.
		/// </summary>
		/// <param name="billingItem">The billing item.</param>
		/// <param name="quantity">The quantity.</param>
		private void biForm_OnAddItem(BillingItem billingItem, int quantity)
		{
			this._controller.AddItem(billingItem, quantity);
			this.btnCreateBill.Enabled = true;
		}

		/// <summary>
		/// Handles the Click event of the btnCreateBill control.
		/// </summary>
		/// <param name="sender">The source of the event.</param>
		/// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
		private void btnCreateBill_Click(object sender, System.EventArgs e)
		{
			try
			{
				string file = this._controller.CreateBill();
				MessageBox.Show("Bill was successfully created.\n\n" + file);
			}
			catch(Exception ex)
			{
				MessageBox.Show("An exception occours.\nMake sure that the template file isn't opened with any other app.\n\n" + ex.Message + "\n\n" + ex.StackTrace);
			}
		}
	}
}
