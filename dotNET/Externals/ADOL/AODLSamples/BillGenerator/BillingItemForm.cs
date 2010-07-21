/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: BillingItemForm.cs,v $
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
using BillGenerator.Model;

namespace BillGenerator
{
	/// <summary>
	/// Zusammenfassung für BillingItem.
	/// </summary>
	public class BillingItemForm : System.Windows.Forms.Form
	{
		private System.Windows.Forms.GroupBox gbxAddItem;
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.Label label3;
		private System.Windows.Forms.Button btnAdd;
		private System.Windows.Forms.Button btnCancel;
		private System.Windows.Forms.ComboBox cbxItems;
		private System.Windows.Forms.TextBox tbxPrice;
		private System.Windows.Forms.TextBox tbxQuantity;
		/// <summary>
		/// Erforderliche Designervariable.
		/// </summary>
		private System.ComponentModel.Container components = null;

		/// <summary>
		/// The billing items
		/// </summary>
		private ArrayList _items;

		public delegate void AddItem(BillingItem billingItem, int quantity);
		public event AddItem OnAddItem;

		public BillingItemForm()
		{
			InitializeComponent();
			this.FillItems();
		}

		/// <summary>
		/// Die verwendeten Ressourcen bereinigen.
		/// </summary>
		protected override void Dispose( bool disposing )
		{
			if( disposing )
			{
				if(components != null)
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
			this.gbxAddItem = new System.Windows.Forms.GroupBox();
			this.label1 = new System.Windows.Forms.Label();
			this.cbxItems = new System.Windows.Forms.ComboBox();
			this.label2 = new System.Windows.Forms.Label();
			this.tbxPrice = new System.Windows.Forms.TextBox();
			this.label3 = new System.Windows.Forms.Label();
			this.tbxQuantity = new System.Windows.Forms.TextBox();
			this.btnAdd = new System.Windows.Forms.Button();
			this.btnCancel = new System.Windows.Forms.Button();
			this.gbxAddItem.SuspendLayout();
			this.SuspendLayout();
			// 
			// gbxAddItem
			// 
			this.gbxAddItem.Controls.Add(this.tbxQuantity);
			this.gbxAddItem.Controls.Add(this.label3);
			this.gbxAddItem.Controls.Add(this.tbxPrice);
			this.gbxAddItem.Controls.Add(this.label2);
			this.gbxAddItem.Controls.Add(this.cbxItems);
			this.gbxAddItem.Controls.Add(this.label1);
			this.gbxAddItem.Location = new System.Drawing.Point(8, 8);
			this.gbxAddItem.Name = "gbxAddItem";
			this.gbxAddItem.Size = new System.Drawing.Size(408, 128);
			this.gbxAddItem.TabIndex = 0;
			this.gbxAddItem.TabStop = false;
			this.gbxAddItem.Text = "Add billing item";
			// 
			// label1
			// 
			this.label1.Location = new System.Drawing.Point(16, 24);
			this.label1.Name = "label1";
			this.label1.TabIndex = 0;
			this.label1.Text = "Items:";
			// 
			// cbxItems
			// 
			this.cbxItems.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
			this.cbxItems.Location = new System.Drawing.Point(88, 24);
			this.cbxItems.Name = "cbxItems";
			this.cbxItems.Size = new System.Drawing.Size(304, 21);
			this.cbxItems.TabIndex = 1;
			this.cbxItems.SelectedIndexChanged += new System.EventHandler(this.cbxItems_SelectedIndexChanged);
			// 
			// label2
			// 
			this.label2.Location = new System.Drawing.Point(16, 56);
			this.label2.Name = "label2";
			this.label2.TabIndex = 2;
			this.label2.Text = "Price:";
			// 
			// tbxPrice
			// 
			this.tbxPrice.Location = new System.Drawing.Point(88, 56);
			this.tbxPrice.Name = "tbxPrice";
			this.tbxPrice.TabIndex = 3;
			this.tbxPrice.Text = "";
			// 
			// label3
			// 
			this.label3.Location = new System.Drawing.Point(16, 88);
			this.label3.Name = "label3";
			this.label3.TabIndex = 4;
			this.label3.Text = "Quantity:";
			// 
			// tbxQuantity
			// 
			this.tbxQuantity.Location = new System.Drawing.Point(88, 88);
			this.tbxQuantity.Name = "tbxQuantity";
			this.tbxQuantity.TabIndex = 5;
			this.tbxQuantity.Text = "";
			// 
			// btnAdd
			// 
			this.btnAdd.Location = new System.Drawing.Point(264, 144);
			this.btnAdd.Name = "btnAdd";
			this.btnAdd.TabIndex = 1;
			this.btnAdd.Text = "Add";
			this.btnAdd.Click += new System.EventHandler(this.btnAdd_Click);
			// 
			// btnCancel
			// 
			this.btnCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
			this.btnCancel.Location = new System.Drawing.Point(344, 144);
			this.btnCancel.Name = "btnCancel";
			this.btnCancel.TabIndex = 2;
			this.btnCancel.Text = "Cancel";
			// 
			// BillingItemForm
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.ClientSize = new System.Drawing.Size(424, 176);
			this.Controls.Add(this.btnCancel);
			this.Controls.Add(this.btnAdd);
			this.Controls.Add(this.gbxAddItem);
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow;
			this.Name = "BillingItemForm";
			this.Text = "BillingItem";
			this.gbxAddItem.ResumeLayout(false);
			this.ResumeLayout(false);

		}
		#endregion

		/// <summary>
		/// Fills the items.
		/// </summary>
		private void FillItems()
		{
			this._items = new ArrayList();
			this._items.Add(new BillingItem("HDD SAMSUNG SP2014N AT133 200GB", "a834723sfd", 120.90));
			this._items.Add(new BillingItem("PCIE-VGA GeForce 7600GT 256MB/PCIE", "g834723sfd", 94.90));
			this._items.Add(new BillingItem("CPU Tray AMD Athlon 64 3500+ 939 2,2GHz", "s837428323", 52.50));
			this._items.Add(new BillingItem("CPU-BOX Intel Core 2 Duo E6600 2400MHz", "d37428323", 274.70));

			foreach(BillingItem bi in this._items)
			{
				this.cbxItems.Items.Add(bi.Item);
			}
		}

		/// <summary>
		/// Handles the SelectedIndexChanged event of the cbxItems control.
		/// </summary>
		/// <param name="sender">The source of the event.</param>
		/// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
		private void cbxItems_SelectedIndexChanged(object sender, System.EventArgs e)
		{
			this.tbxPrice.Text = ((BillingItem)this._items[this.cbxItems.SelectedIndex]).Price.ToString();
		}

		/// <summary>
		/// Handles the Click event of the btnAdd control.
		/// Fire OnAddItem event.
		/// </summary>
		/// <param name="sender">The source of the event.</param>
		/// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
		private void btnAdd_Click(object sender, System.EventArgs e)
		{
			if(this.OnAddItem != null)
			{
				try
				{
					this.OnAddItem((BillingItem)this._items[this.cbxItems.SelectedIndex], Int32.Parse(this.tbxQuantity.Text));
					this.tbxQuantity.Text = "";
				}
				catch(Exception ex)
				{
					MessageBox.Show(ex.Message);
				}
			}
		}
	}
}
