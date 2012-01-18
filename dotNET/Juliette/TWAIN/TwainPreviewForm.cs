//
//  TwainPreviewForm.cs
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
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace Juliette.Graphic.TWAIN
{
	internal partial class TwainPreviewForm : Form
	{
		#region Controller
		/// <summary>
		/// The internal twain controller for the communication with the twain interface.
		/// </summary>
		private InternalTwainController controller;
		/// <summary>
		/// The internal twain controller for the communication with the twain interface.
		/// </summary>
		public InternalTwainController Controller
		{
			get
			{
				return controller;
			}
		}
		#endregion

		#region TwainPreviewForm
		/// <summary>
		/// Constructor creating the internal controller that is necessary to cooperate with
		/// the twain interface.
		/// </summary>
		public TwainPreviewForm()
		{
			InitializeComponent();
			this.Load += new EventHandler(TwainHiddenForm_Load);
			controller = new InternalTwainController(this);
			controller.ScanningFinished += new EventHandler(Controller_ScanningFinished);
		}
		#endregion

		#region Controller_ScanningFinished
		/// <summary>
		/// Closes the form the associated thread and the message loop it runs in after
		/// all data has been acquired from the twainsource
		/// </summary>
		/// <param name="sender">InternalTwainController fireing this event</param>
		/// <param name="e">Parameters for the event</param>
		void Controller_ScanningFinished(object sender, EventArgs e)
		{
			if (InvokeRequired)
			{
				this.Invoke(
					new EventHandler(Controller_ScanningFinished),
					new object[] { sender, e });
			}
			else
			{
				this.Close();
			}
		}
		#endregion

		#region TwainHiddenForm_Load
		/// <summary>
		/// When the form comes up, controlled by a TwainController-Object data is acquired
		/// from the current twain source. This must be done this way. Doing this in the constructur
		/// can result in cross thread accessing or in a non existing message loop. Because of the from
		/// beiing created in the Application.Run(new TwainHiddenForm) statement. Another case is, that
		/// the form never is meant to show, e.g. Select ().
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		void TwainHiddenForm_Load(object sender, EventArgs e)
		{
			controller.Acquire();
		}
		#endregion
	}
}
