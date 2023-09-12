/////////////////////////////////////////////////////////////////////
//Writing System by Bongo, December 2008. Cylinder Script.///////////
/////////////////////////////////////////////////////////////////////
//This script is activated when a Cylinder is used.
//It determines what type of cylinder it is,
//then creates the correct item in the players inventory.

void main()
{
  object oCylinder = GetItemActivated();
  object oPC = GetItemActivator();
  int iCharges = GetItemCharges(oCylinder);
  string sName = GetName(oCylinder, FALSE);

  if(sName=="Paper Cylinder")
  {
  CreateItemOnObject("bv_oai_paper", oPC, 1);
  }
  else if(sName=="Notice Cylinder")
  {
  CreateItemOnObject("bbs_notice", oPC, 1);
  }
  else if(sName=="Letter Cylinder")
  {
  CreateItemOnObject("bv_oai_waxletter", oPC, 1);
  }
  SetItemCharges(oCylinder, iCharges -1);
}
