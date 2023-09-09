/////////////////////////////////////////////////////////////////////
//Writing System by Bongo, December 2008. Wax-Sealed Letter Script.//
/////////////////////////////////////////////////////////////////////
//This script is activated when a Wax-Sealed Letter is used(Opened).
//It sets the description of the Letter so it can now be read.
//Its sets the title as [Opened]+Name.
//If a custom seal is set on the letter it sets the Seal in the description aswell.

void main()
{
  object oPC = GetItemActivator();
  object oLetter = GetItemActivated();
  string sDescript = GetLocalString(oLetter, "LetterBody");
  string sSeal = GetDescription(oLetter, FALSE, TRUE);

  //Is the item activated a letter?
  if(GetTag(oLetter)=="bv_oai_waxletter")
    {
      //Has the letter been opened already?
      if(GetLocalInt(oLetter, "Opened")==0)
      {
        //Is the Letters description the default one? If so, ignore it.
        if(sSeal == "This is a letter sealed with wax, you can write on this and seal it using Sealing Wax and a Signet Ring.")
          {
          SetDescription(oLetter, GetStringLeft(sDescript, 1000), TRUE);
          SetName(oLetter, "[Opened]" +GetName(oLetter, FALSE));
          SetLocalInt(oLetter, "Opened", 1);
          }
        //If the letters description has been changed(Sealed), set it in the description aswell.
        else
          {
          SetDescription(oLetter, sSeal +GetStringLeft(sDescript, 1000), TRUE);
          SetName(oLetter, "[Opened]" +GetName(oLetter, FALSE));
          SetLocalInt(oLetter, "Opened", 1);
          }
      AssignCommand(oPC,PlayAnimation(ANIMATION_FIREFORGET_READ,1.0));
      }
      //You cannot open a letter twice.
      else
      {
        SendMessageToPC(oPC, "This letter has been opened already.");
        AssignCommand(oPC,PlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD,1.0));
      }
    }
}
