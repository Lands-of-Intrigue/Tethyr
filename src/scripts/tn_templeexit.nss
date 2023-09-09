void main()
{
    object oPC = GetExitingObject();
    object oArea = OBJECT_SELF;
    string Shadow1 = "te_shad1";
    string Shadow2 = "te_shad2";
    string Shadow3 = "te_shad3";
    int nPC = 0;
    object oShad;

    object oPC1 = GetFirstObjectInArea(oArea);

    while (oPC1 != OBJECT_INVALID)
    {
        if(GetIsPC(oPC1) == TRUE)
        {
            nPC = nPC+1;
        }
        oPC1 = GetNextObjectInArea(oArea);
    }

    if(nPC < 1)
    {
        oShad = GetFirstObjectInArea(oArea);
        while (oShad != OBJECT_INVALID)
        {
            if((GetTag(oShad) == Shadow1)||(GetTag(oShad) == Shadow2)||(GetTag(oShad) == Shadow3))
            {
                DestroyObject(oShad,0.1);
            }
            oShad = GetNextObjectInArea(oArea);
        }
        object oPlace = GetNearestObjectByTag("tn_artifact",GetWaypointByTag("tn_artifact"),1);

        if(oPlace != GetWaypointByTag("tn_artifact"))
        {
            SetPlotFlag(oPlace,FALSE);
            DestroyObject(oPlace);
        }
    }
}
