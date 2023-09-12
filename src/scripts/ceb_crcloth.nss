#include "ceb_featcheck"
void main()
{
object oPC = GetPCSpeaker();
string sMatTag;
int nDayMod;
int nMat = GetLocalInt(OBJECT_SELF, "Material");
object oItem;
if (nMat == 10) {sMatTag="te_item_0010"; nDayMod=0;}     /* Cloth */
if (nMat == 11) {sMatTag="te_cebcraft030"; nDayMod=5;}   /* Enchanted Cloth */
object oResource=GetItemPossessedBy(oPC, sMatTag);
if (oResource==OBJECT_INVALID)
    {
        SendMessageToPC(oPC, "The resource must be in your inventory");
        return;
    }

if(FeatCheck("Tailoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat."); return;}



DestroyObject(oResource);
oItem=CreateItemOnObject("te_cebcraft02", oPC);
if (nMat==11) SetName(oItem, "Enchanted " + GetName(oItem));
SetLocalInt(oItem, "Material", nMat);
SetLocalInt(oItem, "Days", 2+nDayMod);
SetLocalInt(oItem, "Date", GetCalendarDay());
SendMessageToPC(oPC, "You have begun working on your item.  It will take " + IntToString(2+nDayMod) + " days to complete your item.");
}
