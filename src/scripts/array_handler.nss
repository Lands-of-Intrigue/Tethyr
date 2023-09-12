//::///////////////////////////////////////////////
//:: Array System
//:: Copyright (c) 2001 Bioware Corp.
//:: Credits:
//::    Script: "nw_o0_itemmaker"
//::    https://nwnlexicon.com/index.php?title=JL_SetLocalArrayInt
//:://////////////////////////////////////////////
//:: Created By: Noel
//::    JL_GetLocalArrayInt
//::    JL_SetLocalArrayInt
//::    JL_GetLocalArrayString
//::    JL_SetLocalArrayString
//:://////////////////////////////////////////////
//:: Created By: Noel
//::    JL_GetLocalArrayInt
//::    JL_SetLocalArrayInt
//::    JL_GetLocalArrayString
//::    JL_SetLocalArrayString
//::///////////////////////////////////////////////
//:: Array System
//:: Function(D20) 2019
//:://////////////////////////////////////////////
//:: Created By; Jonathan Lorentsen (Sloth)
//::    JL_GetLocalArrayObject
//::    JL_SetLocalArrayObject
//::    JL_ClearLocalArrayInt
//::    JL_ClearLocalArrayObject
//::    JL_ClearLocalArrayString
//:://////////////////////////////////////////////

string sFullVarName;
int nLoop;

int JL_GetLocalArrayInt(object oObject, string sVarName, int nVarNum);
object JL_GetLocalArrayObject(object oObject, string sVarName, int nVarNum);
string JL_GetLocalArrayString(object oObject, string sVarName, int nVarNum);
void JL_SetLocalArrayInt(object oObject, string sVarName, int nVarNum, int nValue);
void JL_SetLocalArrayObject(object oObject, string sVarName, int nVarNum, object nValue);
void JL_SetLocalArrayString(object oObject, string sVarName, int nVarNum, string nValue);
void JL_ClearLocalArrayInt(object oObject, string sVarName);
void JL_ClearLocalArrayObject(object oObject, string sVarName);
void JL_ClearLocalArrayString(object oObject, string sVarName);

int JL_GetLocalArrayInt(object oObject, string sVarName, int nVarNum)
{
    sFullVarName = sVarName + IntToString(nVarNum) ;
    return GetLocalInt(oObject, sFullVarName);
}

object JL_GetLocalArrayObject(object oObject, string sVarName, int nVarNum)
{
    sFullVarName = sVarName + IntToString(nVarNum);
    return GetLocalObject(oObject, sFullVarName);
}

string JL_GetLocalArrayString(object oObject, string sVarName, int nVarNum)
{
    sFullVarName = sVarName + IntToString(nVarNum);
    return GetLocalString(oObject, sFullVarName);
}

void JL_SetLocalArrayInt(object oObject, string sVarName, int nVarNum, int nValue)
{
    sFullVarName = sVarName + IntToString(nVarNum);
    SetLocalInt(oObject, sFullVarName, nValue);
}

void JL_SetLocalArrayObject(object oObject, string sVarName, int nVarNum, object nValue)
{
    sFullVarName = sVarName + IntToString(nVarNum);
    SetLocalObject(oObject, sFullVarName, nValue);
}

void JL_SetLocalArrayString(object oObject, string sVarName, int nVarNum, string nValue)
{
    sFullVarName = sVarName + IntToString(nVarNum);
    SetLocalString(oObject, sFullVarName, nValue);
}

void JL_ClearLocalArrayInt(object oObject, string sVarName)
{
    nLoop = 1;
    sFullVarName = sVarName + IntToString(nLoop);
    while (GetLocalInt(oObject, sFullVarName) != 0)
    {
        DeleteLocalInt(oObject, sVarName);

        nLoop = nLoop+1;
        sFullVarName = sVarName + IntToString(nLoop);
    }
}

void JL_ClearLocalArrayObject(object oObject, string sVarName)
{
    nLoop = 1;
    sFullVarName = sVarName + IntToString(nLoop);
    while (GetLocalObject(oObject, sFullVarName) != OBJECT_INVALID)
    {
        DeleteLocalObject(oObject, sVarName);

        nLoop = nLoop+1;
        sFullVarName = sVarName + IntToString(nLoop);
    }
}

void JL_ClearLocalArrayString(object oObject, string sVarName)
{
    nLoop = 1;
    sFullVarName = sVarName + IntToString(nLoop);
    while (GetLocalString(oObject, sFullVarName) != "")
    {
        DeleteLocalString(oObject, sVarName);

        nLoop = nLoop+1;
        sFullVarName = sVarName + IntToString(nLoop);
    }
}
