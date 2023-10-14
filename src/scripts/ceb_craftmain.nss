void main()
{
    object oPC = GetPCSpeaker();
    string sRecipe = GetLocalString(OBJECT_SELF, "Recipe");
    object oBox = GetItemPossessedBy(oPC, "ceb_crcraftbox");
    object oItem = GetFirstItemInInventory(oBox);
    object oDestroy;
    int nMaterial = GetLocalInt(oItem, "Material");
    int nMatmod = 0;
    string sItem;
    int nCR = 0;
    int nRoll = d20(1);
    int nCost = 0;
    int nMod = GetHitDice(oPC)+GetAbilityModifier(ABILITY_INTELLIGENCE, oPC) + GetLevelByClass(57, oPC);
    int nSkill;
    int nXP;
    int Value;
    string sType;
    object oCrafted;
    int nStack = 1;
    string sReq;
    string sDesc;

    if (GetLocalInt(oItem, "Days") > 0) {
        SendMessageToPC(oPC, "This item requires further work.");
        return;
    }
}

