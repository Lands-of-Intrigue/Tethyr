#include "te_settle_inc"


void main()
{
    object oPC = GetPCSpeaker();
    object oSettlement = OBJECT_SELF;
    string sSettlement = GetLocalString(oSettlement,"sSettlement");

    object oItem = GetFirstItemInInventory(oPC);
    string sCount;

    SetLocalInt(oPC,TRADE_FISH,0);
    SetLocalInt(oPC,TRADE_ELF,0);
    SetLocalInt(oPC,TRADE_GRAIN,0);
    SetLocalInt(oPC,TRADE_HEAL,0);
    SetLocalInt(oPC,TRADE_GARLIC,0);
    SetLocalInt(oPC,TRADE_ANTIDOTE,0);
    SetLocalInt(oPC,TRADE_BLOODSTAUNCH,0);
    SetLocalInt(oPC,TRADE_IRONBAR,0);
    SetLocalInt(oPC,TRADE_IRONINGOT,0);
    SetLocalInt(oPC,TRADE_IRONORE,0);
    SetLocalInt(oPC,TRADE_MAGIC,0);
    SetLocalInt(oPC,TRADE_MUSHROOM,0);
    SetLocalInt(oPC,TRADE_PEACH,0);
    SetLocalInt(oPC,TRADE_BELLADONNA,0);
    SetLocalInt(oPC,TRADE_BLOODPURGE,0);
    SetLocalInt(oPC,TRADE_WOLF,0);
    SetLocalInt(oPC,TRADE_SILVERBARK,0);
    SetLocalInt(oPC,TRADE_FLOUR,0);
    SetLocalInt(oPC,TRADE_CRATESHADEALE,0);
    SetLocalInt(oPC,TRADE_SHADEALE,0);
    SetLocalInt(oPC,TRADE_SKIN,0);
    SetLocalInt(oPC,TRADE_SKINSOFT,0);
    SetLocalInt(oPC,TRADE_SKINHARD,0);
    SetLocalInt(oPC,TRADE_SMUGGLE,0);
    SetLocalInt(oPC,TRADE_STONE,0);
    SetLocalInt(oPC,TRADE_WAGON,0);
    SetLocalInt(oPC,TRADE_SUPPLIES,0);

    while (oItem != OBJECT_INVALID)
    {
        //Count Barrel of Fish
        sCount = TRADE_FISH;
        if(GetTag(oItem) == sCount)
        {
            SetLocalInt(oPC,sCount,GetLocalInt(oPC,sCount)+1);
        }
        sCount = TRADE_ELF;
        if(GetTag(oItem) == sCount)
        {
            SetLocalInt(oPC,sCount,GetLocalInt(oPC,sCount)+1);
        }
        sCount = TRADE_GRAIN;
        if(GetTag(oItem) == sCount)
        {
            SetLocalInt(oPC,sCount,GetLocalInt(oPC,sCount)+1);
        }
        sCount = TRADE_HEAL;
        if(GetTag(oItem) == sCount)
        {
            SetLocalInt(oPC,sCount,GetLocalInt(oPC,sCount)+1);
        }
        sCount = TRADE_GARLIC;
        if(GetTag(oItem) == sCount)
        {
            SetLocalInt(oPC,sCount,GetLocalInt(oPC,sCount)+1);
        }
        sCount = TRADE_ANTIDOTE;
        if(GetTag(oItem) == sCount)
        {
            SetLocalInt(oPC,sCount,GetLocalInt(oPC,sCount)+1);
        }
        sCount = TRADE_BLOODSTAUNCH;
        if(GetTag(oItem) == sCount)
        {
            SetLocalInt(oPC,sCount,GetLocalInt(oPC,sCount)+1);
        }
        sCount = TRADE_IRONBAR;
        if(GetTag(oItem) == sCount)
        {
            SetLocalInt(oPC,sCount,GetLocalInt(oPC,sCount)+1);
        }
        sCount = TRADE_IRONINGOT;
        if(GetTag(oItem) == sCount)
        {
            SetLocalInt(oPC,sCount,GetLocalInt(oPC,sCount)+1);
        }
        sCount = TRADE_IRONORE;
        if(GetTag(oItem) == sCount)
        {
            SetLocalInt(oPC,sCount,GetLocalInt(oPC,sCount)+1);
        }
        sCount = TRADE_MAGIC;
        if(GetTag(oItem) == sCount)
        {
            SetLocalInt(oPC,sCount,GetLocalInt(oPC,sCount)+1);
        }
        sCount = TRADE_MUSHROOM;
        if(GetTag(oItem) == sCount)
        {
            SetLocalInt(oPC,sCount,GetLocalInt(oPC,sCount)+1);
        }
        sCount = TRADE_PEACH;
        if(GetTag(oItem) == sCount)
        {
            SetLocalInt(oPC,sCount,GetLocalInt(oPC,sCount)+1);
        }
        sCount = TRADE_BELLADONNA;
        if(GetTag(oItem) == sCount)
        {
            SetLocalInt(oPC,sCount,GetLocalInt(oPC,sCount)+1);
        }
        sCount = TRADE_BLOODPURGE;
        if(GetTag(oItem) == sCount)
        {
            SetLocalInt(oPC,sCount,GetLocalInt(oPC,sCount)+1);
        }
        sCount = TRADE_WOLF;
        if(GetTag(oItem) == sCount)
        {
            SetLocalInt(oPC,sCount,GetLocalInt(oPC,sCount)+1);
        }
        sCount = TRADE_SILVERBARK;
        if(GetTag(oItem) == sCount)
        {
            SetLocalInt(oPC,sCount,GetLocalInt(oPC,sCount)+1);
        }
        sCount = TRADE_FLOUR;
        if(GetTag(oItem) == sCount)
        {
            SetLocalInt(oPC,sCount,GetLocalInt(oPC,sCount)+1);
        }
        sCount = TRADE_CRATESHADEALE;
        if(GetTag(oItem) == sCount)
        {
            SetLocalInt(oPC,sCount,GetLocalInt(oPC,sCount)+1);
        }
        sCount = TRADE_SHADEALE;
        if(GetTag(oItem) == sCount)
        {
            SetLocalInt(oPC,sCount,GetLocalInt(oPC,sCount)+1);
        }
        sCount = TRADE_SKIN;
        if(GetTag(oItem) == sCount)
        {
            SetLocalInt(oPC,sCount,GetLocalInt(oPC,sCount)+1);
        }
        sCount = TRADE_SKINSOFT;
        if(GetTag(oItem) == sCount)
        {
            SetLocalInt(oPC,sCount,GetLocalInt(oPC,sCount)+1);
        }
        sCount = TRADE_SKINHARD;
        if(GetTag(oItem) == sCount)
        {
            SetLocalInt(oPC,sCount,GetLocalInt(oPC,sCount)+1);
        }
        sCount = TRADE_SMUGGLE;
        if(GetTag(oItem) == sCount)
        {
            SetLocalInt(oPC,sCount,GetLocalInt(oPC,sCount)+1);
        }
        sCount = TRADE_STONE;
        if(GetTag(oItem) == sCount)
        {
            SetLocalInt(oPC,sCount,GetLocalInt(oPC,sCount)+1);
        }
        sCount = TRADE_WAGON;
        if(GetTag(oItem) == sCount)
        {
            SetLocalInt(oPC,sCount,GetLocalInt(oPC,sCount)+1);
        }
        sCount = TRADE_SUPPLIES;
        if(GetTag(oItem) == sCount)
        {
            SetLocalInt(oPC,sCount,GetLocalInt(oPC,sCount)+1);
        }

        oItem = GetNextItemInInventory(oPC);

    }

    EstablishPrices(oPC);
}


