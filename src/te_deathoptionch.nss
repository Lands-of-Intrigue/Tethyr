//::///////////////////////////////////////////////
//:: FileName te_deathoptionch
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8/8/2016 7:42:04 PM
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iHD = GetHitDice(oPC);
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");

    int nDeathTimes = GetLocalInt(oItem,"nRespawn");


    if (iHD >=11 || nDeathTimes > 10)
    {   return FALSE;}
    else
    {   return TRUE;}
}
