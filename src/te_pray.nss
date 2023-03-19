#include "nwnx_time"

void main()
{
    object oPC = GetPCSpeaker();
    object oShrine = OBJECT_SELF;
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");
    int nPiety = GetLocalInt(oItem,"nPiety");
    int nTimeNow = NWNX_Time_GetTimeStamp();
    int nNextPray = GetLocalInt(oItem,"nNextPray");
    int nTrans = GetLocalInt(oItem, "iTrans");

    AssignCommand(oPC, PlayAnimation(ANIMATION_LOOPING_WORSHIP, 1.0, 10000.0));

    if(nTimeNow > nNextPray && nTrans != 1)
    {
        if(GetLevelByClass(CLASS_TYPE_MONK,oPC) > 1)
        {
            SetLocalInt(oItem,"nPiety",nPiety+10);
            SetLocalInt(oItem,"KiLevel",50);
        }
        else
        {
            SetLocalInt(oItem,"nPiety",nPiety+5);
        }

        SetLocalInt(oItem,"nNextPray",nTimeNow+86400);
        SendMessageToPC(oPC,"You offer words of praise to your deity.");
    }
    else if (nTrans == 1)
    {
        SendMessageToPC(oPC,"You have transgressed against your deity and must seek divine intervention. Your maximum piety is capped at 20.");

        SetLocalInt(oItem,"nPiety",nPiety+5);

        if(GetLocalInt(oItem,"nPiety") >= 20)       {SetLocalInt(oItem,"nPiety",20);}
        else if(GetLocalInt(oItem,"nPiety") < 0)    {SetLocalInt(oItem,"nPiety",0);}
    }
    else
    {
        SendMessageToPC(oPC,"You do not feel as though your actions have caught the attention of your deity.");
    }

    if(GetLocalInt(oItem,"nPiety") >= 100)
    {
        SetLocalInt(oItem,"nPiety",100);
    }
    else if(GetLocalInt(oItem,"nPiety") <= 0)
    {
        SetLocalInt(oItem,"nPiety",0);
    }

}
