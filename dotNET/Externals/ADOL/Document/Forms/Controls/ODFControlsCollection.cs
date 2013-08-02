/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: ODFControlsCollection.cs,v $
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
using System.Xml;
using AODL.Document.Collections;
using AODL.Document.Forms.Controls;
using AODL.Document.Forms;

namespace AODL.Document.Forms.Controls
{
	/// <summary>
	/// Summary description for ODFControlsCollection.
	/// </summary>
	public class ODFControlsCollection: CollectionWithEvents
	{
		/// <summary>
		/// Looks up a specific control by its id
		/// </summary>
		/// <param name="id">Control ID</param>
		/// <returns></returns>
		public AODL.Document.Forms.Controls.ODFFormControl FindControlById(string id)
		{
			foreach (ODFFormControl fc in base.List)
			{
				if (fc.ID == id)
					return fc;
			}
			return null;
		}
		
		/// <summary>
		/// Adds the specified control
		/// </summary>
		/// <param name="value">Control to be added</param>
		/// <returns></returns>
		public int Add(AODL.Document.Forms.Controls.ODFFormControl value)
		{
			return base.List.Add(value as object);
		}

		/// <summary>
		/// Removes the specified control.
		/// </summary>
		/// <param name="value">The control.</param>
		public void Remove(AODL.Document.Forms.Controls.ODFFormControl value)
		{
			base.List.Remove(value as object);
		}

		/// <summary>
		/// Inserts a control at the specified index.
		/// </summary>
		/// <param name="index">The index.</param>
		/// <param name="value">The value.</param>
		public void Insert(int index, AODL.Document.Forms.Controls.ODFFormControl value)
		{
			base.List.Insert(index, value as object);
		}

		/// <summary>
		/// Determines whether the collection contains the specified control.
		/// </summary>
		/// <param name="value">The control.</param>
		/// <returns>
		/// 	<c>true</c> if [contains] [the specified value]; otherwise, <c>false</c>.
		/// </returns>
		public bool Contains(AODL.Document.Forms.Controls.ODFFormControl value)
		{
			return base.List.Contains(value as object);
		}

		/// <summary>
		/// Gets the control at the specified index.
		/// </summary>
		/// <value>Index</value>
		public AODL.Document.Forms.Controls.ODFFormControl this[int index]
		{
			get { return (base.List[index] as AODL.Document.Forms.Controls.ODFFormControl); }
		}
	
	}
}
