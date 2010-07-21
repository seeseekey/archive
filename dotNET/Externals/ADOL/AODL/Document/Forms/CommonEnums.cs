/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: CommonEnums.cs,v $
 *
 * $Revision: 1.4 $
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

namespace AODL.Document
{
	public enum XmlBoolean {True,False,NotSet};
}

namespace AODL.Document.Forms
{
	public enum TargetFrame {Self, Blank, Parent, Top, NotSet};
	public enum Method {Get,Post,NotSet};
	public enum CommandType {Table,Query,Command,NotSet};
	public enum NavigationMode {None,Current,Parent,NotSet};
	public enum TabCycle {Records,Current,Page,NotSet};
	public enum PropertyValueType {Float, Percentage, Currency, Date, Time, Boolean, String, NotSet};	
	public enum ListSourceType {Table, Query, Sql, SqlPassThrough, ValueList, TableFields, NotSet};	

	public enum VisualEffect {Flat, ThreeD, NotSet};
	public enum ImagePosition {Start, End, Top, Bottom, NotSet}
	public enum ImageAlign {Start, Center, End, NotSet}
	public enum State {Unchecked, Checked, Unknown, NotSet}
	public enum Orientation {Horizontal, Vertical, NotSet};
	public enum ButtonType {Submit, Reset, Push, Url, NotSet};
}
