#include "nwnx_item"

void main()
{
int CLASS_TYPE_BLACKCOAT = 51; /* MUST BE REMOVED */
object oPC = GetLastUsedBy();

if (GetItemPossessedBy(oPC, "NW_IT_THNMISC001")== OBJECT_INVALID)
    {
    SendMessageToPC(oPC, "You do not have an empty bottle");
    return;
    }
if (GetLevelByClass(CLASS_TYPE_CLERIC, oPC) > 1
    || GetLevelByClass(CLASS_TYPE_DRUID, oPC) > 1
    || GetLevelByClass(CLASS_TYPE_PALADIN, oPC) > 1
    || GetLevelByClass(CLASS_TYPE_RANGER, oPC) > 1
    || GetLevelByClass(CLASS_TYPE_BLACKCOAT, oPC) > 1)
    {
        object oItem;
        oItem = GetItemPossessedBy(oPC, "NW_IT_THNMISC001");

        if (GetIsObjectValid(oItem))
           DestroyObject(oItem);

        object oWater = CreateItemOnObject("te_item_9005", oPC);
        NWNX_Item_SetBaseGoldPieceValue(oWater,0);
        SendMessageToPC(oPC, "You fill a bottle with holy water.");
    }
else
    {
        SendMessageToPC(oPC, "You cannot use this item.");
        return;
    }

}
