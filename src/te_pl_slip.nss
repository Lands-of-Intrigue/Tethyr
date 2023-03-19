void main()
{
    object oPC = GetEnteringObject();
    object oPlace = OBJECT_SELF;

    string sLoc = GetLocalString(oPlace, "sLoc");
    int nDamageDice = GetLocalInt(oPlace,"nDamageDice");
    int nDC = GetLocalInt(oPlace,"nDC");

    if(!ReflexSave(oPC,nDC,SAVING_THROW_TYPE_NONE,oPlace))
    {
        SendMessageToPC(oPC,"You slip and fall!");
        AssignCommand(oPC, JumpToLocation(GetLocation(GetObjectByTag(sLoc))));
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d6(nDamageDice),DAMAGE_TYPE_BLUDGEONING,DAMAGE_POWER_NORMAL),oPC);
    }
    else
    {
        SendMessageToPC(oPC,"You nearly slip, but steady yourself at the last moment...");
    }
}
