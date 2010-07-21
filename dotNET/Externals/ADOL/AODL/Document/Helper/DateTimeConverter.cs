/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: DateTimeConverter.cs,v $
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
using System.Collections;
using System.Text;
using System.Text.RegularExpressions;

namespace AODL.Document.Helper
{
    public class DateTimeConverter
    {
        public static DateTime GetDateTimeFromString (string val)
        {
            Regex regex = new Regex(@"(?<year>\d{4})-(?<month>\d{2})-(?<day>\d{2})T(?<hour>\d{2}):(?<minute>\d{2}):(?<second>\d{2}).(?<millisecond>\d{2})");
            Match m = regex.Match(val);
            if (m.Success)
            {
                DateTime res = new DateTime(Int32.Parse(m.Groups["year"].Value),Int32.Parse(m.Groups["month"].Value), Int32.Parse(m.Groups["day"].Value), Int32.Parse(m.Groups["hour"].Value), Int32.Parse(m.Groups["minute"].Value), Int32.Parse(m.Groups["second"].Value), Int32.Parse(m.Groups["millisecond"].Value));
                return res;
            }
            return new DateTime();
        }

        public static string GetStringFromDateTime(DateTime val)
        {
            string res = String.Format("{0}-{1}-{2}T{3}:{4}:{5}.{6}", val.Year, val.Month, val.Day, val.Hour, val.Minute, val.Second, val.Millisecond);
            return res;
        }
    }
}

