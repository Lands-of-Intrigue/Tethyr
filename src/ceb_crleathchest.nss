#include "ceb_featcheck"
void main()
{
object oPC = GetPCSpeaker();
string sMatTag;
int nDayMod;
int nMat = GetLocalInt(OBJECT_SELF, "Material");
if (nMat == 7) {sMatTag="te_cebcraft020"; nDayMod=0;}  /* Soft Hide */
if (nMat == 8) {sMatTag="te_cebcraft01"; nDayMod=2;}   /* Hard Hide */
if (nMat == 12) {sMatTag="te_cebcraft024"; nDayMod=10;}  /* Dragon Hide */
object oResource=GetItemPossessedBy(oPC, sMatTag);
object oItem;
if (oResource== OBJECT_INVALID)
    {
        SendMessageToPC(oPC, "The resource must be in your inventory");
        return;
    }

if(FeatCheck("Tailoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat."); return;}



DestroyObject(oResource);
oItem=CreateItemOnObject("te_cebcraft012", oPC);
if (nMat==7) SetName(oItem, "Soft " + GetName(oItem));
if (nMat==8) SetName(oItem, "Hard " + GetName(oItem));
if (nMat == 12) SetName(oItem, "Unfinished Dragonhide Tunic");
SetLocalInt(oItem, "Material", nMat);
SetLocalInt(oItem, "Days", 6+nDayMod);
SetLocalInt(oItem, "Date", GetCalendarDay());
SendMessageToPC(oPC, "You have begun working on your item.  It will take " + IntToString(6+nDayMod) + " days to complete your item.");
}
