#include "so_inc_constants"


void Diminish(object oCampfire)
{
    effect eTemp=GetFirstEffect(oCampfire);
    while(GetIsEffectValid(eTemp))
    {
        if(GetEffectType(eTemp)==EFFECT_TYPE_VISUALEFFECT)
        {
            DelayCommand(0.0,RemoveEffect(oCampfire,eTemp));
        }
        eTemp=GetNextEffect(oCampfire);
    }
    int nActivated=GetLocalInt(oCampfire,CAMP_CAMPFIRE_FIRE);
    switch(nActivated)
    {
        case 4:
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_DUR_LIGHT_ORANGE_15),oCampfire,HoursToSeconds(8));
            DelayCommand(HoursToSeconds(1),Diminish(oCampfire));
        break;
        case 3:
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_DUR_LIGHT_ORANGE_10),oCampfire,HoursToSeconds(8));
            DelayCommand(HoursToSeconds(1),Diminish(oCampfire));
        break;
        case 2:
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_DUR_LIGHT_ORANGE_5),oCampfire,HoursToSeconds(8));
            DelayCommand(HoursToSeconds(1),Diminish(oCampfire));
        break;
        case 1:
            AssignCommand(oCampfire,ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
        break;
    }
    nActivated--;
    SetLocalInt(oCampfire,CAMP_CAMPFIRE_FIRE,nActivated);
}

void FeedCampfire(object oCampfire)
{
    SetLocalInt(oCampfire,CAMP_CAMPFIRE_FIRE,4);
    effect eTemp=GetFirstEffect(oCampfire);
    while(GetIsEffectValid(eTemp))
    {
        if(GetEffectType(eTemp)==EFFECT_TYPE_VISUALEFFECT)
        {
            DelayCommand(0.0,RemoveEffect(oCampfire,eTemp));
        }
        eTemp=GetNextEffect(oCampfire);
    }
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_DUR_LIGHT_ORANGE_20),oCampfire,HoursToSeconds(8));
}

void LightCampfire(object oCampfire)
{
    AssignCommand(oCampfire,ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
    SetLocalInt(oCampfire,CAMP_CAMPFIRE_FIRE,4);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_DUR_LIGHT_ORANGE_20),oCampfire,HoursToSeconds(8));
    DelayCommand(HoursToSeconds(1),Diminish(oCampfire));
}

void ExtinguishCampfire(object oCampfire)
{
    AssignCommand(oCampfire,ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    DeleteLocalInt(oCampfire,CAMP_CAMPFIRE_FIRE);
    effect eTemp=GetFirstEffect(oCampfire);
    while(GetIsEffectValid(eTemp))
    {
        if(GetEffectType(eTemp)==EFFECT_TYPE_VISUALEFFECT)
        {
            DelayCommand(0.0,RemoveEffect(oCampfire,eTemp));
        }
        eTemp=GetNextEffect(oCampfire);
    }
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_FNF_SMOKE_PUFF),oCampfire);
    DestroyObject(GetLocalObject(oCampfire,"Sound"));
}


