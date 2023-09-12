void main()
{
    object oPlace = OBJECT_SELF;
    object oPC = GetPCSpeaker();
    string sGrove = GetLocalString(oPlace,"Grove");

    int nGroveState = GetLocalInt(GetModule(),sGrove);



    //Normal
    if(nGroveState <= 25)
    {
        SetCustomToken(7878, "close to pristine. Nature is in balance currently.");
        if(GetLocalInt(oPlace,"BadLayline") == 1)
        {
            SetCustomToken(7878, "close to prestine. Nature is in balance currently. This location is not located on a strong layline and cannot influence as well as others.");
        }
    }
    //Middle Ground   This location is not a strong layline and cannot influence as well as others.
    else if ((nGroveState > 26) && (nGroveState <= 75))
    {
        SetCustomToken(7878, "tainted by foul energies. Nature is disturbed by the presence of these energies.");
        if(GetLocalInt(oPlace,"BadLayline") == 1)
        {
            SetCustomToken(7878, "tainted by foul energies. Nature is disturbed by the presence of these energies. This location is not located on a strong layline and cannot influence as well as others.");
        }
    }
    //Effreeti Invasion!
    else if (nGroveState > 75)
    {
        SetCustomToken(7878, "overwhelmed by foul energies. Nature is at war with itself due to the presence of these energies.");
        if(GetLocalInt(oPlace,"BadLayline") == 1)
        {
            SetCustomToken(7878, "overwhelmed by foul energies. Nature is at war with itself due to the presence of these energies. This location is not located on a strong layline and cannot influence as well as others.");
        }
    }

}
