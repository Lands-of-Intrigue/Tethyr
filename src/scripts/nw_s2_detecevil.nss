//::///////////////////////////////////////////////
//:: Detect_Evil
//:: NW_S2_DetecEvil.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    All creatures of Evil Alignment within LOS of
    the Paladin glow for a few seconds.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Aug 14, 2001
//:://////////////////////////////////////////////

void main()
{
    //Declare major variables
    object oTarget;
    int nEvil;
    object oItem;
    effect eVis = EffectVisualEffect(VFX_COM_SPECIAL_RED_WHITE);
    int nDC = 11+GetAbilityModifier(ABILITY_WISDOM,OBJECT_SELF);


    //Get first target in spell area
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
        //Check the current target's alignment
        if (GetIsPC(oTarget) == TRUE)
        {
            oItem = GetItemPossessedBy(oTarget,"PC_Data_Object");
            nEvil = GetLocalInt(oItem,"iUndead");
            if(WillSave(oTarget,nDC,SAVING_THROW_TYPE_NONE,OBJECT_SELF) == 0)
            {
                if((nEvil == 1)|| (GetHasFeat(FEAT_UNDEAD_GRAFT_1,oTarget)==TRUE))
                {
                    //Apply the VFX
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, 3.0);
                    SendMessageToPC(oTarget, "Someone nearby knows what you are!");
                    SendMessageToPC(OBJECT_SELF, GetName(oTarget,FALSE) + " is a foul undead creature!");
                }
            }
        }
        //Get next target in spell area
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }
}

