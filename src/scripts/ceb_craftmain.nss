#include "ceb_featcheck"
//VERSION 4/28/20 updated by Djinn

//oPC == Object you wish to give XP to. Only PCs have multiclassing penalty.
//nXPToGive == Amount of XP Reward. If negative, multiclassing penalty will never be calculated or looked at.
//nMulticlass == TRUE for assessing multiclassing penalty. Default = 0/False.
void GiveTrueXPToCreature(object oPC, int nXPToGive, int nMulticlass);

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

/*TAILORING*/
/* Padded Armor */
if (sRecipe == "MNMNSS")
    {
    if (FeatCheck("Tailoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_AARCL009";
    nCR = 11;
    nCost = 5;
    sType = "Armor";
    sReq = "te_cebcraft02";
    sDesc = "This armor features quilted layers of cloth and batting.";
    }

/* Cloak */
if (sRecipe == "MNSNNS")
    {
    if (FeatCheck("Tailoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="plaincloak004";
    nCR = 10;
    nCost = 5;
    sType = "Cloak";
    sReq = "te_cebcraft02";
    sDesc = "This fabric cloak offers some protection from the weather.";
    }

/* Cloak of Elvenkind */
if (sRecipe == "MNSNSN")
    {
    if (FeatCheck("Tailoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    if (GetHasFeat(1177, oPC)==FALSE && //copper elf
        GetHasFeat(1178, oPC)==FALSE && //green elf
        GetHasFeat(1180, oPC)==FALSE && //silver elf
        GetHasFeat(1181, oPC)==FALSE) //gold elf
        {SendMessageToPC(oPC, "You do not have the required background."); return;} //elven heritage feat check
    if (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>=5 ||
        GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>=5 ||
        GetLevelByClass(CLASS_TYPE_BARD, oPC)>=5 ||
        GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>=5 ||
        GetLevelByClass(57, oPC)>=5) {} else {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    sItem="te_item_2012";
    nCR = 18;
    nCost = 1250;
    nXP = 125;
    sType = "Cloak";
    sReq = "te_cebcraft02";
    sDesc = "This symbolic cloak of the elves can only be made by a member of their race.";
    }

/* Robe */
if (sRecipe == "SMNNMS")
    {
    if (FeatCheck("Tailoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_cebcraft28";
    nCR = 10;
    nCost = 5;
    sType = "Armor";
    sReq = "te_cebcraft02";
    sDesc = "A cotton robe.";
    }

/* Bag */
if (sRecipe == "SSMNSM")
    {
    if (FeatCheck("Tailoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="ceb_crbag";
    nCR = 10;
    nCost = 5;
    sType = "Misc";
    sReq = "te_cebcraft02";
    sDesc = "A cotton sack.";
    }

/* Bag of Holding Type 4 */
if (sRecipe == "SSMMNM")
    {
    if (FeatCheck("Tailoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    if (FeatCheck("Craft_Wonderous_Item", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    if (nMaterial != 11) {SendMessageToPC(oPC, "Must use enchanted cloth."); return;}
    sItem="te_item_8662";
    nCR = 15;
    nCost = 5000;
    sType = "Misc";
    sReq = "te_cebcraft02";
    sDesc + "This appears to be a common cloth sack.  The bag opens into a nondimensional space.  Its inside is larger than its outside dimensions.  Regardless of what is put in the bag, the weight does not seem to change.";
    }

/* Bag of Holding Type 3 */
if (sRecipe == "SSMMNN")
    {
    if (FeatCheck("Tailoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    if (FeatCheck("Craft_Wonderous_Item", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    if (nMaterial != 11) {SendMessageToPC(oPC, "Must use enchanted cloth."); return;}
    sItem="ceb_crbag2";
    nCR = 15;
    nCost = 3700;
    sType = "Misc";
    sReq = "te_cebcraft02";
    sDesc + "This appears to be a common cloth sack.  The bag opens into a nondimensional space.  Its inside is larger than its outside dimensions.  Regardless of what is put in the bag, the weight does not seem to change.";
    }

/* Bag of Holding Type 2 */
if (sRecipe == "SSMMNS")
    {
    if (FeatCheck("Tailoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    if (FeatCheck("Craft_Wonderous_Item", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    if (nMaterial != 11) {SendMessageToPC(oPC, "Must use enchanted cloth."); return;}
    sItem="ceb_crbag3";
    nCR = 15;
    nCost = 2500;
    sType = "Misc";
    sReq = "te_cebcraft02";
    sDesc + "This appears to be a common cloth sack.  The bag opens into a nondimensional space.  Its inside is larger than its outside dimensions.  Regardless of what is put in the bag, the weight does not seem to change.";
    }

/* Bag of Holding Type 1 */
if (sRecipe == "SSMMMN")
    {
    if (FeatCheck("Tailoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    if (FeatCheck("Craft_Wonderous_Item", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    if (nMaterial != 11) {SendMessageToPC(oPC, "Must use enchanted cloth."); return;}
    sItem="ceb_crbag4";
    nCR = 15;
    nCost = 1250;
    sType = "Misc";
    sReq = "te_cebcraft02";
    sDesc + "This appears to be a common cloth sack.  The bag opens into a nondimensional space.  Its inside is larger than its outside dimensions.  Regardless of what is put in the bag, the weight does not seem to change.";
    }

/* Low Quality Tent */
if (sRecipe == "SSMNSS")
    {
    if (FeatCheck("Tailoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_tent0";
    nCR = 12;
    nCost = 5;
    sType = "Misc";
    sReq = "te_cebcraft02";
    //sDesc = "A cotton sack.";
    }

/* Adventurer's Tent */
if (sRecipe == "SSMNSN")
    {
    if (FeatCheck("Tailoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_tent1";
    nCR = 15;
    nCost = 12;
    sType = "Misc";
    sReq = "te_cebcraft020";
    //sDesc = "A cotton sack.";
    }

/* High Quality Tent */
if (sRecipe == "SSMMSN")
    {
    if (FeatCheck("Tailoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    if (GetItemPossessedBy(oPC, "te_cebcraft02") == OBJECT_INVALID) {SendMessageToPC(oPC, "You seem to be missing something required to create this item."); return;}
    sItem="te_tent2";
    nCR = 18;
    nCost = 15;
    sType = "Misc";
    sReq = "te_cebcraft018";
    //sDesc = "A cotton sack.";
    }

/* Bedroll */
if (sRecipe == "SSNNSN")
    {
    if (FeatCheck("Tailoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="Bedroll";
    nCR = 10;
    nCost = 5;
    sType = "Misc";
    sReq = "te_cebcraft02";
    sDesc = "A cotton sack.";
    }

/* Flesh Golem Parts */
if (sRecipe == "SSNSSN")
    {
    if (FeatCheck("Tailoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    if (GetItemPossessedBy(oPC, "te_golcraft01b") == OBJECT_INVALID) {SendMessageToPC(oPC, "You seem to be missing something required to create this item."); return;}
    sItem="te_golcraft01";
    nCR = 13;
    nCost = 50;
    sType = "Armor";
    sReq = "te_cebcraft02";
    }

/*LEATHER WORKING*/
/* Leather Hood */
if (sRecipe == "BKBKRB")
    {
    if (FeatCheck("Tailoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_leatherhood";
    nCR = 13;
    nCost = 5;
    sType = "Helm";
    sReq = "te_cebcraft018";
    sDesc = "This leather hood hangs low over your face and offers some protection from the weather.";
    }

/* Nightsinger's Cowl */
if (sRecipe == "BKBKRR")
    {
    if (FeatCheck("Tailoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    if (GetHasFeat(1300, oPC) == FALSE) {SendMessageToPC(oPC, "You do not have the required feats for this creation."); return;}
    sItem="te_item_7015";
    nCR = 15;
    nCost = 1000;
    sType = "Helm";
    sReq = "te_cebcraft018";
    //sDesc = "This leather hood hangs low over your face and offers some protection from the weather.";
    }

/* Leather Boots */
if (sRecipe == "BRBRKK")
    {
    if (FeatCheck("Tailoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_craft_boots";
    nCR = 12;
    nCost = 5;
    sType = "Boots";
    sReq = "te_cebcraft018";
    sDesc = "These leather boots are soft and comfortable.";
    }

/* Nightsinger's Steps */
if (sRecipe == "BRBRRR")
    {
    if (FeatCheck("Tailoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_item_7010";
    nCR = 15;
    nCost = 1000;
    sType = "Boots";
    sReq = "te_cebcraft018";
    //sDesc = "These leather boots are soft and comfortable.";
    }

/* Boots of Elvenkind */
if (sRecipe == "BRBRKR")
    {
    if (FeatCheck("Tailoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    if (GetHasFeat(1177, oPC)==FALSE || //copper elf
        GetHasFeat(1178, oPC)==FALSE || //green elf
        GetHasFeat(1180, oPC)==FALSE || //silver elf
        GetHasFeat(1181, oPC)==FALSE) //gold elf
       {SendMessageToPC(oPC, "You do not have the required background."); return;} //elven heritage feat check
    if (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>=5 ||
        GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>=5 ||
        GetLevelByClass(CLASS_TYPE_BARD, oPC)>=5 ||
        GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>=5 ||
        GetLevelByClass(57, oPC)>=5 ) {} else {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    sItem="te_item_01013";
    nCR = 18;
    nCost = 1250;
    nXP = 125;
    sType = "Boots";
    sReq = "te_cebcraft018";
    sDesc = "These symbolic elven-made boots are given their power by the Seldarine.";
    }

/* Studded Leather Armor */
if (sRecipe == "KKRBRK")
    {
    if (FeatCheck("Tailoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_AARCL002";
    nCR = 13;
    nCost = 25;
    sType = "Armor";
    sReq = "te_cebcraft012";
    sDesc = "This armor is made from tough but flexible leather reinforced with close-set metal rivets.";
    }

/*Ankheg Full Plate*/
if (sRecipe == "KBRKBR")
    {
    if (FeatCheck("Tailoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    if (GetItemPossessedBy(oPC, "te_item_8462") == OBJECT_INVALID) {SendMessageToPC(oPC, "You seem to be missing something required to create this item."); return;}
    sItem="te_item_8518";
    nCR = 20;
    nCost = 250;
    sType = "Armor";
    sReq = "te_cebcraft012";
    sDesc = "This heavy suit of armor covers your entire body with polished ankheg plates and interlocking leathers underneath.";
    }

/* Leather Belt */
if (sRecipe == "KRBKRB")
    {
    if (FeatCheck("Tailoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_leatherbelt";
    nCR = 13;
    nCost = 5;
    sType = "Belt";
    sReq = "te_cebcraft018";
    sDesc = "A leather belt with an ornamental clasp.";
    }

/* Scabbard of Keen Edges */
if (sRecipe == "KRBKBK")
    {
    if (FeatCheck("Tailoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    if (FeatCheck("Craft_Wonderous_Item", oPC)==FALSE) {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    if (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>=5 ||
        GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>=5 ||
        GetLevelByClass(57, oPC)>=5 ) {} else {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    sItem="te_item_01022";
    nCR = 13;
    nCost = 2500;
    sType = "Misc";
    sReq = "te_cebcraft018";
//    sDesc = "A leather belt with an ornamental clasp.";
    }

/* Girdle of Horseback Riding */
if (sRecipe == "KRBKRR")
    {
    if (FeatCheck("Tailoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    if (GetHasFeat(1406, oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat."); return;} //craft wondrous feat check
    if (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>=8 ||
        GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>=8 ||
        GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>=8 ||
        GetLevelByClass(57, oPC)>=8 ) {} else {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    sItem="te_item_2017";
    nCR = 0;
    nCost = 2500;
    sType = "Belt";
    sReq = "te_cebcraft018";
    sDesc = "This fine magical girdle gives the wearer a legendary prowess when on horseback.";
    }

/* Monk's Sash */
if (sRecipe == "KRBKKR")
    {
    if (FeatCheck("Tailoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_item_8144";
    nCR = 18;
    nCost = 1000;
    sType = "Belt";
    sReq = "te_cebcraft018";
    sDesc = "A leather belt with an ornamental clasp. It seems to have several markings that depict the external force known as Ki.";
    }

/* Military Girdle */
if (sRecipe == "KRBKRK")
    {
    if (FeatCheck("Tailoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    sItem="te_item_5027";
    nCR = 15;
    nCost = 50;
    sType = "Belt";
    sReq = "te_cebcraft018";
    sDesc = "This fine girdle gives the wearer some benefits to fighting while mounted, by virtue of its construction.";
    }

/* Whip */
if (sRecipe == "KRRBRK")
    {
    if (FeatCheck("Tailoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="X2_IT_WPWHIP";
    nCR = 18;
    nCost = 1;
    sType = "Weapon";
    sReq = "te_cebcraft024";
    sDesc = "Leather bands have been carefully woven into a well crafted whip.";
    }

/*Doommaster's Whip */
if (sRecipe == "KRRBKK")
    {
    if (FeatCheck("Tailoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_sp_beshaba";
    nCR = 20;
    nCost = 1000;
    nXP = 100;
    sType = "Weapon";
    sReq = "te_cebcraft024";
    sDesc = "A whip with symbols venerating Beshaba.";
    }

/*Heartwarder's Whip */
if (sRecipe == "KRRBBK")
    {
    if (FeatCheck("Tailoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_sp_sune";
    nCR = 20;
    nCost = 1000;
    nXP = 100;
    sType = "Weapon";
    sReq = "te_cebcraft024";
    sDesc = "A whip with symbols venerating Sune.";
    }

/* Leather Gloves */
if (sRecipe == "RKBRRK")
    {
    if (FeatCheck("Tailoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="leathergloves001";
    nCR = 13;
    nCost = 5;
    sType = "Gloves";
    sReq = "te_cebcraft018";
    sDesc = "A pair of leather gloves.";
    }

/* Prepared Leather Gloves (for bigbys spells) */
if (sRecipe == "RRBBKR")
    {
    if (FeatCheck("Tailoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="it_comp_ltglobe";
    nCR = 14;
    nCost = 5;
    sType = "Gloves";
    sReq = "te_cebcraft018";
    sDesc = "A pair of leather gloves, specially made for use with Bigby's spells.";
    }

/* Leather Thong (for Freedom and Displacement) */
if (sRecipe == "RRBRKR")
    {
    if (FeatCheck("Tailoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="it_comp_ltthong";
    nCR = 13;
    nCost = 5;
    sType = "Misc";
    sReq = "te_cebcraft018";
    sDesc = "A leather thong, specially prepared for the Freedom of Movement spell and Displacement spell.";
    }

/* Leather Armor */
if (sRecipe == "RRBKKR")
    {
    if (FeatCheck("Tailoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_AARCL001";
    nCR = 12;
    nCost = 10;
    sType = "Armor";
    sReq = "te_cebcraft012";
    sDesc = "The breastplate and shoulder protectors of this armor are made of leather that has been stiffened by boiling in oil. The rest of the armor is made of softer and more flexible leather.";
    }

/* Hide Armor */
if (sRecipe == "RRBKKK")
    {
    if (FeatCheck("Tailoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_AARCL008";
    nCR = 12;
    nCost = 10;
    sType = "Armor";
    sReq = "te_cebcraft012";
    sDesc = "The breastplate and shoulder protectors of this armor are made of leather that has been stiffened by boiling in oil. The rest of the armor is made of softer and more flexible leather.";
    }

/* Sling */
if (sRecipe == "RRKBRK")
    {
    if (FeatCheck("Tailoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_WBWSL001";
    nCR = 14;
    nCost = 1;
    sType = "Weapon";
    sReq = "te_cebcraft018";
    sDesc = "This strap of leather has been well crafted for the purpose of launching stones.";
    }

/*CARPENTRY*/
/*Small Shield*/
if (sRecipe == "PPLSSS")
    {
    if (FeatCheck("Carpentry", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_ASHSW001";
    nCR = 12;
    nCost = 20;
    sType = "Shield";
    sReq = "te_cebcraft016";
    sDesc = "This is a light weight shield offering minimal protection with little cost to mobility.";
    }

/* Light Crossbow */
if (sRecipe == "PPSSLP")
    {
    if (FeatCheck("Carpentry", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_WBWXL001";
    nCR = 18;
    nCost = 35;
    sType = "Ranged";
    sReq="te_cebcraft09";
    sDesc = "You draw a light crossbow back by pulling a lever. The weapon requires two hands.";
    }

/* Heavy Crossbow */
if (sRecipe == "PPSPLS")
    {
    if (FeatCheck("Carpentry", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="wbwxh003";
    nCR = 20;
    nCost = 50;
    sType = "Ranged";
    sReq="te_cebcraft09";
    sDesc = "This large variation of the crossbow is loaded by turning a small winch.";
    }

//------------------Begin Gunz

/* PISTOL */
if (sRecipe == "PPSSLL")
    {
    if ((FeatCheck("Carpentry", oPC)==FALSE) &&
    (GetHasFeat(1483, oPC)==FALSE)) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
//    if (GetItemPossessedBy(oPC, "te_cebcraft022") == OBJECT_INVALID) {SendMessageToPC(oPC, "You seem to be missing something required to create this item."); return;}
    sItem="te_gun008";
    nCR = 18;
    nCost = 250;
    sType = "Ranged";
    sReq="te_cebcraft09";
//    oDestroy = GetItemPossessedBy(oPC, "te_cebcraft022");
    //sDesc = "This large variation of the crossbow is loaded by turning a small winch.";
    }

/* Caviler */
if (sRecipe == "PPSSPP")
    {
    if ((FeatCheck("Carpentry", oPC)==FALSE) &&
    (GetHasFeat(1483, oPC)==FALSE)) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_gun007";
    nCR = 16;
    nCost = 225;
    sType = "Ranged";
    sReq="te_cebcraft09";
    //sDesc = "This large variation of the crossbow is loaded by turning a small winch.";
    }

/* Arquebus */
if (sRecipe == "PPSSSP")
    {
    if ((FeatCheck("Carpentry", oPC)==FALSE) &&
    (GetHasFeat(1483, oPC)==FALSE)) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_gun001";
    nCR = 15;
    nCost = 250;
    sType = "Ranged";
    sReq="te_cebcraft09";
    //sDesc = "This large variation of the crossbow is loaded by turning a small winch.";
    }

/* Lead Bullets */     // if (GetHasFeat(1483, oPC)==FALSE) //this gunsmithing
if (sRecipe == "BHBHBH")
    {
    if ((FeatCheck("Armoring", oPC)==FALSE) &&
    (GetHasFeat(1483, oPC)==FALSE)) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    if (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>=3 ||
        GetLevelByClass(CLASS_TYPE_BARD, oPC)>=3 ||
        GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>=3 ||
        GetLevelByClass(57, oPC)>=3 ) {} else {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    sItem="te_gunammo001";
    nCR = 15;
    nCost = 100;
    nStack = 99;
    sType = "Ammo";
    sReq="te_cebcraft022";
   //sDesc = "Lead bullets kill yo grannie.";
    }

//------------------End Gunz

/* Shortbow */
if (sRecipe == "PSSPLS")
    {
    if (FeatCheck("Carpentry", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_WBWSH001";
    nCR = 16;
    nCost = 30;
    sType = "Ranged";
    sReq="te_cebcraft07";
    sDesc = "This is a small bow";
    }

/* Longbow */
if (sRecipe == "PPSPLL")
    {
    if (FeatCheck("Carpentry", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_WBWLN001";
    nCR = 18;
    nCost = 75;
    sType = "Ranged";
    sReq="te_cebcraft07";
    sDesc = "This longbow offers more power than it's smaller variations, but is more unwieldy.";
    }

/* Longbow of the Seldarine*/
if (sRecipe == "PPSPLP")
    {
    if (FeatCheck("Carpentry", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_item_8481";
    nCR = 19;
    nCost = 1000;
    sType = "Ranged";
    sReq="te_cebcraft07";
    sDesc = "This longbow is lovingly adorned with carvings depicting the elven pantheon of gods, also known as the Seldarine.";
    }

/*Large Shield*/
if (sRecipe == "PSSLSS")
    {
    if (FeatCheck("Carpentry", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_ASHLW001";
    nCR = 12;
    nCost = 20;
    sType = "Shield";
    sReq = "te_cebcraft016";
    "The large shield offers moderate protection while still be transported with relative ease.";
    }

/* Club */
if (sRecipe == "SSPSSL")
    {
    if (FeatCheck("Carpentry", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_WBLCL001";
    nCR = 16;
    nCost = 1;
    sType = "Weapon";
    sReq="te_cebcraft07"; /*bowshaft for now*/
    sDesc = "This piece of wood has been lightly fashioned into a weapon.";
    }

/* Darkwalker's Club */
if (sRecipe == "SSPSSS")
    {
    if (FeatCheck("Carpentry", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_sp_ibrandul";
    nCR = 20;
    nCost = 1000;
    nXP = 100;
    sType = "Weapon";
    sReq="te_cebcraft07"; /*bowshaft for now*/
    sDesc = "A club with symbols venerating Ibrandul.";
    }

/* Dart */
if (sRecipe == "SPSLSS")
    {
    if (FeatCheck("Carpentry", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_WTHDT001";
    nCR = 14;
    nCost = 1;
    nStack = 99;
    sType = "Ranged";
    sReq="te_cebcraft011";
    sDesc = "These small ranged weapons are easily concealed.";
    }

/* Bolt */
if (sRecipe == "SPSPSL")
    {
    if (FeatCheck("Carpentry", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_WAMBO001";
    nCR = 14;
    nCost = 1;
    nStack = 99;
    sType = "Ammo";
    sReq="te_cebcraft011";
    sDesc = "Crossbow ammunition.";
    }

/* Bolt of Fire */
if (sRecipe == "SPSPSS")
    {
    if (FeatCheck("Carpentry", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    if (GetHasFeat(1405, oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat."); return;} //craft magic arms feat check
    if (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>=8 ||
        GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>=8 ||
        GetLevelByClass(57, oPC)>=8 ) {} else {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    sItem="te_item_6018";
    nCR = 15;
    nCost = 250;
    nXP = 25;
    nStack = 25;
    sType = "Ammo";
    sReq="te_cebcraft011";
    sDesc = "Crossbow ammunition which has been imbued with magical flame.";
    }

/* Arrow */
if (sRecipe == "PSPPLS")
    {
    if (FeatCheck("Carpentry", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="nw_wamar001";
    nCR = 14;
    nCost = 1;
    nStack = 99;
    sType = "Ammo";
    sReq="te_cebcraft011";
    sDesc = "Bow Ammunition.";
    }

/* Ranger's Arrows */
if (sRecipe == "PSPPPS")
    {
    if ((GetLevelByClass(CLASS_TYPE_RANGER, oPC)>=5)) {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    sItem="te_banearrow";
    nCR = 15;
    nCost = 1000;
    nStack = 99;
    sType = "Ammo";
    sReq="te_cebcraft011";
    //sDesc = "Bow Ammunition.";
    }

/* Arrow of Fire */
if (sRecipe == "PSPSPL")
    {
    if (FeatCheck("Carpentry", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    if (GetHasFeat(1405, oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat."); return;} //craft magic arms feat check
    if (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>=8 ||
        GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>=8 ||
        GetLevelByClass(57, oPC)>=8 ) {} else {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    sItem="te_item_6019";
    nCR = 15;
    nCost = 250;
    nXP = 25;
    nStack = 25;
    sType = "Ammo";
    sReq="te_cebcraft011";
    sDesc = "Bow ammunition which has been imbued with magical flame.";
    }

/* Quarterstaff*/
if (sRecipe == "SSLPLP")
    {
    if (FeatCheck("Carpentry", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_WDBQS001";
    nCR = 16;
    nCost = 1;
    sType = "Weapon";
    sReq="te_cebcraft034";
    sDesc = "This piece of wood has been lightly fashioned into a weapon.";
    }

/* Magistrati's Quarterstaff*/
if (sRecipe == "SSLPLS")
    {
    if (FeatCheck("Carpentry", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_sp_azuth";
    nCR = 20;
    nCost = 1000;
    nXP = 100;
    sType = "Weapon";
    sReq="te_cebcraft034";
    sDesc = "A quarterstaff with symbols venerating Azuth.";
    }

/* Necrophant's Quarterstaff*/
if (sRecipe == "SSLPSL")
    {
    if (FeatCheck("Carpentry", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_sp_velsharoon";
    nCR = 20;
    nCost = 1000;
    nXP = 100;
    sType = "Weapon";
    sReq="te_cebcraft034";
    sDesc = "A quarterstaff with symbols venerating Velsharoon.";
    }

/* Staff of Command */
if (sRecipe == "PSSPLS")
    {
    if (FeatCheck("Carpentry", oPC)==FALSE) {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    if (GetHasFeat(1442, oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat."); return;} //craft staff feat check
    if (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>=8 ||
        GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>=8 ||
        GetLevelByClass(57, oPC)>=8 ) {} else {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    sItem="NW_WMGST002";
    nCR = 18;
    nCost = 16500;
    nXP = 1650;
    sType = "Staff";
    sReq="te_cebcraft034";
    sDesc = "Made of twisting wood ornately shaped and carved, this staff allows use of spells which will bend another creature's will.";
    }

/* Fauna Staff */
if (sRecipe == "PSSPLS")
    {
    if (FeatCheck("Carpentry", oPC)==FALSE) {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    if (GetHasFeat(1442, oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat."); return;} //craft staff feat check
    if (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>=9) {} else {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    sItem="ceb_stafffauna";
    nCR = 20;
    nCost = 19406;
    nXP = 1900;
    sType = "Staff";
    sReq="te_cebcraft034";
    sDesc = "This staff is often created by druids to store spells for their animal companions.";
    }

/* Staff of Fire */
if (sRecipe == "PSSPLL")
    {
    if (FeatCheck("Carpentry", oPC)==FALSE) {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    if (GetHasFeat(1442, oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat."); return;} //craft staff feat check
    if (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>=8 ||
        GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>=8 ||
        GetLevelByClass(57, oPC)>=8 ) {} else {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    sItem="te_item_4008";
    nCR = 18;
    nCost = 14250;
    nXP = 1425;
    sType = "Staff";
    sReq="te_cebcraft034";
    sDesc = "Made of smokey, blasted wood, this staff allows use of spells which command the element of fire.";
    }

/* Wooden Magic Staff*/
if (sRecipe == "SSPPPS")
    {
    if (FeatCheck("Carpentry", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_magicstaff";
    nCR = 19;
    nCost = 250;
    sType = "Staff";
    sReq="te_cebcraft034";
    sDesc = "A staff prepared with arcane symbols running the length of the wood.";
    }

/* Arcanist's Quarterstaff*/
if (sRecipe == "PSSPLP")
    {
    if (FeatCheck("Carpentry", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_item_8151";
    nCR = 17;
    nCost = 1000;
    nXP = 100;
    sType = "Weapon";
    sReq="te_cebcraft034";
    sDesc = "A quarterstaff with arcane symbols running the length of the wood.";
    }

/*Ornate Staff*/
if (sRecipe == "SSLPPL")
    {
    if (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>=7) {} else {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    if (FeatCheck("Carpentry", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_holysword12";
    nCR = 21;
    nCost = 2500;
    nXP = 500;
    sType = "Weapon";
    sReq = "te_cebcraft034";
    //sDesc = "The spear consists of a pointed head combined with a wooden shaft.";
    }

/* Rod of Dimension Door */
if (sRecipe == "PSSSLP")
    {
    if (FeatCheck("Carpentry", oPC)==FALSE) {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    if (GetHasFeat(1441, oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat."); return;} //craft rod feat check
    if (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>=8 ||
        GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>=8 ||
        GetLevelByClass(57, oPC)>=8 ) {} else {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    sItem="te_item_4005";
    nCR = 22;
    nCost = 14250;
    nXP = 1425;
    sType = "Rod";
    sReq="te_cebcraft034";
    sDesc = "Made of hollowed wood, this rod enables the bearer to use the spell dimension door.";
    }

/* Rod of Negation */
if (sRecipe == "PSSSPL")
    {
    if (FeatCheck("Carpentry", oPC)==FALSE) {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    if (GetHasFeat(1441, oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat."); return;} //craft rod feat check
    if (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>=13 ||
        GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>=13 ||
        GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>=13 ||
        GetLevelByClass(57, oPC)>=13 ) {} else {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    sItem="te_item_3014";
    nCR = 24;
    nCost = 18500;
    nXP = 1850;
    sType = "Rod";
    sReq="te_cebcraft034";
    sDesc = "Made of simple wood, this rod enables the bearer to negate powerful magical effects in their line of sight.";
    }

/* Harp */
if (sRecipe == "PPPSLP")
    {
    if (FeatCheck("Carpentry", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_item_8723";
    nCR = 16;
    nCost = 25;
    sType = "Weapon";
    sReq="te_cebcraft034";
    sDesc = "This piece of wood has been lightly fashioned into a handheld harp.";
    }

/* Tantan */
if (sRecipe == "PPSLPP")
    {
    if (FeatCheck("Carpentry", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_item_8726";
    nCR = 16;
    nCost = 25;
    sType = "Weapon";
    sReq="te_cebcraft034";
    sDesc = "This piece of wood has been lightly fashioned into a handheld hand drum or tantan.";
    }

/* Yarting */
if (sRecipe == "PPSLLP")
    {
    if (FeatCheck("Carpentry", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_item_8725";
    nCR = 16;
    nCost = 25;
    sType = "Weapon";
    sReq="te_cebcraft034";
    sDesc = "This piece of wood has been lightly fashioned into the popular instrument known as the yarting.";
    }

/* BLACKSMITHING */
/*Halberd*/
if (sRecipe == "BBHBBT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_WPLHB001";
    nCR = 18;
    nCost = 10;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "The halberd consists of a curving axe head combined with a long spear mounted onto an 8-foot-long pole.";
    }

/*Ornate Halberd*/
if (sRecipe == "BBHBTT")
    {
    if (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>=7) {} else {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_holysword5";
    nCR = 21;
    nCost = 1000;
    nXP = 500;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    //sDesc = "The spear consists of a pointed head combined with a wooden shaft.";
    }

/*Spear 2h*/
if (sRecipe == "BBHBBH")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_WPLSS001";
    nCR = 18;
    nCost = 10;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "The spear consists of a pointed head combined with a wooden shaft.";
    }

/*Metal Staff*/
if (sRecipe == "BBHHHH")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_WDBQS001";
    nCR = 18;
    nCost = 10;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "This is a metal staff, and it weighs a bit more than it appears to. This type of weapon was first developed by Taerom Fuiruim, one of the most renowned blacksmiths in all of Faerun.";
    }

/* Metal Magic Staff*/
if (sRecipe == "THHBHH")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_magicstaff2";
    nCR = 19;
    nCost = 250;
    sType = "Staff";
    sReq="te_cebcraft022";
    sDesc = "A staff prepared with esoteric symbols running the length of the metal.";
    }

/*Silvermaid's Spear*/
if (sRecipe == "BBHBHH")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_sp_lurue";
    nCR = 20;
    nCost = 1000;
    nXP = 100;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "A spear with symbols venerating Lurue.";
    }

/*Stormlord's Spear*/
if (sRecipe == "BBHBHT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_sp_talos";
    nCR = 20;
    nCost = 1000;
    nXP = 100;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "A spear with symbols venerating Talos.";
    }

/*Waveservant's Spear*/
if (sRecipe == "BBHTTH")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_sp_umberlee";
    nCR = 20;
    nCost = 1000;
    nXP = 100;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "A spear with symbols venerating Umberlee.";
    }

/*Spear of the Seldarine*/
if (sRecipe == "BBHBTH")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_item_8524";
    nCR = 20;
    nCost = 1000;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "A spear with symbols venerating the Seldarine, but specifically Angharradh, the Queen of the Seldarine.";
    }

/*Spear 1h*/
if (sRecipe == "BBHBBB")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_item_8454";
    nCR = 18;
    nCost = 10;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "The spear consists of a pointed head combined with a wooden shaft.";
    }

/*Ornate Spear*/
if (sRecipe == "BBHTHH")
    {
    if (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>=7) {} else {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_holysword14";
    nCR = 21;
    nCost = 1000;
    nXP = 500;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    //sDesc = "The spear consists of a pointed head combined with a wooden shaft.";
    }

/*Ornate Lance*/
if (sRecipe == "BBHBHB")
    {
    if (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>=7) {} else {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_holysword7";
    nCR = 21;
    nCost = 1000;
    nXP = 500;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    //sDesc = "The spear consists of a pointed head combined with a wooden shaft.";
    }

/*Greataxe*/
if (sRecipe == "BBHHTT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_WAXGR001";
    nCR = 20;
    nCost = 20;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "The greataxe is a large, heavy battleaxe with a double-bladed head. The haft is usually stout wood and longer than even a dwarven waraxe. The grip is about half the length of the haft.";
    }

/*Dwarven Waraxe*/
if (sRecipe == "BBHHHT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="x2_wdwraxe001";
    nCR = 21;
    nCost = 21;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "The Dwarven waraxe is the pride of Dwarven warriors. Every aspect of its design was a celebration of Dwarven history and culture.";
    }

/*Chainmail*/
if (sRecipe == "BTHTTB")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_AARCL004";
    nCR = 15;
    nCost = 150;
    sType = "Armor";
    sReq = "te_cebcraft014";
    sDesc = "Mail is a type of armour consisting of small metal rings linked together in a pattern to form a mesh.";
    }

/*Diremace*/
if (sRecipe == "BBTHHB")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_WDBMA001";
    nCR = 26;
    nCost = 90;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "This two handed weapon resembles a quarterstaff with a mace head at each end.";
    }

/*Helmet*/
if (sRecipe == "BBTTBT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_craft_helm";
    nCR = 11;
    nCost = 5;
    sType = "Helm";
    sReq = "te_cebcraft010";
    sDesc = "A metal helmet.";
    }

/*Two Bladed Sword*/
if (sRecipe == "BHBBTT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_WDBSW001";
    nCR = 26;
    nCost = 100;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "This two handed weapon resembles a quartestraff with a sword blade at each end.";
    }

/*Double Axe*/
if (sRecipe == "BHBHHB")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_WDBAX001";
    nCR = 26;
    nCost = 60;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "This two handed weapon resembles a quarterstaff with an axe head at each end.";
    }

/*Breastplate*/
if (sRecipe == "BHHTBT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_AARCL010";
    nCR = 15;
    nCost = 200;
    sType = "Armor";
    sReq = "te_cebcraft015";
    sDesc = "A breastplate covers your front and your back.  A light suit or skirt of studded leather beneath the breastplate protects your limbs without restricting movement much.";
    }

/*Battleaxe*/
if (sRecipe == "BHTHHT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_WAXBT001";
    nCR = 18;
    nCost = 10;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "The battleaxe is the most common melee weapon among dwarves.";
    }

/*Battleguard's Battleaxe*/
if (sRecipe == "BHTHHB")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_item_8394";
    nCR = 19;
    nCost = 1000;
    nXP = 100;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "The battleaxe is the most common melee weapon among dwarves.";
    }

/*Icepriest's Battleaxe*/
if (sRecipe == "BHTHBT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_sp_auril";
    nCR = 20;
    nCost = 1000;
    nXP = 100;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "A battleaxe with symbols venerating Auril.";
    }

/*Battleaxe*/
if (sRecipe == "BHTHHT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_WAXBT001";
    nCR = 18;
    nCost = 10;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "The battleaxe is the most common melee weapon among dwarves. This one has been lovingly adorned with carvings to the dwarven pantheon of gods, known as the Mordinsamman.";
    }

/*Ring*/
if (sRecipe == "BHHTTT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_cebcraft028";
    nCR = 18;
    nCost = 10;
    sType = "Jewelry";
    sReq = "te_cebcraft027";
    sDesc = "A metal ring.";
    }

/*Metal Bracers*/
if (sRecipe == "BTBBBH")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="MetalBracer";
    nCR = 15;
    nCost = 10;
    sType = "Bracer";
    sReq = "te_cebcraft033";
    sDesc = "A pair of metal bracers.";
    }

/*Metal Gauntlet*/
if (sRecipe == "BTBTHT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="MetalGauntlet";
    nCR = 15;
    nCost = 10;
    sType = "Gauntlet";
    sReq = "te_cebcraft032";
    sDesc = "A pair of metal gauntlets.";
    }

/*Ornate Gauntlet*/
if (sRecipe == "BTBTHB")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    if (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>=7) {} else {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    sItem="te_holysword1";
    nCR = 21;
    nCost = 1000;
    nXP = 500;
    sType = "Gauntlet";
    sReq = "te_cebcraft022";
    //sDesc = "This is a long double edged blade attached to a handle. It has been dedicated to the powers of goodness.";
    }

/*Malagent's Wraps*/
if (sRecipe == "BTBTHH")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_sp_talona";
    nCR = 20;
    nCost = 1000;
    nXP = 100;
    sType = "Gauntlet";
    sReq = "te_cebcraft032";
    sDesc = "A pair of gauntlets with symbols venerating Talona.";
    }

/*Painbearer's Gloves*/
if (sRecipe == "BTBTTT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_sp_ilmater";
    nCR = 20;
    nCost = 1000;
    nXP = 100;
    sType = "Gauntlet";
    sReq = "te_cebcraft032";
    sDesc = "A pair of gauntlets with symbols venerating Ilmater.";
    }

/*Talon's Claw */
if (sRecipe == "BTBHTT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_sp_malar";
    nCR = 20;
    nCost = 1000;
    nXP = 100;
    sType = "Gauntlet";
    sReq = "te_cebcraft032";
    sDesc = "A pair of gauntlets with symbols venerating Malar.";
    }

/*Sensate's Claw */
if (sRecipe == "BTBHTT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_sp_sharess";
    nCR = 20;
    nCost = 1000;
    nXP = 100;
    sType = "Gauntlet";
    sReq = "te_cebcraft032";
    sDesc = "A pair of gauntlets with symbols venerating Sharess.";
    }

/*Gauntlets of the Shining Hand */
if (sRecipe == "BTBHBT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
//    if (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>=5) {} else {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    sItem="te_item_8145";
    nCR = 16;
    nCost = 1000;
    sType = "Gauntlet";
    sReq = "te_cebcraft032";
    sDesc = "A pair of gauntlets with symbols venerating Azuth.";
    }

/*Gauntlets of the Broken Ones */
if (sRecipe == "BTBTTH")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
//    if (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>=5) {} else {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    sItem="te_item_8146";
    nCR = 16;
    nCost = 1000;
    sType = "Gauntlet";
    sReq = "te_cebcraft032";
    sDesc = "A pair of gauntlets with symbols venerating Ilmater.";
    }

/*Gauntlets of the Sun Soul */
if (sRecipe == "BTBTBH")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
//    if (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>=5) {} else {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    sItem="te_item_8147";
    nCR = 16;
    nCost = 1000;
    sType = "Gauntlet";
    sReq = "te_cebcraft032";
    sDesc = "A pair of gauntlets with symbols venerating Lathander, Selune, and Sune.";
    }

/*Gauntlets of the Dark Moon */
if (sRecipe == "BTBHTH")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
//    if (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>=5) {} else {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    sItem="te_item_8148";
    nCR = 16;
    nCost = 1000;
    sType = "Gauntlet";
    sReq = "te_cebcraft032";
    sDesc = "A pair of gauntlets with symbols venerating Shar.";
    }

/*Greatsword*/
if (sRecipe == "BTHHTB")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_WSWGS001";
    nCR = 22;
    nCost = 50;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "The greatsword is a large and powerful blade requiring both hands to wield.";
    }

/*Ornate Greatsword*/
if (sRecipe == "BTHHTH")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    if (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>=7) {} else {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    sItem="te_holysword2";
    nCR = 21;
    nCost = 1000;
    nXP = 500;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    //sDesc = "This is a long double edged blade attached to a handle. It has been dedicated to the powers of goodness.";
    }

/*Holy Champion's Greatsword*/
if (sRecipe == "BTHHHH")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_sp_torm";
    nCR = 20;
    nCost = 1000;
    nXP = 100;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "A greatsword with symbols venerating Torm.";
    }

/*Ranger's Greatsword*/
if (sRecipe == "BTHBTH")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_sp_gwaeron";
    nCR = 20;
    nCost = 1000;
    nXP = 100;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "A greatsword with symbols venerating Gwaeron Windstrom.";
    }

/*Pitted Greatsword*/
if (sRecipe == "BTHBTH")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
//    if (GetLevelByClass(CLASS_TYPE_BLACKGUARD, oPC)>=5) {} else {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    sItem="te_item_8141";
    nCR = 23;
    nCost = 100;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "A greatsword with dark symbols and signs of corrosion...";
    }

/*Bastard sword*/
if (sRecipe == "BTHHTT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_WSWBS001";
    nCR = 21;
    nCost = 45;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "The bastard sword is a large blade requiring special proficiency to wield.";
    }

/*Doomguide's Bastard sword*/
if (sRecipe == "BTHTTT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_sp_kelemvor";
    nCR = 20;
    nCost = 1000;
    nXP = 100;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "A bastard sword with symbols venerating Kelemvor.";
    }

/*Watchers's Bastard sword*/
if (sRecipe == "BTHBBB")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_sp_helm";
    nCR = 20;
    nCost = 1000;
    nXP = 100;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "A bastard sword with symbols venerating Helm.";
    }

/*Ornate Bastard Sword*/
if (sRecipe == "BTHHHT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    if (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>=7) {} else {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    sItem="te_holysword15";
    nCR = 21;
    nCost = 1000;
    nXP = 500;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    //sDesc = "This is a long double edged blade attached to a handle. It has been dedicated to the powers of goodness.";
    }

/*Full Plate*/
if (sRecipe == "BTHTHB")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_AARCL007";
    nCR = 18;
    nCost = 750;
    sType = "Armor";
    sReq = "te_cebcraft015";
    sDesc = "This heavy suit of armor covers your entire body with metal plates offering some of the best protection that can be found.";
    }

/*Watcher's Full Plate*/
if (sRecipe == "BTHTHH")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    if (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>=7) {} else {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    sItem="te_item_8156";
    nCR = 21;
    nCost = 2500;
    nXP = 500;
    sType = "Armor";
    sReq = "te_cebcraft015";
    //sDesc = "This is a long double edged blade attached to a handle. It has been dedicated to the powers of goodness.";
    }

/*Large Shield*/
if (sRecipe == "BTTBHH")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_ASHLW001";
    nCR = 12;
    nCost = 20;
    sType = "Shield";
    sReq = "te_cebcraft017";
    sDesc = "The large shield offers moderate protection while not being over cumbersome.";
    }

/*Shield of the Triad*/
if (sRecipe == "BTTBHB")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
//    if (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>=3) {} else {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    sItem="te_item_8506";
    nCR = 21;
    nCost = 1000;
    nXP = 500;
    sType = "Shield";
    sReq = "te_cebcraft017";
    //sDesc = "This is a long double edged blade attached to a handle. It has been dedicated to the powers of goodness.";
    }

/*Shield Gauntlet*/
if (sRecipe == "BTTBHT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    if (GetItemPossessedBy(oPC, "MetalGauntlet") == OBJECT_INVALID) {SendMessageToPC(oPC, "You seem to be missing something required to create this item."); return;}
    sItem="ShieldGauntlet";
    nCR = 18;
    nCost = 500;
    sType = "Armor";
    sReq = "te_cebcraft017";
    oDestroy = GetItemPossessedBy(oPC, "MetalGauntlet");
    sDesc = "The gnome Daphipine fashioned a gauntlet to the back of her shield to free her hands for casting while defending herself from stones thrown by local children during her arcane studies. This shield was created in the same fashion, and frees one's hands for spell casting.";
    }

/*Light Flail*/
if (sRecipe == "HBBBHT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_WBLFL001";
    nCR = 18;
    nCost = 8;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "Attached to this wooden handle are a number of chains ending with barbed hooks.";
    }

/*Ornate Light Flail*/
if (sRecipe == "HBBHBT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    if (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>=7) {} else {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    sItem="te_holysword";
    nCR = 21;
    nCost = 1000;
    nXP = 500;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    //sDesc = "This is a long double edged blade attached to a handle. It has been dedicated to the powers of goodness.";
    }

/*Firewalker's Light Flail*/
if (sRecipe == "HBBBBT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_sp_kossuth";
    nCR = 20;
    nCost = 1000;
    nXP = 100;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "A light flail with symbols venerating Kossuth.";
    }

/*Pitted Light Flail*/
if (sRecipe == "HBBBTH")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
//    if (GetLevelByClass(CLASS_TYPE_BLACKGUARD, oPC)>=5) {} else {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    sItem="te_item_8140";
    nCR = 19;
    nCost = 1000;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "A light flail with dark symbols and signs of corrosion...";
    }

/*Holy Censer*/
if (sRecipe == "HBBBTT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    if (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>=5) {} else {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    sItem="HolyCenser";
    nCR = 19;
    nCost = 100;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "Attached to this wooden handle is a small censer, which is filled with ceremonial herbs.";
    }

/*Light Hammer*/
if (sRecipe == "HBBTHT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_WBLHL001";
    nCR = 14;
    nCost = 1;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "A hammer.";
    }

/*Hammer of Weaponsmithing*/
if (sRecipe == "HBBTHB")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_hammerow";
    nCR = 15;
    nCost = 10000;
    nXP = 1000;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "This finely worked, magical hammer has phenomenal capabilities aiding in the construction of weapons of any kind.";
    }

/*Repair Hammer*/
if (sRecipe == "HBBTHH")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_rep_hammer";
    nCR = 15;
    nCost = 10;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    //sDesc = "A hammer.";
    }

/*Scimitar*/
if (sRecipe == "HBHHBT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_WSWSC001";
    nCR = 16;
    nCost = 10;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "The scimitar can be wielded with one hand and consists of a large curved blade.";
    }

/*Xvim Authlim Scimitar*/
if (sRecipe == "HBHHBH")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_sp_xvim";
    nCR = 20;
    nCost = 1000;
    nXP = 100;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "A scimitar with symbols venerating Xvim.";
    }

/*Shadoweir Scimitar*/
if (sRecipe == "HBHHBB")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    if (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>=5) {} else {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    sItem="te_item_6012";
    nCR = 17;
    nCost = 1000;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "A scimitar with symbols venerating Mielikki.";
    }

/*Ornate Scimitar*/
if (sRecipe == "HBHHBB")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    if (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>=7) {} else {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    sItem="te_holysword13";
    nCR = 21;
    nCost = 1000;
    nXP = 500;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    //sDesc = "This is a long double edged blade attached to a handle. It has been dedicated to the powers of goodness.";
    }

/*Sickle*/
if (sRecipe == "HBHHTB")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_WSPSC001";
    nCR = 16;
    nCost = 6;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "This curved blade with a handle was originally used for collecting the harvest.";
    }

/*Warhammer*/
if (sRecipe == "HBTTTH")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_WBLHW001";
    nCR = 18;
    nCost = 12;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "This large hammer is quite heavy and deals significant bashing damage.";
    }

/*Earthwalker's War Hammer*/
if (sRecipe == "HBTTTB")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_sp_grumbar";
    nCR = 20;
    nCost = 1000;
    nXP = 100;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "A war hammer with symbols venerating Grumbar.";
    }

/*Waterwalker's War Hammer*/
if (sRecipe == "HBTTTT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_sp_ishtisha";
    nCR = 20;
    nCost = 1000;
    nXP = 100;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "A war hammer with symbols venerating Istishia.";
    }

/*Gondsman's War Hammer*/
if (sRecipe == "HBTTBB")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_sp_gond";
    nCR = 20;
    nCost = 1000;
    nXP = 100;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "A war hammer with symbols venerating Gond.";
    }

/*Warhammer of the Mordinsamman*/
if (sRecipe == "HBTTBT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_item_8482";
    nCR = 18;
    nCost = 1000;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "This large hammer is quite heavy and deals significant bashing damage.";
    }

/*Katana*/
if (sRecipe == "HHBBHT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_WSWKA001";
    nCR = 20;
    nCost = 30;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "The katana is a finely crafted blade offering an excellent balance of power and mobility for a trained hand.";
    }

/*Rapier*/
if (sRecipe == "HHBBTH")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_WSWRP001";
    nCR = 16;
    nCost = 20;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "This long thin pointed weapon is extremely light weight offering quick movements to it's wielder.";
    }

/*Tuneservant's Rapier*/
if (sRecipe == "HHBBTT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_sp_milil";
    nCR = 20;
    nCost = 1000;
    nXP = 100;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "A rapier with symbols venerating Milil.";
    }

/*Bladesinger's Rapier*/
if (sRecipe == "HHBBTT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    if (GetItemPossessedBy(oPC, "te_item_0008") == OBJECT_INVALID) {SendMessageToPC(oPC, "You seem to be missing something required to create this item."); return;}
    sItem="te_item_8138";
    nCR = 20;
    nCost = 1000;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    oDestroy = GetItemPossessedBy(oPC, "te_item_0008");
    sDesc = "This rapier is marked with several strange symbols, which seem to have been inlaid with mithral metal.";
    }

/*Ornate Rapier*/
if (sRecipe == "HHBBTB")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    if (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>=7) {} else {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    sItem="te_holysword11";
    nCR = 21;
    nCost = 1000;
    nXP = 500;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    //sDesc = "This is a long double edged blade attached to a handle. It has been dedicated to the powers of goodness.";
    }

/*Morningstar*/
if (sRecipe == "HHBHHH")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_WBLMS001";
    nCR = 18;
    nCost = 8;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "The morning star consists of a spiked club resembling a mace with a long spike extending straight from the top and many smaller spikes around the particle of the head.";
    }

/*Ornate Mornigstar*/
if (sRecipe == "HHBHHT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    if (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>=7) {} else {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    sItem="te_holysword10";
    nCR = 21;
    nCost = 1000;
    nXP = 500;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    //sDesc = "This is a long double edged blade attached to a handle. It has been dedicated to the powers of goodness.";
    }

/*Heavy Flail*/
if (sRecipe == "HHHBTB")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_WBLFH001";
    nCR = 18;
    nCost = 15;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "This two handed variation of the flail offers weighted barbed balls at the end of several chains.";
    }

/*Ornate Heavy Flail*/
if (sRecipe == "HHBHHT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    if (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>=7) {} else {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    sItem="te_holysword6";
    nCR = 21;
    nCost = 1000;
    nXP = 500;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    //sDesc = "This is a long double edged blade attached to a handle. It has been dedicated to the powers of goodness.";
    }

/*Airwalker's Heavy Flail*/
if (sRecipe == "HHHBTH")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_sp_akadi";
    nCR = 20;
    nCost = 1000;
    nXP = 100;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "A heavy flail with symbols venerating Akadi.";
    }

/*Pitted Heavy Flail*/
if (sRecipe == "HHHBTT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    if (GetLevelByClass(CLASS_TYPE_BLACKGUARD, oPC)>=5) {} else {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    sItem="te_item_8142";
    nCR = 23;
    nCost = 1000;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "A heavy flail with dark symbols and signs of corrosion...";
    }

/*Half Plate*/
if (sRecipe == "HTHBBT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_AARCL006";
    nCR = 17;
    nCost = 600;
    sType = "Armor";
    sReq = "te_cebcraft015";
    sDesc = "This armor is a combination of chainmail and metal plates.";
    }

/*Chain Shirt*/
if (sRecipe == "HTTBHT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_AARCL012";
    nCR = 14;
    nCost = 100;
    sType = "Armor";
    sReq = "te_cebcraft014";
    sDesc = "The chain shirt offers significant mobility while protecting the torso with woven metal rings.";
    }

/*Necklace*/
if (sRecipe == "HTTBTT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_cebcraft029";
    nCR = 18;
    nCost = 10;
    sType = "Jewelry";
    sReq = "te_cebcraft027";
    sDesc = "A fine chain necklace.";
    }

/*Holy Symbol*/
if (sRecipe == "HTTBTH")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    if (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>=3 ||
        GetLevelByClass(CLASS_TYPE_DRUID, oPC)>=3 ||
        GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>=3 ||
        GetLevelByClass(CLASS_TYPE_RANGER, oPC)>=3 ||
        GetLevelByClass(CLASS_TYPE_MONK, oPC)>=3) {} else {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    sItem="it_holysymbol";
    nCR = 15;
    nCost = 25;
    sType = "Jewelry";
    sReq = "te_cebcraft027";
    sDesc = "A fine chain necklace with a pendant. It could be dedicated to a deity or pantheon.";
    }

/*Nightsinger's Vigil*/
if (sRecipe == "HTTBTB")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    if (GetHasFeat(1300, oPC) == FALSE) {SendMessageToPC(oPC, "You do not have the required feats for this creation."); return;}
    sItem="te_item_7008";
    nCR = 18;
    nCost = 1000;
    sType = "Jewelry";
    sReq = "te_cebcraft027";
    sDesc = "A fine chain necklace, dedicated to the powers of darkness...";
    }

/*Brooch of Shielding*/
if (sRecipe == "HTHBTT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    if (FeatCheck("Craft_Wonderous_Item", oPC)==FALSE) {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    if (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>=3 ||
        GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>=3 ||
        GetLevelByClass(57, oPC)>=3 ) {} else {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    sItem="te_item_2011";
    nCR = 22;
    nCost = 750;
    sType = "Misc";
    sReq = "te_cebcraft027";
    sDesc = "A brooch for pinning a cloak. It imbues the wearer with a basic arcane shield when its power is called upon.";
    }

/*Splint Mail*/
if (sRecipe == "HTHBBT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_AARCL005";
    nCR = 16;
    nCost = 200;
    sType = "Armor";
    sReq = "te_cebcraft014";
    sDesc = "This armor is made of several metal bands riveted to a leather backing.";
    }

/*Throwing Axe*/
if (sRecipe == "HTHTBB")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_WTHAX001";
    nCR = 16;
    nCost = 1;
    sType = "Ranged";
    sReq = "te_cebcraft022";
    nStack = 99;
    sDesc = "A small light weight axe for throwing";
    }

/*Shuriken Throwing Star*/
if (sRecipe == "HTHTHH")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_WTHSH001";
    nCR = 16;
    nCost = 1;
    sType = "Ranged";
    sReq = "te_cebcraft022";
    nStack = 99;
    sDesc = "A small light star for throwing";
    }

/*Dweomerkeepers Throwing Star*/
if (sRecipe == "HTHBHT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_sp_mystra";
    nCR = 20;
    nCost = 1000;
    nXP = 100;
    sType = "Ranged";
    sReq = "te_cebcraft022";
    nStack = 99;
    sDesc = "A throwing star with symbols venerating Mystra.";
    }

/*Joydancer's Throwing Star*/
if (sRecipe == "HTHHBB")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_sp_lliira";
    nCR = 20;
    nCost = 1000;
    nXP = 100;
    sType = "Ranged";
    sReq = "te_cebcraft022";
    nStack = 99;
    sDesc = "A throwing star with symbols venerating Lliira.";
    }

/*Mace*/
if (sRecipe == "HTHTTB")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_WBLML001";
    nCR = 16;
    nCost = 5;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "A mace is a weapon with a heavy head, sometimes with flanged or knobbed additions, on the end of a handle.";
    }

/*Heavy Mace*/
if (sRecipe == "HTBTTB")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_item_8574";
    nCR = 18;
    nCost = 5;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "A mace is a weapon with a heavy head, sometimes with flanged or knobbed additions, on the end of a handle.";
    }

/*Nightcloak's Mace*/
if (sRecipe == "HTHTTT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_sp_shar";
    nCR = 20;
    nCost = 1000;
    nXP = 100;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "A light mace with symbols venerating Shar.";
    }

/*Highborn's Mace*/
if (sRecipe == "HTHTBT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_sp_siamorphe";
    nCR = 20;
    nCost = 1000;
    nXP = 100;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "A light mace with symbols venerating Siamorphe.";
    }

/*Morninglord's Mace*/
if (sRecipe == "HTHTBH")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_sp_lathander";
    nCR = 20;
    nCost = 1000;
    nXP = 100;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "A mace with symbols venerating Lathander.";
    }

/*Silverstar's Mace*/
if (sRecipe == "HTHHTT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_sp_selune";
    nCR = 20;
    nCost = 1000;
    nXP = 100;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "A mace with symbols venerating Selune.";
    }

/*Ornate Mace*/
if (sRecipe == "HTHHBT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    if (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>=7) {} else {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    sItem="te_holysword9";
    nCR = 21;
    nCost = 1000;
    nXP = 500;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    //sDesc = "This is a long double edged blade attached to a handle. It has been dedicated to the powers of goodness.";
    }

/*Longsword*/
if (sRecipe == "THBTHT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_WSWLS001";
    nCR = 18;
    nCost = 15;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "This is a long double edged blade attached to a handle.";
    }

/*Ornate Longsword*/
if (sRecipe == "THBTTB")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    if (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>=7) {} else {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    sItem="te_holysword";
    nCR = 21;
    nCost = 1000;
    nXP = 500;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "This is a long double edged blade attached to a handle. It has been dedicated to the powers of goodness.";
    }

/*Strifeleader's Longsword*/
if (sRecipe == "THBTBT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_sp_cyric";
    nCR = 20;
    nCost = 1000;
    nXP = 100;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "A longsword with symbols venerating Cyric.";
    }

/*Lorekeeper's Longsword*/
if (sRecipe == "THBTTT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_sp_oghma";
    nCR = 20;
    nCost = 1000;
    nXP = 100;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "A longsword with symbols venerating Oghma.";
    }

/*Demarch's Longsword*/
if (sRecipe == "THBTTH")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_sp_mask";
    nCR = 20;
    nCost = 1000;
    nXP = 100;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "A longsword with symbols venerating Mask.";
    }

/*Holy Justices's Longsword*/
if (sRecipe == "THBTHB")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_sp_tyr";
    nCR = 20;
    nCost = 1000;
    nXP = 100;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "A longsword with symbols venerating Tyr.";
    }

/*Bloodreavers's Longsword*/
if (sRecipe == "THBTHH")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_sp_garagos";
    nCR = 20;
    nCost = 1000;
    nXP = 100;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "A longsword with symbols venerating Garagos.";
    }

/*Holy Strategist's Longsword*/
if (sRecipe == "THBHHH")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_sp_redknight";
    nCR = 20;
    nCost = 1000;
    nXP = 100;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "A longsword with symbols venerating Red Knight.";
    }

/*Longsword of the Seldarine*/
if (sRecipe == "THBHHT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_item_8480";
    nCR = 19;
    nCost = 1000;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "A longsword with symbols venerating the elven pantheon of gods, known as the Seldarine.";
    }

/*Arcanist's Longsword*/
if (sRecipe == "THBBHT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_item_8150";
    nCR = 19;
    nCost = 1000;
    nXP = 100;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "A longsword with arcane symbols running the length of the blade.";
    }

/*Bladesinger's Longsword*/
if (sRecipe == "THBBTH")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    if (GetItemPossessedBy(oPC, "te_item_0008") == OBJECT_INVALID) {SendMessageToPC(oPC, "You seem to be missing something required to create this item."); return;}
    sItem="te_item_9006";
    nCR = 17;
    nCost = 1000;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    oDestroy = GetItemPossessedBy(oPC, "te_item_0008");
    sDesc = "This longsword is marked with several strange symbols, which seem to have been inlaid with mithral metal.";
    }

/*Pitted Longsword*/
if (sRecipe == "THBBBB")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
//    if (GetLevelByClass(CLASS_TYPE_BLACKGUARD, oPC)>=5) {} else {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    sItem="te_item_8139";
    nCR = 19;
    nCost = 1000;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "A longsword with sinister looking symbols, and signs of corrosion...";
    }

/*Sword of the Triad*/
if (sRecipe == "THBBTT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    if (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>=5) {} else {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    sItem="te_item_8505";
    nCR = 18;
    nCost = 1000;
    sType = "Weapon";
    sReq = "te_cebcraft022";
   //sDesc = "A scimitar with symbols venerating Mielikki.";
    }

/*Falchion*/
if (sRecipe == "THBBBH")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_item_5004";
    nCR = 17;
    nCost = 25;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    //sDesc = "The spear consists of a pointed head combined with a wooden shaft.";
    }

/*Ornate Falchion*/
if (sRecipe == "THBBBT")
    {
    if (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>=7) {} else {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_holysword4";
    nCR = 21;
    nCost = 1000;
    nXP = 500;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    //sDesc = "The spear consists of a pointed head combined with a wooden shaft.";
    }

/*Shortsword*/
if (sRecipe == "THHBBT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_WSWSS001";
    nCR = 16;
    nCost = 10;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "This is a short double edged blade attached to a handle.";
    }

/*Ornate Short Sword*/
if (sRecipe == "THHBBB")
    {
    if (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>=7) {} else {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_holysword16";
    nCR = 21;
    nCost = 1000;
    nXP = 500;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    //sDesc = "The spear consists of a pointed head combined with a wooden shaft.";
    }

/*Handaxe*/
if (sRecipe == "THTBBH")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_WAXHN001";
    nCR = 16;
    nCost = 6;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "A small lightweight axe.";
    }

/*Dagger*/
if (sRecipe == "THTHHT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_WSWDG001";
    nCR = 14;
    nCost = 1;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "This is a small double edged blade.";
    }

/*Glyphscribes Dagger*/
if (sRecipe == "THTHHB")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_sp_deneir";
    nCR = 20;
    nCost = 1000;
    nXP = 100;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "A dagger with symbols venerating Deneir.";
    }

/*Malefactor's Dagger*/
if (sRecipe == "THTHHH")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_sp_gargauth";
    nCR = 20;
    nCost = 1000;
    nXP = 100;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "A dagger with symbols venerating Gargauth.";
    }

/*Mistcaller's Dagger*/
if (sRecipe == "THTHTT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_sp_leira";
    nCR = 20;
    nCost = 1000;
    nXP = 100;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "A dagger with symbols venerating Leira.";
    }

/*Arcanist's Dagger*/
if (sRecipe == "THTHBH")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_item_8149";
    nCR = 15;
    nCost = 1000;
    nXP = 100;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "A dagger with arcane symbols running the length of the blade.";
    }

/*Sewing Needle*/
if (sRecipe == "THTHTH")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_rep_sewing";
    nCR = 15;
    nCost = 1;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    //sDesc = "This is a small double edged blade.";
    }

/*Ornate Dagger*/
if (sRecipe == "THTHBT")
    {
    if (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>=7) {} else {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_holysword3";
    nCR = 21;
    nCost = 1000;
    nXP = 500;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    //sDesc = "The spear consists of a pointed head combined with a wooden shaft.";
    }

/*Kama*/
if (sRecipe == "TTBHHB")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_WSPKA001";
    nCR = 17;
    nCost = 2;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "The kama is a short hooked blade at the end of a handle.";
    }

/*Monk Fan*/
if (sRecipe == "TTBHHH")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_item_8611";
    nCR = 17;
    nCost = 1000;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "This is an ornate fan with symbols depicting the strange energy known as ki.";
    }

/*Dark Moon Fan*/
if (sRecipe == "TTBHTT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_item_8612";
    nCR = 18;
    nCost = 25;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "This is an ornate fan with symbols venerating the goddess Shar.";
    }

/*Punching Dagger (kama)*/
if (sRecipe == "TTBHTB")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_item_8663";
    nCR = 18;
    nCost = 10;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    }

/*Scythe*/
if (sRecipe == "TTHTHB")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_WPLSC001";
    nCR = 18;
    nCost = 18;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "This is a long handled weapon with a large curved blade at the end.";
    }

/*Kukri*/
if (sRecipe == "TTHTHH")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_WSPKU001";
    nCR = 14;
    nCost = 8;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "The kukri is a small once-sided blade with a curve.";
    }

/*Small Shield*/
if (sRecipe == "TTHTBB")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_ASHSW001";
    nCR = 11;
    nCost = 9;
    sType = "Shield";
    sReq = "te_cebcraft017";
    sDesc = "The small shield offers minimal protection while maintaining mobility.";
    }

/*Tower Shield*/
if (sRecipe == "TTHTHT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_ASHTO001";
    nCR = 14;
    nCost = 30;
    sType = "Shield";
    sReq = "te_cebcraft017";
    sDesc = "A large heavy shield which offers full head to toe protection.";
    }

/*Watcher's Tower Shield*/
if (sRecipe == "TTHTTH")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    if (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>=7) {} else {SendMessageToPC(oPC, "You do not meet the requirements for this item."); return;}
    sItem="te_item_8157";
    nCR = 21;
    nCost = 2500;
    nXP = 500;
    sType = "Shield";
    sReq = "te_cebcraft017";
    //sDesc = "This is a long double edged blade attached to a handle. It has been dedicated to the powers of goodness.";
    }

/* Bullet */
if (sRecipe == "TTTHHH")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="NW_WAMBU001";
    nCR = 14;
    nCost = 1;
    nStack = 99;
    sType = "Ammo";
    sReq = "te_cebcraft022";
    sDesc = "A small stone.";
    }

/*Chime*/
if (sRecipe == "HTTBBT")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    sItem="te_item_8724";
    nCR = 18;
    nCost = 25;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    sDesc = "This is a small metal chime with a crisp sound.";
    }

/* Iron Golem Parts */
if (sRecipe == "TBHBBH")
    {
    if (FeatCheck("Armoring", oPC)==FALSE) {SendMessageToPC(oPC, "You do not have the required feat"); return;}
    if (GetItemPossessedBy(oPC, "te_golcraft04b") == OBJECT_INVALID) {SendMessageToPC(oPC, "You seem to be missing something required to create this item."); return;}
    sItem="te_golcraft04";
    nCR = 20;
    nCost = 1500;
    sType = "Weapon";
    sReq = "te_cebcraft022";
    }

//SendMessageToPC(oPC, IntToString(nCost));
/* MODIFIERS */
if (nMaterial == 1) nMatmod=1;
if (nMaterial == 2) nMatmod=1;
if (nMaterial == 3) nMatmod=2;
if (nMaterial == 4) nMatmod=3;
if (nMaterial == 5) nMatmod=1; /* reduce wood modifier to 1*/
if (nMaterial == 6) nMatmod=2; /* reduce darkwood modifier to 2*/
if (nMaterial == 7) nMatmod=3; /* reduce soft leather modifier to 3*/
if (nMaterial == 8) nMatmod=1; /* reduce hard leather modifier to 1*/
if (nMaterial == 9) nMatmod=1; /* reduce feather modifier to 1*/
if (nMaterial == 10) nMatmod=1; /* reduce cloth leather modifier to 1*/
if (nMaterial == 11) nMatmod=4; /* reduce enchanted cloth modifier to 1*/
if (nMaterial == 12) nMatmod=3; /* reduce dragon hide modifier to 3*/
nCR = nCR+nMatmod*nMatmod;
//SendMessageToPC(oPC, IntToString(nMaterial) + " Material");
//SendMessageToPC(oPC, IntToString(nMatmod) + " Modifier");
if (nMatmod != 1) nCost = nMatmod*nCost;
if (GetItemPossessedBy(oPC, "te_artifact") != OBJECT_INVALID) {nCR=nCR-5; SendMessageToPC(oPC, "The artifact in your possesion glimmers and you find an unexplainable force guiding your hand during crafting.");}
if ((GetAppearanceType(oPC) == APPEARANCE_TYPE_DWARF || GetAppearanceType(oPC) == APPEARANCE_TYPE_GNOME)) nCR=nCR-2;
if ((GetItemPossessedBy(oPC, "te_hammerow") != OBJECT_INVALID) && sType=="Weapon") {nCR=nCR-10; SendMessageToPC(oPC, "The hammer of weaponsmithing shines powerfully as it does nearly all of the work for you...");}

/* CHECK VALID RECIPE */
//SendMessageToPC(oPC, IntToString(nCost)+ " Cost");
if (nCost == 0)
    {
    SendMessageToPC(oPC, "Your efforts fail to produce anything of value.");
    return;
    }

/* CHECK SUFFICIENT GOLD */
if (GetGold(oPC) <= nCost-1)
    {
    SendMessageToPC(oPC, "You lack the " + IntToString(nCost) + " aenar required to craft this item.");
    return;
    }

/* CHECK THAT THE ITEM IN THE BOX IS STILL VALID */
if (GetTag(oItem) != sReq)
    {
        SendMessageToPC(oPC, "You cannot make that from this item.");
        return;
    }
if (GetLocalInt(oItem, "Days") > 0)
    {
        SendMessageToPC(oPC, "This item is not ready to be completed.");
        return;
    }
SendMessageToPC(oPC, "Roll: " + IntToString(nRoll) + "+" + IntToString(nMod) + "=" + IntToString(nRoll+nMod) + " vs " + IntToString(nCR));
if (nRoll+nMod >= nCR)
    {
    if (sRecipe == "SSMNSM" || sRecipe == "SSMMNM") oCrafted = CreateItemOnObject(sItem, oPC, nStack);/* Create containers on PC not in box */
    else oCrafted = CreateItemOnObject(sItem, oBox, nStack);
    if (sRecipe == "SSMMNM") {
        SetName(oCrafted, "Bag of Holding");
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyContainerReducedWeight(IP_CONST_CONTAINERWEIGHTRED_100_PERCENT), oCrafted);
        }
    SetDescription(oCrafted, sDesc + " This item was crafted by " + GetName(oPC), TRUE);
    SetDescription(oCrafted, sDesc + " This item was crafted by " + GetName(oPC), FALSE);
    SetLocalInt(oCrafted, "Value", nCost);
    DestroyObject(oItem);
    if (oDestroy != OBJECT_INVALID) DestroyObject(oDestroy);
    if (nXP > 0) GiveTrueXPToCreature(oPC, -nXP, FALSE);
    TakeGoldFromCreature(nCost, oPC, TRUE);
    SendMessageToPC(oPC, "You successfully craft your item.");
/*Material Modifiers*/
    if (sType == "Armor")
        {
        if (nMaterial == 1) /* Iron */
            {
                SetName(oCrafted, "Iron " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(9), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The iron used to create this suit of armor will provide a modest amount of protection against blows.", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The iron used to create this suit of armor will provide a modest amount of protection against blows.", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 12);
            }
        if (nMaterial == 2) /* Steel */
            {
                SetName(oCrafted, "Steel " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(15), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The steel used to create this suit of armor will provide a significant amount of protection against blows.", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The steel used to create this suit of armor will provide a significant amount of protection against blows.", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 25);
            }
        if (nMaterial == 3) /* mithral */
            {
                SetName(oCrafted, "Mithral " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(11), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyArcaneSpellFailure(IP_CONST_ARCANE_SPELL_FAILURE_MINUS_30_PERCENT), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_40_PERCENT), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The rare mithral used to create this item makes it very light weight, and every bit as hardy as steel.", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The rare mithral used to create this item makes it very light weight, and every bit as hardy as steel.", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 1625);
            }
        if (nMaterial == 4) /* adamantine */
            {
                SetName(oCrafted, "Adamantine " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(1), oCrafted);
                if (GetAppearanceType(oPC)==APPEARANCE_TYPE_DWARF && GetItemACValue(oCrafted) == 8) {
                    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyEnhancementBonus(1), oCrafted);
                    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_20), oCrafted);
                    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyLimitUseByRace(IP_CONST_RACIALTYPE_DWARF), oCrafted);
                    SetName(oCrafted, "Dwarven Plate");
                    SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " This adamantine armor bears the mark of a fine dwarven smith.", TRUE);
                    SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " This adamantine armor bears the mark of a fine dwarven smith.", FALSE);
                    SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 3750);
                    }
                else {
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyEnhancementBonus(1), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The rare adamantine used to create this armor makes it extremely strong.", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The rare adamantine used to create this armor makes it extremely strong.", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 3750);
                }
            }
        if (nMaterial == 5) /* wooden */
            {
                SetName(oCrafted, "Wooden " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(37), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_10_PERCENT), oCrafted);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 10);
            }

        if (nMaterial == 6) /* duskwood */
            {
                SetName(oCrafted, "Darkwood " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(39), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_40_PERCENT), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The darkwood used to create this armor makes it very light weight.", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The darkwood used to create this armor makes it very light weight.", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 125);
            }
        if (nMaterial == 7)
            {
                SetName(oCrafted, "Soft " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(31), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyACBonusVsDmgType(IP_CONST_DAMAGETYPE_PIERCING, 1), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertySkillBonus(SKILL_MOVE_SILENTLY, 2), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The soft leather used to create this armor helps to dampen the sound it makes, as much as resist piercing attacks. ", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The soft leather used to create this armor helps to dampen the sound it makes, as much as resist piercing attacks. ", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 15);
            }
        if (nMaterial == 8)
            {
                SetName(oCrafted, "Tough " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(31), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyACBonusVsDmgType(IP_CONST_DAMAGETYPE_SLASHING, 1), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertySkillBonus(SKILL_DISCIPLINE, 2), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The tough leather used to create this armor makes it harder to damage with slashing attacks. ", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The tough leather used to create this armor makes it harder to damage with slashing attacks. ", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 15);
            }
        if (nMaterial == 12)
            {
                SetName(oCrafted, "Dragon Hide " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(28), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyArcaneSpellFailure(IP_CONST_ARCANE_SPELL_FAILURE_MINUS_20_PERCENT), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The dragon's hide used to create this armor makes it ideal for spell casters. ", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The dragon's hide used to create this armor makes it ideal for spell casters. ", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 1250);
            }
    }
if (sType == "Shield")
        {
        if (nMaterial == 1) /* Iron */
            {
                SetName(oCrafted, "Iron " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(9), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The iron used to create this shield will provide a modest amount of protection from lethal attacks.", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The iron used to create this shield will provide a modest amount of protection from lethal attacks.", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 25);
            }
        if (nMaterial == 2) /* Steel */
            {
                SetName(oCrafted, "Steel " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(15), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The steel used to create this shield will provide a significant amount of protection against lethal attacks.", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The steel used to create this shield will provide a significant amount of protection against lethal attacks.", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 50);
            }
        if (nMaterial == 3) /* mithral */
            {
                SetName(oCrafted, "Mithral " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(11), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyArcaneSpellFailure(IP_CONST_ARCANE_SPELL_FAILURE_MINUS_30_PERCENT), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_40_PERCENT), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The rare mithral used to create this item makes it very light weight, and every bit as hardy as steel.", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The rare mithral used to create this item makes it very light weight, and every bit as hardy as steel", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 500);
            }
        if (nMaterial == 4) /* adamantine */
            {
                SetName(oCrafted, "Adamantine " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(1), oCrafted);
                if (GetAppearanceType(oPC)==APPEARANCE_TYPE_DWARF && GetItemACValue(oCrafted) == 3) {
                    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyEnhancementBonus(1), oCrafted);
                    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_20), oCrafted);
                    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyLimitUseByRace(IP_CONST_RACIALTYPE_DWARF), oCrafted);
                    SetName(oCrafted, "Dwarven Tower Shield");
                    SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " This adamantine shield bears the mark of a fine dwarven smith.", TRUE);
                    SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " This adamantine shield bears the mark of a fine dwarven smith.", FALSE);
                    SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 1250);
                    }
                else {
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyEnhancementBonus(1), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The rare adamantine used to create this shield makes it extremely strong.", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The rare adamantine used to create this shield makes it extremely strong.", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 1000);
                }
            }
        if (nMaterial == 5)
            {
                SetName(oCrafted, "Wooden " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(37), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_10_PERCENT), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The oakwood used to create this shield makes it very durable. ", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The oakwood used to create this shield makes it very durable. ", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 10);
            }
        if (nMaterial == 6)
            {
                SetName(oCrafted, "Darkwood " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(39), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_40_PERCENT), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The darkwood used to create this shield makes it very light weight.", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The darkwood used to create this shield makes it very light weight.", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 125);
            }
        if (nMaterial == 12)
            {
                SetName(oCrafted, "Dragon Hide " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(28), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyArcaneSpellFailure(IP_CONST_ARCANE_SPELL_FAILURE_MINUS_20_PERCENT), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The dragon's hide used to create this shield makes it ideal for spell casters.", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The dragon's hide used to create this shield makes it ideal for spell casters.", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 125);
            }
    }
    if (sType == "Weapon")
        {
        if (nMaterial == 1)
            {
                SetName(oCrafted, "Iron " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(9), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The iron used to make this weapon gives it a sufficient weight to do damage.", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The iron used to make this weapon gives it a sufficient weight to do damage.", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 25);
            }
        if (nMaterial == 2)
            {
                SetName(oCrafted, "Steel " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(15), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The steel used to forge this weapon make it an exceptional choice for inflicting real harm against foes.", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The steel used to forge this weapon make it an exceptional choice for inflicting real harm against foes.", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 50);
            }
        if (nMaterial == 3)
            {
                SetName(oCrafted, "Mithral " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(11), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_40_PERCENT), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The rare mithral used to create this weapon makes it very light weight.", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The rare mithral used to create this weapon makes it very light weight.", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 500);
            }
        if (nMaterial == 4)
            {
                SetName(oCrafted, "Adamantine " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(1), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The rare adamantine used to create this weapon makes it extremely strong.", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The rare adamantine used to create this weapon makes it extremely strong.", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 750);
            }
        if (nMaterial == 6)
            {
                SetName(oCrafted, "Darkwood " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(39), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_40_PERCENT), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The darkwood used to create this items makes it very light weight.", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The darkwood used to create this items makes it very light weight.", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 125);
            }
        if ((nMaterial == 6) && (GetBaseItemType(oCrafted)==BASE_ITEM_LONGBOW || GetBaseItemType(oCrafted)==BASE_ITEM_SHORTBOW || GetBaseItemType(oCrafted)==BASE_ITEM_LIGHTCROSSBOW || GetBaseItemType(oCrafted)==BASE_ITEM_HEAVYCROSSBOW ))
            {
                SetName(oCrafted, "Darkwood " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(39), oCrafted);
                SetLocalInt(oCrafted, "Mighty", 1);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaxRangeStrengthMod(1), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_40_PERCENT), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The darkwood used to create this items makes it very light weight.", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The darkwood used to create this items makes it very light weight.", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 125);
            }
        if (nMaterial == 7)
            {
                SetName(oCrafted, "Soft " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(31), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertySkillBonus(SKILL_MOVE_SILENTLY, 1), oCrafted);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 10);
            }
    }
    if (sType == "Ranged")
        {
        if (nMaterial == 1)
            {
                SetName(oCrafted, "Iron " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(9), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The iron used to make this ranged weapon gives it a sufficient weight to do damage.", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The iron used to make this ranged weapon gives it a sufficient weight to do damage.", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 25);
            }
        if (nMaterial == 2)
            {
                SetName(oCrafted, "Steel " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(15), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The steel used to make this ranged weapon makes it exceptionally strong.", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The steel used to make this ranged weapon it exceptionally strong.", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 50);
            }
        if (nMaterial == 3)
            {
                SetName(oCrafted, "Mithral " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(11), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_40_PERCENT), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The rare mithral used to create this ranged weapon makes it very light weight.", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The rare mithral used to create this ranged weapon makes it very light weight.", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 500);
            }
        if (nMaterial == 4)
            {
                SetName(oCrafted, "Adamantine " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(1), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyEnhancementBonus(1), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The rare adamantine used to create this ranged weapon makes it extremely strong.", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The rare adamantine used to create this ranged weapon makes it extremely strong.", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 750);
            }
        if (nMaterial == 6)
            {
                SetName(oCrafted, "Darkwood " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(39), oCrafted);
                SetLocalInt(oCrafted, "Mighty", 1);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaxRangeStrengthMod(1), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_40_PERCENT), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The darkwood used to create this ranged weapon makes it very light weight.", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The darkwood used to create this ranged weapon makes it very light weight.", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 125);
            }
        if (nMaterial == 7)
            {
                SetName(oCrafted, "Soft " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(31), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertySkillBonus(SKILL_MOVE_SILENTLY, 2), oCrafted);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 10);
            }
        if (nMaterial == 8)
            {
                SetName(oCrafted, "Tough " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(31), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertySkillBonus(SKILL_DISCIPLINE, 2), oCrafted);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 10);
            }
    }
    if (sType == "Bracer")
        {
        if (nMaterial == 1)
            {
                SetName(oCrafted, "Iron " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(9), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The iron used to forge these bracers will provide a modest amount of protection against critical blows.", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The iron used to forge these bracers will provide a modest amount of protection against critical blows.", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 25);
            }
        if (nMaterial == 2)
            {
                SetName(oCrafted, "Steel " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(15), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The steel used to forge these bracers will provide a significant amount of protection against lethal blows.", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The steel used to forge these bracers will provide a significant amount of protection against lethal blows.", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 50);
            }
        if (nMaterial == 3)
            {
                SetName(oCrafted, "Mithral " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(11), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyArcaneSpellFailure(IP_CONST_ARCANE_SPELL_FAILURE_MINUS_15_PERCENT), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The rare mithral used to create these bracers makes them very light weight, and every bit as strong as steel in terms of protection from lethal blows.", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The rare mithral used to create these bracers makes them very light weight, and every bit as strong as steel in terms of protection from lethal blows.", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 500);
            }
        if (nMaterial == 4)
            {
                SetName(oCrafted, "Adamantine " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(1), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_1,IP_CONST_DAMAGESOAK_5_HP), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The rare adamantine used to create these bracers makes them extremely strong. The level of protection it provides is unprecedented.", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The rare adamantine used to create these bracers makes them extremely strong. The level of protection it provides is unprecedented.", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 2500);
            }
    }
    if (sType == "Boots")
        {
        if (nMaterial == 7)
            {
                SetName(oCrafted, "Soft " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(31), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertySkillBonus(SKILL_MOVE_SILENTLY, 2), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The soft leather used to create these boots help the wearer tread quietly.", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The soft leather used to create these boots help the wearer tread quietly.", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 75);
            }
        if (nMaterial == 8)
            {
                SetName(oCrafted, "Tough " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(31), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertySkillBonus(SKILL_DISCIPLINE, 2), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The hard leather used to create these boots provide durable and steady traction during combat.", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The hard leather used to create these boots provide durable and steady traction during combat.", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 75);
            }
    }
    if (sType == "Belt")
        {
        if (nMaterial == 7)
            {
                SetName(oCrafted, "Soft " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(31), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyACBonusVsDmgType(IP_CONST_DAMAGETYPE_PIERCING, 1), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The soft leather used to create this belt helps to insulate from piercing attacks.", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The soft leather used to create this belt helps to insulate from piercing attacks.", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 75);
            }
        if (nMaterial == 8)
            {
                SetName(oCrafted, "Tough " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(31), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyACBonusVsDmgType(IP_CONST_DAMAGETYPE_SLASHING, 1), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The hard leather used to create this belt helps to fend off slashing attacks.", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The hard leather used to create this belt helps to fend off slashing attacks.", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 75);
           }
    }
    if (sType == "Cloak")
        {
        if (nMaterial == 7)
            {
                SetName(oCrafted, "Soft " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(31), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertySkillBonus(SKILL_MOVE_SILENTLY, 2), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The soft leather used to create this cloak allows the wearer to move more quietly.", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The soft leather used to create this cloak allows the wearer to move more quietly.", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 75);
            }
        if (nMaterial == 10)
            {
                SetName(oCrafted, "Cloth " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(33), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The cotton fibers used to stitch this cloak are soft and insulating.", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The cotton fibers used to stitch this cloak are soft and insulating.", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 5);
            }
    }
    if (sType == "Gauntlet")
        {
        if (nMaterial == 1)
            {
                SetName(oCrafted, "Iron " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(9), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_BLUDGEONING,IP_CONST_DAMAGEBONUS_1d4), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The iron used to create this gauntlet makes it very serviceable as an improvised weapon.", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The iron used to create this gauntlet makes it very serviceable as an improvised weapon.", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 25);
            }
        if (nMaterial == 2)
            {
                SetName(oCrafted, "Steel " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(15), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_BLUDGEONING,IP_CONST_DAMAGEBONUS_1d4), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The steel used to create this gauntlet makes it very serviceable as an improvised weapon, as well as provides a considerable amount of protection.", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The steel used to create this gauntlet makes it very serviceable as an improvised weapon, as well as provides a considerable amount of protection.", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 50);
            }
        if (nMaterial == 3)
            {
                SetName(oCrafted, "Mithral " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(11), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_BLUDGEONING,IP_CONST_DAMAGEBONUS_1d4), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyArcaneSpellFailure(IP_CONST_ARCANE_SPELL_FAILURE_MINUS_5_PERCENT), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The rare mithral used to create these gauntlets makes them very light weight and every bit as strong as steel.", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The rare mithral used to create these gauntlets makes them very light weight and every bit as strong as steel.", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 500);
            }
        if (nMaterial == 4)
            {
                SetName(oCrafted, "Adamantine " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(1), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_BLUDGEONING,IP_CONST_DAMAGEBONUS_1d4), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyEnhancementBonus(1), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The rare adamantine used to create these gauntlets makes them extremely strong.", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The rare adamantine used to create these gauntlets makes them extremely strong.", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 750);
            }
    }
    if (sType == "Staff")
        {
        if (nMaterial == 1)
            {
                SetName(oCrafted, "Iron " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(9), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_BLUDGEONING,IP_CONST_DAMAGEBONUS_1), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyWeightIncrease(IP_CONST_WEIGHTINCREASE_5_LBS), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The iron used to create this staff makes it durable and suitable for striking.", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The iron used to create this staff makes it durable and suitable for striking.", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 25);
            }
        if (nMaterial == 2)
            {
                SetName(oCrafted, "Steel " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(15), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_BLUDGEONING,IP_CONST_DAMAGEBONUS_2), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyWeightIncrease(IP_CONST_WEIGHTINCREASE_5_LBS), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The steel used to create this staff makes it strong and suitable for striking.", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The steel used to create this staff makes it strong and suitable for striking.", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 50);
            }
        if (nMaterial == 3)
            {
                SetName(oCrafted, "Mithral " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(11), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_BLUDGEONING,IP_CONST_DAMAGEBONUS_2), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyArcaneSpellFailure(IP_CONST_ARCANE_SPELL_FAILURE_MINUS_5_PERCENT), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The rare mithral used to create this staff makes it very light weight.", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The rare mithral used to create this staff makes it very light weight.", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 500);
            }
        if (nMaterial == 4)
            {
                SetName(oCrafted, "Adamantine " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(1), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_BLUDGEONING,IP_CONST_DAMAGEBONUS_1d6), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyWeightIncrease(IP_CONST_WEIGHTINCREASE_5_LBS), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The rare adamantine used to create this staff makes it extremely strong.", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The rare adamantine used to create this staff makes it extremely strong.", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 750);
            }
    }
    if (sType == "Helm")
        {
        if (nMaterial == 1)
            {
                SetName(oCrafted, "Iron " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(9), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The iron used to create this helmet will provide a modest amount of protection against lethal blows.", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The iron used to create this helmet will provide a modest amount of protection against lethal blows.", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 25);
            }
        if (nMaterial == 2)
            {
                SetName(oCrafted, "Steel " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(15), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The steel used to create this helmet will provide a significant amount of protection against lethal blows.", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The steel used to create this helmet will provide a significant amount of protection against lethal blows.", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 50);
            }
        if (nMaterial == 3)
            {
                SetName(oCrafted, "Mithral " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(11), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyArcaneSpellFailure(IP_CONST_ARCANE_SPELL_FAILURE_MINUS_10_PERCENT), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The rare mithral used to create this helmet makes it very light weight, and every bit as strong as steel for the purpose of turning away otherwise lethal blows.", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The rare mithral used to create this helmet makes it very light weight, and every bit as strong as steel for the purpose of turning away otherwise lethal blows.", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 500);
            }
        if (nMaterial == 4)
            {
                SetName(oCrafted, "Adamantine " + GetName(oCrafted));
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaterial(1), oCrafted);
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_1,IP_CONST_DAMAGESOAK_5_HP), oCrafted);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The rare adamantine used to create this helmet makes it extremely strong. It provides an unparalleled level of protection.", TRUE);
                SetDescription(oCrafted, GetDescription(oCrafted, FALSE, TRUE) + " The rare adamantine used to create this helmet makes it extremely strong. It provides an unparalleled level of protection.", FALSE);
                SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value") + 2500);
            }
    }
/* Masterwork (Material 2 is steel and gets boost to masterwork chance */
if (nMaterial == 2 || nMaterial==3 || nMaterial==4) nMod=nMod+10;
if (nRoll > 25-nMod || nRoll == 20 || GetGoldPieceValue(oCrafted) > 2500)
    {
        DelayCommand(0.01, SetLocalInt(oCrafted, "Masterwork", 1));
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyQuality(IP_CONST_QUALITY_MASTERWORK), oCrafted);
        SetName(oCrafted, "Masterwork " + GetName(oCrafted));
        SetLocalInt(oCrafted, "Value", GetLocalInt(oCrafted, "Value")+300);
        SendMessageToPC(oPC, "The item is of Masterwork quality.");
    }
}

else
    {
    SendMessageToPC(oPC, "You fail to craft your item.");
    TakeGoldFromCreature(nCost/10, oPC, TRUE);
    SetLocalInt(oItem, "Date", GetCalendarDay());
    if (nRoll == 1)
        {
        if (GetItemPossessedBy(oPC, "te_artifact") != OBJECT_INVALID && GetLocalInt(GetItemPossessedBy(oPC, "te_artifact"), "Decay") < 5)
            {SetLocalInt(GetItemPossessedBy(oPC, "te_artifact"), "Decay", GetLocalInt(GetItemPossessedBy(oPC, "te_artifact"), "Decay")+1);
            SendMessageToPC(oPC, "You nearly destroy the item in your attempt, however an unknown power intervenes and guides your hand. The artifact in your possession decays a little bit.");
            }
        else if (GetItemPossessedBy(oPC, "te_artifact") != OBJECT_INVALID && GetLocalInt(GetItemPossessedBy(oPC, "te_artifact"), "Decay") >= 5)
            {DestroyObject(GetItemPossessedBy(oPC, "te_artifact"));
            SendMessageToPC(oPC, "You nearly destroy the item in your attempt, however an unknown power intervenes and guides your hand. The artifact in your possession disintegrates and turns to dust.");
            }
        else {
            DestroyObject(oItem);
            SendMessageToPC(oPC, "Critical Failure! The item is ruined in the process.");
            }
        }
    }
}

//oPC == Object you wish to give XP to. Only PCs have multiclassing penalty.
//nXPToGive == Amount of XP Reward. If negative, multiclassing penalty will never be calculated or looked at.
//nMulticlass == TRUE for assessing multiclassing penalty. Default = 0/False.
void GiveTrueXPToCreature(object oPC, int nXPToGive, int nMulticlass)
{
    if(nXPToGive < 0)
    {
        SetXP(oPC,GetXP(oPC)+(nXPToGive));
    }
    else
    {
        if(nMulticlass == TRUE)
        {
            object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");
            if(GetLocalInt(oItem,"iMulticlass") == TRUE)
            {
                nXPToGive = (nXPToGive - FloatToInt(IntToFloat(nXPToGive)*0.20));
                SetXP(oPC,GetXP(oPC)+nXPToGive);
            }
            else
            {
                SetXP(oPC,GetXP(oPC)+(nXPToGive));
            }
        }
        else
        {
            SetXP(oPC,GetXP(oPC)+(nXPToGive));
        }
    }
}
