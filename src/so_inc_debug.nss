//::///////////////////////////////////////////////
//:: Name
//:: FileName
//:: Copyright (c) 2005 The Ravenloft PW Project
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Soeren Peter Moeller/Zarathustra217
//:: Created On:

//:://////////////////////////////////////////////


string GetObjectInfoString(object oObject)
{
    if(oObject==GetModule())
    {
        return "module";
    }
    string sReturn=GetName(oObject);

    if(GetIsPC(oObject))
    {
        string sPCPlayerName = GetPCPlayerName(oObject);
        string sPCKey= GetPCPublicCDKey(oObject);
        string sIP= GetPCIPAddress(oObject);
        sReturn=sReturn+" ("+sPCPlayerName+"/"+sPCKey+" @ "+sIP+")";
    }
    else if(GetIsObjectValid(GetItemPossessor(oObject)))
    {
        string sResRef=GetResRef(oObject);
        string sPossessor=GetObjectInfoString(GetItemPossessor(oObject));

        sReturn=sReturn+" ("+sResRef+" @ "+sPossessor+")";
    }
    else
    {
        string sResRef=GetResRef(oObject);
        string sArea=GetName(GetArea(oObject));
        string sAreaResRef=GetResRef(GetArea(oObject));
        vector vPos=GetPosition(oObject);
        string sCoordinates=IntToString(FloatToInt(vPos.x))+", "+IntToString(FloatToInt(vPos.y));
        sReturn=sReturn+" ("+sResRef+" @ "+sArea+"/"+sAreaResRef+"/pos: "+sCoordinates+")";
    }
    return sReturn;
}

