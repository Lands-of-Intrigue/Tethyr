///////////////////////////////////////////////////////////////
//Writing System by Bongo, December 2008. Signet Ring Script.//
///////////////////////////////////////////////////////////////
//This script is activated when a Signet Ring is used.
//It sets either a custom Seal on a letter or permanently on the Signet Ring.
//It also sets a colour for the Seal text.

#include "x3_inc_string"

void main()
{
  object oSignet = GetItemActivated();
  object oTarget = GetItemActivatedTarget();
  object oPC = GetItemActivator();
  string sSignet = GetLocalString(oPC, "#S#");
  object oWax = GetItemPossessedBy(oPC, "SealingWax");
  string sDefault = "This is a signet ring. It is used to stamp a Wax-Sealed Letter.";
  string sDescription = GetDescription(oSignet, FALSE, TRUE);
  int iCharges = GetItemCharges(oWax);

  //Does the PC have Sealing Wax with charges?
  if(iCharges != FALSE)
  {

    //Is the Target a Letter?
    if(GetTag(oTarget)=="bv_oai_waxletter")
    {
      //Has the Letter been opened?
      if(GetLocalInt(oTarget, "Opened")==0)
      {
        int iSeal = (GetStringLength(sSignet)-3);
        string sSeal = GetStringRight(sSignet, iSeal);
        //Does the letter has its default description?
        if (GetDescription(oTarget, FALSE, TRUE)=="This is a letter sealed with wax, you can write on this and seal it using Sealing Wax and a Signet Ring.")
        {
          //Set the Colours.
          string sColour;
          string sWaxColour;
          string sWaxName = GetName(oWax, FALSE);
          if(sWaxName == "Orange Wax"){sWaxColour = "750";}
          else if(sWaxName == "Light Green Wax"){sWaxColour = "570";}
          else if(sWaxName == "Grey Wax"){sWaxColour = "555";}
          else if(sWaxName == "Cyan Wax"){sWaxColour = "055";}
          else if(sWaxName == "Purple Wax"){sWaxColour = "505";}
          else if(sWaxName == "Yellow Wax"){sWaxColour = "760";}
          else if(sWaxName == "Blue Wax"){sWaxColour = "005";}
          else if(sWaxName == "Green Wax"){sWaxColour = "050";}
          else if(sWaxName == "Red Wax"){sWaxColour = "500";}
          else if(sWaxName == "Rose Wax"){sWaxColour = "755";}
          //Is the description of the Signet Ring the default one? If yes, use the #S# chat string.
          if(sDescription==sDefault)
            {
            int iSeal = (GetStringLength(sSignet)-3);
            string sSeal = GetStringRight(sSignet, iSeal);
            sColour = StringToRGBString(sSeal, sWaxColour);
            SetDescription(oTarget, GetStringLeft(sColour, 200), TRUE);
            }
          //Has a permanent seal been set on the signet ring? If yes, use that.
          if(sDescription!=sDefault)
            {
            sColour = StringToRGBString(sDescription, sWaxColour);
            SetDescription(oTarget, GetStringLeft(sColour, 200), TRUE);
            }
          SetItemCharges(oWax, iCharges -1);
        }
        //You cannot change the seal once its been set.
        else
          {
          SendMessageToPC(oPC, "This letter has already been sealed.");
          AssignCommand(oPC,PlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD,1.0));
          }
      }
      //Letter has been opened, you cannot set its seal.
      else if(GetLocalInt(oTarget, "Opened")==1)
      {
      SendMessageToPC(oPC, "This letter has been opened already.");
      AssignCommand(oPC,PlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD,1.0));
      }
    }

    //Was the Signet Ring used on itself?
    else if(GetTag(oTarget)=="bv_oai_signet")
    {
      //Is the Signet Rings description the default one? If yes, set new description as its Seal.
      if (sDescription==sDefault)
        {
          int iSeal = (GetStringLength(sSignet)-3);
          string sSeal = GetStringRight(sSignet, iSeal);
          SetDescription(oTarget, GetStringLeft(sSeal, 200), TRUE);
        }
      //You cannot alter a Rings permanent seal once its set.
      else
        {
        SendMessageToPC(oPC, "The Signet has already been set.");
        AssignCommand(oPC,PlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD,1.0));
        }
    }
  DeleteLocalString(oPC, "#S#");
  }
  //PC has no Sealing wax.
  else if (GetTag(oTarget) != "bv_oai_signet" && GetTag(oTarget) != "bv_oai_waxletter" && GetTag(oTarget) != "")
  {
  SendMessageToPC(oPC, "You have no Wax");
  AssignCommand(oPC,PlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD,1.0));
  }
  else
  {}

}
