#include "NWNX_Area"
#include "x2_inc_toollib"


//::///////////////////////////////////////////////
//:: Example Item Event Script
//:: x2_it_example
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This is an example on how to use the
    new default module events for NWN to
    have all code concerning one item in
    a single file.

    Note that this system only works, if
    the following events set on your module

    OnEquip      - x2_mod_def_equ
    OnUnEquip    - x2_mod_def_unequ
    OnAcquire    - x2_mod_def_aqu
    OnUnAcqucire - x2_mod_def_unaqu
    OnActivate   - x2_mod_def_act

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-09-10
//:://////////////////////////////////////////////

#include "x2_inc_switches"
#include "loi_functions"
#include "nw_i0_spells"
void main()
{
    int nEvent =GetUserDefinedItemEventNumber();
    object oPC;
    object oItem;
    object oTarget;
    object oArea;
    vector vPos;
    float  fZ;
    int nX;
    int nY;

    if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
    // * This code runs when the Unique Power property of the item is used
    // * Note that this event fires PCs only
    {
        oPC   = GetItemActivator();
        oItem = GetItemActivated();
        oTarget = GetItemActivatedTarget();
        oArea = GetArea(oPC);
        vPos = GetPosition(oPC);
        fZ = vPos.z;

        nX = GetAreaSize(AREA_WIDTH,oArea);
        nY = GetAreaSize(AREA_HEIGHT,oArea);

        if(GetLocalInt(oArea,"TILEMAGIC_APPLIED") == FALSE)
        {
            SetLocalInt(oArea,"TILEMAGIC_APPLIED",TRUE);
            TLChangeAreaGroundTiles(oArea,X2_TL_GROUNDTILE_WATER,nX,nY,-2.5+fZ);
            SendMessageToPC(oPC,"Applying flood...");
        }
        else
        {
            SetLocalInt(oArea,"TILEMAGIC_APPLIED",FALSE);
            TLResetAreaGroundTilesEx(oArea);
            SendMessageToPC(oPC,"Removing flood...");
        }
    }
}
