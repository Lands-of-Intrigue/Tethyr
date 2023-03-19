void main()
{
    int iResult;

    int nDeity = GetLocalInt(OBJECT_SELF,"nDeity");
    object oPC = GetPCSpeaker();
    object oData = GetItemPossessedBy(oPC,"PC_Data_Object");
    object oItem = GetFirstItemInInventory(oPC);
    int nPiety = GetLocalInt(oData, "nPiety");
    int nTrans = GetLocalInt(oData, "iTrans");

    if(GetHasFeat(nDeity,oPC) == FALSE) return;

    while (GetIsObjectValid(oItem) == TRUE)
    {
        if(GetTag(oItem) == "te_masidol_01")
        {
            SetLocalInt(oData,"nPiety",nPiety+5);
            DestroyObject(oItem,0.1f);
        }
        else if(GetTag(oItem) == "te_masidol_02")
        {
            SetLocalInt(oData,"nPiety",nPiety+10);
            DestroyObject(oItem,0.1f);
        }
        else if(GetTag(oItem) == "te_masidol_03")
        {
            SetLocalInt(oData,"nPiety",nPiety+15);
            DestroyObject(oItem,0.1f);
        }

        oItem = GetNextItemInInventory(oPC);
    }

    if (nTrans == 1)
    {
        SendMessageToPC(oPC,"You have transgressed against your deity and must seek divine intervention. Your maximum piety is capped at 20.");

        SetLocalInt(oData,"nPiety",nPiety+5);

        if(GetLocalInt(oData,"nPiety") >= 20)       {SetLocalInt(oData,"nPiety",20);}
        else if(GetLocalInt(oData,"nPiety") < 0)    {SetLocalInt(oData,"nPiety",0);}
    }
    else
    {
        SendMessageToPC(oPC,"You do not feel as though your actions have caught the attention of your deity.");
    }

    if(GetLocalInt(oData,"nPiety") >= 100)
    {
        SetLocalInt(oData,"nPiety",100);
    }
    else if(GetLocalInt(oData,"nPiety") <= 0)
    {
        SetLocalInt(oData,"nPiety",0);
    }

}
