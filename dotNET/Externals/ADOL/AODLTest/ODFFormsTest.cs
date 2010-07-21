/*************************************************************************
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 * 
 * Copyright 2008 by Sun Microsystems, Inc.
 *
 * OpenOffice.org - a multi-platform office productivity suite
 *
 * $RCSfile: ODFFormsTest.cs,v $
 *
 * $Revision: 1.6 $
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
using NUnit.Framework;
using System.Xml;
using AODL.Document.Content.Tables;
using AODL.Document;
using AODL.Document.TextDocuments;
using AODL.Document.Styles;
using AODL.Document.Content.Text;
using AODL.Document.Styles.MasterStyles;
using AODL.Document.Forms;
using AODL.Document.Forms.Controls;
using AODL.Document.SpreadsheetDocuments;

namespace AODLTest
{
	[TestFixture]
	public class ODFFormsTest
	{
		[Test (Description = "A test to check ODFFrame functionality")]
		public void ODFFrameTest()
		{
			//Create a new text document
			TextDocument document					= new TextDocument();
			document.New();
			
			// Create a main paragraph
			Paragraph p =new Paragraph(document);
			// Create a main form
			ODFForm main_form = new ODFForm(document, "mainform");
			main_form.Method = Method.Get;
			
			// Create a frame
			ODFFrame frm = new ODFFrame(main_form, p.Content, "frm", "5mm", "5mm", "5cm", "3cm");
			frm.Label = "ODFFrame test";
			// Add the frame to the form control list
			main_form.Controls.Add (frm);
			
			// Create a button
			ODFButton butt = new ODFButton(main_form, p.Content, "butt", "1cm", "15mm", "4cm", "1cm");
			butt.Label = "A simple button :)";
			// Add the button to the form control list
			main_form.Controls.Add (butt);

			// Add the forms to the document!
			document.Forms.Add(main_form);
			// Add the paragraph to the content list
			document.Content.Add(p);

			document.SaveTo(AARunMeFirstAndOnce.outPutFolder+"frame_test.odt");
			document.Load(AARunMeFirstAndOnce.outPutFolder+"frame_test.odt");
			document.SaveTo(AARunMeFirstAndOnce.outPutFolder+"frame_test2.odt");
		}

		[Test (Description = "A test to check nested forms functionality")]
		public void NestedFormTest()
		{
			//Create a new text document
			TextDocument document					= new TextDocument();
			document.New();
			
			// Create a main paragraph
			Paragraph p =new Paragraph(document);
			// Create a main form
			ODFForm main_form = new ODFForm(document, "mainform");
			ODFForm child_form = new ODFForm(document, "childform");

			main_form.Method = Method.Get;
			main_form.Method = Method.Get;
			
			// Create a frame
			ODFFrame frm = new ODFFrame(main_form, p.Content, "frm", "5mm", "5mm", "5cm", "3cm");
			frm.Label = "Main form";
			// Add the frame to the form control list
			main_form.Controls.Add (frm);
			
			// Create a button
			ODFButton butt = new ODFButton(main_form, p.Content, "butt", "1cm", "15mm", "4cm", "1cm");
			butt.Label = "This is a main form";
			// Add the button to the form control list
			main_form.Controls.Add (butt);

			// Add the forms to the main form!
			document.Forms.Add(main_form);
			// Add the paragraph to the content list
			document.Content.Add(p);

			
			// adding controls to the nested form
			ODFFrame frm_child = new ODFFrame(child_form, p.Content, "frm_child", "5mm", "35mm", "5cm", "3cm");
			frm_child.Label = "Child form";
			child_form.Controls.Add (frm_child);
			
			ODFButton butt_child = new ODFButton(child_form, p.Content, "butt_child", "1cm", "45mm", "4cm", "1cm");
			butt_child.Label = "This is a child form";
			child_form.Controls.Add (butt_child);
			main_form.ChildForms.Add(child_form);

			ODFButton b = document.FindControlById("butt_child") as ODFButton;
			Assert.IsNotNull(b, "Error! could not find the specified control");
			b.Label = "Child form:)";

			
			// Add the forms to the main form!
			document.Forms.Add(main_form);
            // Add the paragraph to the content list
			document.Content.Add(p);

			document.SaveTo(AARunMeFirstAndOnce.outPutFolder+"nested_forms_test.odt");
			document.Load(AARunMeFirstAndOnce.outPutFolder+"nested_forms_test.odt");
			document.SaveTo(AARunMeFirstAndOnce.outPutFolder+"nested_forms_test2.odt");
		}

		[Test (Description = "A test to check ODFHidden functionality and form submissions")]
		public void ODFHiddenAndFormActionTest()
		{
			//Create a new text document
			TextDocument document					= new TextDocument();
			document.New();
			
			// Create a main paragraph
			Paragraph p =new Paragraph(document);
			// Create a main form
			
			// Create the first form (Method = GET)
			ODFForm form1 = new ODFForm(document, "form1");
			form1.Method = Method.Get;
			form1.Href = "http://foo.foo";
			
			// Create all the controls for form1
			ODFFrame frm1 = new ODFFrame(form1, p.Content, "frm1", "5mm", "5mm", "11cm", "3cm");
			frm1.Label = "Form submission test (Method = GET, Hidden name = hid)";
			form1.Controls.Add (frm1);
			ODFButton butt1 = new ODFButton(form1, p.Content, "butt1", "2cm", "15mm", "8cm", "1cm");
			butt1.Label = "Submit to foo.foo!";
			butt1.ButtonType = ButtonType.Submit;
			butt1.Name = "butt1";
			form1.Controls.Add (butt1);
			ODFHidden hid1 = new ODFHidden(form1, p.Content, "hid1", "0cm", "0cm", "0cm", "0cm");
			hid1.Value = "hello!";
			hid1.Name = "hid1";
			form1.Controls.Add(hid1);

			// Create the second form (Method = POST)
			ODFForm form2 = new ODFForm(document, "form2");
			form2.Method = Method.Post;
			form2.Href = "http://foo.foo.2";
			ODFFrame frm2 = new ODFFrame(form2, p.Content, "frm2", "5mm", "45mm", "11cm", "3cm");
			frm2.Label = "Form submission test (Method = POST, Hidden name = hid)";
			form2.Controls.Add (frm2);
			
			// Create all the controls for form2
			ODFButton butt2 = new ODFButton(form2, p.Content, "butt2", "2cm", "55mm", "8cm", "1cm");
			butt2.Label = "Submit to foo.foo!";
			butt2.ButtonType = ButtonType.Submit;
			butt2.Name = "butt2";
			form2.Controls.Add (butt2);
			ODFHidden hid2 = new ODFHidden(form2, p.Content, "hid2", "0cm", "0cm", "0cm", "0cm");
			hid2.Value = "hello!";
			hid2.Name = "hid2";
			form2.Controls.Add (hid2);

			document.Forms.Add(form1);
			document.Forms.Add(form2);
			document.Content.Add(p);

			document.SaveTo(AARunMeFirstAndOnce.outPutFolder+"hidden_subm_test.odt");
			document.Load(AARunMeFirstAndOnce.outPutFolder+"hidden_subm_test.odt");
			document.SaveTo(AARunMeFirstAndOnce.outPutFolder+"hidden_subm_test2.odt");
		}

		[Test (Description = "A test to check ODFButton functionality")]
		public void ODFButtonTest()
		{
			// Create a new document
			TextDocument document	= new TextDocument();
			document.New();
			
			// Create a main paragraph
			Paragraph p =new Paragraph(document);
			
			// Create a main form
			ODFForm main_form = new ODFForm(document, "mainform");
			main_form.Method = Method.Get;
			
			// The first button. It doesn't get a focus on click
			ODFButton butt = new ODFButton(main_form, p.Content, "butt1", "0cm", "0mm", "4cm", "1cm");
			butt.Label = "Button one";
			butt.Title = "First button.";
			butt.FocusOnClick = XmlBoolean.False;
			butt.ButtonType = ButtonType.Push;
			main_form.Controls.Add (butt);

			// The second button. It is disabled
			butt = new ODFButton(main_form, p.Content, "butt2", "0cm", "2cm", "4cm", "1cm");
			butt.Label = "Button two";
			butt.Title = "Second button.";
			butt.FocusOnClick = XmlBoolean.True;
			butt.Disabled = XmlBoolean.True;
			main_form.Controls.Add (butt);

			// The third button with "toggle" behaviour
			butt = new ODFButton(main_form, p.Content, "butt3", "0cm", "4cm", "4cm", "1cm");
			butt.Label = "Button three";
			butt.Title = "Third button.";
			butt.Toggle = XmlBoolean.True;
			main_form.Controls.Add (butt);

			document.Forms.Add(main_form);
			document.Content.Add(p);

			// Button import/export test
			document.SaveTo(AARunMeFirstAndOnce.outPutFolder+"button_test.odt");
			document.Load(AARunMeFirstAndOnce.outPutFolder+"button_test.odt");
			document.SaveTo(AARunMeFirstAndOnce.outPutFolder+"button_test2.odt");
		}

		[Test (Description = "A test to check ODFCheckBox functionality")]
		public void ODFCheckBoxTest()
		{
			// Create a new document
			TextDocument document	= new TextDocument();
			document.New();
			
			// Create a main paragraph
			Paragraph p =new Paragraph(document);
			
			// Create a main form
			ODFForm main_form = new ODFForm(document, "mainform");
			main_form.Method = Method.Get;
			
			ODFCheckBox cb = new ODFCheckBox(main_form, p.Content, "cb1", "0cm", "0mm", "4cm", "5mm");
			cb.Label = "Checkbox 1 (flat)";
			cb.VisualEffect = VisualEffect.Flat;
			cb.IsTristate = XmlBoolean.True;
			cb.Value = "some_value";
			cb.Title = "The first checkbox";
			main_form.Controls.Add(cb);

			cb = new ODFCheckBox(main_form, p.Content, "cb2", "0cm", "5mm", "4cm", "5mm");
			cb.Label = "Checkbox 2 (3d)";
			cb.VisualEffect = VisualEffect.ThreeD;
			cb.IsTristate = XmlBoolean.False;
			cb.Value = "some_value_number_two";
			cb.Title = "The second checkbox";
			cb.CurrentState = State.Checked;
			main_form.Controls.Add(cb);

			cb = new ODFCheckBox(main_form, p.Content, "cb3", "0cm", "10mm", "4cm", "5mm");
			cb.Label = "Checkbox 3 (grayed)";
			cb.VisualEffect = VisualEffect.Flat;
			cb.IsTristate = XmlBoolean.True;
			cb.Value = "some_value_three";
			cb.Title = "The third checkbox";
			cb.CurrentState = State.Unknown;
			main_form.Controls.Add(cb);

			document.Forms.Add(main_form);
			document.Content.Add(p);

			// Button import/export test
			document.SaveTo(AARunMeFirstAndOnce.outPutFolder+"checkbox_test.odt");
			document.Load(AARunMeFirstAndOnce.outPutFolder+"checkbox_test.odt");
			document.SaveTo(AARunMeFirstAndOnce.outPutFolder+"checkbox_test2.odt");
		}

		[Test (Description = "A test to check ODFRadioButton functionality")]
		public void ODFRadioButtonTest()
		{
			// Create a new document
			TextDocument document	= new TextDocument();
			document.New();
			
			// Create a main paragraph
			Paragraph p =new Paragraph(document);
			
			// Create a main form
			ODFForm main_form = new ODFForm(document, "mainform");
			main_form.Method = Method.Get;
			
			// Create two radio buttons with the same name - they will be in one "group"
			ODFRadioButton rb = new ODFRadioButton(main_form, p.Content, "rb1", "0cm", "0mm", "4cm", "5mm");
			rb.Label = "Radio Button One";
			rb.VisualEffect = VisualEffect.Flat;
			rb.CurrentSelected = XmlBoolean.True;
			rb.Name = "radio";
			main_form.Controls.Add(rb);

			rb = new ODFRadioButton(main_form, p.Content, "rb2", "0cm", "1cm", "4cm", "5mm");
			rb.Label = "Radio Button Two";
			rb.VisualEffect = VisualEffect.ThreeD;
			rb.CurrentSelected = XmlBoolean.False;
			rb.Name = "radio";
			main_form.Controls.Add(rb);

			document.Forms.Add(main_form);
			document.Content.Add(p);

			// Button import/export test
			document.SaveTo(AARunMeFirstAndOnce.outPutFolder+"radio_test.odt");
			document.Load(AARunMeFirstAndOnce.outPutFolder+"radio_test.odt");
			document.SaveTo(AARunMeFirstAndOnce.outPutFolder+"radio_test2.odt");
		}

		[Test (Description = "A test to check ODFComboBox functionality")]
		public void ODFComboBoxTest()
		{
			// Create a new document
			TextDocument document	= new TextDocument();
			document.New();
			
			// Create a main paragraph
			Paragraph p =new Paragraph(document);
			
			// Create a main form
			ODFForm main_form = new ODFForm(document, "mainform");
			main_form.Method = Method.Get;
			
			// Create a first combo box - a drop down one 
			ODFComboBox cb = new ODFComboBox(main_form, p.Content, "cb1", "0cm", "0mm", "4cm", "6mm");
			cb.AutoComplete = XmlBoolean.True;
			cb.DropDown = XmlBoolean.True;
			cb.Title = "A test combobox number one";
			cb.Items.Add(new ODFItem(document, "Bill"));
			cb.Items.Add(new ODFItem(document, "Gates"));
			cb.Items.Add(new ODFItem(document, "Melinda"));
			cb.Items.Add(new ODFItem(document, "Gilbert"));
			cb.Items.Add(new ODFItem(document, "Bates"));
			cb.CurrentValue = "Select an item...";
			main_form.Controls.Add(cb);

			// Second combo box
			cb = new ODFComboBox(main_form, p.Content, "cb2", "0cm", "10mm", "4cm", "25mm");
			cb.AutoComplete = XmlBoolean.False;
			cb.DropDown = XmlBoolean.False;
			cb.CurrentValue = "Alt";
			cb.Title = "A test combobox number two";
			cb.Items.Add(new ODFItem(document, "Control"));
			cb.Items.Add(new ODFItem(document, "Alt"));
			cb.Items.Add(new ODFItem(document, "Delete"));
			cb.Items.Add(new ODFItem(document, "Enter"));
			cb.Items.Add(new ODFItem(document, "Escape"));
			main_form.Controls.Add(cb);


			document.Forms.Add(main_form);
			document.Content.Add(p);

			// Button import/export test
			document.SaveTo(AARunMeFirstAndOnce.outPutFolder+"combobox_test.odt");
			document.Load(AARunMeFirstAndOnce.outPutFolder+"combobox_test.odt");
			document.SaveTo(AARunMeFirstAndOnce.outPutFolder+"combobox_test2.odt");
		}

		[Test (Description = "A test to check ODFListBox functionality")]
		public void ODFListBoxTest()
		{
			// Create a new document
			TextDocument document	= new TextDocument();
			document.New();
			
			// Create a main paragraph
			Paragraph p =new Paragraph(document);
			
			// Create a main form
			ODFForm main_form = new ODFForm(document, "mainform");
			main_form.Method = Method.Get;
			
			ODFListBox lb = new ODFListBox(main_form, p.Content, "lb1", "0cm", "0mm", "4cm", "6mm");
			lb.DropDown = XmlBoolean.True;
			lb.Title = "A test listbox number one";
			lb.Options.Add(new ODFOption(document, "Bill"));
			lb.Options.Add(new ODFOption(document, "Gates"));
			lb.Options.Add(new ODFOption(document, "Melinda"));
			lb.Options.Add(new ODFOption(document, "Bates"));
			lb.Options.Add(new ODFOption(document, "Gilbert"));
			main_form.Controls.Add(lb);

			lb = new ODFListBox(main_form, p.Content, "lb2", "0cm", "10mm", "4cm", "25mm");
			lb.DropDown = XmlBoolean.False;
			lb.Title = "A test listbox number two";
			lb.Options.Add(new ODFOption(document, "Bill"));
			lb.Options.Add(new ODFOption(document, "Gates"));
			lb.Options.Add(new ODFOption(document, "Melinda"));
			lb.Options.Add(new ODFOption(document, "Bates"));
			lb.Options.Add(new ODFOption(document, "Gilbert"));
			main_form.Controls.Add(lb);


			document.Forms.Add(main_form);
			document.Content.Add(p);

			// Button import/export test
			document.SaveTo(AARunMeFirstAndOnce.outPutFolder+"listbox_test.odt");
			document.Load(AARunMeFirstAndOnce.outPutFolder+"listbox_test.odt");
			document.SaveTo(AARunMeFirstAndOnce.outPutFolder+"listbox_test2.odt");
		}

		[Test (Description = "A test for ODFFile control")]
		public void ODFFileTest()
		{
			//Create a new text document
			TextDocument document = new TextDocument();
			document.New();
			
			// Create a new paragraph
			Paragraph p =new Paragraph(document);
			
			// Create a main form
			ODFForm main_form = new ODFForm(document, "mainform");
			main_form.Method = Method.Get;
			
			// Create an ODFFile
			ODFFile file= new ODFFile(main_form, p.Content, "file", "5mm", "5mm", "5cm", "1cm");
			file.Title = "File control";
			// This control will not be printable!
			file.Printable = XmlBoolean.False;
			main_form.Controls.Add (file);
			
			document.Forms.Add(main_form);
			document.Content.Add(p);

			document.SaveTo(AARunMeFirstAndOnce.outPutFolder+"file_test.odt");
			document.Load(AARunMeFirstAndOnce.outPutFolder+"file_test.odt");
			document.SaveTo(AARunMeFirstAndOnce.outPutFolder+"file_test2.odt");
		}

		[Test (Description = "A test for ODFFixedText control")]
		public void ODFFixedTextTest()
		{
			//Create a new text document
			TextDocument document = new TextDocument();
			document.New();
			
			// Create a new paragraph
			Paragraph p =new Paragraph(document);
			
			// Create a main form
			ODFForm main_form = new ODFForm(document, "mainform");
			main_form.Method = Method.Get;
			
			// Create three different pieces of text at different positions
			ODFFixedText ft= new ODFFixedText(main_form, p.Content, "ft1", "5mm", "5mm", "5cm", "1cm");
			ft.Label = "Fixed text one";
			ft.Disabled = XmlBoolean.True;
			main_form.Controls.Add (ft);

			ft= new ODFFixedText(main_form, p.Content, "ft2", "15mm", "25mm", "5cm", "1cm");
			ft.Label = "Fixed text two";
			main_form.Controls.Add (ft);

			ft= new ODFFixedText(main_form, p.Content, "ft3", "35mm", "15mm", "5cm", "1cm");
			ft.Label = "Fixed text three";
			main_form.Controls.Add (ft);
			
			document.Forms.Add(main_form);
			document.Content.Add(p);

			document.SaveTo(AARunMeFirstAndOnce.outPutFolder+"fixedtext_test.odt");
			document.Load(AARunMeFirstAndOnce.outPutFolder+"fixedtext_test.odt");
			document.SaveTo(AARunMeFirstAndOnce.outPutFolder+"fixedtext_test2.odt");
		}

		[Test (Description = "A test for ODFFormattedText control")]
		public void ODFFormattedTextTest()
		{
			//Create a new text document
			TextDocument document = new TextDocument();
			document.New();
			
			// Create a new paragraph
			Paragraph p =new Paragraph(document);
			
			// Create a main form
			ODFForm main_form = new ODFForm(document, "mainform");
			main_form.Method = Method.Get;
			
			// Create the formatted text control. Possible value range is 0-100
			ODFFormattedText ft= new ODFFormattedText(main_form, p.Content, "ft1", "5mm", "5mm", "5cm", "1cm");
			ft.MaxValue = 100;
			ft.MinValue = 0;
			ft.Validation = XmlBoolean.True;
			ft.Title = "A very good FT control";
			ft.Name = "formatted_text";
			main_form.Controls.Add (ft);
			
			document.Forms.Add(main_form);
			document.Content.Add(p);

			document.SaveTo(AARunMeFirstAndOnce.outPutFolder+"formatted_text_test.odt");
			document.Load(AARunMeFirstAndOnce.outPutFolder+"formatted_text_test.odt");
			document.SaveTo(AARunMeFirstAndOnce.outPutFolder+"formatted_text_test2.odt");
		}

		[Test (Description = "A test for ODFTextArea control")]
		public void ODFTextAreaTest()
		{
			//Create a new text document
			TextDocument document = new TextDocument();
			document.New();
			
			// Create a new paragraph
			Paragraph p =new Paragraph(document);
			
			// Create a main form
			ODFForm main_form = new ODFForm(document, "mainform");
			main_form.Method = Method.Get;
			
			// Create the text area control
			ODFTextArea ta= new ODFTextArea(main_form, p.Content, "ft1", "5mm", "5mm", "7cm", "4cm");
			ta.Title = "Some text area";
			main_form.Controls.Add (ta);
			
			document.Forms.Add(main_form);
			document.Content.Add(p);

			document.SaveTo(AARunMeFirstAndOnce.outPutFolder+"textarea_test.odt");
			document.Load(AARunMeFirstAndOnce.outPutFolder+"textarea_test.odt");
			document.SaveTo(AARunMeFirstAndOnce.outPutFolder+"textarea_test2.odt");
		}

		[Test (Description = "A test for ODFValueRange control")]
		public void ODFValueRangeTest()
		{
			//Create a new text document
			TextDocument document = new TextDocument();
			document.New();
			
			// Create a new paragraph
			Paragraph p =new Paragraph(document);
			
			// Create a main form
			ODFForm main_form = new ODFForm(document, "mainform");
			main_form.Method = Method.Get;
			
			// Create the ODFValueRange as a scroll bar(see the contol implementation)
			ODFValueRange vr= new ODFValueRange(main_form, p.Content, "vr1", "5mm", "5mm", "7cm", "5mm");
			vr.ControlImplementation = "ooo:com.sun.star.form.component.ScrollBar";
			vr.Orientation = Orientation.Horizontal;
			vr.RepeatDelay = "PT0.50S";
			vr.MinValue = 0;
			vr.MaxValue = 100;
            vr.Title = "A scroll bar";
			vr.Properties.Add(new SingleFormProperty(document, PropertyValueType.Boolean, "LiveScroll", "true"));
			main_form.Controls.Add (vr);

			// Create the ODFValueRange as a spin button(see the contol implementation)
			vr= new ODFValueRange(main_form, p.Content, "vr2", "5mm", "2cm", "8mm", "15mm");
			vr.ControlImplementation = "ooo:com.sun.star.form.component.SpinButton";
			vr.Orientation = Orientation.Vertical;
			vr.RepeatDelay = "PT0.50S";
			vr.MinValue = 0;
			vr.MaxValue = 100;
			vr.Title = "A scroll bar";
			main_form.Controls.Add (vr);
			
			document.Forms.Add(main_form);
			document.Content.Add(p);

			document.SaveTo(AARunMeFirstAndOnce.outPutFolder+"valuerange_test.odt");
			document.Load(AARunMeFirstAndOnce.outPutFolder+"valuerange_test.odt");
			document.SaveTo(AARunMeFirstAndOnce.outPutFolder+"valuerange_test2.odt");
		}


		[Test (Description = "A test for Grid control")]
		public void ODFGridTest()
		{
			//Create a new text document
			TextDocument document = new TextDocument();
			document.New();
			
			// Create a new paragraph
			Paragraph p =new Paragraph(document);
			
			// Create a main form
			ODFForm main_form = new ODFForm(document, "mainform");
			main_form.Method = Method.Get;
			
			// Create an ODFGrid
			ODFGrid grd = new ODFGrid(main_form, p.Content, "grd", "5mm", "5mm", "7cm", "5cm");
			grd.Columns.Add(new ODFGridColumn(document, "col1", "One"));
			grd.Columns.Add(new ODFGridColumn(document, "col1", "Two"));
			grd.Columns.Add(new ODFGridColumn(document, "col1", "Three"));
			main_form.Controls.Add (grd);
			
			document.Forms.Add(main_form);
			document.Content.Add(p);

			document.SaveTo(AARunMeFirstAndOnce.outPutFolder+"grid_test.odt");
			document.Load(AARunMeFirstAndOnce.outPutFolder+"grid_test.odt");
			document.SaveTo(AARunMeFirstAndOnce.outPutFolder+"grid_test2.odt");
		}

		[Test (Description = "A test for ODFImage control")]
		public void ODFImageTest()
		{
			//Create a new text document
			TextDocument document = new TextDocument();
			document.New();
			
			// Create a new paragraph
			Paragraph p =new Paragraph(document);
			
			// Create a main form
			ODFForm main_form = new ODFForm(document, "mainform");
			main_form.Method = Method.Get;
			
			// Create an ODFGrid
			ODFImage img = new ODFImage(main_form, p.Content, "grd", "5mm", "5mm", "10cm", "6cm");
			img.ImageData = AARunMeFirstAndOnce.inPutFolder+"Eclipse_add_new_Class.jpg";
			main_form.Controls.Add (img);
			
			document.Forms.Add(main_form);
			document.Content.Add(p);

			document.SaveTo(AARunMeFirstAndOnce.outPutFolder+"image_test.odt");
			document.Load(AARunMeFirstAndOnce.outPutFolder+"image_test.odt");
			document.SaveTo(AARunMeFirstAndOnce.outPutFolder+"image_test2.odt");
		}


		[Test(Description="A test to check import/export to ODT")]
		public void SaveLoadTest()
		{
			//Create a new text document
			TextDocument document					= new TextDocument();
			document.New();
			
			Paragraph p =new Paragraph(document);
			p.StyleName = "Standard";
			ODFForm main_form = new ODFForm(document, "mainform");
			main_form.Method = Method.Get;
			ODFFrame frm = new ODFFrame(main_form, p.Content, "frm", "5mm", "5mm", "5cm", "3cm");
			frm.Label = "Save and Load test";
			main_form.Controls.Add (frm);
			
			ODFButton butt = new ODFButton(main_form, p.Content, "butt", "1cm", "15mm", "4cm", "1cm");
			butt.Label = "A simple button :)";
			main_form.Controls.Add (butt);

			document.Forms.Add(main_form);
			document.Content.Add(p);

			document.SaveTo(AARunMeFirstAndOnce.outPutFolder+"saveload.odt");

			document.Load(AARunMeFirstAndOnce.outPutFolder+"saveload.odt");
			ODFButton bt = document.FindControlById("butt") as ODFButton;
			Assert.IsNotNull(bt, "Could not find control with >butt< ID");
			bt.Label = "This label has chanhed";
			document.SaveTo(AARunMeFirstAndOnce.outPutFolder+"saveload2.odt");
			
		}

		[Test(Description="A test to check listbox and combobox implementation")]
		public void ODFListBoxAndComboBoxTest()
		{
			//Create a new text document
			TextDocument document					= new TextDocument();
			document.New();
			
			Paragraph p =new Paragraph(document);
			p.StyleName = "Standard";
			ODFForm main_form = new ODFForm(document, "mainform");
			main_form.Method = Method.Get;
			
			ODFFrame frm = new ODFFrame(main_form, p.Content, "frm", "5mm", "5mm", "5cm", "7cm");
			frm.Label = "List- and ComboBox test";
			main_form.Controls.Add (frm);
			
			ODFListBox lb = new ODFListBox(main_form, p.Content, "lb", "1cm", "15mm", "4cm", "5cm");
			lb.Options.Add(new ODFOption(document, "Charlie"));
			lb.Options.Add(new ODFOption(document, "John"));
			lb.Options.Add(new ODFOption(document, "Dieter"));
			lb.Options.Add(new ODFOption(document, "Bill"));
			lb.Options.Add(new ODFOption(document, "Oleg"));
			lb.Options.Add(new ODFOption(document, "Lars"));
			main_form.Controls.Add (lb);

			ODFComboBox cb = new ODFComboBox(main_form, p.Content, "cb", "1cm", "65mm", "4cm", "6mm");
			cb.Items.Add(new ODFItem(document, "Charlie"));
			cb.Items.Add(new ODFItem(document, "John"));
			cb.Items.Add(new ODFItem(document, "Dieter"));
			cb.Items.Add(new ODFItem(document, "Bill"));
			cb.Items.Add(new ODFItem(document, "Oleg"));
			cb.Items.Add(new ODFItem(document, "Lars"));
			cb.CurrentValue = "Please select a value...";
			cb.DropDown = XmlBoolean.True;

			main_form.Controls.Add (cb);

			document.Forms.Add(main_form);
			document.Content.Add(p);

			document.SaveTo(AARunMeFirstAndOnce.outPutFolder+"listbox_combobox.odt");
		}

		[Test(Description="Generic properties test")]
		public void GenericPropertiesTest()
		{
			//Create a new text document
			TextDocument document					= new TextDocument();
			document.New();
			
			Paragraph p =new Paragraph(document);
			p.StyleName = "Standard";
			ODFForm main_form = new ODFForm(document, "mainform");
			
			// add form:properties to the form
			main_form.Properties.Add(new SingleFormProperty(document, PropertyValueType.String, "name", "Oleg Yegorov"));
			main_form.Properties.Add(new SingleFormProperty(document, PropertyValueType.String, "comment", "ODF rulezz!"));
			main_form.Properties.Add(new SingleFormProperty(document, PropertyValueType.Boolean, "some_bool_value", "true"));
			// please check content.xml file to see that they were really added :)

			main_form.Method = Method.Get;
			ODFFrame frm = new ODFFrame(main_form, p.Content, "frm", "5mm", "5mm", "5cm", "7cm");
			frm.Label = "Generic properties test.";
			main_form.Controls.Add (frm);
			
			document.Forms.Add(main_form);
			document.Content.Add(p);

			document.SaveTo(AARunMeFirstAndOnce.outPutFolder+"generic_prop.odt");
		}

		[Test(Description="HTML export test")]
		public void HTMLExportTest()
		{
			//Create a new text document
			TextDocument document					= new TextDocument();
			document.New();
			
			Paragraph p =new Paragraph(document);
			ODFForm main_form = new ODFForm(document, "mainform");
			main_form.Method = Method.Get;
			main_form.Href="http://hello.foo.com";
			
			ODFComboBox	ccb = new ODFComboBox(main_form, p.Content, "ccb", "0mm", "0mm", "3cm", "1cm");
			ccb.Size = 5;
			ccb.DropDown = XmlBoolean.True;
			ccb.Items.Add(new ODFItem(document, "Charlie"));
			ccb.Items.Add(new ODFItem(document, "John"));
			ccb.Items.Add(new ODFItem(document, "Dieter"));
			ccb.Items.Add(new ODFItem(document, "Bill"));
			ccb.Items.Add(new ODFItem(document, "Oleg"));
			ccb.Items.Add(new ODFItem(document, "Lars"));
			main_form.Controls.Add (ccb);
			
			ODFButton butt = new ODFButton(main_form, p.Content, "butt", "5mm", "15mm", "4cm", "1cm");
			butt.Label = "A simple button :)";
			main_form.Controls.Add (butt);

			ODFCheckBox cb = new ODFCheckBox(main_form, p.Content, "cbx", "5mm", "25mm", "4cm", "5mm");
			cb.Label = "check it!";
			cb.Name = "cbx";
			cb.Value = "cbx_value";
			
			main_form.Controls.Add (cb);

			document.Forms.Add(main_form);
			document.Content.Add(p);

			Paragraph text_p = new Paragraph(document);
			text_p.TextContent.Add(new SimpleText(document, "This is a simple text content that is located in the next paragraph after the form!"));
			document.Content.Add(text_p);
			
			document.SaveTo(AARunMeFirstAndOnce.outPutFolder+"html_test.odt");
			document.SaveTo(AARunMeFirstAndOnce.outPutFolder+"html_test.html");
			
		}

		[Test(Description="Test for forms support in spreadsheet documents")]
		public void SpreadSheetFormsTest()
		{
			//Create new spreadsheet document
			SpreadsheetDocument spreadsheetDocument		= new SpreadsheetDocument();
			spreadsheetDocument.New();
			//Create a new table
			Table table					= new Table(spreadsheetDocument, "First", "tablefirst");
			//Create a new cell, without any extra styles 
			Cell cell								= table.CreateCell("cell001");
			cell.OfficeValueType					= "string";
			//Set full border
			cell.CellStyle.CellProperties.Border	= Border.NormalSolid;			
			//Add a paragraph to this cell
			Paragraph paragraph						= ParagraphBuilder.CreateSpreadsheetParagraph(
				spreadsheetDocument);
			//Add some text content
			paragraph.TextContent.Add(new SimpleText(spreadsheetDocument, "Some text"));
			//Add paragraph to the cell
			cell.Content.Add(paragraph);
			//Insert the cell at row index 2 and column index 3
			//All need rows, columns and cells below the given
			//indexes will be build automatically.
			table.RowCollection.Add(new Row(table, "Standard"));
			table.RowCollection.Add(new Row(table, "Standard"));
			table.RowCollection.Add(new Row(table, "Standard"));
			table.InsertCellAt(3, 2, cell);
			//Insert table into the spreadsheet document
			
			ODFForm main_form = new ODFForm(spreadsheetDocument, "mainform");
			main_form.Method = Method.Get;
			ODFButton butt = new ODFButton(main_form, cell.Content, "butt", "0cm", "0cm", "15mm", "8mm");
			butt.Label = "test :)";
			main_form.Controls.Add (butt);
			spreadsheetDocument.TableCollection.Add(table);
			table.Forms.Add(main_form);
			
			spreadsheetDocument.SaveTo(AARunMeFirstAndOnce.outPutFolder+"spreadsheet_forms.ods");

			SpreadsheetDocument spreadsheetDocument2		= new SpreadsheetDocument();
			spreadsheetDocument2.Load(AARunMeFirstAndOnce.outPutFolder+"spreadsheet_forms.ods");
			ODFButton b = spreadsheetDocument2.TableCollection[0].FindControlById("butt") as ODFButton;
			Assert.IsNotNull(b);
			b.Label = "it works!";
			spreadsheetDocument2.SaveTo(AARunMeFirstAndOnce.outPutFolder+"spreadsheet_forms2.ods");
		}

		[Test(Description="Test for spreadsheet import/export")]
		public void SpreadSheetImportExportTest()
		{
			//Create new spreadsheet document
			SpreadsheetDocument spreadsheetDocument		= new SpreadsheetDocument();
			spreadsheetDocument.Load(AARunMeFirstAndOnce.inPutFolder+@"bigtable.ods");
			ODFForm f = new ODFForm(spreadsheetDocument, "mainform");
			ODFButton butt = new ODFButton(f, spreadsheetDocument.TableCollection[0].RowCollection[1].CellCollection[1].Content, "butt", "5mm", "15mm", "4cm", "1cm");
			f.Controls.Add(butt);
			spreadsheetDocument.TableCollection[0].Forms.Add(f);
            spreadsheetDocument.SaveTo(AARunMeFirstAndOnce.outPutFolder+"bigtable2.ods");
		}

		[Test (Description = "Tests style support in the Forms implementation")]
		public void StyleTest()
		{
			// Create a new document
			TextDocument document	= new TextDocument();
			document.New();
			
			// Create a main paragraph
			Paragraph p =new Paragraph(document);
			
			ParagraphStyle ps1 = new ParagraphStyle(document, "style1");
			ps1.Family = "paragraph";
			ps1.TextProperties.FontName = FontFamilies.Arial;
			ps1.TextProperties.FontColor = AODL.Document.Helper.Colors.GetColor(System.Drawing.Color.Blue);
			ps1.TextProperties.Bold = "bold";
			ps1.TextProperties.FontSize = "18pt";
			document.Styles.Add(ps1);
			
			ParagraphStyle ps2 = new ParagraphStyle(document, "style2");
			ps2.Family = "paragraph";
			ps2.TextProperties.FontName = FontFamilies.CourierNew;
			ps2.TextProperties.Italic = "italic";
			ps2.TextProperties.FontSize = "14pt";
			ps2.TextProperties.Underline = "dotted";
			document.Styles.Add(ps2);

			ParagraphStyle ps3 = new ParagraphStyle(document, "style3");
			ps3.Family = "paragraph";
			ps3.TextProperties.FontName = FontFamilies.Wingdings;
			ps3.TextProperties.FontColor = AODL.Document.Helper.Colors.GetColor(System.Drawing.Color.Red);
			ps3.TextProperties.FontSize = "16pt";
			document.Styles.Add(ps3);

			// Create a main form
			ODFForm main_form = new ODFForm(document, "mainform");
			main_form.Method = Method.Get;
			
			// The first button. It doesn't get a focus on click
			ODFButton butt = new ODFButton(main_form, p.Content, "butt1", "0cm", "0mm", "7cm", "1cm");
			butt.TextStyle = ps1;
			butt.Label = "Button one";
			butt.Title = "This button uses Arial font.";
			butt.FocusOnClick = XmlBoolean.False;
			butt.ButtonType = ButtonType.Push;
			main_form.Controls.Add (butt);

			// The second button. It is disabled
			butt = new ODFButton(main_form, p.Content, "butt2", "0cm", "2cm", "7cm", "1cm");
			butt.Label = "Button two";
			butt.Title = "Second button.";
			butt.FocusOnClick = XmlBoolean.True;
			butt.Disabled = XmlBoolean.True;
			butt.TextStyle = ps2;
			main_form.Controls.Add (butt);

			// The third button with "toggle" behaviour
			butt = new ODFButton(main_form, p.Content, "butt3", "0cm", "4cm", "7cm", "1cm");
			butt.Label = "Button three";
			butt.Title = "Third button.";
			butt.Toggle = XmlBoolean.True;
			butt.TextStyle = ps3;
			main_form.Controls.Add (butt);


			
			document.Forms.Add(main_form);
			document.Content.Add(p);

	
			document.SaveTo(AARunMeFirstAndOnce.outPutFolder+"style_test.odt");
			document.Load(AARunMeFirstAndOnce.outPutFolder+"style_test.odt");
			document.SaveTo(AARunMeFirstAndOnce.outPutFolder+"style_test2.odt");
		}

		[Test (Description = "A test to check if the Controls collection can be cleared correctly")]
		public void ControlsClearTest()
		{
			// Create a new document
			TextDocument document	= new TextDocument();
			document.New();
			
			// Create a main paragraph
			Paragraph p =new Paragraph(document);
			p.TextContent.Add(new SimpleText(document, "This document should contain no controls!"));
			
			// Create a main form
			ODFForm main_form = new ODFForm(document, "mainform");
			main_form.Method = Method.Get;
			
            // The first button. It doesn't get a focus on click
			ODFButton butt = new ODFButton(main_form, p.Content, "butt1", "0cm", "0mm", "4cm", "1cm");
			butt.Label = "Button one";
			butt.Title = "First button.";
			butt.FocusOnClick = XmlBoolean.False;
			butt.ButtonType = ButtonType.Push;
			main_form.Controls.Add (butt);

			// The second button. It is disabled
			butt = new ODFButton(main_form, p.Content, "butt2", "0cm", "2cm", "4cm", "1cm");
			butt.Label = "Button two";
			butt.Title = "Second button.";
			butt.FocusOnClick = XmlBoolean.True;
			butt.Disabled = XmlBoolean.True;
			main_form.Controls.Add (butt);

			// The third button with "toggle" behaviour
			butt = new ODFButton(main_form, p.Content, "butt3", "0cm", "4cm", "4cm", "1cm");
			butt.Label = "Button three";
			butt.Title = "Third button.";
			butt.Toggle = XmlBoolean.True;
			main_form.Controls.Add (butt);

			document.Forms.Add(main_form);
			document.Content.Add(p);

			//// Clear ALL the controls in the form
			document.Forms[0].Controls.Clear();

			document.SaveTo(AARunMeFirstAndOnce.outPutFolder+"no_controls.odt");
		}

		[Test (Description = "A test to check if the Forms collection can be cleared correctly")]
		public void FormsClearTest()
		{
			// Create a new document
			TextDocument document	= new TextDocument();
			document.New();
			
			// Create a main paragraph
			Paragraph p =new Paragraph(document);
			p.TextContent.Add(new SimpleText(document, "This document should contain no forms!"));
			
			// Create a main form
			ODFForm main_form = new ODFForm(document, "mainform");
			main_form.Method = Method.Get;
			
			// The first button. It doesn't get a focus on click
			ODFButton butt = new ODFButton(main_form, p.Content, "butt1", "0cm", "0mm", "4cm", "1cm");
			butt.Label = "Button one";
			butt.Title = "First button.";
			butt.FocusOnClick = XmlBoolean.False;
			butt.ButtonType = ButtonType.Push;
			main_form.Controls.Add (butt);

			// The second button. It is disabled
			butt = new ODFButton(main_form, p.Content, "butt2", "0cm", "2cm", "4cm", "1cm");
			butt.Label = "Button two";
			butt.Title = "Second button.";
			butt.FocusOnClick = XmlBoolean.True;
			butt.Disabled = XmlBoolean.True;
			main_form.Controls.Add (butt);

			// The third button with "toggle" behaviour
			butt = new ODFButton(main_form, p.Content, "butt3", "0cm", "4cm", "4cm", "1cm");
			butt.Label = "Button three";
			butt.Title = "Third button.";
			butt.Toggle = XmlBoolean.True;
			main_form.Controls.Add (butt);

			document.Forms.Add(main_form);
			document.Content.Add(p);

			// Clear all the forms within the document!
			document.Forms.Clear();

			document.SaveTo(AARunMeFirstAndOnce.outPutFolder+"no_forms.odt");
		}

		[Test (Description = "A test to check if the Forms collection elements can be removed correctly")]
		public void FormsRemoveTest()
		{
			// Create a new document
			TextDocument document	= new TextDocument();
			document.New();
			
			// Create a main paragraph
			Paragraph p =new Paragraph(document);
			p.TextContent.Add(new SimpleText(document, "This document should contain no forms!"));
			
			// Create a main form
			ODFForm main_form = new ODFForm(document, "mainform");
			main_form.Method = Method.Get;
			
			// The first button. It doesn't get a focus on click
			ODFButton butt = new ODFButton(main_form, p.Content, "butt1", "0cm", "0mm", "4cm", "1cm");
			butt.Label = "Button one";
			butt.Title = "First button.";
			butt.FocusOnClick = XmlBoolean.False;
			butt.ButtonType = ButtonType.Push;
			main_form.Controls.Add (butt);

			// The second button. It is disabled
			butt = new ODFButton(main_form, p.Content, "butt2", "0cm", "2cm", "4cm", "1cm");
			butt.Label = "Button two";
			butt.Title = "Second button.";
			butt.FocusOnClick = XmlBoolean.True;
			butt.Disabled = XmlBoolean.True;
			main_form.Controls.Add (butt);

			// The third button with "toggle" behaviour
			butt = new ODFButton(main_form, p.Content, "butt3", "0cm", "4cm", "4cm", "1cm");
			butt.Label = "Button three";
			butt.Title = "Third button.";
			butt.Toggle = XmlBoolean.True;
			main_form.Controls.Add (butt);

			document.Forms.Add(main_form);
			document.Content.Add(p);

			// Remove the form from the document!
			document.Forms.RemoveAt(0);

			document.SaveTo(AARunMeFirstAndOnce.outPutFolder+"no_forms.odt");
		}
	}
}
