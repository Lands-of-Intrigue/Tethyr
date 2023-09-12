//::///////////////////////////////////////////////
//:: FileName te_expulsionbook
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/27/2018 3:11:12 AM
//:://////////////////////////////////////////////
void main()
{
    // Remove some gold from the player
    TakeGoldFromCreature(1, GetPCSpeaker(), TRUE);

    // Give the speaker the items
    CreateItemOnObject("te_item_0003", GetPCSpeaker(), 1);
}
