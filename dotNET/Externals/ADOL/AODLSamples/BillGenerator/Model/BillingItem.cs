/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: BillingItem.cs,v $
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

namespace BillGenerator.Model
{
	/// <summary>
	/// Summary for BillingItem.
	/// </summary>
	public class BillingItem
	{
		private string _item;
		/// <summary>
		/// Gets or sets the item.
		/// </summary>
		/// <value>The item.</value>
		public string Item
		{
			get { return this._item; }
			set { this._item = value; }
		}

		private string _itemNo;
		/// <summary>
		/// Gets or sets the item no.
		/// </summary>
		/// <value>The item no.</value>
		public string ItemNo
		{
			get { return this._itemNo; }
			set { this._itemNo = value; }
		}

		private double _price;
		/// <summary>
		/// Gets or sets the price.
		/// </summary>
		/// <value>The price.</value>
		public double Price
		{
			get { return this._price; }
			set { this._price = value; }
		}

		/// <summary>
		/// Initializes a new instance of the <see cref="BillingItem"/> class.
		/// </summary>
		/// <param name="item">The item.</param>
		/// <param name="itemNo">The item no.</param>
		/// <param name="price">The price.</param>
		public BillingItem(string item, string itemNo, double price)
		{
			this._item = item;
			this._itemNo = itemNo;
			this._price = price;
		}

		/// <summary>
		/// Initializes a new instance of the <see cref="BillingItem"/> class.
		/// </summary>
		public BillingItem() {}
	}
}
