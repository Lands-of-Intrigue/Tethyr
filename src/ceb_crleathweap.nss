#include "ceb_featcheck"
void main()
{
object oPC = GetPCSpeaker();
string sMatTag;
int nDayMod;
int nMat = GetLocalInt(OBJECT_SELF, "Material");
if (nMat == 7) {sMatTag="te_cebcraft20"; nDayMod=0;}
if (nMat == 8) {sMatTag="te_cebcraft01"; nDayMod=2;}
object oResource=GetItemPossessedBy(oPC, sMatTag);
if (oResource== OBJECT_INVALID)
    {
        SendMessageToPC(oPC, "The resource must be in your inventory");
        return;
    }

if(FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat."); return;}



DestroyObject(oResource);
object oItem=CreateItemOnObject("te_cebcraft018", oPC);
if (nMat==7) SetName(oItem, "Soft " + GetName(oItem));
if (nMat==8) SetName(oItem, "Hard " + GetName(oItem));
SetLocalInt(oItem, "Material", nMat);
SetLocalInt(oItem, "Days", 5+nDayMod);
SetLocalInt(oItem, "Date", GetCalendarDay());
SendMessageToPC(oPC, "You have begun working on your item.  It will take " + IntToString(5+nDayMod) + " days to complete your item.");
}
