#include "ceb_featcheck"
void main()
{
object oPC = GetPCSpeaker();
string sMatTag;
int nDayMod;
int nMat = GetLocalInt(OBJECT_SELF, "Material");
if (nMat == 9) {sMatTag="te_cebcraft013"; nDayMod=0;}
object oResource=GetItemPossessedBy(oPC, sMatTag);
if (oResource== OBJECT_INVALID)
    {
        SendMessageToPC(oPC, "The resource must be in your inventory");
        return;
    }

if(FeatCheck("Carpentry", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat."); return;}



DestroyObject(oResource);
object oItem=CreateItemOnObject("te_cebcraft011", oPC);
SetLocalInt(oItem, "Material", nMat);
SetLocalInt(oItem, "Days", 1+nDayMod);
SetLocalInt(oItem, "Date", GetCalendarDay());
SendMessageToPC(oPC, "You have begun working on your item.  It will take " + IntToString(1+nDayMod) + " days to complete your item.");
}
