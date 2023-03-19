/////////////////////////////////////////////////////////////////////
//Writing System by Bongo, December 2008. OnPlayerChat Script.///////
/////////////////////////////////////////////////////////////////////
//This script stores players chat messages as string when the commands are used.

void main()
{
  object oPC = GetPCChatSpeaker();
  string sSpoken = GetPCChatMessage();

  if(GetStringLeft(sSpoken, 1)=="#")
  {
    string sCommand = GetStringLeft(sSpoken, 3);
    if((sCommand=="#T#")||(sCommand=="#W#")||(sCommand=="#S#")||(sCommand=="#C#"))
      {
        string sIdentity = GetStringLeft(sSpoken, 3);
        DeleteLocalString(oPC, sIdentity);
        DeleteLocalString(oPC, "#E#");
        DelayCommand(0.5, SetLocalString(oPC, sIdentity, sSpoken));
        SendMessageToPC(oPC, sSpoken);
        SetPCChatMessage(sSpoken ="");
      }

    else if((sCommand=="#E#")||(sCommand=="#R#")||(sCommand=="#F#"))
      {
        DeleteLocalString(oPC, "#E#");
        DelayCommand(0.5, SetLocalString(oPC, "#E#", sSpoken));
        SendMessageToPC(oPC, sSpoken);
        SetPCChatMessage(sSpoken ="");
      }
  }
}
