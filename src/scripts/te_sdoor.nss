#include "loi_functions"
#include "x2_inc_spellhook"
void JumpAssociate(object i_oPC, int i_type, location lDest);

void main()
{
/*
  Spellcast Hook Code
  Added 2003-06-23 by GeorgZ
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
     object oUser = OBJECT_SELF;
     location lLoc = GetLocation(GetObjectByTag("WP_Shadow"));

    // Make the player say something on his departure (so others will now that he teleported but crashed):
    string sGoodbye = "*Vanishes in a burst of shadow...*";
    // Enter the message being send to the player when teleport starts:
    string sTeleportmessage = "Your surroundings fade as you step into the Shadow Plane...";

     if(GetPCDeadStatus(oUser) == 1 || GetLocalInt(GetArea(oUser),"DeathArea") == 1)
     {
        SendMessageToPC(oUser,"You are dead...");
     }
     else
     {
        if(GetIsPC(oUser) == FALSE || GetIsDM(oUser) == TRUE)
            {ActionJumpToLocation(lLoc);}
        else
        {
            object oFM = GetFirstFactionMember(oUser);
            // Step through the party members.
            while(GetIsObjectValid(oFM))
            {
                AssignCommand(oFM, ActionSpeakString(sGoodbye));
                SendMessageToPC(oFM, sTeleportmessage);
                AssignCommand(oFM,  DelayCommand(2.0, JumpToLocation(lLoc)));
                effect eVis = EffectLinkEffects(EffectVisualEffect(1889),EffectVisualEffect(816));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oFM,12.0f);

                // now send the players companions over as well:
                DelayCommand(2.0, JumpAssociate(oFM, ASSOCIATE_TYPE_ANIMALCOMPANION, lLoc));
                DelayCommand(2.0, JumpAssociate(oFM, ASSOCIATE_TYPE_DOMINATED, lLoc));
                DelayCommand(2.0, JumpAssociate(oFM, ASSOCIATE_TYPE_FAMILIAR, lLoc));
                DelayCommand(2.0, JumpAssociate(oFM, ASSOCIATE_TYPE_HENCHMAN, lLoc));
                DelayCommand(2.0, JumpAssociate(oFM, ASSOCIATE_TYPE_SUMMONED, lLoc));
                // Select the next member of the faction and loop.
                oFM = GetNextFactionMember(oFM);
            }
        }

    }
}

void JumpAssociate(object i_oPC, int i_type, location lDest)
{
    object oAssociate = GetAssociate(i_type, i_oPC);
    if(GetIsObjectValid(oAssociate))
        AssignCommand(oAssociate, JumpToLocation(lDest));
}

// "Teleport_Party"
// this teleport script is pre-set to teleport the whole party
// edit the "INSERT TAG HERE" below to set a new destination
// then "Save As" a different script name. Place the script where needed.
