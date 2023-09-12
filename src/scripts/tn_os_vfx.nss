#include "x0_i0_spawncond"
//version 3/7/20 Updated by Djinn
void main()
{
    effect eBlue = ExtraordinaryEffect(EffectVisualEffect(VFX_DUR_GLOW_BLUE));
    effect eBrown = EffectVisualEffect(VFX_DUR_GLOW_BROWN);
    effect eGreen = EffectVisualEffect(VFX_DUR_GLOW_GREEN);
    effect eGrey = EffectVisualEffect(VFX_DUR_GLOW_GREY);
    effect eOrange = EffectVisualEffect(VFX_DUR_GLOW_ORANGE);
    effect ePurple = EffectVisualEffect(VFX_DUR_GLOW_PURPLE);
    effect eRed = EffectVisualEffect(VFX_DUR_GLOW_RED);
    effect eWhite = EffectVisualEffect(VFX_DUR_GLOW_WHITE);
    effect eYellow = EffectVisualEffect(VFX_DUR_GLOW_YELLOW);
    effect eLBlue = EffectVisualEffect(VFX_DUR_GLOW_LIGHT_BLUE);
    effect eLBrown = EffectVisualEffect(VFX_DUR_GLOW_LIGHT_BROWN);
    effect eLGreen = EffectVisualEffect(VFX_DUR_GLOW_LIGHT_GREEN);
    effect eLOrange = EffectVisualEffect(VFX_DUR_GLOW_LIGHT_ORANGE);
    effect eLPurple = EffectVisualEffect(VFX_DUR_GLOW_LIGHT_PURPLE);
    effect eLRed = EffectVisualEffect(VFX_DUR_GLOW_LIGHT_RED);
    effect eLYellow = EffectVisualEffect(VFX_DUR_GLOW_LIGHT_YELLOW);
    effect eIceSkin = EffectVisualEffect(VFX_DUR_ICESKIN);
    effect eFlaming = EffectVisualEffect(VFX_DUR_INFERNO_CHEST);
    effect eStone = EffectVisualEffect(VFX_DUR_PROT_STONESKIN);
    effect eWooden = EffectVisualEffect(VFX_DUR_PROT_BARKSKIN);
    effect eTentacles = EffectVisualEffect(VFX_DUR_TENTACLE);
    effect eEvil = EffectVisualEffect(VFX_DUR_PROTECTION_EVIL_MAJOR);
    effect eGood = EffectVisualEffect(VFX_DUR_PROTECTION_GOOD_MAJOR);
    effect eBardsong = EffectVisualEffect(VFX_DUR_BARD_SONG);
    effect eShadow = EffectVisualEffect(VFX_DUR_PROT_SHADOW_ARMOR);
    effect ePremo = EffectVisualEffect(VFX_DUR_PROT_PREMONITION);
    effect eSR = EffectVisualEffect(VFX_DUR_MAGIC_RESISTANCE);
    effect eDarkness = EffectVisualEffect(VFX_DUR_DARKNESS);
    effect eDeathArmor = EffectVisualEffect(VFX_DUR_DEATH_ARMOR);
    effect eElementalShield = EffectVisualEffect(VFX_DUR_ELEMENTAL_SHIELD);
    effect eFlies = EffectVisualEffect(VFX_DUR_FLIES);
    effect eGlobeMajor = EffectVisualEffect(VFX_DUR_GLOBE_INVULNERABILITY);
    effect eGlobeMinor = EffectVisualEffect(VFX_DUR_GLOBE_MINOR);
    effect eBubbles = EffectVisualEffect(VFX_DUR_BUBBLES);
    effect ePixie = EffectVisualEffect(VFX_DUR_PIXIEDUST);
    effect eSmoke = EffectVisualEffect(VFX_DUR_SMOKE);
    effect eMestil = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_POSITIVE);
    effect eTS = EffectVisualEffect(VFX_DUR_MAGICAL_SIGHT);
    effect eStatue = EffectVisualEffect(VFX_DUR_PETRIFY);
    effect eInvis = EffectVisualEffect(VFX_DUR_INVISIBILITY);
    effect eDom = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DOMINATED);
    effect eSuma = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1);
    effect eSumb = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_2);
    effect eSumc = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
    effect eSumU = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
    effect eSumG = EffectVisualEffect(VFX_FNF_SUMMON_GATE);
    effect eQuake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
    effect eStop = EffectVisualEffect(VFX_DUR_FREEZE_ANIMATION);
    effect eGhost = ExtraordinaryEffect(EffectVisualEffect(VFX_DUR_GHOST_SMOKE_2));
//    effect eConceal = EffectConcealment(50);


    if (GetLocalString(OBJECT_SELF, "Color") == "Blue")
    {ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBlue, OBJECT_SELF);}
    if (GetLocalString(OBJECT_SELF, "Color") == "Brown")
    {ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBrown, OBJECT_SELF);}
    if (GetLocalString(OBJECT_SELF, "Color") == "Green")
    {ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGreen, OBJECT_SELF);}
    if (GetLocalString(OBJECT_SELF, "Color") == "Grey")
    {
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGrey, OBJECT_SELF);
//    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eConceal, OBJECT_SELF);
    }
    if (GetLocalString(OBJECT_SELF, "Color") == "Orange")
    {ApplyEffectToObject(DURATION_TYPE_PERMANENT, eOrange, OBJECT_SELF);}
    if (GetLocalString(OBJECT_SELF, "Color") == "Purple")
    {ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePurple, OBJECT_SELF);}
    if (GetLocalString(OBJECT_SELF, "Color") == "Red")
    {ApplyEffectToObject(DURATION_TYPE_PERMANENT, eRed, OBJECT_SELF);}
    if (GetLocalString(OBJECT_SELF, "Color") == "White")
    {ApplyEffectToObject(DURATION_TYPE_PERMANENT, eWhite, OBJECT_SELF);}
    if (GetLocalString(OBJECT_SELF, "Color") == "Yellow")
    {ApplyEffectToObject(DURATION_TYPE_PERMANENT, eYellow, OBJECT_SELF);}
    if (GetLocalString(OBJECT_SELF, "Color") == "Light Blue")
    {ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLBlue, OBJECT_SELF);}
    if (GetLocalString(OBJECT_SELF, "Color") == "Light Brown")
    {ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLBrown, OBJECT_SELF);}
    if (GetLocalString(OBJECT_SELF, "Color") == "Light Green")
    {ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLGreen, OBJECT_SELF);}


    if (GetLocalString(OBJECT_SELF, "Magical Effect") == "SpellResistance")
    {ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSR, OBJECT_SELF);
    SetSpawnInCondition(NW_FLAG_FAST_BUFF_ENEMY);}
    if (GetLocalString(OBJECT_SELF, "Magical Effect") == "Invisibility")
    {ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, OBJECT_SELF);
    SetSpawnInCondition(NW_FLAG_STEALTH);}
    if (GetLocalString(OBJECT_SELF, "Magical Effect") == "Dominated")
    {ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDom, OBJECT_SELF);}
    if (GetLocalString(OBJECT_SELF, "Magical Effect") == "Premonition")
    {ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePremo, OBJECT_SELF);
    SetSpawnInCondition(NW_FLAG_FAST_BUFF_ENEMY);}
    if (GetLocalString(OBJECT_SELF, "Magical Effect") == "Teleport")
    {ApplyEffectToObject(DURATION_TYPE_INSTANT, eSumc, OBJECT_SELF);
    SetSpawnInCondition(NW_FLAG_FAST_BUFF_ENEMY);}
    if (GetLocalString(OBJECT_SELF, "Magical Effect") == "Ghost")
    {ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, OBJECT_SELF);}
    if (GetLocalString(OBJECT_SELF, "Magical Effect") == "Profane")
    {ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEvil, OBJECT_SELF);
    SetSpawnInCondition(NW_FLAG_APPEAR_SPAWN_IN_ANIMATION);}
    if (GetLocalString(OBJECT_SELF, "Magical Effect") == "Virtue")
    {ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGood, OBJECT_SELF);
    SetSpawnInCondition(NW_FLAG_APPEAR_SPAWN_IN_ANIMATION);}


    if (GetLocalString(OBJECT_SELF, "Natural Effect") == "Flies")
    {ApplyEffectToObject(DURATION_TYPE_PERMANENT, eFlies, OBJECT_SELF);}
    if (GetLocalString(OBJECT_SELF, "Natural Effect") == "Rumble")
    {ApplyEffectToObject(DURATION_TYPE_INSTANT, eQuake, OBJECT_SELF);
    SetSpawnInCondition(NW_FLAG_APPEAR_SPAWN_IN_ANIMATION);}
    if (GetLocalString(OBJECT_SELF, "Natural Effect") == "Stopped")
    {DelayCommand(3.0,ApplyEffectToObject(DURATION_TYPE_PERMANENT, eStop, OBJECT_SELF));}
//    if (GetLocalString(OBJECT_SELF, "Natural Effect") == "Incorporeal")
//    {
//        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eConceal, OBJECT_SELF);
//    }

    if (GetLocalString(OBJECT_SELF, "Skin") == "Ice")
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eIceSkin, OBJECT_SELF);
    }
    if (GetLocalString(OBJECT_SELF, "Skin") == "Statue")
    {
        SetObjectVisualTransform(OBJECT_SELF,OBJECT_VISUAL_TRANSFORM_SCALE,1.7f);
        AssignCommand(OBJECT_SELF, PlayAnimation(ANIMATION_LOOPING_CUSTOM11, 1.0, 10000.0));
        DelayCommand(6.0,ApplyEffectToObject(DURATION_TYPE_PERMANENT, eStatue, OBJECT_SELF));
    }
    if (GetLocalString(OBJECT_SELF, "Skin") == "Shadow")
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eShadow, OBJECT_SELF);
    }
    if (GetLocalString(OBJECT_SELF, "Natural Effect") == "Outsider")
    {
        SetObjectVisualTransform(OBJECT_SELF,OBJECT_VISUAL_TRANSFORM_SCALE,1.2f);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSeeInvisible(),OBJECT_SELF);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectUltravision(),OBJECT_SELF);
    }
    if (GetLocalString(OBJECT_SELF, "Natural Effect") == "Boss")
    {
        SetObjectVisualTransform(OBJECT_SELF,OBJECT_VISUAL_TRANSFORM_SCALE,1.3f);
    }
    if (GetLocalString(OBJECT_SELF, "Natural Effect") == "Baby")
    {
        SetObjectVisualTransform(OBJECT_SELF,OBJECT_VISUAL_TRANSFORM_SCALE,0.5f);
    }
    if (GetLocalString(OBJECT_SELF, "Natural Effect") == "GiantSkeleton")
    {
        SetObjectVisualTransform(OBJECT_SELF,OBJECT_VISUAL_TRANSFORM_SCALE,2.0f);
        //ApplyEffectToObject(DURATION_TYPE_PERMANENT, eFlaming, OBJECT_SELF);
    }


        ExecuteScript("nw_c2_default9", OBJECT_SELF);
}
