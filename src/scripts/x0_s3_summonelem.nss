//::///////////////////////////////////////////////
//:: Summon Huge Elemental
//:: x0_s3_summonelem
//:: Copyright (c) 2002 Floodgate Entertainment
//:://////////////////////////////////////////////
/*
    This spell is used for the various elemental-summoning
    items.
    It does not consider metamagic as it is only used for
    item properties.
*/
//:://////////////////////////////////////////////
//:: Created By: Nathaniel Blumberg
//:: Created On: 12/13/02
//:://////////////////////////////////////////////
//:: Latest Update: Djinn 4/19/20

void main()
{
    // Level 1: Belker
    // Level 2: Water Weird
    // Level 3: Xorn
    // Level 4: Flame Horror

    //Declare major variables
    object oCaster = OBJECT_SELF;
    string sResRef;
    int nLevel = GetCasterLevel(oCaster) - 4;
    float fDuration = 606.0; // Ten turns + one round

    // Figure out which creature to summon
    switch (nLevel)
    {
        case 1: sResRef = "te_summons087"; break;
        case 2: sResRef = "te_summons090"; break;
        case 3: sResRef = "te_summons093"; break;
        case 4: sResRef = "te_summons096"; break;
    }

    // 0.5 sec delay between VFX and creature creation
    effect eSummon = EffectSummonCreature(sResRef, VFX_FNF_SUMMON_MONSTER_3, 0.5);

    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), fDuration);
}
