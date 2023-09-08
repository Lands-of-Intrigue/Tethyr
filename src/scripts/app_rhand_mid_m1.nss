const int RIGHT_HAND = INVENTORY_SLOT_RIGHTHAND;
const int MODEL = ITEM_APPR_TYPE_WEAPON_MODEL;
const int TOP = ITEM_APPR_WEAPON_MODEL_MIDDLE;

void main()
{
object oPC = OBJECT_SELF;
object oItem = GetItemInSlot(RIGHT_HAND,oPC);
int iIndex = GetItemAppearance(oItem, MODEL, TOP);
object oItemCopy = CopyItemAndModify(oItem, MODEL, TOP, iIndex-1, TRUE);
AssignCommand(oPC, ActionEquipItem(oItemCopy, RIGHT_HAND));
DestroyObject(oItem, 0.0f);
}
