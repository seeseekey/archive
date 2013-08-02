/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: VariableDeclCollection.cs,v $
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
using AODL.Document.Collections;
using System.Xml;


namespace AODL.Document.Content.Fields
{
    /// <summary>
    /// A typed IContent Collection.
    /// </summary>
    public class VariableDeclCollection : CollectionWithEvents
    {
        /// <summary>
        /// Adds the specified form property to the collection.
        /// </summary>
        /// <param name="value">The variable declaration to be added.</param>
        /// <returns></returns>
        public int Add(VariableDecl value)
        {
            return base.List.Add(value as object);
        }

        /// <summary>
        /// Removes the specified variable declaration from the collection
        /// </summary>
        /// <param name="value">The variable declaration to be deleted.</param>
        public void Remove(VariableDecl value)
        {
            base.List.Remove(value as object);
        }

        /// <summary>
        /// Inserts the specified variable declaration at the specified index
        /// </summary>
        /// <param name="index">The index.</param>
        /// <param name="value">The variable declaration.</param>
        public void Insert(int index, VariableDecl value)
        {
            base.List.Insert(index, value as object);
        }

        /// <summary>
        /// Determines whether the collection contains the given variable declaration
        /// </summary>
        /// <param name="value">The variable declaration.</param>
        public bool Contains(VariableDecl value)
        {
            return base.List.Contains(value as object);
        }

        /// <summary>
        /// Gets the variable declaration at the specified index.
        /// </summary>
        /// <value>Index</value>
        public VariableDecl this[int index]
        {
            get { return (base.List[index] as VariableDecl); }
        }

        /// <summary>
        /// Gets a variable declaration by its name
        /// </summary>
        /// <param name="name">Name</param>
        /// <returns>Variable declaration, null if not found</returns>
        public VariableDecl GetVariableDeclByName(string name)
        {
            foreach (VariableDecl vd in base.List)
            {
                if (vd.Name == name)
                    return vd;
            }
            return null;
        }
    }
}


