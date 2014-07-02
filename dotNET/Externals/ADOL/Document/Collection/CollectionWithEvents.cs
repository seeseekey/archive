/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: CollectionWithEvents.cs,v $
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


using System.Collections;

namespace AODL.Document.Collections
{
	/// <summary>
	/// The events for all collections used within AODL
	/// </summary>
	public class CollectionWithEvents : CollectionBase
	{
	   // Declare the event signatures
	   /// <summary>
	   /// The collection clear delegate
	   /// </summary>
	   public delegate void CollectionClear();
	   /// <summary>
	   /// The collection change event.
	   /// </summary>
	   public delegate void CollectionChange(int index, object value);

	   // Collection change events
	   /// <summary>
	   /// The clearing event
	   /// </summary>
	   public event CollectionClear Clearing;
	   /// <summary>
	   /// The cleared event
	   /// </summary>
	   public event CollectionClear Cleared;
	   /// <summary>
	   /// The inserting event
	   /// </summary>
	   public event CollectionChange Inserting;
	   /// <summary>
	   /// The inserted event
	   /// </summary>
	   public event CollectionChange Inserted;
	   /// <summary>
	   /// The removing event
	   /// </summary>
	   public event CollectionChange Removing;
	   /// <summary>
	   /// The removed event
	   /// </summary>
	   public event CollectionChange Removed;

	   // Overrides for generating events
	   /// <summary>
	   /// Executes additional processes while deleting <see cref="T:System.Collections.CollectionBase"/>
	   /// </summary>
	   protected override void OnClear() 
	   { 
	      if (Clearing != null) Clearing(); 
	   }		

	   /// <summary>
	   /// Executes additional processes after content deleted <see cref="T:System.Collections.CollectionBase"/>
	   /// </summary>
	   protected override void OnClearComplete() 
	   { 
	      if (Cleared != null) Cleared(); 
	   }	

	   /// <summary>
	   /// Executes additional processes before deleting an object.<see cref="T:System.Collections.CollectionBase"/>
	   /// </summary>
	   /// <param name="index">Zero based index <paramref name="value"/> which should be inserted</param>
	   /// <param name="value">The new value at <paramref name="index"/>.</param>
	   protected override void OnInsert(int index, object value) 
	   {
	      if (Inserting != null) Inserting(index, value);
	   }

	   /// <summary>
	   /// Executes additional processes after inserting a new object<see cref="T:System.Collections.CollectionBase"/>
	   /// </summary>
	   /// <param name="index">Zero based index <paramref name="value"/> which should be inserted</param>
	   /// <param name="value">The new value at <paramref name="index"/>.</param>
	   protected override void OnInsertComplete(int index, object value)
	   {
	      if (Inserted != null) Inserted(index, value);
	   }

	   /// <summary>
	   /// Executes additional processes while deleting an object<see cref="T:System.Collections.CollectionBase"/>
	   /// </summary>
	   /// <param name="index">The zero based index of the object <paramref name="value"/> to delete</param>
	   /// <param name="value">The object to <paramref name="index"/> delete.</param>
	   protected override void OnRemove(int index, object value)
	   {
	      if (Removing != null) Removing(index, value);
	   }

	   /// <summary>
	   /// Executes additional processes after an object is deleted <see cref="T:System.Collections.CollectionBase"/>
	   /// </summary>
	   /// <param name="index">Th zero based index, of the object <paramref name="value"/> which was deleted</param>
	   /// <param name="value">The object <paramref name="index"/> which was deleted.</param>
	   protected override void OnRemoveComplete(int index, object value)
	   {
	      if (Removed != null) Removed(index, value);
	   }
	}

}

/*
 * $Log: CollectionWithEvents.cs,v $
 * Revision 1.2  2008/04/29 15:39:42  mt
 * new copyright header
 *
 * Revision 1.1  2007/02/25 08:58:32  larsbehr
 * initial checkin, import from Sourceforge.net to OpenOffice.org
 *
 * Revision 1.1  2006/01/29 11:29:45  larsbm
 * *** empty log message ***
 *
 * Revision 1.3  2005/11/20 17:31:20  larsbm
 * - added suport for XLinks, TabStopStyles
 * - First experimental of loading dcuments
 * - load and save via importer and exporter interfaces
 *
 * Revision 1.2  2005/10/08 08:19:25  larsbm
 * - added cvs tags
 *
 */