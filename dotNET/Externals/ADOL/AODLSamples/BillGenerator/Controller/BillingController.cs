/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: BillingController.cs,v $
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
using System.IO;
using System.Data;
using System.Windows.Forms;
using BillGenerator;
using BillGenerator.Model;
using AODL.Document.TextDocuments;
using AODL.Document.Content.Tables;
using AODL.Document.Content.Text;
using AODL.Document.Content;
using AODL.Document.Styles;
using AODL.Document.Styles.Properties;

namespace BillGenerator.Controller
{
	/// <summary>
	/// Summary for BillingController.
	/// </summary>
	public class BillingController
	{
		/// <summary>
		/// Reference to the main form.
		/// </summary>
		private MainForm _mainForm;
		/// <summary>
		/// The table of billing items.
		/// </summary>
		private DataTable _tblItems;

		/// <summary>
		/// Initializes a new instance of the <see cref="BillingController"/> class.
		/// </summary>
		public BillingController(MainForm mainForm)
		{
			this._mainForm = mainForm;
			this.CreateBillingTable();
		}

		/// <summary>
		/// Creates the billing table.
		/// </summary>
		public void CreateBillingTable()
		{
			this._tblItems = new DataTable("Billing Items");
			this._tblItems.Columns.Add("Item", typeof(String));
			this._tblItems.Columns.Add("ItemNo", typeof(String));
			this._tblItems.Columns.Add("Quantity", typeof(Int32));
			this._tblItems.Columns.Add("Price", typeof(Double));
			this._tblItems.Columns.Add("PriceTotal", typeof(Double));
			this._mainForm.BillingGrid.DataSource = this._tblItems;
		}

		/// <summary>
		/// Adds the item.
		/// </summary>
		/// <param name="billingItem">The billing item.</param>
		/// <param name="quantity">The quantity.</param>
		public void AddItem(BillingItem billingItem, int quantity)
		{
			DataRow dr = this._tblItems.NewRow();
			dr["Item"] = billingItem.Item;
			dr["ItemNo"] = billingItem.ItemNo;
			dr["Quantity"] = quantity;
			dr["Price"] = billingItem.Price;
			dr["PriceTotal"] = billingItem.Price * (double)quantity;
			this._tblItems.Rows.Add(dr);
		}

		/// <summary>
		/// Creates the bill.
		/// </summary>
		public string CreateBill()
		{
			try
			{
				string billingTemplate = Path.Combine(Application.StartupPath, "bill_template.odt");
				if(File.Exists(billingTemplate))
				{
					string billFile = Path.Combine(Application.StartupPath, "bill.odt");
					TextDocument billingDoc = new TextDocument();
					billingDoc.Load(billingTemplate);
					this.WriteBillingItems(billingDoc);
					this.WriteCustomerAndDate(billingDoc);
					billingDoc.SaveTo(billFile);
					return billFile;
				}
				else
				{
					throw new Exception("The billing template wasn't found!\n" + billingTemplate);
				}
			}
			catch(Exception)
			{
				throw;
			}
		}

		/// <summary>
		/// Writes the billing items.
		/// </summary>
		/// <param name="billingDoc">The billing doc.</param>
		private void WriteBillingItems(TextDocument billingDoc)
		{
			if(billingDoc != null)
			{
				foreach(IContent content in billingDoc.Content)
				{
					if(content is Table)
					{
						Table itemTable = (Table)content;
						double priceTotal = 0;
						int r = 0;
						string lastCellStyleName = "";
						foreach(DataRow dr in this._tblItems.Rows)
						{
							Row itemRow = new Row(itemTable);
							int c = 0;
							foreach(object obj in dr.ItemArray)
							{
								lastCellStyleName = "c" + r.ToString() + c.ToString();
								Cell cell = new Cell(itemTable, lastCellStyleName);
								((CellStyle)cell.Style).CellProperties.Padding = "0.2cm";
								((CellStyle)cell.Style).CellProperties.BorderBottom = "0.002cm solid #000000";
								Paragraph p = ParagraphBuilder.CreateParagraphWithCustomStyle(billingDoc, "p" + r.ToString() + c.ToString());
								ParagraphProperties pp = ((ParagraphStyle)p.Style).ParagraphProperties;
								if(pp != null)
								{
									if(c == 1)
										pp.Alignment = TextAlignments.center.ToString();
									if(c > 1)
										pp.Alignment = TextAlignments.end.ToString();
								}
								TextProperties tp = ((ParagraphStyle)p.Style).TextProperties;
								if(tp != null)
								{
									tp.Bold = "bold";
									tp.FontName = FontFamilies.Arial;
									tp.FontSize = "11pt";
									if(c < 2)
										tp.Italic = "italic";
								}
								if(c == 4)
									priceTotal += Double.Parse(obj.ToString());
								p.TextContent.Add(new SimpleText(billingDoc, obj.ToString()));
								cell.Content.Add(p);
								itemRow.CellCollection.Add(cell);
								c++;
							}
							itemTable.RowCollection.Add(itemRow);
							r++;
						}

						Row priceTotalRow = new Row(itemTable);						
						for(int i=0; i < 4; i++)
							priceTotalRow.CellCollection.Add(new Cell(itemTable));

						Cell cell1 = new Cell(itemTable, lastCellStyleName);
						Paragraph p1 = ParagraphBuilder.CreateParagraphWithCustomStyle(billingDoc, "ppricetotal");
						((ParagraphStyle)p1.Style).ParagraphProperties.Alignment = TextAlignments.end.ToString();
						((ParagraphStyle)p1.Style).TextProperties.Bold = "bold";
						((ParagraphStyle)p1.Style).TextProperties.FontSize = "11pt";
						((ParagraphStyle)p1.Style).TextProperties.FontName = FontFamilies.Arial;
						p1.TextContent.Add(new SimpleText(billingDoc, priceTotal.ToString()));
						cell1.Content.Add(p1);
						priceTotalRow.CellCollection.Add(cell1);
						itemTable.RowCollection.Add(priceTotalRow);
					}					
				}
			}
		}

		/// <summary>
		/// Writes the customer and date.
		/// </summary>
		/// <param name="billingDoc">The billing doc.</param>
		private void WriteCustomerAndDate(TextDocument billingDoc)
		{
			int i = 0;
			int customerIndex = 0;
			foreach(IContent content in billingDoc.Content)
			{
				if(content is Paragraph && ((Paragraph)content).TextContent != null 
					&& ((Paragraph)content).TextContent.Count == 1
					&& ((Paragraph)content).TextContent[0] is SimpleText)
				{
					if(((Paragraph)content).TextContent[0].Text.ToLower() == "customer")
					{
						((Paragraph)content).TextContent[0].Text = this._mainForm.FirstName + " " + this._mainForm.LastName;
						customerIndex = i;
					}
					if(((Paragraph)content).TextContent[0].Text.ToLower() == "date")
						((Paragraph)content).TextContent[0].Text = DateTime.Now.ToShortDateString();
				}
				i++;
			}
			if(customerIndex > 0)
				this.WriteCustomerAtIndex(billingDoc, customerIndex);
		}

		/// <summary>
		/// Writes the index of the customer at.
		/// </summary>
		/// <param name="billingDoc">The billing doc.</param>
		/// <param name="index">The index.</param>
		private void WriteCustomerAtIndex(TextDocument billingDoc, int index)
		{
			Paragraph p = ParagraphBuilder.CreateStandardTextParagraph(billingDoc);
			p.TextContent.Add(new SimpleText(billingDoc, this._mainForm.Street));
			billingDoc.Content.Insert(index+1, p);
			p = ParagraphBuilder.CreateStandardTextParagraph(billingDoc);
			p.TextContent.Add(new SimpleText(billingDoc, this._mainForm.City));
			billingDoc.Content.Insert(index+2, p);
			p = ParagraphBuilder.CreateStandardTextParagraph(billingDoc);
			p.TextContent.Add(new SimpleText(billingDoc, "Account ID: " + this._mainForm.AccountID));
			billingDoc.Content.Insert(index+3, p);
		}
	}
}
