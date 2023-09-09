/////////////////////////////////////////////////////////////////////
//Writing System by Bongo, December 2008. Quill Pen Include Script.//
/////////////////////////////////////////////////////////////////////

//For copying either a Description or Title.
//sVarName = #T# for Title or #W# for Description.
void CopyText(object oPC, object oTarget, string sVarName);

//Set Paragraph. Gets Paragraph from Item Activated.
//Set Description of oTarget with either 1 or 2 Spaces. sPara = #P# string.
void SetParagraph(object oTarget, object oActivated, string sPara);

//Set Title. sName is the stored chat string, aka sTitle.
//iLength is the number of the character limit.
void SetTitle(object oTarget, string sName, int iLength);

//For setting a Description. sText is the chat string stored on the PC.
//iLength is the character limit for the Description
void WritePaper(object oTarget, string sText, int iLength);

//For setting a Description. WriteBook has no character limit.
//sText is the chat string stored on the PC.
void WriteBook(object oTarget, string sText);

//Sets the Title and title string for a Bulletin Notice.
//iLength is the character limit for the title. sName is the stored chat string.
void TitleBulletin(object oTarget, string sName, int iLength);

//Sets the Description and description string for the Bulletin Notice.
//iLength is the character limit. sText is the stored chat string.
void WriteBulletin(object oTarget, string sText, int iLength);

//Sets the stored string for a Wax-Sealed Letter. The string is set as the description,
//once the letter is activated. sText is the stored chat string.
//Refer to "bv_oai_waxletter" to customise the Opened description.
void WriteLetter(object oTarget, string sText);


void CopyText(object oPC, object oTarget, string sVarName)
{
  if(sVarName=="#T#")
  {
  SetLocalString(oPC, sVarName, sVarName +GetName(oTarget, FALSE));
  }
  else if(sVarName=="#W#")
  {
  SetLocalString(oPC, sVarName, sVarName +GetDescription(oTarget, FALSE, TRUE));
  }
}

void SetParagraph(object oTarget, object oActivated, string sPara)
{
  string sSpace = GetStringRight(GetDescription(oActivated , FALSE, TRUE), 1);
  string sDescription = GetDescription(oTarget, FALSE, TRUE);
  if(GetTag(oTarget) == "bv_oai_waxletter")
    {
    string sLetter = GetLocalString(oTarget, "LetterBody");
    if(GetStringLeft(sPara, 3)=="#E#")
      {
      SetLocalString(oTarget, "LetterBody", sLetter +sSpace);
      }
    }
  else
    {
    if(GetStringLeft(sPara, 3)=="#E#")
      {
      if(GetDescription(oTarget, TRUE, TRUE)==GetDescription(oTarget, FALSE, TRUE))
        {
        SetDescription(oTarget, sSpace, TRUE);
        }
      else
        {
        SetDescription(oTarget, sDescription +sSpace, TRUE);
        }
      }
    }
}

void SetTitle(object oTarget, string sName, int iLength)
{
  int iTitle = (GetStringLength(sName)-3);
  string sTitle = GetStringRight(sName, iTitle);
  SetName(oTarget, GetStringLeft(sTitle, iLength));
}



void WritePaper(object oTarget, string sText, int iLength)
{
  int iMessage = (GetStringLength(sText)-3);
  string sMessage = GetStringRight(sText, iMessage);
  string sDescription = GetDescription(oTarget, FALSE, TRUE);
  SetLocalString(oTarget, "Reverse", sDescription);
  if (sDescription=="This is a blank sheet of paper, you can write on this using a Quill Pen and Ink Well.")
    {
    SetDescription(oTarget, GetStringLeft(sMessage, iLength), TRUE);
    }
  else
    {
    SetDescription(oTarget, GetStringLeft(sDescription+ sMessage, iLength), TRUE);
    }
}

void WriteBook(object oTarget, string sText)
{
  int iMessage = (GetStringLength(sText)-3);
  string sMessage = GetStringRight(sText, iMessage);
  string sDescription = GetDescription(oTarget, FALSE, TRUE);
  SetLocalString(oTarget, "Reverse", sDescription);
  if (sDescription=="This is a blank book, you can write in its pages using a Quill Pen and an Ink Well.")
    {
    SetDescription(oTarget, sMessage, TRUE);
    }
  else
    {
    SetDescription(oTarget, sDescription+ sMessage, TRUE);
    }
}

void TitleBulletin(object oTarget, string sName, int iLength)
{
  int iTitle = (GetStringLength(sName)-3);
  string sTitle = GetStringRight(sName, iTitle);
  SetName(oTarget, GetStringLeft(sTitle, iLength));
  SetLocalString(oTarget, "#T", GetStringLeft(sTitle, iLength));
}

void WriteBulletin(object oTarget, string sText, int iLength)
{
  int iMessage = (GetStringLength(sText)-3);
  string sMessage = GetStringRight(sText, iMessage);
  string sDescription = GetDescription(oTarget, FALSE, TRUE);
  SetLocalString(oTarget, "Reverse", sDescription);
  if (sDescription=="This is a blank bulletin board notice, you can write on it using a Quill Pen and Ink Well. You can then post it on a Bulletin Board.")
    {
    SetDescription(oTarget, GetStringLeft(sMessage, iLength), TRUE);
    SetLocalString(oTarget, "#M", GetStringLeft(sMessage, iLength));
    }
  else
    {
    SetDescription(oTarget, GetStringLeft(sDescription+ sMessage, iLength), TRUE);
    SetLocalString(oTarget, "#M", GetStringLeft(sDescription+ sMessage, iLength));
    }
}

void WriteLetter(object oTarget, string sText)
{
  int iMessage = (GetStringLength(sText)-3);
  string sMessage = GetStringRight(sText, iMessage);
  string sLetter = GetLocalString(oTarget, "LetterBody");
  SetLocalString(oTarget, "Reverse", sLetter);
  SetLocalString(oTarget, "LetterBody", sLetter + sMessage);
}
