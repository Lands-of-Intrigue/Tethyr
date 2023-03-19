 #include "te_functions"
 #include "x2_inc_switches"
/*

*/

int modifyRoll(int nRoll, object oPC, string sSchool);

void main()
{
if (GetUserDefinedItemEventNumber() != X2_ITEM_EVENT_ACTIVATE) return;
  object oPC = GetItemActivator();
  object oBook =  GetItemActivated();
  int nCasterLevel = TE_ArcaneCasterLevel(oPC);
  object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");
  string sSchool = GetLocalString(oBook, "School");
  int nBookLevel = GetLocalInt(oBook,"Level");
  int nDeciphered = GetLocalInt(oBook,"Deciphered");
  int nCurrentMastery = GetLocalInt(oItem, sSchool);
  SendMessageToPC(oPC, sSchool);

  // Cases for the book not working
  if (nCasterLevel <= 1){SendMessageToPC(oPC, "You are not experienced enough.");return;}
  if (nBookLevel == 2 && nCasterLevel <= 3){SendMessageToPC(oPC, "You are not experienced enough.");return;}
  if (nBookLevel == 3 && nCasterLevel <= 7){SendMessageToPC(oPC, "You are not experienced enough.");return;}
  if (nBookLevel == 4 && nCasterLevel <= 9){SendMessageToPC(oPC, "You are not experienced enough.");return;}

  if (nBookLevel * 30 <= (GetLocalInt(oItem, sSchool)))
  {
     SendMessageToPC(oPC, "Your mastery far outstrips that of this book and you can learn nothing from it.");
     return;
  }

  // start of the book effects
  if (nBookLevel == 1) // 3rd lower
  {
    int nRoll = d6(1);
    nRoll = modifyRoll(nRoll, oPC, sSchool); // applying modifyers to the roll
    SetLocalInt(oItem, sSchool, nCurrentMastery + nRoll);
    SendMessageToPC(oPC, "Your mastery in " + sSchool + " has been raised by: " + IntToString(nRoll));
    SendMessageToPC(oPC, "The tome withers away as you read it and once it has conveyed all the knowledge in it, it ceases to exist.");
    return;

  }

  if (nBookLevel == 2) //4-6th level spells
  {
    int nRoll = d6(2);
    nRoll = modifyRoll(nRoll, oPC, sSchool); // applying modifyers to the roll
    SetLocalInt(oItem, sSchool, nCurrentMastery + nRoll);
    SendMessageToPC(oPC, "The tome withers away as you read it and once it has conveyed all the knowledge in it, it ceases to exist.");
    return;
  }

  if (nBookLevel == 3) //7-9th level spells
  {
    int nRoll = d6(3);
    nRoll = modifyRoll(nRoll, oPC, sSchool); // applying modifyers to the roll
    SetLocalInt(oItem, sSchool, nCurrentMastery + nRoll);
    SendMessageToPC(oPC, "The tome withers away as you read it and once it has conveyed all the knowledge in it, it ceases to exist.");
    return;
  }

  if (nBookLevel == 4) //Artifact level powah
  {
    int nRoll = 10;
    nRoll = modifyRoll(nRoll, oPC, sSchool); // applying modifyers to the roll
    SetLocalInt(oItem, sSchool, nCurrentMastery + nRoll);
    SendMessageToPC(oPC, "The tome withers away as you read it and once it has conveyed all the knowledge in it, it ceases to exist.");
    return;
  }

}

int modifyRoll(int nRoll, object oPC, string sSchool)
{
    if (GetHasFeat(1428, oPC)) // Decipher Script Feat +4 to all schools
    {
        nRoll = nRoll + 4;
    }
    /*
    if (GetHasFeat(1466, oPC)) // High_Mage +2 to all schools
    {
        nRoll = nRoll + 2;
    }
    if (GetHasFeat(1394, oPC)) // Enlightened_Student +1 all schools
    {
        nRoll = nRoll + 1;
    }
    if (GetHasFeat(1163, oPC)) // Background_Hedgemage - All +1
    {
        nRoll = nRoll + 1;
    }
    if (GetHasFeat(1174, oPC)) // Background_Spellfire - All +2
    {
        nRoll = nRoll + 2;
    }
    if (GetHasFeat(1398, oPC)) // Talfirian_Lineage -illusion/enchantment +4
    {
        if(sSchool == "Illusion" || sSchool == "Enchantment" )
        {
            nRoll = nRoll + 4;
        }
    }
    if (GetHasFeat(1390, oPC)) // Calishite_Trained - necromancy/evocation +4
    {
        if(sSchool == "Necromancy" || sSchool == "Evocation" )
        {
            nRoll = nRoll + 4;
        }
    }
    if (GetHasFeat(1389, oPC)) // Amnian_Trained - conjuration +4
    {
        if(sSchool == "Conjuration" )
        {
            nRoll = nRoll + 4;
        }
    }*/

    return  nRoll;
}
