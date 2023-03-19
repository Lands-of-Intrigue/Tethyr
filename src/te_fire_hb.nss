void DouseFire(object oFire);
void main()
{
    object oFire = OBJECT_SELF;
    object oPC;
    int nWet  = GetLocalInt(oFire,"Wet");
    int nType = GetLocalInt(oFire,"Type");
    int nWeather = GetWeather(GetArea(oFire));
    float fDist;

    if(nType == 0)
    {
        if(nWet >= 100)
        {
            DouseFire(oFire);
            return;
        }

        if(nWeather == WEATHER_RAIN || nWeather == WEATHER_SNOW)
        {
            SetLocalInt(oFire,"Wet",nWet+1);
        }
    }

    oPC = GetFirstObjectInShape(SHAPE_SPHERE,10.0f,GetLocation(oFire),FALSE,OBJECT_TYPE_CREATURE);
    while(GetIsObjectValid(oPC) == TRUE)
    {
        fDist = 0.0f;
        fDist = GetDistanceBetween(oPC,oFire);
        if(GetRacialType(oPC) != RACIAL_TYPE_DRAGON)
        {
            if(nType == 0)
            {
                if(fDist < 5.0)
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d4(2),DAMAGE_TYPE_FIRE,DAMAGE_POWER_NORMAL),oPC);
                    SendMessageToPC(oPC,"You are very close to the heat of the flames!");
                }
                if(fDist >= 5.0)
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d4(1),DAMAGE_TYPE_FIRE,DAMAGE_POWER_NORMAL),oPC);
                    SendMessageToPC(oPC,"You are close to the heat of the flames!");
                }
            }
            else
            {
                if(fDist < 5.0)
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d4(4),DAMAGE_TYPE_FIRE,DAMAGE_POWER_NORMAL),oPC);
                    SendMessageToPC(oPC,"You are very close to the heat of the flames!");
                }
                if(fDist >= 5.0)
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d4(2),DAMAGE_TYPE_FIRE,DAMAGE_POWER_NORMAL),oPC);
                    SendMessageToPC(oPC,"You are close to the heat of the flames!");
                }
            }
        }
        oPC = GetNextObjectInShape(SHAPE_SPHERE,10.0f,GetLocation(oFire),FALSE,OBJECT_TYPE_CREATURE);
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
            SetPlotFlag(oSubFire,FALSE);
            DestroyObject(oSubFire,0.1f);
        }
        oSubFire = GetNextObjectInShape(SHAPE_SPHERE,10.0f,GetLocation(oFire),FALSE,OBJECT_TYPE_PLACEABLE);
    }
    DestroyObject(oFire,0.1f);
}
