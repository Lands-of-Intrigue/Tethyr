//::///////////////////////////////////////////////
//:: Apothecary
//:: TE_apoth.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Modified By: David Novotny
//:: Modified On: Feb 22, 2016
//:://////////////////////////////////////////////
void main()
{

    object oPC = OBJECT_SELF;
    /*
    string sItem;
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");
    int nNum;
    int iNow = (GetCalendarYear()*10000)+(GetCalendarMonth()*100) + GetCalendarDay();

    if (GetLocalInt(oItem,"nApothUse") < iNow)
    {
        SetLocalInt(oItem,"nApothUse",iNow);
        switch (d6(1))
        {
            case 1:
            //Antidote
            {
                string sItem = "te_item_9001";
                nNum = d4();
                CreateItemOnObject(sItem , oPC, nNum);
                break;
            }
            case 2:
            //Healing Drought
            {
                string sItem = "te_item_9002";
                nNum = d4();
                CreateItemOnObject(sItem , oPC, nNum);
                break;
            }
            case 3:
            //Restorative
            {
                string sItem = "te_item_9003";
                nNum = d4();
                CreateItemOnObject(sItem , oPC, nNum);
                break;
            }
            case 4:
            //Wolfsbane
            {
                string sItem = "te_item_9004";
                nNum = 1;
                CreateItemOnObject(sItem , oPC, nNum);
                break;
            }
            case 5:
            //Holy Water
            {
                string sItem = "te_item_9005";
                nNum = d4();
                CreateItemOnObject(sItem , oPC, nNum);
                break;
            }
            case 6:
            //Blessed Bolts
            {
                string sItem = "te_item_9008";
                nNum = 1;
                CreateItemOnObject(sItem , oPC, nNum);
                break;
            }
        }
    }
    else
    {
        SendMessageToPC(oPC,"It will require time for you to gather the materials necessary to replenish your arsenal.");
    }
    */
    SendMessageToPC(oPC,"Please use the crafting system to create all Blackcoat Apothecary and Arsenal Items.");
}
