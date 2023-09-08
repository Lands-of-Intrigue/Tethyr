#include "nwnx_webhook"
const string WEBHOOK_KEEP_CHANNEL   = "/api/webhooks/536603660373721098/PzH5X3rZ1iqckCnI5i0Pu9tvayP1pfS4jyU3EiY1lc4YwvynNPFY_iMHj2zr9KVV-Stv/slack";

void ActionAutoCloseAndLock(object theObject)
{
    if (GetIsOpen(OBJECT_SELF))
        { ActionCloseDoor(OBJECT_SELF); }
    ActionDoCommand (SetLocked (OBJECT_SELF, TRUE));
}


void main()
{
    object oPC           = GetPCSpeaker();
    object oDoor         = OBJECT_SELF;
    object oBailiff      = GetItemPossessedBy(oPC,"te_item_8508");                           //Bailiff's Writ.
    object oBaron        = GetItemPossessedBy(oPC,"te_item_8509");                           //Baron's Writ.
    //Strings
    string sUnique       = GetLocalString(oDoor,"sUnique");                             //Unique ID for Settlement
    string sID           = GetSubString(GetPCPublicCDKey(oPC)+"_"+GetName(oPC), 0, 15); //Unique ID for player interacting to be compared to sRenter.
    string sOwner        = GetLocalString(oDoor,"sOwner");                              //Owner ID / Settlement that owns this location.
    string sBank         = GetCampaignString("Settlement",sOwner+"_sBank");             //Bank ID associated with settlement that owns this location.
    string sSetOwner     = GetCampaignString("Settlement",sOwner+"_sOwner");            //Barony that owns this Settlement and therefore this location.
    string sRenter       = GetCampaignString("Housing",sUnique+"Rent");                 //Unique ID for the player that is renting this location.
    string sName         = GetCampaignString("Housing",sUnique+"Name");                 //The Name of this location that will get printed to a key when generated.
    //Integers
    int nLockDC          = GetCampaignInt("Housing",sUnique+"Lock");                    //The DC for trying to unlock this door using Open Lock skill.
    int nDoorDC          = GetCampaignInt("Housing",sUnique+"Door");                    //The DC for trying to bust down this door using STR.
    int nState           = GetCampaignInt("Housing",sUnique+"Stat");                    //The state of this location. Is it just a door?

    int nRoll            = d20(1)+GetAbilityModifier(ABILITY_STRENGTH,oPC);

    object oItem         = GetItemPossessedBy(oPC,"PC_Data_Object");
    int    nPiety        = GetLocalInt(oItem,"nPiety");

    if(GetLevelByClass(CLASS_TYPE_PALADIN,oPC) >= 1)
    {
        SetLocalInt(oItem,"nPiety",nPiety-5);
        SendMessageToPC(oPC,"Your actions are not in accordance with your vows and your piety has fallen as a result.");
        SendMessageToPC(oPC,"Your piety has fallen to "+IntToString(nPiety-5)+" out of 100.");
    }

    if(nRoll > nDoorDC)
    {
        SendMessageToPC(oPC,"You are able to successfully bust open the door.");
        SetCampaignInt("Housing",sUnique+"Brok",1);
        ActionOpenDoor(OBJECT_SELF); //Open the Door.
        DelayCommand(180.0, ActionAutoCloseAndLock(OBJECT_SELF)); //Delay 12 seconds before auto closing and locking the door.
        AdjustReputation(oPC,oDoor,-100);
        NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_KEEP_CHANNEL,"**"+GetName(oPC)+GetPCPublicCDKey(oPC)+" ("+GetName(GetArea(oPC))+") has succeeded in breaking down door: "+sUnique+". Owner: "+sOwner+" Settlement Owner: "+sSetOwner,"KEEP SYSTEM EVENT");
    }
    else
    {
        NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_KEEP_CHANNEL,"**"+GetName(oPC)+GetPCPublicCDKey(oPC)+" ("+GetName(GetArea(oPC))+") has attempted to break down door: "+sUnique+". Owner: "+sOwner+" Settlement Owner: "+sSetOwner,"KEEP SYSTEM EVENT");
        SendMessageToPC(oPC,"You are unable to successfully bust open the door.");
    }
}
