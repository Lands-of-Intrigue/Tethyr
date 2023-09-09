void main()
{
    object oPC = GetLastUsedBy();
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");

    int iEnter = GetLocalInt(oItem,"iPCEntered");
    location oLoc1 = GetLocation(GetWaypointByTag("WP_Keep1"));
    location oLoc2 = GetLocation(GetWaypointByTag("WP_Brost_Enter"));
    location oLoc3 = GetLocation(GetWaypointByTag("WP_START_UPPER"));
    location oLoc4 = GetLocation(GetWaypointByTag("WP_START_BROST"));
    if(iEnter == 1)
    {
        AssignCommand(oPC, JumpToLocation(oLoc4));
    }
    else
    {
        SetLocalInt(oItem,"iPCEntered",1);

        if(GetHasFeat(1152,oPC) == TRUE)
        {
            SendMessageToPC(oPC, "<cþ  >After several days of travel from Trailstone and the larger Riatavin, your caravan seems to come to an abrupt halt at some sort of checkpoint. Voices can be heard from muttering outside of your carriage.");
            SendMessageToPC(oPC, "<cþ  >The smell of resin, the kind used to make torches, can be sniffed on the air along with an aroma of spices and meats. Eventually, you grow bored and venture outside the carriage.");
            AssignCommand(oPC, JumpToLocation(oLoc3));
        }
        else
        {
            SendMessageToPC(oPC, "<cþ  >After several weeks of travel from Trailstone and the larger Riatavin, you approach what appears to be a well-maintained section of the road. More so than you experienced in days past.");
            SendMessageToPC(oPC, "<cþ  >The smell of resin, the kind used to make torches, can be sniffed wafting onto the road along with an aroma of spices and meats. You seem to be approaching a camp of some sort.");
            AssignCommand(oPC, JumpToLocation(oLoc2));
        }
    }

}
