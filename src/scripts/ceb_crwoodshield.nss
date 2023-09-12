#include "ceb_featcheck"
void main()
{
object oPC = GetPCSpeaker();
string sMatTag;
int nDayMod;
int nMat = GetLocalInt(OBJECT_SELF, "Material");
if (nMat == 5) {sMatTag="te_cebcraft026"; nDayMod=0;}
if (nMat == 6) {sMatTag="te_cebcraft025"; nDayMod=2;}
object oResource=GetItemPossessedBy(oPC, sMatTag);
if (oResource== OBJECT_INVALID)
    {
        SendMessageToPC(oPC, "The resource must be in your inventory");
        return;
    }

if(FeatCheck("Carpentry", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat."); return;}



DestroyObject(oResource);
object oItem=CreateItemOnObject("te_cebcraft016", oPC);
if (nMat==5) SetName(oItem, "Oak " + GetName(oItem));
if (nMat==6) SetName(oItem, "Darkwood " + GetName(oItem));
SetLocalInt(oItem, "Material", nMat);
SetLocalInt(oItem, "Days", 3+nDayMod);
SetLocalInt(oItem, "Date", GetCalendarDay());
SendMessageToPC(oPC, "You have begun working on your item.  It will take " + IntToString(3+nDayMod) + " days to complete your item.");
}
