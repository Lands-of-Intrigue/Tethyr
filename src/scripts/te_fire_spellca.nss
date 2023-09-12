void DouseFire(object oFire);

void main()
{
    object oFire = OBJECT_SELF;
    int nType = GetLocalInt(oFire,"Type");
    object oCaster = GetLastSpellCaster();
    int bHarmful = GetLastSpellHarmful();
    int nSpellCast = GetLastSpell();

    if(nType == 0)
    {
       if(nSpellCast == SPELL_CONE_OF_COLD ||
          nSpellCast == SPELL_ICE_DAGGER ||
          nSpellCast == 991 ||
          nSpellCast == SPELL_GUST_OF_WIND ||
          nSpellCast == 911 ||
          nSpellCast == 900 )
       {
            DouseFire(oFire);
       }
    }
    else
    {
        if(nSpellCast == SPELL_DISPEL_MAGIC ||
           nSpellCast == 911 ||
           nSpellCast == SPELL_GREATER_DISPELLING ||
           nSpellCast == SPELL_LESSER_DISPEL ||
           nSpellCast == 900 )
        {
            DouseFire(oFire);
        }
    }
}

void DouseFire(object oFire)
{
    object oSubFire = GetFirstObjectInShape(SHAPE_SPHERE,10.0f,GetLocation(oFire),FALSE,OBJECT_TYPE_PLACEABLE);
    while(GetIsObjectValid(oSubFire) == TRUE)
    {
        if(GetTag(oSubFire) == "plc_flamelarge" || GetTag(oSubFire) == "plc_flamemedium" || GetTag(oSubFire) == "plc_flamesmall" ||
           GetTag(oSubFire) == "x3_plc_flame001" || GetTag(oSubFire) == "x3_plc_flame002" || GetTag(oSubFire) == "x3_plc_flame003" )
        {
            DestroyObject(oSubFire,0.1f);
        }
        oSubFire = GetNextObjectInShape(SHAPE_SPHERE,10.0f,GetLocation(oFire),FALSE,OBJECT_TYPE_PLACEABLE);
    }
    DestroyObject(oFire,0.1f);
}
