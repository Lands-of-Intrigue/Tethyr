#include "nwnx_time"
void main()
{
    effect eEcto = EffectVisualEffect(VFX_DUR_GLOW_LIGHT_GREEN);
    effect eGhost = EffectVisualEffect(VFX_DUR_GLOW_GREY);
    effect eBloody = EffectVisualEffect(VFX_DUR_GLOW_RED);
    effect eLight = EffectVisualEffect(VFX_DUR_LIGHT_PURPLE_20);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEcto, GetNearestObjectByTag("DW1_DWB"));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, GetNearestObjectByTag("DW1_DW2E"));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBloody, GetNearestObjectByTag("DW2_DW1W"));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLight, GetNearestObjectByTag("tn_harpplc"));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, GetNearestObjectByTag("tn_dw_quest_neck"));

    object oArea = GetArea(OBJECT_SELF);
    object oDoor = GetFirstObjectInArea(oArea);
    int nTimeNow = NWNX_Time_GetTimeStamp();

    while( GetIsObjectValid(oDoor) == TRUE)
    {
        int nTimestamp = GetLocalInt(oDoor,"TimeOpened");
        if(GetTag(oDoor) == "tn_dwcandle")
        {
            if(nTimestamp >= nTimeNow)
            {
                SetLocalInt(oDoor,"Active",0);
                SetLocalInt(oDoor,"TimeOpened",0);
            }
        }
        else if(GetTag(oDoor) == "tn_spookydoor")
        {
            if(nTimestamp >= nTimeNow)
            {
                SetLocalInt(oDoor,"TimeOpened",0);
                ActionCloseDoor(oDoor);
            }
        }
        oDoor = GetNextObjectInArea(oArea);
    }
}
