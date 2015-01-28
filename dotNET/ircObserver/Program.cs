//
//  Program.cs
//
//  Copyright (c) 2011 by seeseekey <seeseekey@googlemail.com>
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.

using System;
using System.Collections.Generic;
using System.Text;
using CSCL.Network.IRC;
using System.Collections;
using CSCL.Network;
using CSCL;
using System.Timers;
using System.Threading;
using CSCL.Network;

namespace ircObserver
{
	class Program
	{
        static List<Observer> observers;

		static void Main(string[] args)
		{
			if(args.Length<1)
			{
				Console.WriteLine("Please set a config file!");
				return;
			}

            //Observer anlegen
            observers=new List<Observer>();

            foreach(string arg in args)
            {
                observers.Add(new Observer(arg));
            }

            while(true)
            {
                Thread.Sleep(1000);
            }
		}
	}
}
