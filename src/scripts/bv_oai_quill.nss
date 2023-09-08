/////////////////////////////////////////////////////////////
//Writing System by Bongo, December 2008. Quill Pen Script.//
/////////////////////////////////////////////////////////////
//This script is activated by a Quill Pen. There are four items I created to be writen on;
//Sheet of Paper, Wax-Sealed Letter, Bulletin Board Notice, & Blank Book.
//
//#Sheet of Paper has a maximum Name of 55 characters and a maximum description length of 1000 characters.
//#Wax_Sealed Letter remains without a description(max 1000 characters) untill a PC activates the letter in game,
//its Name can be set but is limited to 47 characters due to "{Opened}" being added to its name once opened.
//Activating the letter breaks the seal and it now can be read(has description). Once activated the Letter cannot be edited further.
//Wax-Sealed Letter has its own script that sets the description, "bv_oai_waxletter". Refer to "bv_oai_signet" for Seal details.
//#Bulletin Board Notices have a maximum description length of 300 characters and maximum name of 30 characters.
//This is to avoid message clutter on Bulletin Boards.
//#Blank Books have no maximum character length for their description, but a 55 character maximum name.

#include "bv_writing_inc"
#include "x2_inc_switches"

void main()
{
    // Make sure this is the OnAtivateItem event
    if (GetUserDefinedItemEventNumber() != X2_ITEM_EVENT_ACTIVATE)
    {
        return;
    }

  object oTarget = GetItemActivatedTarget();
  object oPC = GetItemActivator();
  string sTitle = GetLocalString(oPC, "#T#");
  string sMessage = GetLocalString(oPC, "#W#");
  string sCopy = GetLocalString(oPC, "#C#");
  string sPara = GetLocalString(oPC, "#E#");
  object oInk = GetItemPossessedBy(oPC, "InkWell");
  int iCharges = GetItemCharges(oInk);

  //Copying Process.
  if(GetStringLeft(sCopy, 3)=="#C#")
  {
    if(GetStringLeft(sCopy, 7)=="#C#text")
      {
      CopyText(oPC, oTarget, "#W#");
      SendMessageToPC(oPC, "You begin to copy.");
      }
    else if(GetStringLeft(sCopy, 6)=="#C#all")
      {
      CopyText(oPC, oTarget, "#T#");
      CopyText(oPC, oTarget, "#W#");
      SendMessageToPC(oPC, "You begin to copy.");
      }
    AssignCommand(oPC,PlayAnimation(ANIMATION_FIREFORGET_READ,1.0));
    DeleteLocalString(oPC,"#C#");
  }

  //If item is set as finished. You cannot edit it any further.
  else if(GetLocalString(oTarget, "Finish") == "Finished")
  {
    SendMessageToPC(oPC, "You cannot edit this any further.");
    AssignCommand(oPC,PlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD,1.0));
  }
  else
  {

    //Process for using Paragraphs, Reverse command, and Finished command.
    if((GetStringLeft(sPara, 3)=="#E#")||(GetStringLeft(sPara, 3)=="#R#")||(GetStringLeft(sPara, 3)=="#F#"))
    {
      if(GetStringLeft(sPara, 3)=="#E#")
        {
        object oActivated = GetItemActivated();
        SetParagraph(oTarget, oActivated, sPara);
        DeleteLocalString(oPC,"#E#");
        }
      //Reverse command used to undo a descriptions last update, in case of a mistake.
      else if(GetStringLeft(sPara, 3)=="#R#")
        {
        if(GetTag(oTarget)=="bv_oai_waxletter")
          {
          SetLocalString(oTarget, "LetterBody", "Reverse");
          }
        else
          {
          SetDescription(oTarget, GetLocalString(oTarget, "Reverse"), TRUE);
          }
        }
      //Finished command, set as finished so the target can no longer be edited/written on.
      else if(GetStringLeft(sPara, 3)=="#F#")
        {
        SetLocalString(oTarget, "Finish", "Finished");
        }
    AssignCommand(oPC,PlayAnimation(ANIMATION_FIREFORGET_READ,1.0));
    DeleteLocalString(oPC,"#E#");
    }

    //Does PC have an Ink Well, does it have any charges left?
    else if(iCharges != FALSE)
    {
      string sTarget = GetTag(oTarget);

      //Process for writing on paper. Is oTarget a Sheet of Paper?
      if(sTarget == "bv_oai_paper")
        {
          if(GetStringLength(sTitle) !=0)
            {
            SetTitle(oTarget, sTitle, 55);
            }
          if(GetStringLength(sMessage) !=0)
            {
            WritePaper(oTarget, sMessage, 1000);
            }
          AssignCommand(oPC,PlayAnimation(ANIMATION_FIREFORGET_READ,1.0));
          DeleteLocalString(oPC,"#T#");
          DeleteLocalString(oPC,"#W#");
          SetItemCharges(oInk, iCharges -1);
        }

      //Process for Wax-Sealed Letter, sets the text as a string on the letter.
      else if(sTarget == "bv_oai_waxletter")
        {
          //Has the letter been opened?
          if(GetLocalInt(oTarget, "Opened")==0)
            {
              if(GetStringLength(sTitle) !=0)
                {
                SetTitle(oTarget, sTitle, 47);
                }
                if(GetStringLength(sMessage) !=0)
                {
                WriteLetter(oTarget, sMessage);
                }
            }
          //You cannot edit opened letters.
          else if(GetLocalInt(oTarget, "Opened")==1)
            {
            SendMessageToPC(oPC, "This letter has been opened already.");
            }
          AssignCommand(oPC,PlayAnimation(ANIMATION_FIREFORGET_READ,1.0));
          DeleteLocalString(oPC,"#T#");
          DeleteLocalString(oPC,"#W#");
          SetItemCharges(oInk, iCharges -1);
        }

      //Process for writing Bulletins. Is oTarget a Bulletin?
      else if(sTarget == "bbs_notice")
        {
          if(GetStringLength(sTitle) !=0)
            {
            TitleBulletin(oTarget, sTitle, 30);
            }
          if(GetStringLength(sMessage) !=0)
            {
            WriteBulletin(oTarget, sMessage, 300);
            }
          AssignCommand(oPC,PlayAnimation(ANIMATION_FIREFORGET_READ,1.0));
          DeleteLocalString(oPC,"#T#");
          DeleteLocalString(oPC,"#W#");
          SetItemCharges(oInk, iCharges -1);
        }

      //Process for writing a book. Is oTarget a Blank Book?
      else if(sTarget == "bv_oai_book")
        {
          if(GetStringLength(sTitle) !=0)
            {
            SetTitle(oTarget, sTitle, 55);
            }
          if(GetStringLength(sMessage) !=0)
            {
            WriteBook(oTarget, sMessage);
            }
          AssignCommand(oPC,PlayAnimation(ANIMATION_FIREFORGET_READ,1.0));
          DeleteLocalString(oPC,"#T#");
          DeleteLocalString(oPC,"#W#");
          SetItemCharges(oInk, iCharges -1);
       }
     //Object is invalid. You cannot write on random objects.
     else
       {
       SendMessageToPC(oPC, "You cannot write on this.");
       AssignCommand(oPC,PlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD,1.0));
       }
    }

    //PC doesn't have an Ink Well.
    else
    {
    SendMessageToPC(oPC, "You have no Ink.");
    AssignCommand(oPC,PlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD,1.0));
    }

  }
}
