void DestroyPortal(object oPortal);

void main()
{
    object oPortal = OBJECT_SELF;
    int nType = GetLocalInt(oPortal,"Type");
    object oCaster = GetLastSpellCaster();
    int nSpellCast = GetLastSpell();
    int nPortal = GetLocalInt(oPortal,"HP");
    int nLevel = GetLocalInt(oPortal,"Level");
    if(nSpellCast == SPELL_DISPEL_MAGIC ||
       nSpellCast == 911 ||
       nSpellCast == SPELL_GREATER_DISPELLING ||
       nSpellCast == SPELL_LESSER_DISPEL ||
       nSpellCast == 900 ||
       nSpellCast == 902 )
    {
        nPortal = nPortal +1;
        SetLocalInt(oPortal,"HP",nPortal);
        if(nLevel > 1)
        {
            SetLocalInt(oPortal,"Level",nLevel-1);
        }
        SendMessageToPC(oCaster,"The portal fluctates...You sense it weakening.");
    }
    else if(nSpellCast == 911)
    {
        SendMessageToPC(oCaster,"You are wracked with pain as the portal reflects your blast!");
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(DAMAGE_TYPE_FIRE,d6(2),DAMAGE_POWER_NORMAL),oCaster);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(DAMAGE_TYPE_MAGICAL,d6(2),DAMAGE_POWER_NORMAL),oCaster);
    }
    else
    {
        SetLocalInt(oPortal,"HP",nPortal-1);
    }

    if(nPortal >= 5)
    {
        DestroyPortal(oPortal);
    }

}

void DestroyPortal(object oPortal)
{
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_IMPLOSION),GetLocation(oPortal));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_SCREEN_SHAKE),GetLocation(oPortal));
    object oSubPortal = GetFirstObjectInShape(SHAPE_SPHERE,1.0f,GetLocation(oPortal),FALSE,OBJECT_TYPE_PLACEABLE);
    while(GetIsObjectValid(oSubPortal) == TRUE)
    {
        if(GetLocalInt(oSubPortal,"Portal") == 1)
        {
            DestroyObject(oSubPortal,0.1f);
        }
        oSubPortal = GetNextObjectInShape(SHAPE_SPHERE,1.0f,GetLocation(oPortal),FALSE,OBJECT_TYPE_PLACEABLE);
    }
    DestroyObject(oPortal,0.1f);
}
