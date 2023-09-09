#include "ceb_featcheck"
void main()
{
object oPC = GetPCSpeaker();
string sMatTag;
int nDayMod;
int nMat = GetLocalInt(OBJECT_SELF, "Material");
if (nMat == 1) {sMatTag="te_item_0007"; nDayMod=0;}
if (nMat == 2) {sMatTag="te_item_0009"; nDayMod=2;}
if (nMat == 3) {sMatTag="te_item_0008"; nDayMod=4;}
if (nMat == 4) {sMatTag="te_item_0006"; nDayMod=6;}
object oResource=GetItemPossessedBy(oPC, sMatTag);
if (oResource== OBJECT_INVALID)
    {
        SendMessageToPC(oPC, "The resource must be in your inventory");
        return;
    }

if(FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat."); return;}



DestroyObject(oResource);
object oItem=CreateItemOnObject("te_cebcraft010", oPC);
if (nMat==1) SetName(oItem, "Iron " + GetName(oItem));
if (nMat==2) SetName(oItem, "Steel " + GetName(oItem));
if (nMat==3) SetName(oItem, "Mithril " + GetName(oItem));
if (nMat==4) SetName(oItem, "Admantine " + GetName(oItem));
SetLocalInt(oItem, "Material", nMat);
SetLocalInt(oItem, "Days", 3+nDayMod);
SetLocalInt(oItem, "Date", GetCalendarDay());
SendMessageToPC(oPC, "You have begun working on your item.  It will take " + IntToString(3+nDayMod) + " days to complete your item.");
}
