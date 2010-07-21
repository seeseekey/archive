using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace Juliette
{
	public partial class FormCategoryMover: Form
	{
		public int CategoryID=-1;
		public int DocumentID=-1;
		public DataTable ReturnDT;

		MoveMode InternalMoveMode=MoveMode.enNone;

		public enum MoveMode
		{
			enNone,
			enCategory,
			enDocument
		}

		public FormCategoryMover()
		{
			InitializeComponent();
		}

		private void btnCancel_Click(object sender, EventArgs e)
		{
			DialogResult=DialogResult.Cancel;
			Close();
		}

		/// <summary>
		/// Erzeugt den Treeview
		/// </summary>
		private void BuildTreeview()
		{
			//Treeview Bauen
			tvCategories.Nodes.Clear();
			tvCategories.BeginUpdate();

			//Datenbank Connection
			if(Globals.InstSQLite == null) return; //Wenn keine Datenbank dann return
			DataTable InstDatatable=Globals.InstSQLite.ExecuteQuery("SELECT * FROM gtjlteCategoryTree ORDER BY ParentID;");

			TreeNode tnRoot=new TreeNode("Juliette");
			tnRoot.Tag=new CustomTreeNodeData(CustomTreeNodeData.enFunction.Root);
			tnRoot.ImageIndex=0;
			tnRoot.SelectedImageIndex=0;
			tvCategories.Nodes.Add(tnRoot);
			FindAllNodesTV(InstDatatable, tnRoot, -1);

			tvCategories.Sort();
			tvCategories.Nodes[0].Expand();

			tvCategories.EndUpdate();
		}

		private void FindAllNodesTV(DataTable Table, TreeNode node, int id)
		{
			foreach(DataRow i in Table.Rows)
			{
				int ParentID=(int)(long)i["ParentID"];
				int IndexID=(int)(long)i["IndexID"];

				if(ParentID==id)
				{
					string ElementName=i["ElementName"].ToString();
					string ElementDescription=i["ElementDescription"].ToString();

					TreeNode tnLeave=new TreeNode(ElementName);
					tnLeave.Tag=new CustomTreeNodeData(CustomTreeNodeData.enFunction.Category, IndexID, ElementName, ElementDescription);
					tnLeave.ImageIndex=1;
					tnLeave.SelectedImageIndex=1;
					node.Nodes.Add(tnLeave);

					//Rekursiv Weiter
					FindAllNodesTV(Table, tnLeave, IndexID);
				}
			}
		}

		private void FormCategoryMover_Load(object sender, EventArgs e)
		{
			BuildTreeview();
		}

		private void btnOK_Click(object sender, EventArgs e)
		{
			if(tvCategories.SelectedNode==null)
			{
				MessageBox.Show("Sie haben keinen Eintrag selektiert!");
				return;
			}

			if (InternalMoveMode==MoveMode.enDocument)
			{
				//Kategorie ID ermitteln
				CustomTreeNodeData ctnData=(CustomTreeNodeData)tvCategories.SelectedNode.Tag;
				CategoryID=ctnData.ID;

				Globals.SetCategoryOfDocument(DocumentID, CategoryID);
			}
			else if (InternalMoveMode==MoveMode.enCategory)
			{
				//Kategorie ID ermitteln
				CustomTreeNodeData ctnData=(CustomTreeNodeData)tvCategories.SelectedNode.Tag;
				CategoryID=ctnData.ID;

				//DocumentID ist in diesem Fall die Alte Cat ID
				ReturnDT = Globals.SetCategoryParent(DocumentID, CategoryID);
			}

			DialogResult=DialogResult.OK;
			Close();
		}

		/// <summary>
		/// Zeigt den Dialog an
		/// </summary>
		/// <param name="mode"></param>
		/// <returns></returns>
		public DialogResult ShowDialog(MoveMode mode)
		{
			InternalMoveMode=mode;

			if (InternalMoveMode==MoveMode.enCategory)
			{
				Text="Kategorie verschieben...";
			}
			else if (InternalMoveMode==MoveMode.enDocument)
			{
				Text="Dokument in andere Kategorie verschieben...";
			}

			return base.ShowDialog();
		}
	}
}
