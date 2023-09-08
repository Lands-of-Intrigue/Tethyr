#include "x2_inc_itemprop"
#include "x2_inc_switches"
#include "ceb_featcheck"

const int CEP_BASE_ITEM_Wood = 200;
const int CEP_BASE_ITEM_Widget = 201;
const int CEP_BASE_ITEM_Social_BeerMug = 202;
const int CEP_BASE_ITEM_Coins = 203;
const int CEP_BASE_ITEM_ThinBox = 204;
const int CEP_BASE_ITEM_HerbSmall = 205;
const int CEP_BASE_ITEM_HerbThin = 206;
const int CEP_BASE_ITEM_stacksmall1 = 207;
const int CEP_BASE_ITEM_PeltLarge = 208;
const int CEP_BASE_ITEM_PeltThin = 209;
const int CEP_BASE_ITEM_TinySpear = 210;
const int CEP_BASE_ITEM_miscsmall3 = 211;
const int CEP_BASE_ITEM_miscmedium3 = 212;
const int CEP_BASE_ITEM_trident_1h = 300;
const int CEP_BASE_ITEM_heavypick = 301;
const int CEP_BASE_ITEM_lightpick = 302;
const int CEP_BASE_ITEM_sai = 303;
const int CEP_BASE_ITEM_nunchaku = 304;
const int CEP_BASE_ITEM_falchion = 305;
const int CEP_BASE_ITEM_smallbox = 306;
const int CEP_BASE_ITEM_miscmedium2 = 307;
const int CEP_BASE_ITEM_sap = 308;
const int CEP_BASE_ITEM_daggerassn = 309;
const int CEP_BASE_ITEM_katar = 310;
const int CEP_BASE_ITEM_miscsmall2 = 311;
const int CEP_BASE_ITEM_lightmace2 = 312;
const int CEP_BASE_ITEM_kukri2 = 313;
const int CEP_BASE_ITEM_fashionacc = 314;
const int CEP_BASE_ITEM_book2 = 315;
const int CEP_BASE_ITEM_falchion_2 = 316;
const int CEP_BASE_ITEM_heavy_mace = 317;
const int CEP_BASE_ITEM_maul = 318;
const int CEP_BASE_ITEM_mercurial_longsword = 319;
const int CEP_BASE_ITEM_mercurial_greatsword = 320;
const int CEP_BASE_ITEM_scimitar_double = 321;
const int CEP_BASE_ITEM_goad = 322;
const int CEP_BASE_ITEM_windfirewheel = 323;
const int CEP_BASE_ITEM_maugdoublesword = 324;
const int CEP_BASE_ITEM_Flowers = 325;
const int CEP_BASE_ITEM_useable_torch = 326;
const int CEP_BASE_ITEM_Flowers_Crystal = 327;
const int CEP_BASE_ITEM_neckwear_scarf = 328;
const int CEP_BASE_ITEM_tool_2handed = 329;
const int CEP_BASE_ITEM_Longsword_2 = 330;
const int CEP_BASE_ITEM_makeshiftbl = 331;
const int CEP_BASE_ITEM_makeshiftbs = 332;
const int CEP_BASE_ITEM_makeshiftss = 333;
const int CEP_BASE_ITEM_fishlarge = 334;
const int CEP_BASE_ITEM_fishthin = 335;
const int CEP_BASE_ITEM_fishsmall = 336;
const int CEP_BASE_ITEM_ring_2 = 350;
const int CEP_BASE_ITEM_amulet_2 = 351;
const int CEP_BASE_ITEM_ring_armor = 353;
const int CEP_BASE_ITEM_ring_natural = 354;
const int CEP_BASE_ITEM_ring_shield = 355;
const int CEP_BASE_ITEM_amulet_armor = 356;
const int CEP_BASE_ITEM_amulet_deflect = 357;
const int CEP_BASE_ITEM_amulet_shield = 358;
const int CEP_BASE_ITEM_belt_armor = 359;
const int CEP_BASE_ITEM_belt_natural = 360;
const int CEP_BASE_ITEM_belt_shield = 361;
const int CEP_BASE_ITEM_bracer_shield = 362;
const int CEP_BASE_ITEM_torch_shield = 367;
const int CEP_BASE_ITEM_ring2_armor = 368;
const int CEP_BASE_ITEM_ring2_natural = 369;
const int CEP_BASE_ITEM_ring2_shield = 370;
const int CEP_BASE_ITEM_amulet2_armor = 371;
const int CEP_BASE_ITEM_amulet2_deflect = 372;
const int CEP_BASE_ITEM_amulet2_shield = 373;
const int CEP_BASE_ITEM_runestone = 374;
const int CEP_BASE_ITEM_miscsmall4 = 380;
const int CEP_BASE_ITEM_miscmedium4 = 381;
const int CEP_BASE_ITEM_miscthin2 = 382;
const int CEP_BASE_ITEM_miscthin3 = 383;
const int CEP_BASE_ITEM_miscthin4 = 384;
const int CEP_BASE_ITEM_misclarge2 = 385;
const int CEP_BASE_ITEM_misclarge3 = 386;
const int CEP_BASE_ITEM_misclarge4 = 387;
const int CEP_BASE_ITEM_stacksmall2 = 388;
const int CEP_BASE_ITEM_stacksmall3 = 389;
const int CEP_BASE_ITEM_stacksmall4 = 390;
const int CEP_BASE_ITEM_stackmedium1 = 391;
const int CEP_BASE_ITEM_stackmedium2 = 392;
const int CEP_BASE_ITEM_stackmedium3 = 393;
const int CEP_BASE_ITEM_stackmedium4 = 394;
const int CEP_BASE_ITEM_stackthin1 = 395;
const int CEP_BASE_ITEM_stackthin2 = 396;
const int CEP_BASE_ITEM_stackthin3 = 397;
const int CEP_BASE_ITEM_stackthin4 = 398;
const int CEP_BASE_ITEM_stacklarge1 = 399;
const int CEP_BASE_ITEM_stacklarge2 = 400;
const int CEP_BASE_ITEM_stacklarge3 = 401;
const int CEP_BASE_ITEM_stacklarge4 = 402;
const int CEP_BASE_ITEM_ring3 = 403;
const int CEP_BASE_ITEM_ring3_armor = 404;
const int CEP_BASE_ITEM_ring3_natural = 405;
const int CEP_BASE_ITEM_ring3_shield = 406;
const int CEP_BASE_ITEM_amulet3 = 407;
const int CEP_BASE_ITEM_amulet3_armor = 408;
const int CEP_BASE_ITEM_amulet3_deflect = 409;
const int CEP_BASE_ITEM_amulet3_shield = 410;
const int CEP_BASE_ITEM_gem2 = 411;
const int CEP_BASE_ITEM_gem3 = 412;

//VERSION 5/2/20 updated by Djinn
int GetArmorType(object oItem)
{
    // Make sure the item is valid and is an armor.
    if (!GetIsObjectValid(oItem))
        return -1;
    if (GetBaseItemType(oItem) != BASE_ITEM_ARMOR)
        return -1;

    // Get the identified flag for safe keeping.
    int bIdentified = GetIdentified(oItem);
    SetIdentified(oItem,FALSE);

    int nType = -1;
    switch (GetGoldPieceValue(oItem))
    {
        case    1: nType = 0; break; // None
        case    5: nType = 1; break; // Padded
        case   10: nType = 2; break; // Leather
        case   15: nType = 3; break; // Studded Leather / Hide
        case  100: nType = 4; break; // Chain Shirt / Scale Mail
        case  150: nType = 5; break; // Chainmail / Breastplate
        case  200: nType = 6; break; // Splint Mail / Banded Mail
        case  600: nType = 7; break; // Half-Plate
        case 1500: nType = 8; break; // Full Plate
    }
    // Restore the identified flag, and return armor type.
    SetIdentified(oItem,bIdentified);
    return nType;
}

void main()
{
    // Make sure this is the OnAtivateItem event
    if (GetUserDefinedItemEventNumber() != X2_ITEM_EVENT_ACTIVATE)
    {
        return;
    }

    object oTarget = GetItemActivatedTarget();
    object oPC = GetItemActivator();
    object oItem;
    int nItemCount = 0;
    object oSource;
    object oDest;
    object oCopy;
    string sType;
    int nAnim;
    int nMod;
    int nBonus;
    int nCost;
    int nEEL=0;
    int nRoll = d20(1);
    itemproperty pItemprop;
    itemproperty pAddprop;
    string sNewname;
    object oCreated;

if(GetIsObjectValid(oPC) == FALSE || GetIsObjectValid(oTarget) == FALSE)
{
    return;
}

/*Make sure the target is the combiner box*/
if (GetTag(oTarget)!="ceb_crcraftbox")
{
    SetLocalObject(oPC,"ObjectEdit",oTarget);
    SendMessageToPC(oPC, "Target selected for description/name editing. If you are crafting, the target must be the Crafter's Box.");
    return;
}
oItem = GetFirstItemInInventory(oTarget);
/*Ensure there are two items.  One valid target, one valid source*/
while (GetIsObjectValid(oItem))
    {
    nItemCount = nItemCount+1;

    //////////// DESTINATION ITEMS ONLY ////////////////////////////////////////////////////////////////////////
    if (GetBaseItemType(oItem) == BASE_ITEM_ARMOR)              {oDest=oItem; sType="Armor";}
    if (GetBaseItemType(oItem) == BASE_ITEM_AMULET)             {oDest=oItem; sType="Amulet";}
    if (GetBaseItemType(oItem) == BASE_ITEM_ARROW)              {oDest=oItem; sType="Ammo";}
    if (GetBaseItemType(oItem) == BASE_ITEM_BASTARDSWORD)       {oDest=oItem; sType="Weapon";}
    if (GetBaseItemType(oItem) == BASE_ITEM_BATTLEAXE)          {oDest=oItem; sType="Weapon";}
    if (GetBaseItemType(oItem) == BASE_ITEM_BELT)               {oDest=oItem; sType="Belt";}
    if (GetBaseItemType(oItem) == BASE_ITEM_BOLT)               {oDest=oItem; sType="Ammo";}
    if (GetBaseItemType(oItem) == BASE_ITEM_BOOTS)              {oDest=oItem; sType="Boots";}
    if (GetBaseItemType(oItem) == BASE_ITEM_BRACER)             {oDest=oItem; sType="Bracer";}
    if (GetBaseItemType(oItem) == BASE_ITEM_BULLET)             {oDest=oItem; sType="Ammo";}
    if (GetBaseItemType(oItem) == BASE_ITEM_CLOAK)              {oDest=oItem; sType="Cloak";}
    if (GetBaseItemType(oItem) == BASE_ITEM_CLUB)               {oDest=oItem; sType="Weapon";}
    if (GetBaseItemType(oItem) == BASE_ITEM_DAGGER)             {oDest=oItem; sType="Weapon";}
    if (GetBaseItemType(oItem) == BASE_ITEM_DART)               {oDest=oItem; sType="Ammo";}
    if (GetBaseItemType(oItem) == BASE_ITEM_DIREMACE)           {oDest=oItem; sType="Weapon";}
    if (GetBaseItemType(oItem) == BASE_ITEM_DOUBLEAXE)          {oDest=oItem; sType="Weapon";}
    if (GetBaseItemType(oItem) == BASE_ITEM_DWARVENWARAXE)      {oDest=oItem; sType="Weapon";}
    if (GetBaseItemType(oItem) == BASE_ITEM_GREATAXE)           {oDest=oItem; sType="Weapon";}
    if (GetBaseItemType(oItem) == BASE_ITEM_GREATSWORD)         {oDest=oItem; sType="Weapon";}
    if (GetBaseItemType(oItem) == BASE_ITEM_HALBERD)            {oDest=oItem; sType="Weapon";}
    if (GetBaseItemType(oItem) == BASE_ITEM_HANDAXE)            {oDest=oItem; sType="Weapon";}
    if (GetBaseItemType(oItem) == BASE_ITEM_HEAVYCROSSBOW)      {oDest=oItem; sType="Ranged";}
    if (GetBaseItemType(oItem) == BASE_ITEM_HEAVYFLAIL)         {oDest=oItem; sType="Weapon";}
    if (GetBaseItemType(oItem) == BASE_ITEM_HELMET)             {oDest=oItem; sType="Helm";}
    if (GetBaseItemType(oItem) == BASE_ITEM_KAMA)               {oDest=oItem; sType="Weapon";}
    if (GetBaseItemType(oItem) == BASE_ITEM_KATANA)             {oDest=oItem; sType="Weapon";}
    if (GetBaseItemType(oItem) == BASE_ITEM_KUKRI)              {oDest=oItem; sType="Weapon";}
    if (GetBaseItemType(oItem) == BASE_ITEM_LARGESHIELD)        {oDest=oItem; sType="Shield";}
    if (GetBaseItemType(oItem) == BASE_ITEM_LIGHTCROSSBOW)      {oDest=oItem; sType="Ranged";}
    if (GetBaseItemType(oItem) == BASE_ITEM_LIGHTFLAIL)         {oDest=oItem; sType="Weapon";}
    if (GetBaseItemType(oItem) == BASE_ITEM_LIGHTHAMMER)        {oDest=oItem; sType="Weapon";}
    if (GetBaseItemType(oItem) == BASE_ITEM_LIGHTMACE)          {oDest=oItem; sType="Weapon";}
    if (GetBaseItemType(oItem) == BASE_ITEM_LONGBOW)            {oDest=oItem; sType="Weapon";}
    if (GetBaseItemType(oItem) == BASE_ITEM_LONGSWORD)          {oDest=oItem; sType="Weapon";}
    if (GetBaseItemType(oItem) == BASE_ITEM_MAGICROD)           {oDest=oItem; sType="Rod";}
    if (GetBaseItemType(oItem) == BASE_ITEM_MAGICSTAFF)         {oDest=oItem; sType="Staff";}
    if (GetBaseItemType(oItem) == BASE_ITEM_MAGICWAND)          {oDest=oItem; sType="Wand";}
    if (GetBaseItemType(oItem) == BASE_ITEM_MORNINGSTAR)        {oDest=oItem; sType="Weapon";}
    if (GetBaseItemType(oItem) == BASE_ITEM_QUARTERSTAFF)       {oDest=oItem; sType="Weapon";}
    if (GetBaseItemType(oItem) == BASE_ITEM_RAPIER)             {oDest=oItem; sType="Weapon";}
    if (GetBaseItemType(oItem) == BASE_ITEM_RING)               {oDest=oItem; sType="Jewelry";}
    if (GetBaseItemType(oItem) == BASE_ITEM_SCIMITAR)           {oDest=oItem; sType="Weapon";}
    if (GetBaseItemType(oItem) == BASE_ITEM_SCYTHE)             {oDest=oItem; sType="Weapon";}
    if (GetBaseItemType(oItem) == BASE_ITEM_SHORTBOW)           {oDest=oItem; sType="Ranged";}
    if (GetBaseItemType(oItem) == BASE_ITEM_SHORTSPEAR)         {oDest=oItem; sType="Weapon";}
    if (GetBaseItemType(oItem) == BASE_ITEM_SHORTSWORD)         {oDest=oItem; sType="Weapon";}
    if (GetBaseItemType(oItem) == BASE_ITEM_SHURIKEN)           {oDest=oItem; sType="Ammo";}
    if (GetBaseItemType(oItem) == BASE_ITEM_SICKLE)             {oDest=oItem; sType="Weapon";}
    if (GetBaseItemType(oItem) == BASE_ITEM_SLING)              {oDest=oItem; sType="Ranged";}
    if (GetBaseItemType(oItem) == BASE_ITEM_SMALLSHIELD)        {oDest=oItem; sType="Shield";}
    if (GetBaseItemType(oItem) == BASE_ITEM_THROWINGAXE)        {oDest=oItem; sType="Ammo";}
    if (GetBaseItemType(oItem) == BASE_ITEM_TOWERSHIELD)        {oDest=oItem; sType="Shield";}
    if (GetBaseItemType(oItem) == BASE_ITEM_TRIDENT)            {oDest=oItem; sType="Weapon";}
    if (GetBaseItemType(oItem) == BASE_ITEM_TWOBLADEDSWORD)     {oDest=oItem; sType="Weapon";}
    if (GetBaseItemType(oItem) == BASE_ITEM_WARHAMMER)          {oDest=oItem; sType="Weapon";}
    if (GetBaseItemType(oItem) == BASE_ITEM_WHIP)               {oDest=oItem; sType="Weapon";}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_TinySpear)                {oDest=oItem; sType="Weapon";}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_trident_1h)               {oDest=oItem; sType="Weapon";}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_heavypick)                {oDest=oItem; sType="Weapon";}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_lightpick)                {oDest=oItem; sType="Weapon";}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_sai)                      {oDest=oItem; sType="Weapon";}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_nunchaku)                 {oDest=oItem; sType="Weapon";}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_falchion)                 {oDest=oItem; sType="Weapon";}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_sap)                      {oDest=oItem; sType="Weapon";}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_daggerassn)               {oDest=oItem; sType="Weapon";}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_katar)                    {oDest=oItem; sType="Weapon";}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_lightmace2)               {oDest=oItem; sType="Weapon";}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_kukri2)                   {oDest=oItem; sType="Weapon";}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_falchion_2)               {oDest=oItem; sType="Weapon";}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_heavy_mace)               {oDest=oItem; sType="Weapon";}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_maul)                     {oDest=oItem; sType="Weapon";}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_mercurial_longsword)      {oDest=oItem; sType="Weapon";}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_mercurial_greatsword)     {oDest=oItem; sType="Weapon";}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_scimitar_double)          {oDest=oItem; sType="Weapon";}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_goad)                     {oDest=oItem; sType="Weapon";}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_windfirewheel)            {oDest=oItem; sType="Weapon";}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_maugdoublesword)          {oDest=oItem; sType="Weapon";}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_tool_2handed)             {oDest=oItem; sType="Weapon";}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_Longsword_2)              {oDest=oItem; sType="Weapon";}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_makeshiftbl)              {oDest=oItem; sType="Weapon";}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_makeshiftbs)              {oDest=oItem; sType="Weapon";}
    if(GetResRef(oItem) == "wm_grenade003")              {oDest=oItem;}
    if(GetResRef(oItem) == "wm_grenade010")              {oDest=oItem;}
    if(GetResRef(oItem) == "wm_grenade011")              {oDest=oItem;}
    if(GetResRef(oItem) == "wm_grenade012")              {oDest=oItem;}
    if(GetResRef(oItem) == "te_gunammo001")              {oDest=oItem;}
    if(GetResRef(oItem) == "te_gunammo002")              {oDest=oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_makeshiftss)              {oDest=oItem; sType="Weapon";}
    if (GetBaseItemType(oItem) == BASE_ITEM_GLOVES &&
        GetTag(oItem) == "LeatherGloves")                               {oDest=oItem; sType="Gloves";}
    if (GetBaseItemType(oItem) == BASE_ITEM_GLOVES &&
        GetTag(oItem) == "MetalGauntlet")                               {oDest=oItem; sType="Gauntlet";}

    if (GetBaseItemType(oItem) == BASE_ITEM_POTIONS &&
        GetTag(oItem)!="RawJhuild" &&
        GetTag(oItem)!="RawRhul")
                                                                        {oDest=oItem; sType="Potion";}
    //////////// DESTINATION ITEMS ONLY ABOVE THIS POINT ////////////////////////////////////////////////////////////////////////


    //////////// SOURCE ITEMS ONLY FROM THIS POINT ON///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    if (GetBaseItemType(oItem) == BASE_ITEM_ENCHANTED_POTION)                   {oSource=oItem;}
    if (GetBaseItemType(oItem) == BASE_ITEM_ENCHANTED_SCROLL)                   {oSource=oItem;}
    if (GetBaseItemType(oItem) == BASE_ITEM_SPELLSCROLL)                        {oSource=oItem;}
    if (GetBaseItemType(oItem) == BASE_ITEM_GEM)                                {oSource=oItem;}
    if (GetBaseItemType(oItem) == BASE_ITEM_MISCLARGE)                          {oSource=oItem;}
    if (GetBaseItemType(oItem) == BASE_ITEM_MISCMEDIUM)                         {oSource=oItem;}
    if (GetBaseItemType(oItem) == BASE_ITEM_MISCSMALL &&
        GetTag(oItem)!="NW_IT_MSMLMISC21" &&
        GetTag(oItem)!="te_item_9005" &&
        GetTag(oItem)!="ceb_mortarandpestle")
                                                                                {oSource=oItem;}
    if (GetBaseItemType(oItem) == BASE_ITEM_MISCTALL)                           {oSource=oItem;}
    if (GetBaseItemType(oItem) == BASE_ITEM_MISCTHIN &&
        GetTag(oItem)!="NW_IT_THNMISC001")                                      {oSource=oItem;}
    if (GetBaseItemType(oItem) == BASE_ITEM_MISCWIDE)                           {oSource=oItem;}
    if (GetBaseItemType(oItem) == BASE_ITEM_SCROLL)                             {oSource=oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_Wood) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_Widget) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_Social_BeerMug) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_Coins) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_ThinBox) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_HerbSmall) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_HerbThin) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_stacksmall1) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_PeltLarge) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_PeltThin) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_miscsmall3) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_miscmedium3) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_smallbox) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_miscmedium2) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_miscsmall2) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_fashionacc) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_book2) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_Flowers) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_useable_torch) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_Flowers_Crystal) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_neckwear_scarf) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_fishlarge) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_fishthin) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_fishsmall) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_ring_2) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_amulet_2) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_ring_armor) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_ring_natural) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_ring_shield) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_amulet_armor) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_amulet_deflect) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_amulet_shield) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_belt_armor) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_belt_natural) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_belt_shield) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_bracer_shield) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_torch_shield) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_ring2_armor) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_ring2_natural) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_ring2_shield) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_amulet2_armor) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_amulet2_deflect) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_amulet2_shield) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_runestone) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_miscsmall4) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_miscmedium4) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_miscthin2) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_miscthin3) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_miscthin4) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_misclarge2) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_misclarge3) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_misclarge4) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_stacksmall2) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_stacksmall3) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_stacksmall4) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_stackmedium1) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_stackmedium2) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_stackmedium3) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_stackmedium4) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_stackthin1) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_stackthin2) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_stackthin3) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_stackthin4) {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_stacklarge1)         {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_stacklarge2)         {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_stacklarge3)         {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_stacklarge4)         {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_ring3)               {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_ring3_armor)         {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_ring3_natural)       {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_ring3_shield)        {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_amulet3)             {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_amulet3_armor)       {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_amulet3_deflect)     {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_amulet3_shield)      {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_gem2)                {oSource = oItem;}
    if(GetBaseItemType(oItem) == CEP_BASE_ITEM_gem3)                {oSource = oItem;}
    if(GetBaseItemType(oItem) == BASE_ITEM_CRAFTMATERIALSML)        {oSource = oItem;}
    if(GetBaseItemType(oItem) == BASE_ITEM_CRAFTMATERIALMED)        {oSource = oItem;}
    //////////// SOURCE ITEMS ONLY ABOVE THIS POINT ////////////////////////////////////////////////////////////////////////


    ///////////////
    //CUSTOM ADDITIONS HERE -> Any overrides not handled by the base item type that require a resref or tag check should go here!///
    ///////////////
    if(GetResRef(oItem) == "te_armorupg001") {oSource = oItem;}
    if(GetResRef(oItem) == "te_armorupg002") {oSource = oItem;}
    if(GetResRef(oItem) == "te_armorupg003") {oSource = oItem;}
    if(GetResRef(oItem) == "te_armorupg004") {oSource = oItem;}
    if(GetResRef(oItem) == "te_armorupg005") {oSource = oItem;}
    if(GetResRef(oItem) == "te_armorupg006") {oSource = oItem;}
    if(GetResRef(oItem) == "te_armorupg007") {oSource = oItem;}
    if(GetResRef(oItem) == "te_armorupg008") {oSource = oItem;}
    if(GetResRef(oItem) == "te_armorupg009") {oSource = oItem;}
    if(GetResRef(oItem) == "te_armorupg010") {oSource = oItem;}
    if(GetResRef(oItem) == "te_armorupg011") {oSource = oItem;}
    if(GetResRef(oItem) == "te_armorupg012") {oSource = oItem;}

    if(GetResRef(oItem) == "te_palupgr001") {oSource = oItem;}
    if(GetResRef(oItem) == "te_palupgr002") {oSource = oItem;}
    if(GetResRef(oItem) == "te_palupgr003") {oSource = oItem;}
    if(GetResRef(oItem) == "te_palupgr004") {oSource = oItem;}
    if(GetResRef(oItem) == "te_palupgr005") {oSource = oItem;}
    if(GetResRef(oItem) == "te_palupgr006") {oSource = oItem;}
    if(GetResRef(oItem) == "te_palupgr007") {oSource = oItem;}
    if(GetResRef(oItem) == "te_palupgr008") {oSource = oItem;}
    if(GetResRef(oItem) == "te_palupgr009") {oSource = oItem;}
    if(GetResRef(oItem) == "te_palupgr010") {oSource = oItem;}
    if(GetResRef(oItem) == "te_palupgr011") {oSource = oItem;}
    if(GetResRef(oItem) == "te_palupgr012") {oSource = oItem;}
    if(GetResRef(oItem) == "te_palupgr013") {oSource = oItem;}
    if(GetResRef(oItem) == "te_palupgr014") {oSource = oItem;}
    if(GetResRef(oItem) == "te_palupgr015") {oSource = oItem;}

    if(GetTag(oItem) == "te_kiupgrade01") {oSource = oItem;}
    if(GetTag(oItem) == "te_kiupgrade02") {oSource = oItem;}
    if(GetTag(oItem) == "te_kiupgrade03") {oSource = oItem;}
    if(GetTag(oItem) == "te_kiupgrade04") {oSource = oItem;}

    if(GetTag(oItem) == "te_bgupgrade01") {oSource = oItem;}
    if(GetTag(oItem) == "te_bgupgrade02") {oSource = oItem;}

    if(GetTag(oItem) == "te_illucraft01") {oSource = oItem;}
    if (GetTag(oItem)=="te_alembic")                            {oDest=oItem; sType="Alchemy";}   //Alchemcy Stuff
    if (GetTag(oItem)=="te_item_8463")                          {oDest=oItem; sType="Smelting";}   //Smelting Stuff
    if (GetTag(oItem)=="te_siegehammer")                        {oDest=oItem; sType="Siege";}   //Siege stuff
    if (GetTag(oItem)=="te_item_9005")                          {oDest=oItem; sType="Healing";} //Holy Water
    if (GetTag(oItem)=="NW_IT_THNMISC001")                      {oDest=oItem; sType="Healing";} /* empty bottle */
    if (GetTag(oItem)=="NW_IT_MSMLMISC21")                      {oDest=oItem; sType="Healing";} /* rags */
    if (GetTag(oItem)=="ceb_mortarandpestle")                   {oDest=oItem; sType="Herb";}
    if (GetTag(oItem)=="te_item_0010")                          {oDest=oItem; sType="Craft";} /* cloth for enchanted cloth */
    if (GetTag(oItem)=="te_item_8455")                          {oDest=oItem; sType="Trap";} /*trap creation kit*/
    if (GetTag(oItem) == "te_alchemy")                                          {oSource=oItem;}
    if (GetResRef(oItem)=="te_item_8468")                                       {oSource=oItem;}
    if (GetResRef(oItem)=="te_item_8464")                                       {oSource=oItem;}
    if (GetResRef(oItem)=="te_item_0007")                                       {oSource=oItem;}
    if (GetResRef(oItem)=="te_item_8469")                                       {oSource=oItem;}
    if (GetResRef(oItem)=="te_item_8466")                                       {oSource=oItem;}
    if (GetResRef(oItem)=="te_item_0008")                                       {oSource=oItem;}
    if (GetResRef(oItem)=="te_item_8470")                                       {oSource=oItem;}
    if (GetResRef(oItem)=="te_item_8467")                                       {oSource=oItem;}
    if (GetResRef(oItem)=="te_item_0006")                                       {oSource=oItem;}

   // if (GetResRef(oItem)=="te_bount008")                                      {oSource=oItem;}
   // if (GetResRef(oItem)=="te_bount002")                                      {oSource=oItem;}
   // if (GetResRef(oItem)=="te_bount019")                                      {oSource=oItem;}
   // if (GetResRef(oItem)=="te_bount029")                                      {oSource=oItem;}
   // if (GetResRef(oItem)=="te_bount032")                                      {oSource=oItem;}
   // if (GetResRef(oItem)=="te_bount020")                                      {oSource=oItem;}

    if (GetResRef(oItem)=="te_bount009")                                        {oSource=oItem;}
    if (GetTag(oItem)=="te_cebcraft03")                                         {oSource=oItem;}
    if (GetTag(oItem)=="te_cebcraft031")                                        {oSource=oItem;}
    if (GetTag(oItem)=="te_cebcraft035")                                        {oSource=oItem;}
    if (GetTag(oItem)=="te_cebcraft036")                                        {oSource=oItem;}
    if (GetTag(oItem)=="te_cebcraft037")                                        {oSource=oItem;}
    if (GetTag(oItem)=="RawJhuild" || GetTag(oItem)=="RawRhul" )                {oSource=oItem;}
    if (GetResRef(oItem) == "te_item_0005")                     {oDest=oItem; sType="Gauntlet";}
    if (GetResRef(oItem) == "irongauntletsmw")                  {oDest=oItem; sType="Gauntlet";}
    if (GetResRef(oItem) == "te_item_8569")                     {oDest=oItem; sType="Gauntlet";}
    if (GetResRef(oItem) == "te_item_5021hmw")                  {oDest=oItem; sType="Gauntlet";}
    if (GetResRef(oItem) == "te_ridinggloves")                  {oDest=oItem; sType="Gloves";}
    if (GetTag(oItem)=="it_comp_pwdsilv")                       {oSource=oItem;}
    if (GetResRef(oItem) == "x1_wmgrenade005")                  {oSource=oItem;}
    if (GetResRef(oItem) == "sp_plaguefire")                    {oSource=oItem;}
    if (GetResRef(oItem) == "x1_wmgrenade007")                    {oSource=oItem;}
    if (GetResRef(oItem) == "crpi_o_hematite")                    {oSource=oItem;}

    oItem = GetNextItemInInventory(oTarget);
    }

/*End the script if it does not meet the requirements*/
if (GetItemStackSize(oSource) > 1)
    {
    SendMessageToPC(oPC, "Source items cannot be stacked.");
    return;
    }
if (nItemCount != 2)
    {
    SendMessageToPC(oPC, "The combiner requires 2 items.");
    return;
    }
if (GetIsObjectValid(oSource) != TRUE || GetIsObjectValid(oDest) != TRUE)
    {
    SendMessageToPC(oPC, "These items cannot be combined.");
    return;
    }
//Use this to make it so crafting components don't need to be masterwork
//if (GetLocalInt(oDest, "Masterwork") != 1 && sType!="Healing" && sType!="Potion" && sType!="Herb" && sType!="Craft" && sType!="Alchemy" && sType!="Smelting" && sType!="Siege" && sType!="Trap" && sType!="Kit")
//    {
//    SendMessageToPC(oPC, "The target item must be masterwork.");
//    return;
//    }

// Check to make sure that weapons have a +1 EB added to them first
//this is the old code that worked//if (GetLocalInt(oDest, "Masterwork") == 1 && sType== "Weapon" && (GetLocalInt(oDest, "WeaponEnchantCount") < 1) && (GetTag(oSource)!="X2_IT_SPARSCR105") && (GetTag(oSource)!="te_palupgr001"))
  if (GetLocalInt(oDest, "Masterwork") == 1 && sType== "Weapon" && (IPGetWeaponEnhancementBonus(oDest) < 1) && (GetTag(oSource)!="X2_IT_SPARSCR105") && (GetTag(oSource)!="te_palupgr001") && (GetTag(oSource)!="te_kiupgrade01") && (GetTag(oSource)!="te_kiupgrade02") && (GetTag(oSource)!="te_kiupgrade03") && (GetTag(oSource)!="te_kiupgrade04") && (GetTag(oSource)!="te_bgupgrade01") && (GetTag(oSource)!="te_bgupgrade02") && (GetTag(oSource)!="te_illucraft01"))
    {
    SendMessageToPC(oPC, "This weapon must be enchanted with enhancement bonus before it can be imbued with an additional property.");
    return;
    }

//Check to make sure that shields and armors have a +1 AC added to them first
  if (GetLocalInt(oDest, "Masterwork") == 1 && (sType== "Shield" || sType=="Armor") && (GetLocalInt(oDest, "ArmorAC")< 1) && (GetTag(oSource)!="NW_IT_SPARSCR104") && (GetTag(oSource)!="te_illucraft01"))
    {
    SendMessageToPC(oPC, "This item must be enchanted with enhancement bonus before it can be imbued with an additional property.");
    return;
    }

// Check for specific scrolls that do strange things, disallow the recipe
if (GetTag(oSource) =="X2_IT_SPARSCR101") //Horizikauls Boom
    {
    SendMessageToPC(oPC, "This scroll is not suitable for any item enchantments.");
    return;
    }

// Prohibit Specialty Priest Items from being enchanted
if (GetTag(oSource) =="te_cleric_equip") //All specialty weapons
    {
    SendMessageToPC(oPC, "This weapon is dedicated to the gods, so it resists any attempt to enhance it with magic.");
    return;
    }

//Prohibit Ki Weapons from being enchanted
if (GetTag(oSource) =="KiWeapon") //all monk ki weapons
    {
    SendMessageToPC(oPC, "This weapon is infused with the strange energy referred to as ki. It resists any conventional attempts to enchant it.");
    return;
    }

// Prohibit going higher than WeaponCap 10
if (GetLocalInt(oDest, "WeaponCap") >= 10)
    {
    SendMessageToPC(oPC, "This weapon has been enchanted to the maximum extent.");
    return;
    }

// Prohibit going higher than Armor 10
if (GetLocalInt(oDest, "ArmorCap") >= 10)
    {
    SendMessageToPC(oPC, "This armor has been enchanted to the maximum extent.");
    return;
    }

// Prohibit going higher than AccessoryCap 10
if (GetLocalInt(oDest, "AccessoryCap") >= 10)
    {
    SendMessageToPC(oPC, "This accessory has been enchanted to the maximum extent.");
    return;
    }

// Prohibit Ornate Weapons from being enchanted
if (GetTag(oSource) =="te_holysword") //holy avenger tag
    {
    SendMessageToPC(oPC, "This weapon is dedicated to the gods, so it resists any attempt to enhance it with magic.");
    return;
    }

// Prohibit bladesong items from being enchanted
if (GetTag(oSource) =="te_bladesong") //bladesinger mithril weapons
    {
    SendMessageToPC(oPC, "This weapon is attuned to the bladesong, so it resists any normal attempt to enhance it with magic.");
    return;
    }

// Prohibit pitted weapons from being enchanted
if (GetTag(oSource) =="te_bg_pitted") //blackguard pitted weapons
    {
    SendMessageToPC(oPC, "This weapon is attuned to the lower planes, so it resists any normal attempt to enhance it with magic.");
    return;
    }

// Prohibit monk sash enchantment
if (GetTag(oSource) =="te_monk_sash") //monk sash on-equip
    {
    SendMessageToPC(oPC, "This sash is attuned to ki energy, so it resists any attempts to enhance it with magic.");
    return;
    }

// Prohibit wizard weapon enchantment
if (GetTag(oSource) =="te_wiz_weap") //wizard weapon on-equips
    {
    SendMessageToPC(oPC, "This weapon is attuned to spell completion energies, so it resists any attempts to permanently enchant it.");
    return;
    }

// Prohibit shadoweir weapon enchantment
if (GetTag(oSource) =="te_shadoweir") //shadoweir weapon on-equips
    {
    SendMessageToPC(oPC, "This weapon is attuned to the Supreme Ranger, so it resists any attempts to permanently enchant it.");
    return;
    }

// Prohibit Triadic weapon/shield enchantment
if (GetTag(oSource) =="te_triadic" || (GetTag(oSource) =="te_triadic2")) //triadic weapon on-equips
    {
    SendMessageToPC(oPC, "This weapon is attuned to the powers of the Triad, so it resists any attempts to permanently enchant it.");
    return;
    }

// Prohibit Watcher's on-equip enchantment
if (GetTag(oSource) =="te_helm_armor") //Helm armor on-equips
    {
    SendMessageToPC(oPC, "This armor is attuned to the Clockwork Nirvana of Mechanus, so it resists any attempts to permanently enchant it.");
    return;
    }

// Prohibit Ranger's Arrows on-equip enchantment
if (GetTag(oSource) =="te_banearrow") //Ranger's arrows on-equips
    {
    SendMessageToPC(oPC, "These arrows are attuned to the powers of nature, so they resist any attempts to permanently enchant it.");
    return;
    }

// Prohibit Monk gloves enchantment
if (GetTag(oSource) =="te_darkmoon")
    {
    SendMessageToPC(oPC, "These gloves are attuned to ki energy, so they resist any attempts to enhance them with magic.");
    return;
    }
if (GetTag(oSource)=="te_brokenones")
    {
    SendMessageToPC(oPC, "These gloves are attuned to ki energy, so they resist any attempts to enhance them with magic.");
    return;
    }
if (GetTag(oSource)== "te_shininghand")
    {
    SendMessageToPC(oPC, "These gloves are attuned to ki energy, so they resist any attempts to enhance them with magic.");
    return;
    }
if (GetTag(oSource)== "te_sunsoul") //all supported monk weaps
    {
    SendMessageToPC(oPC, "These gloves are attuned to ki energy, so they resist any attempts to enhance them with magic.");
    return;
    }

//Prohibit Potion Stack Exploits
if ((sType == "Potion") && (GetItemStackSize(oItem) >1))
    {
    SendMessageToPC(oPC, "Only a single potion can be used in the combiner at a time.");
    return;
    }

/* Verify that the item has a value */
if (GetLocalInt(oDest, "Value") < 1) SetLocalInt(oDest, "Value", GetGoldPieceValue(oDest));

/*Preparation*/
sNewname=GetName(oDest);
oCopy=CopyItem(oDest, oTarget, TRUE);
/* nEEL is Effective Enchanter Level  and is reduced as the value of the target item increases */
nEEL = (GetGoldPieceValue(oDest)/1000)*(1/7);

/*COMBINATIONS*/
/* Enchanted Cloth */
if (GetTag(oSource)=="nw_it_sparscr614" && GetTag(oDest) == "te_item_0010")
    {
    if ((GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    if (GetCasterLevel(oPC)-(nEEL) < 5)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    if (GetGold(oPC) < 2000)
        {
            SendMessageToPC(oPC, "You do not have the 2000 gold required.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        CreateItemOnObject("te_cebcraft030", oTarget, 1);
        AssignCommand(oPC, TakeGoldFromCreature(2000, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
    return;
    }

/* Bandages */
else if (GetTag(oSource)=="te_garlici" && GetTag(oDest) == "NW_IT_MSMLMISC21")
    {
    int checkDC = 10;
    if (GetGold(oPC) < 2)
        {
            SendMessageToPC(oPC, "You do not have the 2 gold required to make a bandage.");
            DestroyObject(oCopy);
            return;
        }
    if (GetHasFeat(1431, oPC) == TRUE)//Herbalism Proficiency
        {
            SendMessageToPC(oPC, "You are especially adept at creating bandages due to your proficiency with herbalism.");
            checkDC = 8;
        }
    SendMessageToPC(oPC, IntToString(nRoll) + "+" + IntToString(GetSkillRank(SKILL_HEAL, oPC)) + "=" + IntToString(nRoll+GetSkillRank(SKILL_HEAL, oPC)) + " vs DC "+IntToString(checkDC));
    if (nRoll+GetSkillRank(SKILL_HEAL, oPC) < checkDC)
        {
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
            SendMessageToPC(oPC, "You fail to create the item. The bandage is ruined.");
            DestroyObject(oSource);
            DestroyObject(oDest);
            DestroyObject(oCopy);
        }
    else
        {
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("bandages", oTarget, 1);
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 5);
        }
    return;
    }

/* Salve */
else if (GetResRef(oSource)=="te_bloodstaunchi" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    int checkDC = 12;
    if (GetGold(oPC) < 25)
        {
            SendMessageToPC(oPC, "You do not have the 25 gold required to make a salve.");
            DestroyObject(oCopy);
            return;
        }
    if (GetHasFeat(1431, oPC) == TRUE)//Herbalism Proficiency
        {
            SendMessageToPC(oPC, "You are especially adept at creating salves due to your proficiency with herbalism.");
            checkDC = 10;
        }
    SendMessageToPC(oPC, IntToString(nRoll) + "+" + IntToString(GetSkillRank(SKILL_HEAL, oPC)) + "=" + IntToString(nRoll+GetSkillRank(SKILL_HEAL, oPC)) + " vs DC "+IntToString(checkDC));
    if (nRoll+GetSkillRank(SKILL_HEAL, oPC) < checkDC)
        {
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
            SendMessageToPC(oPC, "You fail to create the item. The salve is ruined.");
            DestroyObject(oSource);
            DestroyObject(oDest);
            DestroyObject(oCopy);
            SetLocalInt(oCreated, "Value", 25);
        }
    else
        {
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_salve", oTarget, 1);
        AssignCommand(oPC, TakeGoldFromCreature(25, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 25);
        }
    return;
    }

/* Treatment */
else if (GetResRef(oSource)=="te_belladonnai" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    int checkDC = 15;
    if (GetGold(oPC) < 750)
        {
            SendMessageToPC(oPC, "You do not have the 750 gold required to make a treatment.");
            DestroyObject(oCopy);
            return;
        }
    if (GetHasFeat(1431, oPC) == TRUE)//Herbalism Proficiency
        {
            SendMessageToPC(oPC, "You are especially adept at creating treatments due to your proficiency with herbalism.");
            checkDC = 13;
        }
    SendMessageToPC(oPC, IntToString(nRoll) + "+" + IntToString(GetSkillRank(SKILL_HEAL, oPC)) + "=" + IntToString(nRoll+GetSkillRank(SKILL_HEAL, oPC)) + " vs DC "+IntToString(checkDC));
    if (nRoll+GetSkillRank(SKILL_HEAL, oPC) < checkDC)
        {
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
            SendMessageToPC(oPC, "You fail to create the item. The treatment is ruined.");
            DestroyObject(oSource);
            DestroyObject(oDest);
            DestroyObject(oCopy);
        }
    else
        {
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_treatment", oTarget, 1);
        AssignCommand(oPC, TakeGoldFromCreature(750, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 750);
        }
    return;
    }

/* Antidote - Heal Skill */
else if (GetTag(oSource)=="te_bloodpurgei" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    int checkDC = 18;
    if (GetGold(oPC) < 1400)
        {
            SendMessageToPC(oPC, "You do not have the 1400 gold required to make an antidote.");
            DestroyObject(oCopy);
            return;
        }
    if (GetHasFeat(1431, oPC) == TRUE)//Herbalism Proficiency
        {
            SendMessageToPC(oPC, "You are especially adept at creating antidotes due to your proficiency with herbalism.");
            checkDC = 16;
        }
    SendMessageToPC(oPC, IntToString(nRoll) + "+" + IntToString(GetSkillRank(SKILL_HEAL, oPC)) + "=" + IntToString(nRoll+GetSkillRank(SKILL_HEAL, oPC)) + " vs DC "+IntToString(checkDC));
    if (nRoll+GetSkillRank(SKILL_HEAL, oPC) < checkDC)
        {
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
            SendMessageToPC(oPC, "You fail to create the item. The antidote is ruined.");
            DestroyObject(oSource);
            DestroyObject(oDest);
            DestroyObject(oCopy);
        }
    else
        {
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion002", oTarget, 1);
        AssignCommand(oPC, TakeGoldFromCreature(1400, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 1400);
        }
    return;
    }

////SIEGE STUFF/////

////Launchers////
/* Siege Arbalest */
else if (GetTag(oSource)=="te_cebcraft03" && GetTag(oDest) == "te_siegehammer" && sType=="Siege")
    {
    if (GetHasFeat(1429, oPC) == FALSE)//Siege Engineering
        {
            SendMessageToPC(oPC, "You must be a Siege Engineer to do that.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        CreateItemOnObject("siege_arbalest", oTarget, 1);
        DestroyObject(oSource);
        DestroyObject(oCopy);
    return;
    }

/* Siege Onager */
else if (GetTag(oSource)=="te_cebcraft031" && GetTag(oDest) == "te_siegehammer" && sType=="Siege")
    {
    if (GetHasFeat(1429, oPC) == FALSE)//Siege Engineering
        {
            SendMessageToPC(oPC, "You must be a Siege Engineer to do that.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        CreateItemOnObject("siege_onager", oTarget, 1);
        DestroyObject(oSource);
        DestroyObject(oCopy);
    return;
    }

/* Siege Scorpion */
else if (GetTag(oSource)=="te_cebcraft037" && GetTag(oDest) == "te_siegehammer" && sType=="Siege")
    {
    if (GetHasFeat(1429, oPC) == FALSE)//Siege Engineering
        {
            SendMessageToPC(oPC, "You must be a Siege Engineer to do that.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        CreateItemOnObject("siege_scorpion", oTarget, 1);
        DestroyObject(oSource);
        DestroyObject(oCopy);
    return;
    }

///End of Launchers///
///Beginning of Ammo///

/* Siege Arbalest Ammo */
else if (GetTag(oSource)=="te_cebcraft011" && GetTag(oDest) == "te_siegehammer")
    {
    if (GetHasFeat(1429, oPC) == FALSE)//Siege Engineering
        {
            SendMessageToPC(oPC, "You must be a Siege Engineer to do that.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        CreateItemOnObject("arbaleststandard", oTarget, 1);
        DestroyObject(oSource);
        DestroyObject(oCopy);
    return;
    }

/* Siege Onager Rock */
else if (GetTag(oSource)=="te_cebcraft035" && GetTag(oDest) == "te_siegehammer")
    {
    if (GetHasFeat(1429, oPC) == FALSE)//Siege Engineering
        {
            SendMessageToPC(oPC, "You must be a Siege Engineer to do that.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        CreateItemOnObject("onagerrock", oTarget, 1);
        DestroyObject(oSource);
        DestroyObject(oCopy);
    return;
    }

/* Siege Scorpion Spear */
else if (GetTag(oSource)=="te_cebcraft036" && GetTag(oDest) == "te_siegehammer")
    {
    if (GetHasFeat(1429, oPC) == FALSE)//Siege Engineering
        {
            SendMessageToPC(oPC, "You must be a Siege Engineer to do that.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        CreateItemOnObject("scorpionspear", oTarget, 1);
        DestroyObject(oSource);
        DestroyObject(oCopy);
    return;
    }

///END OF SIEGE STUFF///

///TRAP STUFF////

/* Average Spike Trap - Trap Creation Kit and PieceofIron  */
else if (GetTag(oSource)=="PieceofIron" && GetTag(oDest) == "te_item_8455" && sType=="Trap")
    {
     if (GetLevelByClass(CLASS_TYPE_ASSASSIN, oPC) < 1)
     if (GetLevelByClass(CLASS_TYPE_RANGER, oPC) < 3)
     if (GetLevelByClass(CLASS_TYPE_ROGUE, oPC) < 3)
     if (GetLevelByClass(CLASS_TYPE_DRUID, oPC) <3)
        {
            SendMessageToPC(oPC, "Your class cannot perform this combination.");
            DestroyObject(oCopy);
            return;
        }
        nAnim = ANIMATION_LOOPING_GET_LOW;
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        CreateItemOnObject("nw_it_trap002", oTarget, 1);
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
    return;
    }

/* Average Tangle Trap - Trap Creation Kit and Spider Web  */
else if (GetTag(oSource)=="SpiderWeb" && GetTag(oDest) == "te_item_8455" && sType=="Trap")
    {
     if (GetLevelByClass(CLASS_TYPE_ASSASSIN, oPC) < 1)
     if (GetLevelByClass(CLASS_TYPE_RANGER, oPC) < 3)
     if (GetLevelByClass(CLASS_TYPE_ROGUE, oPC) < 3)
     if (GetLevelByClass(CLASS_TYPE_DRUID, oPC) <3)
        {
            SendMessageToPC(oPC, "Your class cannot perform this combination.");
            DestroyObject(oCopy);
            return;
        }
        nAnim = ANIMATION_LOOPING_GET_LOW;
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        CreateItemOnObject("nw_it_trap010", oTarget, 1);
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
    return;
    }

/* Average Fire Trap - Trap Creation Kit and Oily Flint */
else if (GetTag(oSource)=="OilyFlint" && GetTag(oDest) == "te_item_8455" && sType=="Trap")
    {
     if (GetLevelByClass(CLASS_TYPE_ASSASSIN, oPC) < 1)
     if (GetLevelByClass(CLASS_TYPE_RANGER, oPC) < 3)
     if (GetLevelByClass(CLASS_TYPE_ROGUE, oPC) < 3)
     if (GetLevelByClass(CLASS_TYPE_DRUID, oPC) <3)
        {
            SendMessageToPC(oPC, "Your class cannot perform this combination.");
            DestroyObject(oCopy);
            return;
        }
        nAnim = ANIMATION_LOOPING_GET_LOW;
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        CreateItemOnObject("nw_it_trap018", oTarget, 1);
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
    return;
    }

///Magic Traps Require Craft Wondrous Items Feat////

/* Strong Fire Trap - Trap Creation Kit and Burning Hands */
else if (GetTag(oSource)=="NW_IT_SPARSCR112" && GetTag(oDest) == "te_item_8455" && sType=="Trap")
    {
     if (GetLevelByClass(CLASS_TYPE_CLERIC, oPC) < 5)
     if (GetLevelByClass(CLASS_TYPE_WIZARD, oPC) < 5)
     if (GetLevelByClass(CLASS_TYPE_DRUID, oPC) < 5)
        {
            SendMessageToPC(oPC, "Your class cannot perform this combination.");
            DestroyObject(oCopy);
            return;
        }
         nAnim = ANIMATION_LOOPING_CONJURE1;
     if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
            CreateItemOnObject("nw_it_trap019", oTarget, 1);
            SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 2000);
            DestroyObject(oSource);
            DestroyObject(oDest);
            DestroyObject(oCopy);
            return;
        }

/* Strong Holy Trap - Trap Creation Kit and Searing light */
else if (GetTag(oSource)=="X2_IT_SPDVSCR313" && GetTag(oDest) == "te_item_8455" && sType=="Trap")
    {
     if (GetLevelByClass(CLASS_TYPE_CLERIC, oPC) < 5)
     if (GetLevelByClass(CLASS_TYPE_PALADIN, oPC) < 7)
        {
            SendMessageToPC(oPC, "Your class cannot perform this combination.");
            DestroyObject(oCopy);
            return;
        }
         nAnim = ANIMATION_LOOPING_CONJURE1;
     if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
            CreateItemOnObject("nw_it_trap007", oTarget, 1);
            SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 2000);
            DestroyObject(oSource);
            DestroyObject(oDest);
            DestroyObject(oCopy);
            return;
        }

/* Strong Negative Trap - Trap Creation Kit and Negative Energy Burst */
else if (GetTag(oSource)=="nw_it_sparscr315" && GetTag(oDest) == "te_item_8455" && sType=="Trap")
    {
     if (GetLevelByClass(CLASS_TYPE_WIZARD, oPC) < 5)
     if (GetLevelByClass(CLASS_TYPE_CLERIC, oPC) < 5)
     if (GetLevelByClass(CLASS_TYPE_PALEMASTER, oPC) < 3)
        {
            SendMessageToPC(oPC, "Your class cannot perform this combination.");
            DestroyObject(oCopy);
            return;
        }
         nAnim = ANIMATION_LOOPING_CONJURE1;
     if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
            CreateItemOnObject("nw_it_trap043", oTarget, 1);
            SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 2000);
            DestroyObject(oSource);
            DestroyObject(oDest);
            DestroyObject(oCopy);
            return;
        }

////END OF TRAP STUFF////

///Alchemy Stuff///
///Distillations///
/* Alchemist's Fire - Requires Blood of Firedrake & alembic*/
else if (GetResRef(oSource)=="te_bounty034" && GetTag(oDest) == "te_alembic")
    {
    if (GetHasFeat(1481, oPC) == FALSE && GetLevelByClass(57, oPC) < 6)//Alchemy
        {
            SendMessageToPC(oPC, "You must be an Alchemist or a Sixth-Level Artificer to do that.");
            DestroyObject(oCopy);
            return;
        }
            SendMessageToPC(oPC, IntToString(nRoll) + "+" + IntToString(GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + "=" + IntToString(nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + " vs DC 14");
            if ((nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) < 14)
        {
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
            SendMessageToPC(oPC, "You fail to create the item. The distillation is ruined.");
            DestroyObject(oSource);
            DestroyObject(oDest);
            DestroyObject(oCopy);
        }
    else
        {
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("wmgrenade003", oTarget, 1);
        DestroyObject(oSource);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 50);
        }
    return;
    }
/* Alchemist's cold - Requires Ectoplasm and Alembic */
else if (GetResRef(oSource)=="te_bounty009" && GetTag(oDest) == "te_alembic")
    {
    if (GetHasFeat(1481, oPC) == FALSE && GetLevelByClass(57, oPC) < 6)//Alchemy
        {
            SendMessageToPC(oPC, "You must be an Alchemist or a Sixth-Level Artificer to do that.");
            DestroyObject(oCopy);
            return;
        }
            SendMessageToPC(oPC, IntToString(nRoll) + "+" + IntToString(GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + "=" + IntToString(nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + " vs DC 14");
            if ((nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) < 14)
        {
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
            SendMessageToPC(oPC, "You fail to create the item. The distillation is ruined.");
            DestroyObject(oSource);
            DestroyObject(oDest);
            DestroyObject(oCopy);
        }
    else
        {
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("wmgrenade010", oTarget, 1);
        DestroyObject(oSource);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 50);
        }
    return;
    }
/* Alchemist's Lightning - Requires Distilled Gel and Alchemist's fire */
else if (GetResRef(oSource)=="te_alchemy10" && GetTag(oDest) == "wmgrenade003")
    {
    if (GetHasFeat(1481, oPC) == FALSE && GetLevelByClass(57, oPC) < 12)//Alchemy
        {
            SendMessageToPC(oPC, "You must be an Alchemist or a Twelfth-Level Artificer to do that.");
            DestroyObject(oCopy);
            return;
        }
            SendMessageToPC(oPC, IntToString(nRoll) + "+" + IntToString(GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + "=" + IntToString(nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + " vs DC 14");
            if ((nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) < 14)
        {
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
            SendMessageToPC(oPC, "You fail to create the item. The distillation is ruined.");
            DestroyObject(oSource);
            DestroyObject(oDest);
            DestroyObject(oCopy);
        }
    else
        {
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("wmgrenade011", oTarget, 1);
        DestroyObject(oSource);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 50);
        }
    return;
    }
/* Alchemist's Acid - Requires Troll's Blood Emulsion and Alchemist's cold */
else if (GetResRef(oSource)=="te_alchemy01" && GetTag(oDest) == "wmgrenade010")
    {
    if (GetHasFeat(1481, oPC) == FALSE && GetLevelByClass(57, oPC) < 12)//Alchemy
        {
            SendMessageToPC(oPC, "You must be an Alchemist or a Twelfth-Level Artificer to do that.");
            DestroyObject(oCopy);
            return;
        }
            SendMessageToPC(oPC, IntToString(nRoll) + "+" + IntToString(GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + "=" + IntToString(nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + " vs DC 14");
            if ((nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) < 14)
        {
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
            SendMessageToPC(oPC, "You fail to create the item. The distillation is ruined.");
            DestroyObject(oSource);
            DestroyObject(oDest);
            DestroyObject(oCopy);
        }
    else
        {
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("wmgrenade012", oTarget, 1);
        DestroyObject(oSource);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 50);
        }
    return;
    }
/* Alchemist's Blare - Requires Thunderstone and Alchemist's Lightning */
else if (GetResRef(oSource)=="x1_wmgrenade007" && GetTag(oDest) == "wmgrenade011")
    {
    if (GetHasFeat(1481, oPC) == FALSE && GetLevelByClass(57, oPC) < 18)//Alchemy
        {
            SendMessageToPC(oPC, "You must be an Alchemist or a Eighteenth-Level Artificer to do that.");
            DestroyObject(oCopy);
            return;
        }
            SendMessageToPC(oPC, IntToString(nRoll) + "+" + IntToString(GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + "=" + IntToString(nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + " vs DC 14");
            if ((nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) < 14)
        {
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
            SendMessageToPC(oPC, "You fail to create the item. The distillation is ruined.");
            DestroyObject(oSource);
            DestroyObject(oDest);
            DestroyObject(oCopy);
        }
    else
        {
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("wmgrenade013", oTarget, 1);
        DestroyObject(oSource);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 50);
        }
    return;
    }
/* Alchemist's Wonder - Requires Plaguefire and Alchemist's Acid */
else if (GetResRef(oSource)=="sp_plaguefire" && GetTag(oDest) == "wmgrenade012")
    {
    if (GetHasFeat(1481, oPC) == FALSE && GetLevelByClass(57, oPC) < 18)//Alchemy
        {
            SendMessageToPC(oPC, "You must be an Alchemist or a Eighteenth-Level Artificer to do that.");
            DestroyObject(oCopy);
            return;
        }
            SendMessageToPC(oPC, IntToString(nRoll) + "+" + IntToString(GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + "=" + IntToString(nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + " vs DC 14");
            if ((nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) < 14)
        {
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
            SendMessageToPC(oPC, "You fail to create the item. The distillation is ruined.");
            DestroyObject(oSource);
            DestroyObject(oDest);
            DestroyObject(oCopy);
        }
    else
        {
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("wmgrenade014", oTarget, 1);
        DestroyObject(oSource);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 50);
        }
    return;
    }
/* Fire Element Source - Requires Phlogiston & alembic*/
else if (GetResRef(oSource)=="te_bounty036" && GetTag(oDest) == "te_alembic")
    {
    if (GetHasFeat(1481, oPC) == FALSE)//Alchemy
        {
            SendMessageToPC(oPC, "You must be an Alchemist to do that.");
            DestroyObject(oCopy);
            return;
        }
            SendMessageToPC(oPC, IntToString(nRoll) + "+" + IntToString(GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + "=" + IntToString(nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + " vs DC 22");
            if ((nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) < 22)
        {
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
            SendMessageToPC(oPC, "You fail to create the item. The distillation is ruined.");
            DestroyObject(oSource);
            DestroyObject(oDest);
            DestroyObject(oCopy);
        }
    else
        {
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_alchemy18", oTarget, 1);
        DestroyObject(oSource);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 1400);
        }
    return;
    }

/* Necrotic Material - Requires Skeleton Bone & alembic*/
else if (GetResRef(oSource)=="te_bount011" && GetTag(oDest) == "te_alembic")
    {
    if (GetHasFeat(1481, oPC) == FALSE)//Alchemy
        {
            SendMessageToPC(oPC, "You must be an Alchemist to do that.");
            DestroyObject(oCopy);
            return;
        }
            SendMessageToPC(oPC, IntToString(nRoll) + "+" + IntToString(GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + "=" + IntToString(nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + " vs DC 12");
            if ((nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) < 12)
        {
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
            SendMessageToPC(oPC, "You fail to create the item. The emulsion is ruined.");
            DestroyObject(oSource);
            DestroyObject(oDest);
            DestroyObject(oCopy);
        }
    else
        {
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_alchemy17", oTarget, 1);
        DestroyObject(oSource);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 50);
        }
    return;
    }


/* Troll Blood Emulsion - Requires Troll head & alembic */
else if (GetResRef(oSource)=="te_bount008" && GetTag(oDest) == "te_alembic")
    {
    if (GetHasFeat(1481, oPC) == FALSE)//Alchemy
        {
            SendMessageToPC(oPC, "You must be an Alchemist to do that.");
            DestroyObject(oCopy);
            return;
        }
            SendMessageToPC(oPC, IntToString(nRoll) + "+" + IntToString(GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + "=" + IntToString(nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + " vs DC 18");
            if ((nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) < 18)
        {
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
            SendMessageToPC(oPC, "You fail to create the item. The emulsion is ruined.");
            DestroyObject(oSource);
            DestroyObject(oDest);
            DestroyObject(oCopy);
        }
    else
        {
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_alchemy01", oTarget, 1);
        DestroyObject(oSource);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 1400);
        }
    return;
    }

/* Distilled Giant Sweat - Requires Ogre Ear & alembic */
else if (GetResRef(oSource)=="te_bount002" && GetTag(oDest) == "te_alembic")
    {
    if (GetHasFeat(1481, oPC) == FALSE)//Alchemy
        {
            SendMessageToPC(oPC, "You must be an Alchemist to do that.");
            DestroyObject(oCopy);
            return;
        }
            SendMessageToPC(oPC, IntToString(nRoll) + "+" + IntToString(GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + "=" + IntToString(nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + " vs DC 14");
            if ((nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) < 14)
        {
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
            SendMessageToPC(oPC, "You fail to create the item. The distillation is ruined.");
            DestroyObject(oSource);
            DestroyObject(oCopy);
            DestroyObject(oDest);
        }
    else
        {
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_alchemy02", oTarget, 1);
        DestroyObject(oSource);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 300);
        }
    return;
    }

/* Werewolf Skin - Requires werewolf head & alembic */
else if (GetResRef(oSource)=="te_bount019" && GetTag(oDest) == "te_alembic")
    {
    if (GetHasFeat(1481, oPC) == FALSE)//Alchemy
        {
            SendMessageToPC(oPC, "You must be an Alchemist to do that.");
            DestroyObject(oCopy);
            return;
        }
            SendMessageToPC(oPC, IntToString(nRoll) + "+" + IntToString(GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + "=" + IntToString(nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + " vs DC 16");
            if ((nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) < 16)
        {
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
            SendMessageToPC(oPC, "You fail to create the item. The lycanthrope skin is ruined.");
            DestroyObject(oSource);
            DestroyObject(oCopy);
            DestroyObject(oDest);
        }
    else
        {
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_alchemy03", oTarget, 1);
        DestroyObject(oSource);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 750);
        }
    return;
    }

/* Demonic Essence - Requires Demon Heart & alembic */
else if (GetResRef(oSource)=="te_bount029" && GetTag(oDest) == "te_alembic")
    {
    if (GetHasFeat(1481, oPC) == FALSE)//Alchemy
        {
            SendMessageToPC(oPC, "You must be an Alchemist to do that.");
            DestroyObject(oCopy);
            return;
        }
            SendMessageToPC(oPC, IntToString(nRoll) + "+" + IntToString(GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + "=" + IntToString(nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + " vs DC 16");
            if ((nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) < 16)
        {
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
            SendMessageToPC(oPC, "You fail to create the item. The distillation is ruined.");
            DestroyObject(oSource);
            DestroyObject(oCopy);
            DestroyObject(oDest);
        }
    else
        {
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_alchemy04", oTarget, 1);
        DestroyObject(oSource);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 750);
        }
    return;
    }

/* Blood of Minotaur - Requires Minotaur Horn & alembic */
else if (GetResRef(oSource)=="te_bount020" && GetTag(oDest) == "te_alembic")
    {
    if (GetHasFeat(1481, oPC) == FALSE)//Alchemy
        {
            SendMessageToPC(oPC, "You must be an Alchemist to do that.");
            DestroyObject(oCopy);
            return;
        }
            SendMessageToPC(oPC, IntToString(nRoll) + "+" + IntToString(GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + "=" + IntToString(nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + " vs DC 16");
            if ((nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) < 16)
        {
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
            SendMessageToPC(oPC, "You fail to create the item. The emulsion is ruined.");
            DestroyObject(oSource);
            DestroyObject(oCopy);
            DestroyObject(oDest);
        }
    else
        {
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_alchemy05", oTarget, 1);
        DestroyObject(oSource);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 750);
        }
    return;
    }

/* Mucous of Amphibian - Requires Bullywug head & alembic */
else if (GetResRef(oSource)=="te_bount032" && GetTag(oDest) == "te_alembic")
    {
    if (GetHasFeat(1481, oPC) == FALSE)//Alchemy
        {
            SendMessageToPC(oPC, "You must be an Alchemist to do that.");
            DestroyObject(oCopy);
            return;
        }
            SendMessageToPC(oPC, IntToString(nRoll) + "+" + IntToString(GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + "=" + IntToString(nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + " vs DC 15");
            if ((nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) < 15)
        {
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
            SendMessageToPC(oPC, "You fail to create the item. The emulsion is ruined.");
            DestroyObject(oSource);
            DestroyObject(oCopy);
            DestroyObject(oDest);
        }
    else
        {
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_alchemy06", oTarget, 1);
        DestroyObject(oSource);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 50);
        }
    return;
    }

/* Spectral Essence - Requires Ectoplasm & alembic */
else if (GetResRef(oSource)=="te_bount009" && GetTag(oDest) == "te_alembic")
    {
    if (GetHasFeat(1481, oPC) == FALSE)//Alchemy
        {
            SendMessageToPC(oPC, "You must be an Alchemist to do that.");
            DestroyObject(oCopy);
            return;
        }
            SendMessageToPC(oPC, IntToString(nRoll) + "+" + IntToString(GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + "=" + IntToString(nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + " vs DC 14");
            if ((nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) < 14)
        {
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
            SendMessageToPC(oPC, "You fail to create the item. The distillation is ruined.");
            DestroyObject(oSource);
            DestroyObject(oCopy);
            DestroyObject(oDest);
        }
    else
        {
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_alchemy07", oTarget, 1);
        DestroyObject(oSource);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 300);
        }
    return;
    }

/* Aberrant Essence - Requires Drider spinnerette & alembic */
else if (GetResRef(oSource)=="te_bount005" && GetTag(oDest) == "te_alembic")
    {
    if (GetHasFeat(1481, oPC) == FALSE)//Alchemy
        {
            SendMessageToPC(oPC, "You must be an Alchemist to do that.");
            DestroyObject(oCopy);
            return;
        }
            SendMessageToPC(oPC, IntToString(nRoll) + "+" + IntToString(GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + "=" + IntToString(nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + " vs DC 16");
            if ((nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) < 16)
        {
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
            SendMessageToPC(oPC, "You fail to create the item. The distillation is ruined.");
            DestroyObject(oSource);
            DestroyObject(oCopy);
            DestroyObject(oDest);
        }
    else
        {
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_alchemy08", oTarget, 1);
        DestroyObject(oSource);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 750);
        }
    return;
    }

/* Essence of Arachnid - Requires spinnerette & alembic */
else if (GetResRef(oSource)=="te_bount027" && GetTag(oDest) == "te_alembic")
    {
    if (GetHasFeat(1481, oPC) == FALSE)//Alchemy
        {
            SendMessageToPC(oPC, "You must be an Alchemist to do that.");
            DestroyObject(oCopy);
            return;
        }
            SendMessageToPC(oPC, IntToString(nRoll) + "+" + IntToString(GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + "=" + IntToString(nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + " vs DC 18");
            if ((nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) < 18)
        {
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
            SendMessageToPC(oPC, "You fail to create the item. The distillation is ruined.");
            DestroyObject(oSource);
            DestroyObject(oCopy);
            DestroyObject(oDest);
        }
    else
        {
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_alchemy09", oTarget, 1);
        DestroyObject(oSource);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 1400);
        }
    return;
    }

/* Distilled Gel - Requires murky bottle & alembic */
else if (GetResRef(oSource)=="te_bount007" && GetTag(oDest) == "te_alembic")
    {
    if (GetHasFeat(1481, oPC) == FALSE)//Alchemy
        {
            SendMessageToPC(oPC, "You must be an Alchemist to do that.");
            DestroyObject(oCopy);
            return;
        }
            SendMessageToPC(oPC, IntToString(nRoll) + "+" + IntToString(GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + "=" + IntToString(nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + " vs DC 14");
            if ((nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) < 14)
        {
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
            SendMessageToPC(oPC, "You fail to create the item. The distillation is ruined.");
            DestroyObject(oSource);
            DestroyObject(oCopy);
            DestroyObject(oDest);
        }
    else
        {
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_alchemy10", oTarget, 1);
        DestroyObject(oSource);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 50);
        }
    return;
    }

/* Animalistic Essence - Requires Gnoll Tooth & alembic */
else if (GetResRef(oSource)=="te_bount024" && GetTag(oDest) == "te_alembic")
    {
    if (GetHasFeat(1481, oPC) == FALSE)//Alchemy
        {
            SendMessageToPC(oPC, "You must be an Alchemist to do that.");
            DestroyObject(oCopy);
            return;
        }
            SendMessageToPC(oPC, IntToString(nRoll) + "+" + IntToString(GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + "=" + IntToString(nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + " vs DC 12");
            if ((nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) < 12)
        {
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
            SendMessageToPC(oPC, "You fail to create the item. The distillation is ruined.");
            DestroyObject(oSource);
            DestroyObject(oCopy);
            DestroyObject(oDest);
        }
    else
        {
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_alchemy11", oTarget, 1);
        DestroyObject(oSource);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 50);
        }
    return;
    }

/* Vampiric Essence - Requires Vampire Teeth & alembic */
else if (GetResRef(oSource)=="te_bount026" && GetTag(oDest) == "te_alembic")
    {
    if (GetHasFeat(1481, oPC) == FALSE)//Alchemy
        {
            SendMessageToPC(oPC, "You must be an Alchemist to do that.");
            DestroyObject(oCopy);
            return;
        }
            SendMessageToPC(oPC, IntToString(nRoll) + "+" + IntToString(GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + "=" + IntToString(nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + " vs DC 16");
            if ((nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) < 16)
        {
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
            SendMessageToPC(oPC, "You fail to create the item. The distillation is ruined.");
            DestroyObject(oSource);
            DestroyObject(oCopy);
            DestroyObject(oDest);
        }
    else
        {
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_alchemy12", oTarget, 1);
        DestroyObject(oSource);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 300);
        }
    return;
    }

/* Distilled Infernal Essence - Requires Infernal Crystal & alembic */
else if (GetResRef(oSource)=="te_bount028" && GetTag(oDest) == "te_alembic")
    {
    if (GetHasFeat(1481, oPC) == FALSE)//Alchemy
        {
            SendMessageToPC(oPC, "You must be an Alchemist to do that.");
            DestroyObject(oCopy);
            return;
        }
            SendMessageToPC(oPC, IntToString(nRoll) + "+" + IntToString(GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + "=" + IntToString(nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + " vs DC 14");
            if ((nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) < 14)
        {
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
            SendMessageToPC(oPC, "You fail to create the item. The distillation is ruined.");
            DestroyObject(oSource);
            DestroyObject(oCopy);
            DestroyObject(oDest);
        }
    else
        {
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_alchemy13", oTarget, 1);
        DestroyObject(oSource);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 300);
        }
    return;
    }

/* Devil's Blood - Requires Baatezu Idol & alembic */
else if (GetResRef(oSource)=="te_bount030" && GetTag(oDest) == "te_alembic")
    {
    if (GetHasFeat(1481, oPC) == FALSE)//Alchemy
        {
            SendMessageToPC(oPC, "You must be an Alchemist to do that.");
            DestroyObject(oCopy);
            return;
        }
            SendMessageToPC(oPC, IntToString(nRoll) + "+" + IntToString(GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + "=" + IntToString(nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + " vs DC 20");
            if ((nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) < 20)
        {
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
            SendMessageToPC(oPC, "You fail to create the item. The distillation is ruined.");
            DestroyObject(oSource);
            DestroyObject(oCopy);
            DestroyObject(oDest);
        }
    else
        {
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_alchemy14", oTarget, 1);
        DestroyObject(oSource);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 2250);
        }
    return;
    }

/* Abyssal Essence - Requires Tanari Idol & alembic */
else if (GetResRef(oSource)=="te_bount031" && GetTag(oDest) == "te_alembic")
    {
    if (GetHasFeat(1481, oPC) == FALSE)//Alchemy
        {
            SendMessageToPC(oPC, "You must be an Alchemist to do that.");
            DestroyObject(oCopy);
            return;
        }
            SendMessageToPC(oPC, IntToString(nRoll) + "+" + IntToString(GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + "=" + IntToString(nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + " vs DC 18");
            if ((nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) < 18)
        {
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
            SendMessageToPC(oPC, "You fail to create the item. The distillation is ruined.");
            DestroyObject(oSource);
            DestroyObject(oCopy);
            DestroyObject(oDest);
        }
    else
        {
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_alchemy15", oTarget, 1);
        DestroyObject(oSource);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 1400);
        }
    return;
    }

/* Hardened Eyedust - Requires Beholder Eye & alembic */
else if (GetResRef(oSource)=="te_item_8460" && GetTag(oDest) == "te_alembic")
    {
    if (GetHasFeat(1481, oPC) == FALSE)//Alchemy
        {
            SendMessageToPC(oPC, "You must be an Alchemist to do that.");
            DestroyObject(oCopy);
            return;
        }
            SendMessageToPC(oPC, IntToString(nRoll) + "+" + IntToString(GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + "=" + IntToString(nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) + " vs DC 14");
            if ((nRoll+GetHitDice(oPC)+ GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) < 14)
        {
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
            SendMessageToPC(oPC, "You fail to create the item. The distillation is ruined.");
            DestroyObject(oSource);
            DestroyObject(oCopy);
            DestroyObject(oDest);
        }
    else
        {
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_alchemy16", oTarget, 1);
        DestroyObject(oSource);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 300);
        }
    return;
    }

///Alchemy Combinations///
/* Potion of Fire Elemental Summoning = Fire Element Source + Empty Bottle*/
else if (GetResRef(oSource)=="te_alchemy18" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(1481, oPC) == FALSE)//Alchemy
        {
            SendMessageToPC(oPC, "You must be an Alchemist to do that.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 1400)
        {
            SendMessageToPC(oPC, "You do not have the 1400 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion045", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(1400, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 1400);
    return;
    }

/* Potion of Cure Light Wounds = Necrotic Material + Empty Bottle*/
else if (GetResRef(oSource)=="te_alchemy17" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(1481, oPC) == FALSE)//Alchemy
        {
            SendMessageToPC(oPC, "You must be an Alchemist to do that.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 50)
        {
            SendMessageToPC(oPC, "You do not have the 50 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion009", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(50, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 50);
    return;
    }

/* Potion of Cure Critical Wounds = Troll Blood Emulsion + Empty Bottle*/
else if (GetResRef(oSource)=="te_alchemy01" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(1481, oPC) == FALSE)//Alchemy
        {
            SendMessageToPC(oPC, "You must be an Alchemist to do that.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 1400)
        {
            SendMessageToPC(oPC, "You do not have the 1400 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion008", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(1400, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 1400);
    return;
    }

/* Potion of Bull's Strength - Distilled Giant Sweat + Empty Bottle*/
else if (GetResRef(oSource)=="te_alchemy02" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(1481, oPC) == FALSE)//Alchemy
        {
            SendMessageToPC(oPC, "You must be an Alchemist to do that.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 300)
        {
            SendMessageToPC(oPC, "You do not have the 300 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion005", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(300, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 300);
    return;
    }

/* Potion of Displacement - Werewolf Skin + Empty Bottle*/
else if (GetResRef(oSource)=="te_alchemy03" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(1481, oPC) == FALSE)//Alchemy
        {
            SendMessageToPC(oPC, "You must be an Alchemist to do that.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 750)
        {
            SendMessageToPC(oPC, "You do not have the 750 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_item_8373", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(750, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 750);
    return;
    }

/* Potion of Elemental Resistance - Demonic Essence + Empty Bottle*/
else if (GetResRef(oSource)=="te_alchemy04" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(1481, oPC) == FALSE)//Alchemy
        {
            SendMessageToPC(oPC, "You must be an Alchemist to do that.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 750)
        {
            SendMessageToPC(oPC, "You do not have the 750 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion029", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(750, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 750);
    return;
    }

/* Potion of Heroism - Blood of Minotaur + Empty Bottle*/
else if (GetResRef(oSource)=="te_alchemy05" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(1481, oPC) == FALSE)//Alchemy
        {
            SendMessageToPC(oPC, "You must be an Alchemist to do that.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 750)
        {
            SendMessageToPC(oPC, "You do not have the 750 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion032", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(750, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 750);
    return;
    }

/* Potion of Breath - Mucous of Amphibian + Empty Bottle*/
else if (GetResRef(oSource)=="te_alchemy06" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(1481, oPC) == FALSE)//Alchemy
        {
            SendMessageToPC(oPC, "You must be an Alchemist to do that.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) <50)
        {
            SendMessageToPC(oPC, "You do not have the 50 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion023", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(50, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 50);
    return;
    }

/* Potion of Invisibility - Spectral Essence + Empty Bottle*/
else if (GetResRef(oSource)=="te_alchemy07" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(1481, oPC) == FALSE)//Alchemy
        {
            SendMessageToPC(oPC, "You must be an Alchemist to do that.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 300)
        {
            SendMessageToPC(oPC, "You do not have the 300 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion016", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(300, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 300);
    return;
    }

/* Potion of Haste - Aberrant Essence + Empty Bottle*/
else if (GetResRef(oSource)=="te_alchemy08" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(1481, oPC) == FALSE)//Alchemy
        {
            SendMessageToPC(oPC, "You must be an Alchemist to do that.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 750)
        {
            SendMessageToPC(oPC, "You do not have the 750 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion021", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(750, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 750);
    return;
    }

/* Potion of Freedom - Essence of Arachnid + Empty Bottle*/
else if (GetResRef(oSource)=="te_alchemy09" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(1481, oPC) == FALSE)//Alchemy
        {
            SendMessageToPC(oPC, "You must be an Alchemist to do that.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 1400)
        {
            SendMessageToPC(oPC, "You do not have the 1400 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion031", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(1400, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 1400);
    return;
    }

/* Potion of Ultravision - Distilled Gel + Empty Bottle*/
else if (GetResRef(oSource)=="te_alchemy10" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(1481, oPC) == FALSE)//Alchemy
        {
            SendMessageToPC(oPC, "You must be an Alchemist to do that.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 300)
        {
            SendMessageToPC(oPC, "You do not have the 300 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion044", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(300, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 300);
    return;
    }

/* Potion of Longstrider - Animalistic Essence + Empty Bottle*/
else if (GetResRef(oSource)=="te_alchemy11" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(1481, oPC) == FALSE)//Alchemy
        {
            SendMessageToPC(oPC, "You must be an Alchemist to do that.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 50)
        {
            SendMessageToPC(oPC, "You do not have the 50 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion033", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(50, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 50);
    return;
    }

/* Potion of Clairvoyance - Vampiric Essence + Empty Bottle*/
else if (GetResRef(oSource)=="te_alchemy12" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(1481, oPC) == FALSE)//Alchemy
        {
            SendMessageToPC(oPC, "You must be an Alchemist to do that.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 300)
        {
            SendMessageToPC(oPC, "You do not have the 300 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion026", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(300, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 300);
    return;
    }

/* Potion of Eagle's Splendor - Distilled Infernal Essence + Empty Bottle*/
else if (GetResRef(oSource)=="te_alchemy13" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(1481, oPC) == FALSE)//Alchemy
        {
            SendMessageToPC(oPC, "You must be an Alchemist to do that.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 300)
        {
            SendMessageToPC(oPC, "You do not have the 300 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion013", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(300, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 300);
    return;
    }

/* Potion of Divine Power - Devil's Blood + Empty Bottle*/
else if (GetResRef(oSource)=="te_alchemy14" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(1481, oPC) == FALSE)//Alchemy
        {
            SendMessageToPC(oPC, "You must be an Alchemist to do that.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 2250)
        {
            SendMessageToPC(oPC, "You do not have the 2250 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion028", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(2250, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 2250);
    return;
    }

/* Potion of Polymorph Self - Abyssal Essence + Empty Bottle*/
else if (GetResRef(oSource)=="te_alchemy15" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(1481, oPC) == FALSE)//Alchemy
        {
            SendMessageToPC(oPC, "You must be an Alchemist to do that.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 1400)
        {
            SendMessageToPC(oPC, "You do not have the 1400 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion036", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(1400, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 1400);
    return;
    }

/* Potion of See Invisibility - Hardened Eyedust + Empty Bottle*/
else if (GetResRef(oSource)=="te_alchemy16" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(1481, oPC) == FALSE)//Alchemy
        {
            SendMessageToPC(oPC, "You must be an Alchemist to do that.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 300)
        {
            SendMessageToPC(oPC, "You do not have the 300 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion042", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(300, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 300);
    return;
    }

///End of Alchemy Stuff///

////BLACKCOAT STUFF////
/* Blackcoat Healing Draught */
else if (GetTag(oSource)=="te_garlici" && GetTag(oDest) == "te_item_9005")
    {
    if (GetHasFeat(1247, oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You must be a trained blackcoat to make this item.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 750)
        {
            SendMessageToPC(oPC, "You do not have the 750 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_item_9002", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(750, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 750);
    return;
    }

/* Blackcoat Antidote */
else if (GetTag(oSource)=="MulticoloredSand" && GetTag(oDest) == "te_item_9005")
    {
    if (GetHasFeat(1247, oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You must be a trained blackcoat to make this item.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 750)
        {
            SendMessageToPC(oPC, "You do not have the 750 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion002", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(750, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 750);
    return;
    }

/* Blackcoat Restorative */
else if (GetTag(oSource)=="DiamondDust" && GetTag(oDest) == "te_item_9005")
    {
    if (GetHasFeat(1247, oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You must be a trained blackcoat to make this item.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 1400)
        {
            SendMessageToPC(oPC, "You do not have the 1400 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_item_9003", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(1400, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 1400);
    return;
    }

/* Blackcoat Wolfsbane */
else if (GetTag(oSource)=="PowderedSilver" && GetTag(oDest) == "te_item_9005")
    {
    if (GetHasFeat(1247, oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You must be a trained blackcoat to make this item.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 50)
        {
            SendMessageToPC(oPC, "You do not have the 50 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_item_9004", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(50, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 50);
    return;
    }

/* Holy Bolts Blackcoat */
else if (GetTag(oSource)=="BitofHolyParchment" && GetTag(oDest) == "NW_WAMBO001")
    {
    if (GetHasFeat(1247, oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You must be a trained blackcoat to make this item.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 150)
        {
            SendMessageToPC(oPC, "You do not have the 150 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_item_9008", oTarget, 150);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(150, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 150);
    return;
    }

////END OF BLACKCOAT STUFF////

/* Fire bolts - sulfur and bolts */
else if (GetTag(oSource)=="CompSulfur" && GetTag(oDest) == "NW_WAMBO001")
    {
    if (GetGold(oPC) < 50)
        {
            SendMessageToPC(oPC, "You do not have the 50 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLevelByClass(CLASS_TYPE_RANGER, oPC) < 9 && GetLevelByClass(57, oPC) < 9)
        {
            SendMessageToPC(oPC, "Your class cannot perform this combination, or you do not have enough levels in your class.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_item_6018", oTarget, 10);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(50, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 50);
    return;
    }

/* Fire arrows - sulfur and arrows */
else if (GetTag(oSource)=="CompSulfur" && GetTag(oDest) == "NW_WAMAR001")
    {
    if (GetGold(oPC) < 150)
        {
            SendMessageToPC(oPC, "You do not have the 150 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLevelByClass(CLASS_TYPE_RANGER, oPC) < 9 && GetLevelByClass(57, oPC) < 9)
        {
            SendMessageToPC(oPC, "Your class cannot perform this combination, or you do not have enough levels in your class");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_item_6019", oTarget, 99);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(150, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 8);
    return;
    }

/* Flaming Arrow - Oily Flint and arrows */
else if (GetTag(oSource)=="OilyFlint" && GetTag(oDest) == "NW_WAMAR001")
    {
    if (GetGold(oPC) < 300)
        {
            SendMessageToPC(oPC, "You do not have the 300 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLevelByClass(CLASS_TYPE_RANGER, oPC) < 9 && GetLevelByClass(57, oPC) < 9)
        {
            SendMessageToPC(oPC, "Your class cannot perform this combination, or you do not have enough levels in your class.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_rang18", oTarget, 99);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(300, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 15);
    return;
    }

/* Exploding Arrow - EggShell Flint and arrows */
else if (GetTag(oSource)=="EggShell" && GetTag(oDest) == "NW_WAMAR001")
    {
    if (GetGold(oPC) < 1000)
        {
            SendMessageToPC(oPC, "You do not have the 1000 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
    if (GetHasFeat(1169, oPC) == FALSE && GetLevelByClass(57, oPC) < 20)//Saboteur Background or Level 20 artificer
        {
            SendMessageToPC(oPC, "You do not have the required feat or enough levels in the required class.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_rang19", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(750, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 750);
    return;
    }

/* Sticky Arrows - Spider Silk and arrows */
else if (GetTag(oSource)=="SpiderWeb" && GetTag(oDest) == "NW_WAMAR001")
    {
    if (GetGold(oPC) < 750)
        {
            SendMessageToPC(oPC, "You do not have the 750 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLevelByClass(CLASS_TYPE_RANGER, oPC) < 15 && GetLevelByClass(57, oPC) < 15)
        {
            SendMessageToPC(oPC, "Your class cannot perform this combination, or you do not have enough levels in your class.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_rang21", oTarget, 10);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(300, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 300);
    return;
    }

/* Quartz Arrows - PowderedCrystal and arrows */
else if (GetTag(oSource)=="PowderedCrystal" && GetTag(oDest) == "NW_WAMAR001")
    {
    if (GetGold(oPC) < 300)
        {
            SendMessageToPC(oPC, "You do not have the 300 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLevelByClass(CLASS_TYPE_RANGER, oPC) < 15 && GetLevelByClass(57, oPC) < 15)
        {
            SendMessageToPC(oPC, "Your class cannot perform this combination, or you do not have enough levels in your class.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_rang22", oTarget, 99);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(300, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 15);
    return;
    }

/* Weighted Arrow - Piece of Iron and arrows */
else if (GetTag(oSource)=="PieceofIron" && GetTag(oDest) == "NW_WAMAR001")
    {
    if (GetGold(oPC) < 300)
        {
            SendMessageToPC(oPC, "You do not have the 300 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLevelByClass(CLASS_TYPE_RANGER, oPC) < 9 && GetLevelByClass(57, oPC) < 9)
        {
            SendMessageToPC(oPC, "Your class cannot perform this combination, or you do not have enough levels in your class.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_rang20", oTarget, 99);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(300, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 15);
    return;
    }

/* Blessed Arrow - Rose Petals and arrows */
else if (GetTag(oSource)=="RosePetals" && GetTag(oDest) == "NW_WAMAR001")
    {
    if (GetGold(oPC) < 300)
        {
            SendMessageToPC(oPC, "You do not have the 300 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
    if (GetHasFeat(1156, oPC) == FALSE)//Crusader Background
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_rang24", oTarget, 99);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(300, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 15);
    return;
    }

/* Darkened Arrow - Grave Dirt and arrows */
else if (GetTag(oSource)=="cnrGraveyardDirt" && GetTag(oDest) == "NW_WAMAR001")
    {
    if (GetGold(oPC) < 300)
        {
            SendMessageToPC(oPC, "You do not have the 300 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
    if (GetHasFeat(1156, oPC) == FALSE)//Crusader Background
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_rang23", oTarget, 99);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(300, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 15);
    return;
    }

/* Bane Arrow Aberrations - Bull Hair and arrows */
else if (GetTag(oSource)=="BullHair" && GetTag(oDest) == "NW_WAMAR001")
    {
    if (GetGold(oPC) < 300)
        {
            SendMessageToPC(oPC, "You do not have the 300 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLevelByClass(CLASS_TYPE_RANGER, oPC) < 5)
        {
            SendMessageToPC(oPC, "Your class cannot perform this combination.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_rang01", oTarget, 99);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(300, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 15);
    return;
    }

/* Bane Arrow Goblins - Eagle Feather and arrows */
else if (GetTag(oSource)=="EagleFeathers" && GetTag(oDest) == "NW_WAMAR001")
    {
    if (GetGold(oPC) < 300)
        {
            SendMessageToPC(oPC, "You do not have the 300 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLevelByClass(CLASS_TYPE_RANGER, oPC) < 5)
        {
            SendMessageToPC(oPC, "Your class cannot perform this combination.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_rang06", oTarget, 99);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(300, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 15);
    return;
    }

/* Bane Arrow Orcs - Owl Feathers and arrows */
else if (GetTag(oSource)=="OwlFeathers" && GetTag(oDest) == "NW_WAMAR001")
    {
    if (GetGold(oPC) < 300)
        {
            SendMessageToPC(oPC, "You do not have the 300 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLevelByClass(CLASS_TYPE_RANGER, oPC) < 5)
        {
            SendMessageToPC(oPC, "Your class cannot perform this combination.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_rang08", oTarget, 99);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(300, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 15);
    return;
    }

/* Bane Arrow Giants - Tarts and feathers and arrows */
else if (GetTag(oSource)=="TartsandaFeather" && GetTag(oDest) == "NW_WAMAR001")
    {
    if (GetGold(oPC) < 300)
        {
            SendMessageToPC(oPC, "You do not have the 300 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLevelByClass(CLASS_TYPE_RANGER, oPC) < 5)
        {
            SendMessageToPC(oPC, "Your class cannot perform this combination.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_rang12", oTarget, 99);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(300, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 15);
    return;
    }

/* Bane Arrow Shapechangers - Powdered Silver and arrows */
else if (GetTag(oSource)=="PowderedSilver" && GetTag(oDest) == "NW_WAMAR001")
    {
    if (GetGold(oPC) < 300)
        {
            SendMessageToPC(oPC, "You do not have the 300 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLevelByClass(CLASS_TYPE_RANGER, oPC) < 5)
        {
            SendMessageToPC(oPC, "Your class cannot perform this combination.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_rang15", oTarget, 99);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(300, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 15);
    return;
    }

/* Bane Arrow Dragons - Diamond Dust and arrows */
else if (GetTag(oSource)=="DiamondDust" && GetTag(oDest) == "NW_WAMAR001")
    {
    if (GetGold(oPC) < 300)
        {
            SendMessageToPC(oPC, "You do not have the 300 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLevelByClass(CLASS_TYPE_RANGER, oPC) < 5)
        {
            SendMessageToPC(oPC, "Your class cannot perform this combination.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_rang05", oTarget, 99);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(300, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 15);
    return;
    }

/* Bane Arrow Outsiders - Talc Powder and arrows */
else if (GetTag(oSource)=="CompTalc" && GetTag(oDest) == "NW_WAMAR001")
    {
    if (GetGold(oPC) < 300)
        {
            SendMessageToPC(oPC, "You do not have the 300 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLevelByClass(CLASS_TYPE_RANGER, oPC) < 5)
        {
            SendMessageToPC(oPC, "Your class cannot perform this combination.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_rang14", oTarget, 99);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(300, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 15);
    return;
    }

/* Bane Arrow Undead - White Feather and arrows */
else if (GetTag(oSource)=="WhiteFeather" && GetTag(oDest) == "NW_WAMAR001")
    {
    if (GetGold(oPC) < 300)
        {
            SendMessageToPC(oPC, "You do not have the 300 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLevelByClass(CLASS_TYPE_RANGER, oPC) < 5)
        {
            SendMessageToPC(oPC, "Your class cannot perform this combination.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_rang14", oTarget, 99);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(300, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 15);
    return;
    }

/* Dust of Sleep - Assassin */
else if (GetTag(oSource)=="Dust" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetLevelByClass(CLASS_TYPE_ASSASSIN, oPC) < 2)
        {
            SendMessageToPC(oPC, "Your class cannot perform this combination.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 100)
        {
            SendMessageToPC(oPC, "You do not have the 100 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_item_8381", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(100, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 100);
    return;
    }

/* Dust of Blinding - Assassin */
else if (GetTag(oSource)=="CompSulfur" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetLevelByClass(CLASS_TYPE_ASSASSIN, oPC) < 4)
        {
            SendMessageToPC(oPC, "Your class cannot perform this combination.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 300)
        {
            SendMessageToPC(oPC, "You do not have the 300 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_item_8383", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(300, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 300);
    return;
    }

/* Dust of Nausea - Assassin */
else if (GetTag(oSource)=="RottenEgg" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetLevelByClass(CLASS_TYPE_ASSASSIN, oPC) < 6)
        {
            SendMessageToPC(oPC, "Your class cannot perform this combination.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 750)
        {
            SendMessageToPC(oPC, "You do not have the 750 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_item_8395", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(750, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 750);
    return;
    }

/* Potion of True Strike - Assassin */
else if (GetTag(oSource)=="WhiteFeather" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetLevelByClass(CLASS_TYPE_ASSASSIN, oPC) < 2)
        {
            SendMessageToPC(oPC, "Your class cannot perform this combination.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 50)
        {
            SendMessageToPC(oPC, "You do not have the 50 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion043", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(50, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 50);
    return;
    }

/* Potion of Fox's Cunning - Assassin */
else if (GetTag(oSource)=="FoxHairs" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetLevelByClass(CLASS_TYPE_ASSASSIN, oPC) < 4)
        {
            SendMessageToPC(oPC, "Your class cannot perform this combination.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 300)
        {
            SendMessageToPC(oPC, "You do not have the 300 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion015", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(300, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 300);
    return;
    }

/* Potion of Cat's Grace - Assassin */
else if (GetTag(oSource)=="CatFur" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetLevelByClass(CLASS_TYPE_ASSASSIN, oPC) < 4)
        {
            SendMessageToPC(oPC, "Your class cannot perform this combination.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 300)
        {
            SendMessageToPC(oPC, "You do not have the 300 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion006", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(300, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 300);
    return;
    }

/* Bottled Black - Assassin */
else if (GetTag(oSource)=="cnrLumpOfCoal" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetLevelByClass(CLASS_TYPE_ASSASSIN, oPC) < 4)
        {
            SendMessageToPC(oPC, "Your class cannot perform this combination.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 300)
        {
            SendMessageToPC(oPC, "You do not have the 300 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion022", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(300, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 300);
    return;
    }

/* Potion of Invisibility - Assassin */
else if (GetTag(oSource)=="MiniatureCloak" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetLevelByClass(CLASS_TYPE_ASSASSIN, oPC) < 4)
        {
            SendMessageToPC(oPC, "Your class cannot perform this combination.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 300)
        {
            SendMessageToPC(oPC, "You do not have the 300 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion016", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(300, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 300);
    return;
    }

/* Potion of Freedom of Movement - Assassin */
else if (GetTag(oSource)=="PieceofIron" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetLevelByClass(CLASS_TYPE_ASSASSIN, oPC) < 8)
        {
            SendMessageToPC(oPC, "Your class cannot perform this combination.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 1400)
        {
            SendMessageToPC(oPC, "You do not have the 1400 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion031", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(1400, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 1400);
    return;
    }

/* Potion of Clairvoyance/Clairaudience - Assassin */
else if (GetTag(oSource)=="PowderedCrystal" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetLevelByClass(CLASS_TYPE_ASSASSIN, oPC) < 8)
        {
            SendMessageToPC(oPC, "Your class cannot perform this combination.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 750)
        {
            SendMessageToPC(oPC, "You do not have the 750 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion026", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(750, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 750);
    return;
    }
/* Rounds, Improved - Artificer */
else if (GetResRef(oSource)=="crpi_o_hematite" && GetTag(oDest) == "te_gunammo001")
    {
    if (GetLevelByClass(57, oPC) < 9)
        {
            SendMessageToPC(oPC, "Your class cannot perform this combination.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 250)
        {
            SendMessageToPC(oPC, "You do not have the 250 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_gunammo002", oTarget, 99);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(250, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 25);
    return;
    }
/* Rounds, Flaming - Artificer */
else if (GetResRef(oSource)=="te_alchemy18" && GetResRef(oDest) == "te_gunammo002")
    {
    if (GetLevelByClass(57, oPC) < 15)
        {
            SendMessageToPC(oPC, "Your class cannot perform this combination.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 2500)
        {
            SendMessageToPC(oPC, "You do not have the 2500 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_gunammo005", oTarget, 10);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(2500, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 250);
    return;
    }
/* Rounds, Blessed - Artificer */
else if (GetResRef(oSource)=="x1_wmgrenade005" && GetResRef(oDest) == "te_gunammo002")
    {
    if (GetLevelByClass(57, oPC) < 9)
        {
            SendMessageToPC(oPC, "Your class cannot perform this combination.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 500)
        {
            SendMessageToPC(oPC, "You do not have the 500 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_gunammo004", oTarget, 10);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(500, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 500);
    return;
    }
/* Rounds, Arcane - Artificer */
else if (GetResRef(oSource)=="sp_plaguestone" && GetTag(oDest) == "te_gunammo002")
    {
    if (GetLevelByClass(57, oPC) < 20)
        {
            SendMessageToPC(oPC, "Your class cannot perform this combination.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 5000)
        {
            SendMessageToPC(oPC, "You do not have the 5000 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_gunammo003", oTarget, 10);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(5000, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 5000);
    return;
    }

/* Potion of Mage Armor */
else if (GetTag(oSource)=="MulticoloredSand" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(FEAT_BREW_POTION, oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 50)
        {
            SendMessageToPC(oPC, "You do not have the 50 gold required.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion034", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(50, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 50);
    return;
    }

/* Oil of Magic Weapon */
else if (GetTag(oSource)=="OilyFlint" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(FEAT_BREW_POTION, oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 50)
        {
            SendMessageToPC(oPC, "You do not have the 50 gold required.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_item_8380", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(50, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 50);
    return;
    }

/* Potion of Protection From Evil */
else if (GetTag(oSource)=="CompIncense" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(FEAT_BREW_POTION, oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 50)
        {
            SendMessageToPC(oPC, "You do not have the 50 gold required.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion037", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(50, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 50);
    return;
    }

/* Potion of Resistance */
else if (GetTag(oSource)=="RosePetals" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(FEAT_BREW_POTION, oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) <25)
        {
            SendMessageToPC(oPC, "You do not have the 25 gold required.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion041", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(25, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 25);
    return;
    }

/* Potion of Cure Light Wounds */
else if (GetTag(oSource)=="EagleFeathers" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(FEAT_BREW_POTION, oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 50)
        {
            SendMessageToPC(oPC, "You do not have the 50 gold required.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion009", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(50, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 50);
    return;
    }

/* Oil of Shield of Faith */
else if (GetTag(oSource)=="BitofHolyParchment" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(FEAT_BREW_POTION, oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 50)
        {
            SendMessageToPC(oPC, "You do not have the 50 gold required.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_item_8372", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(50, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 50);
    return;
    }

/* Potion Ultravision */
else if (GetTag(oSource)=="PorkRind" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(FEAT_BREW_POTION, oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetCasterLevel(oPC) < 3)
        {
            SendMessageToPC(oPC, "You must grow in skill before making this potion.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 300)
        {
            SendMessageToPC(oPC, "You do not have the 300 gold required.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion044", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(300, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 300);
    return;
    }

/* Potion of Aid */
else if (GetTag(oSource)=="NutShells" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(FEAT_BREW_POTION, oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 300)
        {
            SendMessageToPC(oPC, "You do not have the 300 gold required.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion001", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(300, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 300);
    return;
    }

/* Potion of Remove Blindness & Deafness */
else if (GetTag(oSource)=="CompLimeWater" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(FEAT_BREW_POTION, oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetCasterLevel(oPC) < 3)
        {
            SendMessageToPC(oPC, "You must grow in skill before making this potion.");
            DestroyObject(oCopy);
            return;
        }

    if (GetGold(oPC) < 300)
        {
            SendMessageToPC(oPC, "You do not have the 300 gold required.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion039", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(300, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 300);
    return;
    }

/* Potion of Bless */
else if (GetTag(oSource)=="EggShell" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(FEAT_BREW_POTION, oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 50)
        {
            SendMessageToPC(oPC, "You do not have the 50 gold required.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion004", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(50, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 50);
    return;
    }

/* Bottled Black */
else if (GetTag(oSource)=="BitOfBone" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(FEAT_BREW_POTION, oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 300)
        {
            SendMessageToPC(oPC, "You do not have the 300 gold required.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion022", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(300, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 300);
    return;
    }

/* Potion of Bull's Strength */
else if (GetTag(oSource)=="BullHair" && GetTag(oDest) == "te_potion001")
    {
    if (GetHasFeat(FEAT_BREW_POTION, oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetHitDice(oPC) < 5)
                {
            SendMessageToPC(oPC, "You must grow in skill before making this potion.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 300)
        {
            SendMessageToPC(oPC, "You do not have the 300 gold required.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion005", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(300, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 300);
    return;
    }

/* Breath Potion requires Bit of Sponge*/
else if (GetTag(oSource)=="BitofSponge" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(FEAT_BREW_POTION, oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 50)
        {
            SendMessageToPC(oPC, "You do not have the 50 gold required.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion023", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(50, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 50);
    return;
    }


/* Potion of Cat's Grace */
else if (GetTag(oSource)=="CatFur" && GetTag(oDest) == "te_potion001")
    {
    if (GetHasFeat(FEAT_BREW_POTION, oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetCasterLevel(oPC) < 3)
                {
            SendMessageToPC(oPC, "You must grow in skill before making this potion.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 300)
        {
            SendMessageToPC(oPC, "You do not have the 300 gold required.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion006", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(300, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 300);
    return;
    }

/* Potion of Eagle's Splendor */
else if (GetTag(oSource)=="EagleFeathers" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(FEAT_BREW_POTION, oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetCasterLevel(oPC) < 3)
                {
            SendMessageToPC(oPC, "You must grow in skill before making this potion.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 300)
        {
            SendMessageToPC(oPC, "You do not have the 300 gold required.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion013", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(300, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 300);
    return;
    }

/* Potion of Owl's Wisdom */
else if (GetTag(oSource)=="OwlFeathers" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(FEAT_BREW_POTION, oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetCasterLevel(oPC) < 3)
                {
            SendMessageToPC(oPC, "You must grow in skill before making this potion.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 300)
        {
            SendMessageToPC(oPC, "You do not have the 300 gold required.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion020", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(300, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 300);
    return;
    }

/* Potion of Fox's Cunning */
else if (GetTag(oSource)=="FoxHairs" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(FEAT_BREW_POTION, oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetCasterLevel(oPC) < 3)
                {
            SendMessageToPC(oPC, "You must grow in skill before making this potion.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 300)
        {
            SendMessageToPC(oPC, "You do not have the 300 gold required.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion015", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(300, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 300);
    return;
    }

/* Potion of Bear's Endurance */
else if (GetTag(oSource)=="PorkRind" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(FEAT_BREW_POTION, oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetCasterLevel(oPC) < 3)
                {
            SendMessageToPC(oPC, "You must grow in skill before making this potion.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 300)
        {
            SendMessageToPC(oPC, "You do not have the 300 gold required.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion014", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(300, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 300);
    return;
    }

/* Potion of Cure Moderate */
else if (GetTag(oSource)=="PowderedSilver" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(FEAT_BREW_POTION, oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetCasterLevel(oPC) < 3)
                {
            SendMessageToPC(oPC, "You must grow in skill before making this potion.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 300)
        {
            SendMessageToPC(oPC, "You do not have the 300 gold required.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion010", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(300, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 300);
    return;
    }

/* Potion of Lesser Restoration */
else if (GetTag(oSource)=="PwdRhubandAdder" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(FEAT_BREW_POTION, oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetCasterLevel(oPC) < 3)
                {
            SendMessageToPC(oPC, "You must grow in skill before making this potion.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 300)
        {
            SendMessageToPC(oPC, "You do not have the 300 gold required.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion018", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(300, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 300);
    return;
    }

/* Potion of Cure Serious */
else if (GetTag(oSource)=="PowderedCrystal" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(FEAT_BREW_POTION, oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetCasterLevel(oPC) < 5)
                {
            SendMessageToPC(oPC, "You must grow in skill before making this potion.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 750)
        {
            SendMessageToPC(oPC, "You do not have the 750 gold required.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion011", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(750, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 750);
    return;
    }

/* Potion of Rage */
else if (GetTag(oSource)=="NutShells" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(FEAT_BREW_POTION, oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetCasterLevel(oPC) < 3)
                {
            SendMessageToPC(oPC, "You must grow in skill before making this potion.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 300)
        {
            SendMessageToPC(oPC, "You do not have the 300 gold required.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion038", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(300, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 300);
    return;
    }

/* Potion of Heroism */
else if (GetTag(oSource)=="SmallHorn" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(FEAT_BREW_POTION, oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetCasterLevel(oPC) < 5)
                {
            SendMessageToPC(oPC, "You must grow in skill before making this potion.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 750)
        {
            SendMessageToPC(oPC, "You do not have the 750 gold required.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion032", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(750, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 750);
    return;
    }

/* Potion of Blur */
else if (GetTag(oSource)=="EyelashinGum" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(FEAT_BREW_POTION, oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetCasterLevel(oPC) < 3)
                {
            SendMessageToPC(oPC, "You must grow in skill before making this potion.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 300)
        {
            SendMessageToPC(oPC, "You do not have the 300 gold required.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion025", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(300, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 300);
    return;
    }

/* Potion of Misdirection */
else if (GetTag(oSource)=="MineralSpheres" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(FEAT_BREW_POTION, oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetCasterLevel(oPC) < 3)
                {
            SendMessageToPC(oPC, "You must grow in skill before making this potion.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 300)
        {
            SendMessageToPC(oPC, "You do not have the 300 gold required.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion035", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(300, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 300);
    return;
    }

/* Potion of Displacement */
else if (GetTag(oSource)=="PearlDust" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(FEAT_BREW_POTION, oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetCasterLevel(oPC) < 5)
                {
            SendMessageToPC(oPC, "You must grow in skill before making this potion.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 750)
        {
            SendMessageToPC(oPC, "You do not have the 750 gold required.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion027", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(750, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 750);
    return;
    }

/* Potion of Remove Disease */
else if (GetTag(oSource)=="DropofMolasses" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(FEAT_BREW_POTION, oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetCasterLevel(oPC) < 5)
                {
            SendMessageToPC(oPC, "You must grow in skill before making this potion.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 750)
        {
            SendMessageToPC(oPC, "You do not have the 750 gold required.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion040", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(750, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 750);
    return;
    }

/* Potion of Elemental Resistance */
else if (GetTag(oSource)=="Sunstone" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(FEAT_BREW_POTION, oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetCasterLevel(oPC) < 5)
                {
            SendMessageToPC(oPC, "You must grow in skill before making this potion.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 750)
        {
            SendMessageToPC(oPC, "You do not have the 750 gold required.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion029", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(750, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 750);
    return;
    }

/* Elixir of Fire Breath */
else if (GetTag(oSource)=="CompFireAgate" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetHitDice(oPC) < 11)
                {
            SendMessageToPC(oPC, "You must grow in skill before making this potion.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 750)
        {
            SendMessageToPC(oPC, "You do not have the 750 gold required.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_item_8374", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(750, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 750);
    return;
    }

/* Elixir of Vision */
else if (GetTag(oSource)=="EyeOintment" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetCasterLevel(oPC) < 3)
                {
            SendMessageToPC(oPC, "You must grow in skill before making this potion.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 300)
        {
            SendMessageToPC(oPC, "You do not have the 300 gold required.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion044", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(300, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 300);
    return;
    }

/* Dust of Disappearance */
else if (GetTag(oSource)=="PeasAndHoof" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetHitDice(oPC) < 7)
                {
            SendMessageToPC(oPC, "You must grow in skill before making this item.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 1400)
        {
            SendMessageToPC(oPC, "You do not have the 1400 gold required.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("x0_it_mthnmisc06", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(1400, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 1400);
    return;
    }

/* Dust of Appearance */
else if (GetTag(oSource)=="CompTalc" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetHitDice(oPC) < 7)
                {
            SendMessageToPC(oPC, "You must grow in skill before making this item.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 750)
        {
            SendMessageToPC(oPC, "You do not have the 750 gold required.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("it_mthnmisc006", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(750, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 750);
    return;
    }

/* Potion of Death Armor */
else if (GetTag(oSource)=="cnrGraveyardDirt" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(FEAT_BREW_POTION, oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetCasterLevel(oPC) < 3)
                {
            SendMessageToPC(oPC, "You must grow in skill before making this potion.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 300)
        {
            SendMessageToPC(oPC, "You do not have the 300 gold required.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion012", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(300, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 300);
    return;
    }

/* Potion of Bark Skin */
else if (GetTag(oSource)=="te_cebcraft019" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(FEAT_BREW_POTION, oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetCasterLevel(oPC) < 3)
                {
            SendMessageToPC(oPC, "You must grow in skill before making this potion.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 300)
        {
            SendMessageToPC(oPC, "You do not have the 300 gold required.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion003", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(300, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 300);
    return;
    }

/* Potion of Clarity */
else if (GetTag(oSource)=="PhosphorescentMoss" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetHasFeat(FEAT_BREW_POTION, oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetCasterLevel(oPC) < 3)
                {
            SendMessageToPC(oPC, "You must grow in skill before making this potion.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 300)
        {
            SendMessageToPC(oPC, "You do not have the 300 gold required.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("te_potion007", oTarget, 1);
        SetStolenFlag(oCreated, TRUE);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(300, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 300);
    return;
    }

/* Haunspeir */
else if (GetTag(oSource)=="RawHaunspeir" && GetTag(oDest) == "ceb_mortarandpestle")
    {
    if (FeatCheck("Herbalism", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 35)
        {
            SendMessageToPC(oPC, "You do not have the 35 gold required.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("Haunspeir", oTarget, 1);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(35, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 35);
    return;
    }

/* Jhuild */
else if (GetTag(oSource)=="RawJhuild" && GetTag(oDest) == "ceb_mortarandpestle")
    {
    if (FeatCheck("Herbalism", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 50)
        {
            SendMessageToPC(oPC, "You do not have the 50 gold required.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("Jhuild", oTarget, 1);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(50, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 50);
    return;
    }

/* Rhul */
else if (GetTag(oSource)=="RawRhul" && GetTag(oDest) == "ceb_mortarandpestle")
    {
    if (FeatCheck("Herbalism", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 50)
        {
            SendMessageToPC(oPC, "You do not have the 50 gold required.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("Rhul", oTarget, 1);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(50, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 50);
    return;
    }

/* Kammarth */
else if (GetTag(oSource)=="RawKammarth" && GetTag(oDest) == "ceb_mortarandpestle")
    {
    if (FeatCheck("Herbalism", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 85)
        {
            SendMessageToPC(oPC, "You do not have the 85 gold required.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("Kammarth", oTarget, 1);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(85, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 85);
    return;
    }

/* Katakuda */
else if (GetTag(oSource)=="RawKatakuda" && GetTag(oDest) == "ceb_mortarandpestle")
    {
    if (FeatCheck("Herbalism", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 50)
        {
            SendMessageToPC(oPC, "You do not have the 50 gold required.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("Katakuda", oTarget, 1);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(50, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 50);
    return;
    }

/* Rhul */
else if (GetTag(oSource)=="RawRhul" && GetTag(oDest) == "ceb_mortarandpestle")
    {
    if (FeatCheck("Herbalism", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 60)
        {
            SendMessageToPC(oPC, "You do not have the 60 gold required.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("Rhul", oTarget, 1);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(60, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 60);
    return;
    }

/* Haunspeir */
else if (GetTag(oSource)=="RawSezaradRoot" && GetTag(oDest) == "ceb_mortarandpestle")
    {
    if (FeatCheck("Herbalism", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 40)
        {
            SendMessageToPC(oPC, "You do not have the 40 gold required.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        oCreated = CreateItemOnObject("SezaradRoot", oTarget, 1);
        SetIdentified(oCreated, TRUE);
        AssignCommand(oPC, TakeGoldFromCreature(40, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oCopy);
        SetLocalInt(oCreated, "Value", 60);
    return;
    }

/*Weapon Enchantment - Requires Magic Weapon Scroll(new)*/
else if (GetTag(oSource)=="X2_IT_SPARSCR105" && (sType=="Weapon" || sType=="Gauntlet" || sType=="Ranged"))
        {
     if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
        (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
        (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
        (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
        (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
        (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
        (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
        {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
        nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
        SendMessageToPC(oPC, "You do not have the required feat.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "HolyAvenger")==1)
        {
        SendMessageToPC(oPC, "The Holy Avenger resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "KiMod")>=2)
        {
        SendMessageToPC(oPC, "The Ki Weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "BGMod")>=2)
        {
        SendMessageToPC(oPC, "The Blackguard weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "nGun1"))
        {
        SendMessageToPC(oPC, "Smoke powder weapons are unable to be enchanted.");
        DestroyObject(oCopy);
        return;
        }
    if (IPGetWeaponEnhancementBonus(oDest)>=5)
        {
        SendMessageToPC(oPC, "This weapon cannot be given a higher enhancement bonus.");
        DestroyObject(oCopy);
        return;
        }
    if ((GetLocalInt(oDest, "WeaponEnch")>=1) && (GetLocalInt(oDest, "WeaponEnch")<=4))
        {
        IPUpgradeWeaponEnhancementBonus(oDest, 1);
        SetLocalInt(oDest, "WeaponEnch", GetLocalInt(oDest, "WeaponEnch")+1);
        SetLocalInt(oDest, "WeaponCap", GetLocalInt(oDest, "WeaponCap")+1);
        }
    else
        {
        IPUpgradeWeaponEnhancementBonus(oDest, 1);
        sNewname="Enchanted " + GetName(oDest);
            if ((Random(100) > 70) && (GetHasFeat(1329, oPC) == FALSE))//Shar
                {
                SetLocalInt(oDest, "Gleaming", GetLocalInt(oDest, "Gleaming")+1);
                IPSafeAddItemProperty(oDest, ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_LOW,IP_CONST_LIGHTCOLOR_WHITE));
                }
        SetLocalInt(oDest, "WeaponEnch", 1);
        SetLocalInt(oDest, "WeaponCap", 1);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This weapon now radiates an aura of magical energy. It bears the mark of the enchanter, " + GetName(oPC) + ". ", TRUE);
        SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 1000);
        }
    }

/*Defending Weapon - Requires Mage Armor or Magic Vestment*/
else if ((GetTag(oSource)=="NW_IT_SPARSCR104" || GetTag(oSource)=="X2_IT_SPDVSCR304") && sType=="Weapon")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
        if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetLocalInt(oDest, "HolyAvenger")==1)
        {
        SendMessageToPC(oPC, "The Holy Avenger resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
         if (GetLocalInt(oDest, "KiMod")>=2)
        {
        SendMessageToPC(oPC, "The Ki Weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
        if (GetLocalInt(oDest, "BGMod")>=2)
        {
        SendMessageToPC(oPC, "The Blackguard weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
        if (GetLocalInt(oDest, "nGun")==1)
            {
            SendMessageToPC(oPC, "Smoke powder weapons are unable to be enchanted.");
            DestroyObject(oCopy);
            return;
            }
        if (GetCasterLevel(oPC)-(nEEL) < 8)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "WeaponEnch")<1)
            {
            SendMessageToPC(oPC, "This weapon requires a magical enhancement bonus in order to be imbued with additional traits.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Defending")>=5)
            {
            SendMessageToPC(oPC, "This item cannot be enchanted further with this trait.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Defending")>=1)
            {
            SetLocalInt(oDest, "Defending", GetLocalInt(oDest, "Defending")+1);
            SetLocalInt(oDest, "WeaponCap", GetLocalInt(oDest, "WeaponCap")+1);
            IPSafeAddItemProperty(oDest, ItemPropertyACBonus(GetLocalInt(oDest, "Defending")));
            }
       else {
            IPSafeAddItemProperty(oDest, ItemPropertyACBonus(1));
            sNewname="Defending " + GetName(oDest);
            SetLocalInt(oDest, "Defending", 1);
            SetLocalInt(oDest, "WeaponCap", GetLocalInt(oDest, "WeaponCap")+1);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This weapon now radiates an aura of magical defense. It bears the mark of the enchanter, " + GetName(oPC) + ". ", TRUE);
            }
    }

/* Gleaming Weapon - Requires Light Spell */
else if (GetTag(oSource)=="NW_IT_SPARSCR004" && sType=="Weapon")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 5)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "nGun")==1)
            {
            SendMessageToPC(oPC, "Smoke powder weapons are unable to be enchanted.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "HolyAvenger")==1)
        {
        SendMessageToPC(oPC, "The Holy Avenger resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "KiMod")>=2)
        {
        SendMessageToPC(oPC, "The Ki Weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "BGMod")>=2)
        {
        SendMessageToPC(oPC, "The Blackguard weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
        if (GetLocalInt(oDest, "Gleaming")==1)
            {
            SetLocalInt(oDest, "Gleaming", GetLocalInt(oDest, "Gleaming")+1);
            IPSafeAddItemProperty(oDest, ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_LOW,IP_CONST_LIGHTCOLOR_WHITE));
            SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 150);
            }
        if (GetLocalInt(oDest, "Gleaming")==2)
            {
            SetLocalInt(oDest, "Gleaming", GetLocalInt(oDest, "Gleaming")+1);
            IPSafeAddItemProperty(oDest, ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_NORMAL,IP_CONST_LIGHTCOLOR_WHITE));
            SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 150);
            }
        if (GetLocalInt(oDest, "Gleaming")==3)
            {
            SetLocalInt(oDest, "Gleaming", GetLocalInt(oDest, "Gleaming")+1);
            IPSafeAddItemProperty(oDest, ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_BRIGHT,IP_CONST_LIGHTCOLOR_WHITE));
            SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 150);
            }
        else {
        IPSafeAddItemProperty(oDest, ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_DIM,IP_CONST_LIGHTCOLOR_WHITE));
        SetLocalInt(oDest, "Gleaming", 1);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This weapon casts a radius of light when it is held. It has the Enchanter's mark of " + GetName(oPC) + ". ", TRUE);
        SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 150);
        }
    }

/* Ki Weapon - Requires Owl's Wisdom*/
else if (GetTag(oSource)=="nw_it_sparscr221" && sType=="Weapon")
    {
    if (GetLevelByClass(CLASS_TYPE_MONK, oPC)>=5) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_WORSHIP;
        if (GetLocalInt(oDest, "KiWeapon")>=5)
            {
            SendMessageToPC(oPC, "This item already bears a similar enchantment.");
            DestroyObject(oCopy);
            }
        if (GetLocalInt(oDest, "nGun")==1)
            {
            SendMessageToPC(oPC, "Smoke powder weapons are unable to be enchanted.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "HolyAvenger")==1)
        {
        SendMessageToPC(oPC, "The Holy Avenger resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "KiMod")>=2)
        {
        SendMessageToPC(oPC, "The Ki Weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "BGMod")>=2)
        {
        SendMessageToPC(oPC, "The Blackguard weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
        else {
            sNewname="Ki " + GetName(oDest);
            SetLocalInt(oDest, "KiWeapon", 5);
            SetTag(oDest, "te_monkfan");
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + "This weapon has been infused in such a way as to channel the power of ki. It bears the mark of the monk, " + GetName(oPC) + ". ", TRUE);
            SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 1000);
            }
    }

/* Dark Ki Weapon - Requires Inflict Light Wounds*/
else if (GetTag(oSource)=="X1_IT_SPDVSCR104" && sType=="Weapon")
    {
    if (GetLevelByClass(CLASS_TYPE_MONK, oPC)>=5) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_WORSHIP;
        if (GetLocalInt(oDest, "KiWeapon")>=5)
            {
            SendMessageToPC(oPC, "This item already bears a similar enchantment.");
            DestroyObject(oCopy);
            }
        if (GetLocalInt(oDest, "nGun")==1)
            {
            SendMessageToPC(oPC, "Smoke powder weapons are unable to be enchanted.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "HolyAvenger")==1)
        {
        SendMessageToPC(oPC, "The Holy Avenger resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "KiMod")>=2)
        {
        SendMessageToPC(oPC, "The Ki Weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "BGMod")>=2)
        {
        SendMessageToPC(oPC, "The Blackguard weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
        else {
            sNewname="Dark Ki " + GetName(oDest);
            SetLocalInt(oDest, "KiWeapon", 5);
            SetTag(oDest, "te_darkmoon");
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + "This weapon has been infused in such a way as to channel the power of ki. It bears the mark of the monk, " + GetName(oPC) + ". ", TRUE);
            SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 1000);
            }
    }

/*Alchemical Silver Weapon - Gilding Silver*/
else if (GetTag(oSource)=="te_palupgr003" && sType=="Weapon")
    {
        if (GetHasFeat(1437, oPC) == FALSE)//Alchemy
        {
            SendMessageToPC(oPC, "Alchemy proficiency is required for this task.");
            DestroyObject(oCopy);
            return;
        }
    nAnim = ANIMATION_LOOPING_GET_LOW;
        if (GetLocalInt(oDest, "nGun")==1)
            {
            SendMessageToPC(oPC, "Smoke powder weapons are unable to be manipulated in this way.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "HolyAvenger")==1)
        {
        SendMessageToPC(oPC, "The Holy Avenger resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "KiMod")>=2)
        {
        SendMessageToPC(oPC, "The Ki Weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "BGMod")>=2)
        {
        SendMessageToPC(oPC, "The Blackguard weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
        if (GetLocalInt(oDest,"Material")==3)
            {
            SendMessageToPC(oPC, "This item is of a rare metal and can't be silvered properly.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest,"Material")==4)
            {
            SendMessageToPC(oPC, "This item is of a rare metal and can't be silvered properly.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Silvered")==1)
            {
            SendMessageToPC(oPC, "This item already has a similar modification.");
            DestroyObject(oCopy);
            return;
            }
        else {
            sNewname="Silvered " + GetName(oDest);
            SetLocalInt(oDest, "Silvered", 1);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + "This weapon has been coated in alchemical silver, and it bears the name of the Alchemist, " + GetName(oPC) + ". ", TRUE);
            SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 500);
        }
    }

///Alchemical Silver Gauntlet - Powdered Silver
else if (GetTag(oSource)=="it_comp_pwdsilv" && sType=="Gauntlet")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetLocalInt(oDest, "nGun")==1)
            {
            SendMessageToPC(oPC, "Smoke powder weapons are unable to be enchanted.");
            DestroyObject(oCopy);
            return;
            }
        if (GetCasterLevel(oPC)-(nEEL) < 5)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest,"Material")==3)
            {
            SendMessageToPC(oPC, "This item is of a rare metal and can't be silvered properly.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest,"Material")==4)
            {
            SendMessageToPC(oPC, "This item is of a rare metal and can't be silvered properly.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Silvered")==1)
            {
            SendMessageToPC(oPC, "This item already has a similar enchantment.");
            DestroyObject(oCopy);
            return;
            }
        else {
            sNewname="Silvered " + GetName(oDest);
            SetLocalInt(oDest, "Silvered", 1);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + "This weapon has been coated in alchemical silver, and it bears the name of the Alchemist, " + GetName(oPC) + ". ", TRUE);
            SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 500);
        }
    }

/*Ghost Touch Weapon and cure light wounds*/
else if (GetTag(oSource)=="X2_IT_SPDVSCR104" && sType=="Weapon")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetLocalInt(oDest, "nGun")==1)
            {
            SendMessageToPC(oPC, "Smoke powder weapons are unable to be enchanted.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "HolyAvenger")==1)
        {
        SendMessageToPC(oPC, "The Holy Avenger resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "KiMod")>=2)
        {
        SendMessageToPC(oPC, "The Ki Weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "BGMod")>=2)
        {
        SendMessageToPC(oPC, "The Blackguard weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 9)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "GhostTouch")==1)
            {
            SendMessageToPC(oPC, "This item already has a similar enchantment.");
            DestroyObject(oCopy);
            return;
            }
        else {
            sNewname="Ghost Touch " + GetName(oDest);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + "This weapon has been imbued in a way that makes it effective against ghosts or other incorporeal beings. It bears the mark of the Enchanter, " + GetName(oPC) + ". ", TRUE);
            SetLocalInt(oDest, "GhostTouch", 1);
            SetLocalInt(oDest, "WeaponCap", GetLocalInt(oDest, "WeaponCap")+1);
            }
    }

/*Ghost Touch Gauntlet and cure light wounds*/
else if (GetTag(oSource)=="X2_IT_SPDVSCR104" && sType=="Gauntlet")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetLocalInt(oDest, "nGun")==1)
            {
            SendMessageToPC(oPC, "Smoke powder weapons are unable to be enchanted.");
            DestroyObject(oCopy);
            return;
            }
        if (GetCasterLevel(oPC)-(nEEL) < 9)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "GhostTouch")==1)
            {
            SendMessageToPC(oPC, "This item already has a similar enchantment.");
            DestroyObject(oCopy);
            return;
            }
        else {
            sNewname="Ghost Touch " + GetName(oDest);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + "This weapon has been imbued in a way that makes it effective against ghosts or other incorporeal beings. It bears the mark of the Enchanter, " + GetName(oPC) + ". ", TRUE);
            SetLocalInt(oDest, "GhostTouch", 1);
            SetLocalInt(oDest, "WeaponCap", GetLocalInt(oDest, "WeaponCap")+1);
        }
    }

/*Ghost Touch Armor cure light wounds*/
else if (GetTag(oSource)=="X2_IT_SPDVSCR104" && sType=="Armor")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetLocalInt(oDest, "nGun")==1)
            {
            SendMessageToPC(oPC, "Smoke powder weapons are unable to be enchanted.");
            DestroyObject(oCopy);
            return;
            }
        if (GetCasterLevel(oPC)-(nEEL) < 9)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "GhostTouch")==1)
            {
            SendMessageToPC(oPC, "This item already has a similar enchantment.");
            DestroyObject(oCopy);
            return;
            }
        else {
            sNewname="Ghost Touch " + GetName(oDest);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + "This armor has been imbued in a way that makes it effective against ghosts or other incorporeal beings. It bears the mark of the Enchanter, " + GetName(oPC) + ". ", TRUE);
            SetLocalInt(oDest, "GhostTouch", 1);
            SetLocalInt(oDest, "ArmorCap", GetLocalInt(oDest, "ArmorCap")+1);
        }
    }

/*Ghost Touch Bracer - cure light wounds*/
else if (GetTag(oSource)=="X2_IT_SPDVSCR104" && sType=="Bracer")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetLocalInt(oDest, "nGun")==1)
            {
            SendMessageToPC(oPC, "Smoke powder weapons are unable to be enchanted.");
            DestroyObject(oCopy);
            return;
            }
        if (GetCasterLevel(oPC)-(nEEL) < 9)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "GhostTouch")==1)
            {
            SendMessageToPC(oPC, "This item already has a similar enchantment.");
            DestroyObject(oCopy);
            return;
            }
        else {
            sNewname="Ghost Touch " + GetName(oDest);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + "This bracer has been imbued in a way that makes it effective against ghosts or other incorporeal beings. It bears the mark of the Enchanter, " + GetName(oPC) + ". ", TRUE);
            SetLocalInt(oDest, "GhostTouch", 1);
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/*Ghost Touch Shield - requires cure moderaate*/
else if (GetTag(oSource)=="X2_IT_SPDVSCR203" && sType=="Shield")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetLocalInt(oDest, "nGun")==1)
            {
            SendMessageToPC(oPC, "Smoke powder weapons are unable to be enchanted.");
            DestroyObject(oCopy);
            return;
            }
        if (GetCasterLevel(oPC)-(nEEL) < 9)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "GhostTouch")==1)
            {
            SendMessageToPC(oPC, "This item already has a similar enchantment.");
            DestroyObject(oCopy);
            return;
            }
        else {
            sNewname="Ghost Touch " + GetName(oDest);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + "This shield has been imbued in a way that makes it effective against ghosts or other incorporeal beings. It bears the mark of the Enchanter, " + GetName(oPC) + ". ", TRUE);
            SetLocalInt(oDest, "GhostTouch", 1);
            SetLocalInt(oDest, "ArmorCap", GetLocalInt(oDest, "ArmorCap")+1);
        }
    }

/*Darkened Weapon - Requires Ray of Enfeeblement*/
else if (GetTag(oSource)=="NW_IT_SPARSCR111" && (sType=="Weapon" || sType=="Gauntlet" || sType=="Ranged"))
    {
    if ((GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetLocalInt(oDest, "nGun")==1)
            {
            SendMessageToPC(oPC, "Smoke powder weapons are unable to be enchanted.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "HolyAvenger")==1)
        {
        SendMessageToPC(oPC, "The Holy Avenger resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "KiMod")>=2)
        {
        SendMessageToPC(oPC, "The Ki Weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "BGMod")>=2)
        {
        SendMessageToPC(oPC, "The Blackguard weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 5)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Darkened")==1)
            {
            SendMessageToPC(oPC, "This item already has a similar enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Elemental")==1)
            {
            SendMessageToPC(oPC, "This item already has a similar enchantment.");
            DestroyObject(oCopy);
            return;
            }
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_NEGATIVE, IP_CONST_DAMAGEBONUS_1d6), oDest);
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyVisualEffect(ITEM_VISUAL_EVIL), oDest);
            sNewname="Darkened " + GetName(oDest);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + "This weapon has been imbued with the sinister power of the Negative Energy Plane. It bears the mark of the Enchanter, " + GetName(oPC) + ". ", TRUE);
            SetLocalInt(oDest, "Darkened", 1);
            SetLocalInt(oDest, "Elemental", 1);
            SetLocalInt(oDest, "Evil", 1);
            SetLocalInt(oDest, "WeaponCap", GetLocalInt(oDest, "WeaponCap")+1);
            }

/*AC Bonus for items*/
/*Armor Enhancement requires Mage Armor*/
else if (GetTag(oSource)=="NW_IT_SPARSCR104" && (sType=="Armor" || sType=="Shield"))
        {
     if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
        (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
        (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
        (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
        (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
        (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
        (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
        {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
        nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
        SendMessageToPC(oPC, "You do not have the required feat.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "nGun")==1)
        {
        SendMessageToPC(oPC, "Smoke powder weapons are unable to be enchanted.");
        DestroyObject(oCopy);
        return;
        }
    if ((GetItemPropertyType(pItemprop)==ITEM_PROPERTY_AC_BONUS)>=5)
        {
        SendMessageToPC(oPC, "This item has been enchanted to its maximum protective value.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "ArmorAC") >=5)
        {
        SendMessageToPC(oPC, "This item has been enchanted to its maximum protective value.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "ArmorAC")>=1)
        {
        SetLocalInt(oDest, "ArmorAC", GetLocalInt(oDest, "ArmorAC")+1);
        IPSafeAddItemProperty(oDest, ItemPropertyACBonus(GetLocalInt(oDest,"ArmorAC")));
        SetLocalInt(oDest, "ArmorCap", GetLocalInt(oDest, "ArmorCap")+1);
        }
    else {
        IPSafeAddItemProperty(oDest, ItemPropertyACBonus(1));
        sNewname=GetName(oDest) + " of Protection";
        SetLocalInt(oDest, "ArmorAC", 1);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This item radiates an aura of protection. It bears the mark of the Enchanter, " + GetName(oPC) + ". ", TRUE);
        SetLocalInt(oDest, "ArmorCap", GetLocalInt(oDest, "ArmorCap")+1);
        }
    }

/*AC Bonus for items*/
/*Armor Enhancement requires Mage Armor*/
else if ((GetTag(oSource)=="NW_IT_SPARSCR104" || GetTag(oSource)=="X2_IT_SPDVSCR202") && (sType=="Cloak" || sType=="Amulet" || sType=="Bracer"))
        {
     if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
        (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
        (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
        (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
        (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
        (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
        (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
        {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
        nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
        SendMessageToPC(oPC, "You do not have the required feat.");
        DestroyObject(oCopy);
        return;
        }
    if ((GetItemPropertyType(pItemprop)==ITEM_PROPERTY_AC_BONUS)>=5)
        {
        SendMessageToPC(oPC, "This item has been enchanted to its maximum protective value.");
        return;
        }
    if (GetLocalInt(oDest, "ArmorAC")>=1)
        {
        SetLocalInt(oDest, "ArmorAC", GetLocalInt(oDest, "ArmorAC")+1);
        IPSafeAddItemProperty(oDest, ItemPropertyACBonus(GetLocalInt(oDest,"ArmorAC")));
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    else {
        IPSafeAddItemProperty(oDest, ItemPropertyACBonus(1));
        sNewname=GetName(oDest) + " of Protection";
        SetLocalInt(oDest, "ArmorAC", 1);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This accessory now radiates an aura of protective energy. It bears the mark of the enchanter, " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/*Cold Resisting - Requires Ice Storm*/
else if (GetTag(oSource)=="X2_IT_SPARSCR401" && (sType=="Armor"  || sType=="Clothing" || sType=="Shield"))
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLocalInt(oDest, "nGun")==1)
            {
            SendMessageToPC(oPC, "Smoke powder weapons are unable to be enchanted.");
            DestroyObject(oCopy);
            return;
            }
    if (GetLocalInt(oDest, "Elemental")==1)
            {
            SendMessageToPC(oPC, "This item already has a similar enchantment.");
            DestroyObject(oCopy);
            return;
            }
    if (GetCasterLevel(oPC)-(nEEL) < 5)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_COLD, IP_CONST_DAMAGERESIST_5), oDest);
            sNewname="Cold Resisting " + GetName(oDest);
            SetLocalInt(oDest, "Elemental", 1);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " The armor appears to be covered in frost, however is not cold to the touch and bears the enchanter's mark of " + GetName(oPC), TRUE);
            SetLocalInt(oDest, "ArmorCap", GetLocalInt(oDest, "ArmorCap")+1);
        }

/*Cold Resisting, Greater - Requires Cone of Cold*/
else if (GetTag(oSource)=="NW_IT_SPARSCR507" && (sType=="Armor"  || sType=="Clothing" || sType=="Shield"))
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLocalInt(oDest, "nGun")==1)
            {
            SendMessageToPC(oPC, "Smoke powder weapons are unable to be enchanted.");
            DestroyObject(oCopy);
            return;
            }
    if (GetLocalInt(oDest, "ArmorAC")<2)
            {
            SendMessageToPC(oPC, "This item requires more magical enhancement bonus in order to be imbued with additional traits.");
            DestroyObject(oCopy);
            return;
            }
    if (GetLocalInt(oDest, "Elemental")==1)
        {
        SendMessageToPC(oPC, "You cannot perform this enchantments a second time on this item.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "ArmorCap")==9)
        {
        SendMessageToPC(oPC, "You cannot place an enchantment of this strength on this item, it is already close to its maximum value.");
        DestroyObject(oCopy);
        return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 7)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_COLD, IP_CONST_DAMAGERESIST_10), oDest);
    sNewname="Cold Resisting " + GetName(oDest);
    SetLocalInt(oDest, "Elemental", 1);
    SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " The armor appears to be covered in frost, however is not cold to the touch and bears the enchanter's mark of " + GetName(oPC), TRUE);
    SetLocalInt(oDest, "ArmorCap", GetLocalInt(oDest, "ArmorCap")+1);
    }

/*Fire Resisting - Requires Flame Weapon*/
else if (GetTag(oSource)=="X2_IT_SPARSCR205" && (sType=="Armor"  || sType=="Clothing" || sType=="Shield"))
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLocalInt(oDest, "nGun")==1)
            {
            SendMessageToPC(oPC, "Smoke powder weapons are unable to be enchanted.");
            DestroyObject(oCopy);
            return;
            }
    if (GetLocalInt(oDest, "Elemental")==1)
        {
        SendMessageToPC(oPC, "You cannot perform this enchantments a second time on this item.");
        DestroyObject(oCopy);
        return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 5)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_FIRE, IP_CONST_DAMAGERESIST_5), oDest);
    sNewname="Fire Resisting " + GetName(oDest);
    SetLocalInt(oDest, "Elemental", 1);
    SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " The armor occasionally appears to flicker with flame but is not warm to the touch and bears the enchanter's mark of " + GetName(oPC), TRUE);
    SetLocalInt(oDest, "ArmorCap", GetLocalInt(oDest, "ArmorCap")+1);
    }

/*Fire Resisting, Greater - Requires Firebrand*/
else if (GetTag(oSource)=="X1_IT_SPARSCR501" && (sType=="Armor"  || sType=="Clothing" || sType=="Shield"))
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLocalInt(oDest, "nGun")==1)
            {
            SendMessageToPC(oPC, "Smokepowder weapons are unable to be enchanted.");
            DestroyObject(oCopy);
            return;
            }
    if (GetLocalInt(oDest, "Elemental")==1)
        {
        SendMessageToPC(oPC, "You cannot perform this enchantments a second time on this item.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "ArmorAC")<2)
        {
        SendMessageToPC(oPC, "This item requires more magical enhancement bonus in order to be imbued with additional traits.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "ArmorCap")==9)
        {
        SendMessageToPC(oPC, "You cannot place an enchantment of this strength on this item, it is already close to its maximum value.");
        DestroyObject(oCopy);
        return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 7)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_FIRE, IP_CONST_DAMAGERESIST_10), oDest);
    sNewname="Fire Resisting " + GetName(oDest);
    SetLocalInt(oDest, "Elemental", 1);
    SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " The armor occasionally appears to flicker with flame but is not warm to the touch and bears the enchanter's mark of " + GetName(oPC), TRUE);
    SetLocalInt(oDest, "ArmorCap", GetLocalInt(oDest, "ArmorCap")+1);
    }

/*Shock Resisting - Requires Lightening Bolt*/
else if (GetTag(oSource)=="X2_IT_SPDVSCR307" && (sType=="Armor"  || sType=="Clothing" || sType=="Shield"))
    {
   if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLocalInt(oDest, "nGun")==1)
            {
            SendMessageToPC(oPC, "Smoke powder weapons are unable to be enchanted.");
            DestroyObject(oCopy);
            return;
            }
    if (GetLocalInt(oDest, "Elemental")==1)
        {
        SendMessageToPC(oPC, "You cannot perform this enchantments a second time on this item.");
        DestroyObject(oCopy);
        return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 5)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ELECTRICAL, IP_CONST_DAMAGERESIST_5), oDest);
    sNewname="Shock Resisting " + GetName(oDest);
    SetLocalInt(oDest, "Elemental", 1);
    SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " An occasional flash of magical lightning ripples over this armor.  It bears the enchanter's mark of " + GetName(oPC), TRUE);
    SetLocalInt(oDest, "ArmorCap", GetLocalInt(oDest, "ArmorCap")+1);
    }

/*Shock Resisting, Greater - Requires Chain Lightning*/
else if (GetTag(oSource)=="NW_IT_SPARSCR607" && (sType=="Armor"  || sType=="Clothing" || sType=="Shield"))
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLocalInt(oDest, "Elemental")==1)
        {
        SendMessageToPC(oPC, "You cannot perform this enchantments a second time on this item.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "ArmorAC")<2)
        {
        SendMessageToPC(oPC, "This item requires more magical enhancement bonus in order to be imbued with additional traits.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "ArmorCap")==9)
        {
        SendMessageToPC(oPC, "You cannot place this enchantment upon an item of this strength, it is almost at maximum value.");
        DestroyObject(oCopy);
        return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 7)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ELECTRICAL, IP_CONST_DAMAGERESIST_10), oDest);
    sNewname="Shock Resisting " + GetName(oDest);
    SetLocalInt(oDest, "Elemental", 1);
    SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " An occasional flash of magical lightning ripples over this armor.  It bears the enchanter's mark of " + GetName(oPC), TRUE);
    SetLocalInt(oDest, "ArmorCap", GetLocalInt(oDest, "ArmorCap")+1);
    }

/*Acid Resisting - Requires Melf's Acid Arrow*/
else if (GetTag(oSource)=="NW_IT_SPARSCR202" && (sType=="Armor"  || sType=="Clothing" || sType=="Shield"))
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLocalInt(oDest, "Elemental")==1)
        {
        SendMessageToPC(oPC, "You cannot perform this enchantments a second time on this item.");
        DestroyObject(oCopy);
        return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 5)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID, IP_CONST_DAMAGERESIST_5), oDest);
    sNewname="Acid Resisting " + GetName(oDest);
    SetLocalInt(oDest, "Elemental", 1);
    SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Any exposed metal on this armor looks alive, nearly as though it is corroding at an excellerated rate, however it never diminishes. The armor bears the enchanter's mark of " + GetName(oPC), TRUE);
    SetLocalInt(oDest, "ArmorCap", GetLocalInt(oDest, "ArmorCap")+1);
        }

/*Acid Resisting, Greater - Requires Mestil's Acid Breath*/
else if (GetTag(oSource)=="X2_IT_SPARSCR301" && (sType=="Armor"  || sType=="Clothing" || sType=="Shield"))
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLocalInt(oDest, "Elemental")==1)
        {
        SendMessageToPC(oPC, "You cannot perform this enchantments a second time on this item.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "ArmorAC")<2)
        {
        SendMessageToPC(oPC, "This item requires more magical enhancement bonus in order to be imbued with additional traits.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "ArmorCap")==9)
        {
        SendMessageToPC(oPC, "You cannot place this enchantment on an item of this strength, it is near to maximum value.");
        DestroyObject(oCopy);
        return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 7)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID, IP_CONST_DAMAGERESIST_10), oDest);
    sNewname="Acid Resisting " + GetName(oDest);
    SetLocalInt(oDest, "Elemental", 1);
    SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Any exposed metal on this armor looks alive, nearly as though it is corroding at an excellerated rate, however it never diminishes. The armor bears the enchanter's mark of " + GetName(oPC), TRUE);
    SetLocalInt(oDest, "ArmorCap", GetLocalInt(oDest, "ArmorCap")+1);
        }

/*Sonic Resisting - Requires Blindness / Deafness*/
else if (GetTag(oSource)=="NW_IT_SPARSCR211" && (sType=="Armor"  || sType=="Clothing" || sType=="Shield"))
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_WORSHIP;
    if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLocalInt(oDest, "Elemental")==1)
        {
        SendMessageToPC(oPC, "You cannot perform this enchantments a second time on this item.");
        DestroyObject(oCopy);
        return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 5)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_SONIC, IP_CONST_DAMAGERESIST_5), oDest);
    sNewname="Sonic Resisting " + GetName(oDest);
    SetLocalInt(oDest, "Elemental", 1);
    SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " In absolute silence, the armor appears to be perpetually humming and vibrating. It bears the enchanter's mark of " + GetName(oPC), TRUE);
    SetLocalInt(oDest, "ArmorCap", GetLocalInt(oDest, "ArmorCap")+1);
        }

/*Sonic Resisting, greater - Requires Gust of Wind*/
else if (GetTag(oSource)=="X1_IT_SPARSCR303" && (sType=="Armor"  || sType=="Clothing" || sType=="Shield"))
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_WORSHIP;
    if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLocalInt(oDest, "Elemental")==1)
        {
        SendMessageToPC(oPC, "You cannot perform this enchantments a second time on this item.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "ArmorAC")<2)
        {
        SendMessageToPC(oPC, "This item requires more magical enhancement bonus in order to be imbued with additional traits.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "ArmorCap")==9)
        {
        SendMessageToPC(oPC, "You cannot place this enchantment on an item of this strength, it is too close to its maximum value.");
        DestroyObject(oCopy);
        return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 7)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_SONIC, IP_CONST_DAMAGERESIST_10), oDest);
    sNewname="Sonic Resisting " + GetName(oDest);
    SetLocalInt(oDest, "Elemental", 1);
    SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " In absolute silence the armor appears to be perpetually humming and vibarating. It bears the enchanter's mark of " + GetName(oPC), TRUE);
    SetLocalInt(oDest, "ArmorCap", GetLocalInt(oDest, "ArmorCap")+1);
        }

/* Shadow Armor - Requires Invisibility*/
else if (GetTag(oSource)=="NW_IT_SPARSCR207" && sType=="Armor")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 5)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "Shadow")>=2)
        {
        SetLocalInt(oDest, "Shadow", GetLocalInt(oDest, "Shadow")+2);
        IPSafeAddItemProperty(oDest, ItemPropertySkillBonus(SKILL_HIDE,GetLocalInt(oDest, "Shadow")));
        SetLocalInt(oDest, "ArmorCap", GetLocalInt(oDest, "ArmorCap")+1);
        }
    else
        {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertySkillBonus(SKILL_HIDE,2), oDest);
        sNewname="Shadow " + GetName(oDest);
        SetLocalInt(oDest, "Shadow", 2);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Shadows nearby seem to come to life and bend to help envelope the wearer of this armor.  It has the enchanter's mark of " + GetName(oPC),TRUE);
        SetLocalInt(oDest, "ArmorCap", GetLocalInt(oDest, "ArmorCap")+1);
        }
    }

/* Silent Armor - Cat's Gace*/
else if ((GetTag(oSource)=="X2_IT_SPARSCR207" || GetTag(oSource)=="NW_IT_SPARSCR213") && sType=="Armor")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 7)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "Silence")>=2)
        {
        SetLocalInt(oDest, "Silence", GetLocalInt(oDest, "Silence")+2);
        IPSafeAddItemProperty(oDest, ItemPropertySkillBonus(SKILL_MOVE_SILENTLY,GetLocalInt(oDest, "Silence")));
        SetLocalInt(oDest, "ArmorCap", GetLocalInt(oDest, "ArmorCap")+1);
        }
    else
        {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertySkillBonus(SKILL_MOVE_SILENTLY,2), oDest);
        sNewname="Silent " + GetName(oDest);
        SetLocalInt(oDest, "Silence", 2);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " An aura of palpable silence envelopes the wearer of this armor.  It has the enchanter's mark of " + GetName(oPC),TRUE);
        SetLocalInt(oDest, "ArmorCap", GetLocalInt(oDest, "ArmorCap")+1);
        }
    }

/* Armor of Proof Against Transmutation - Requires Stone to Flesh*/
else if (GetTag(oSource)=="X1_IT_SPARSCR604" && sType=="Armor")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 13)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "ProofVsTr")==20)
        {
        SendMessageToPC(oPC, "You cannot perform this enchantment a second time on this item.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "ArmorAC")<3)
        {
        SendMessageToPC(oPC, "This item requires more magical enhancement bonus in order to be imbued with additional traits.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "ArmorCap")==9)
        {
        SendMessageToPC(oPC, "You cannot place this enchantment on this armor, it is too close to maximum value.");
        }
    else
        {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertySpellImmunitySchool(IP_CONST_SPELLSCHOOL_TRANSMUTATION), oDest);
        sNewname==GetName(oDest) + " of Proof Against Transmutation";
        SetLocalInt(oDest, "ProofVsTr", 20);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This armor has been imbued with a magic that makes it resist any attempts to alter its own shape or that of the wearer.  It has the enchanter's mark of " + GetName(oPC),TRUE);
        SetLocalInt(oDest, "ArmorCap", GetLocalInt(oDest, "ArmorCap")+1);
        }
    }

/* Armor of the Bull - Bull's Strength*/
else if (GetTag(oSource)=="NW_IT_SPARSCR212" && sType=="Armor")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 7)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "OgreStr")==4)
            {
            SendMessageToPC(oPC, "You have reached the maximum level of strength modification possible for this item.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "OgreStr")>=1)
            {
            SetLocalInt(oDest, "OgreStr", GetLocalInt(oDest, "OgreStr")+2);
            IPSafeAddItemProperty(oDest, ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR, GetLocalInt(oDest, "OgreStr")));
            SetLocalInt(oDest, "ArmorCap", GetLocalInt(oDest, "ArmorCap")+1);
        }
        else {
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR, 2), oDest);
            sNewname=GetName(oDest) + " of the Bull";
            SetLocalInt(oDest, "OgreStr", 2);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Wearing this armor you feel a surge of unnatural strength. They have the enchanter's mark of " + GetName(oPC), TRUE);
            SetLocalInt(oDest, "ArmorCap", GetLocalInt(oDest, "ArmorCap")+1);
        }
    }

/* Glamered Armor - Requires Shadow Conjuration*/
else if (GetTag(oSource)=="NW_IT_SPARSCR410" && sType=="Armor")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 7)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "Glamer")>=2)
        {
        SetLocalInt(oDest, "Glamer", GetLocalInt(oDest, "Glamer")+2);
        IPSafeAddItemProperty(oDest, ItemPropertySkillBonus(SKILL_BLUFF,GetLocalInt(oDest, "Glamer")));
        SetLocalInt(oDest, "ArmorCap", GetLocalInt(oDest, "ArmorCap")+1);
        }
    else {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertySkillBonus(SKILL_BLUFF,2), oDest);
        sNewname="Glamered " + GetName(oDest);
        SetLocalInt(oDest, "Glamer", 2);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This armor could appear as normal armor or even as a simple cloth outfit...  It bears the enchanter's mark of " + GetName(oPC), TRUE
);
        SetLocalInt(oDest, "ArmorCap", GetLocalInt(oDest, "ArmorCap")+1);
        }
    }

/*Fortified Armor - requires globe of invulnerability*/
else if (GetTag(oSource)=="NW_IT_SPARSCR601" && (sType=="Armor" || sType=="Shield"))
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLocalInt(oDest, "ArmorAC")<4)
        {
        SendMessageToPC(oPC, "This item requires more magical enhancement bonus in order to be imbued with additional traits.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "ArmorCap")>=8)
        {
        SendMessageToPC(oPC, "You cannot perform an enchantment of this strength on this item, it is too close to maximum value.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "Fortify")==13)
        {
        SendMessageToPC(oPC, "You cannot perform this enchantment a second time on this item.");
        DestroyObject(oCopy);
        return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 13)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_CRITICAL_HITS), oDest);
    sNewname="Fortified " + GetName(oDest);
    SetLocalInt(oDest, "Fortify", 13);
    SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " The item appears impervious to any profound damage from weapons and bears the enchanter's mark of " + GetName(oPC), TRUE);
    SetLocalInt(oDest, "ArmorCap", GetLocalInt(oDest, "ArmorCap")+1);
        }

/* Armor or Shield of Undead Control  */
else if (GetTag(oSource)=="NW_IT_SPARSCR707" &&  (sType=="Armor" || sType=="Shield"))
    {
    if ((GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetLocalInt(oDest, "ArmorAC")<3)
            {
            SendMessageToPC(oPC, "This item requires more magical enhancement bonus in order to be imbued with additional traits.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "ArmorCap")>=8)
            {
            SendMessageToPC(oPC, "You cannot perform an enchantment of this strength on this item, it is too close to maximum value.");
            DestroyObject(oCopy);
            return;
            }
        if (GetCasterLevel(oPC)-(nEEL) < 13)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "UndeadControl")==13)
            {
            SendMessageToPC(oPC, "This item already has a similar enchantment.");
            DestroyObject(oCopy);
            return;
            }
        else {
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_CONTROL_UNDEAD_13, IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY), oDest);
            sNewname=GetName(oDest) + " of Undead Control";
            SetLocalInt(oDest, "UndeadControl", 13);
            SetLocalInt(oDest, "iCasterLvl", 13);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Armors and shields of this type enable the wearer to control undead, as per the spell. It has the enchanter's mark of " + GetName(oPC), TRUE);
            SetLocalInt(oDest, "ArmorCap", GetLocalInt(oDest, "ArmorCap")+1);
        }
    }

/* Robe of Knowledge - Fox's Cunning*/
else if (GetTag(oSource)=="nw_it_sparscr220" && sType=="Armor" && GetArmorType(oDest)==0)
    {
    if ((GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 7)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "ArmorAC")<2)
        {
        SendMessageToPC(oPC, "This item requires more magical enhancement bonus in order to be imbued with additional traits.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "Knowledge")>=3)
        {
        SetLocalInt(oDest, "Knowledge", GetLocalInt(oDest, "Knowledge")+1);
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusLevelSpell(IP_CONST_CLASS_WIZARD ,GetLocalInt(oDest, "Knowledge")/2), oDest);
        SetLocalInt(oDest, "ArmorCap", GetLocalInt(oDest, "ArmorCap")+1);
         }
    else {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusLevelSpell(IP_CONST_CLASS_WIZARD ,1), oDest);
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusLevelSpell(IP_CONST_CLASS_WIZARD ,1), oDest);
        sNewname=GetName(oDest) + " of Knowledge";
        SetLocalInt(oDest, "Knowledge", 3);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Your mind clears as you wear these robes.  With the new clarity you can recall more spells than normal.  It bears the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "ArmorCap", GetLocalInt(oDest, "ArmorCap")+1);
        }
    }

/* Robes of Blending requires Darkness */
else if (GetTag(oSource)=="NW_IT_SPARSCR206" && sType=="Armor" && GetArmorType(oDest)==0)
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 5)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "ArmorAC")<2)
        {
        SendMessageToPC(oPC, "This item requires more magical enhancement bonus in order to be imbued with additional traits.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "Shadow")>=2)
            {
            SetLocalInt(oDest, "Shadow", GetLocalInt(oDest, "Shadow")+2);
            IPSafeAddItemProperty(oDest, ItemPropertySkillBonus(SKILL_HIDE,GetLocalInt(oDest, "Shadow")));
            SetLocalInt(oDest, "ArmorCap", GetLocalInt(oDest, "ArmorCap")+1);

            }
        else {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertySkillBonus(SKILL_HIDE,2), oDest);
        sNewname=GetName(oDest) + " of Blending";
        SetLocalInt(oDest, "Shadow", 2);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This robe seems to swarm with magical shadows. It has the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "ArmorCap", GetLocalInt(oDest, "ArmorCap")+1);
        }
    }

/* Robes of Eyes requires True Seeing */
else if (GetTag(oSource)=="NW_IT_SPARSCR606" && sType=="Armor" && GetArmorType(oDest)==0)
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 11)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "ArmorAC")<3)
        {
        SendMessageToPC(oPC, "This item requires more magical enhancement bonus in order to be imbued with additional traits.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "ArmorCap") == 9)
        {
        SendMessageToPC(oPC, "You are unable to add an enchantment of this strength onto this item, it is too close to maximum value.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "Seeing")>=2)
            {
            SetLocalInt(oDest, "Seeing", GetLocalInt(oDest, "Seeing")+2);
            IPSafeAddItemProperty(oDest, ItemPropertySkillBonus(SKILL_SEARCH,GetLocalInt(oDest, "SEARCH")));
            IPSafeAddItemProperty(oDest, ItemPropertySkillBonus(SKILL_SPOT,GetLocalInt(oDest, "SPOT")));
            SetLocalInt(oDest, "ArmorCap", GetLocalInt(oDest, "ArmorCap")+1);
            }
        else {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertySkillBonus(SKILL_SEARCH,2), oDest);
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertySkillBonus(SKILL_SPOT,2), oDest);
        sNewname=GetName(oDest) + " of Seeing Eyes";
        SetLocalInt(oDest, "Seeing", 5);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This robe seems normal until worn- when a score of magical eyes open, looking in all directions. It has the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "ArmorCap", GetLocalInt(oDest, "ArmorCap")+1);
        }
    }

/* Robe of Scintelating Colors - Etherial Visage*/
else if (GetTag(oSource)=="NW_IT_SPARSCR608" && sType=="Armor" && GetArmorType(oDest)==0)
    {
    if ((GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 11)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "ArmorAC")<3)
        {
        SendMessageToPC(oPC, "This item requires more magical enhancement bonus in order to be imbued with additional traits.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "Colors")==11)
        {
        SendMessageToPC(oPC, "You cannot perform this enchantments a second time on this item.");
        DestroyObject(oCopy);
        return;
        }
    else {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusLevelSpell(IP_CONST_CASTSPELL_DISPLACEMENT_9 ,10), oDest);
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_DAZE,5), oDest);
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_NORMAL, IP_CONST_LIGHTCOLOR_ORANGE), oDest);
        sNewname=GetName(oDest) + " of Scintillating Colors";
        SetLocalInt(oDest, "iCasterLvl", 11);
        SetLocalInt(oDest, "Colors", 11);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " The colors of this robe appear alive and moving.  Incredible hues, color after color cascade from the upper part of the robe to the hem.  It bears the enchanter's mark of " + GetName(oPC), TRUE);
        }
        SetLocalInt(oDest, "ArmorCap", GetLocalInt(oDest, "ArmorCap")+1);
    }

/* Spined Shield - Requires Magic Missile*/
else if (GetTag(oSource)=="NW_IT_SPARSCR109" && sType=="Shield")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLocalInt(oDest, "ArmorAC")<2)
        {
        SendMessageToPC(oPC, "This item requires more magical enhancement bonus in order to be imbued with additional traits.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "Spined")==5)
        {
        SendMessageToPC(oPC, "You cannot perform this enchantments a second time on this item.");
        DestroyObject(oCopy);
        return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 5)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_MAGIC_MISSILE_3, IP_CONST_CASTSPELL_NUMUSES_3_USES_PER_DAY), oDest);
    sNewname="Spined " + GetName(oDest);
    SetLocalInt(oDest, "Spined", 5);
    SetLocalInt(oDest, "iCasterLvl", 5);
    SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This shield is covered in small spines which can be launced at a target in front of you on command. It holds the enchanter's mark of " + GetName(oPC), TRUE);
    SetLocalInt(oDest, "ArmorCap", GetLocalInt(oDest, "ArmorCap")+1);
        }

/* Wolf Shield - Requires Summon Creature 3*/
else if (GetTag(oSource)=="NW_IT_SPARSCR306" && sType=="Shield")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLocalInt(oDest, "Wolf")==9)
        {
        SendMessageToPC(oPC, "You cannot perform this enchantment a second time on this item.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "ArmorAC")<2)
        {
        SendMessageToPC(oPC, "This item requires more magical enhancement bonus in order to be imbued with additional traits.");
        DestroyObject(oCopy);
        return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 9)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_SUMMON_CREATURE_III_5, IP_CONST_CASTSPELL_NUMUSES_3_USES_PER_DAY), oDest);
    sNewname="Wolf's " + GetName(oDest);
    SetLocalInt(oDest, "Wolf", 9);
    SetLocalInt(oDest, "iCasterLvl", 9);
    SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " There are three wolf head's engraved into the face of this shield. It has the enchanter's mark of " + GetName(oPC), TRUE);
    SetLocalInt(oDest, "ArmorCap", GetLocalInt(oDest, "ArmorCap")+1);
    }

/* Returning - Gust of Wind */
else if (GetTag(oSource)=="X1_IT_SPARSCR303" && (GetBaseItemType(oDest)==BASE_ITEM_LONGBOW || GetBaseItemType(oDest)==BASE_ITEM_SHORTBOW))
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 7)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "Returning")==7)
        {
        SendMessageToPC(oPC, "You cannot perform this enchantments a second time on this item.");
        DestroyObject(oCopy);
        return;
        }
    else {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyUnlimitedAmmo(), oDest);
        sNewname=GetName(oDest) + " of Returning";
        SetLocalInt(oDest, "Returning", 7);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " After firing this weapon, a magical wind seems to carry the ammunition back to you to be used again. It has the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "WeaponCap", GetLocalInt(oDest, "WeaponCap")+1);
        }
    }

/* Mighty*/
else if (GetTag(oSource)=="NW_IT_SPARSCR212" && (GetBaseItemType(oDest)==BASE_ITEM_LONGBOW || GetBaseItemType(oDest)==BASE_ITEM_SHORTBOW))
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 5)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "Mighty")>=2)
        {
        SetLocalInt(oDest, "Mighty", GetLocalInt(oDest, "Mighty")+2);
        IPSafeAddItemProperty(oDest, ItemPropertyMaxRangeStrengthMod(GetLocalInt(oDest, "Mighty")));
        SetLocalInt(oDest, "WeaponCap", GetLocalInt(oDest, "WeaponCap")+1);
        }
    else {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaxRangeStrengthMod(2), oDest);
        sNewname="Mighty " + GetName(oDest);
        SetLocalInt(oDest, "Mighty", 2);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " You feel a strange connection to the bow as your strength transfers into it when you wield it. It has the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "WeaponCap", GetLocalInt(oDest, "WeaponCap")+1);
        }
    }

/* Vorpal Weapon - Circle of Death*/
else if (GetTag(oSource)=="NW_IT_SPARSCR610" && sType=="Weapon")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 11)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "WeaponEnch")<4)
        {
        SendMessageToPC(oPC, "This weapon requires more magical enhancement bonus in order to be imbued with additional traits.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "WeaponCap")>=8)
        {
        SendMessageToPC(oPC, "This item cannot accept the enchantment, it brings it over the maximum item value.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "HolyAvenger")==1)
        {
        SendMessageToPC(oPC, "The Holy Avenger resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "KiMod")>=2)
        {
        SendMessageToPC(oPC, "The Ki Weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "BGMod")>=2)
        {
        SendMessageToPC(oPC, "The Blackguard weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
     if (GetLocalInt(oDest, "Vorpal")>=11)
        {
        SendMessageToPC(oPC, "This item already has a similar enchantment.");
        DestroyObject(oCopy);
        return;
        }
     else {
        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_VORPAL, IP_CONST_ONHIT_SAVEDC_20), oDest);
        sNewname="Vorpal " + GetName(oDest);
        SetLocalInt(oDest, "Vorpal", 11);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " The weapon has an odd feeling in your hands.  It's as if the weapon itself is eager to take lives.  The weapon has the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "WeaponCap", GetLocalInt(oDest, "WeaponCap")+1);
        }
    }

/* Vampiric Weapon - Requires Vampiric Touch or Healing Sting*/
else if ((GetTag(oSource)=="NW_IT_SPARSCR311" || (GetTag(oSource)=="X2_IT_SPDVSCR302")) && (sType=="Weapon" || sType=="Gauntlet"))
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
     if (GetLocalInt(oDest, "Good")==1)
        {
        SendMessageToPC(oPC, "This item has enchantments that conflict with your attempt.");
        DestroyObject(oCopy);
        return;
        }
if (GetLocalInt(oDest, "HolyAvenger")==1)
        {
        SendMessageToPC(oPC, "The Holy Avenger resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "KiMod")>=2)
        {
        SendMessageToPC(oPC, "The Ki Weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "BGMod")>=2)
        {
        SendMessageToPC(oPC, "The Blackguard weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 5)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
     if (GetLocalInt(oDest, "Vampiric")>=2)
        {
        SetLocalInt(oDest, "Vampiric", GetLocalInt(oDest, "Vampiric")+2);
        IPSafeAddItemProperty(oDest, ItemPropertyVampiricRegeneration(GetLocalInt(oDest, "Vampiric")));
        SetLocalInt(oDest, "WeaponCap", GetLocalInt(oDest, "WeaponCap")+1);
        }
     else {
        IPSafeAddItemProperty(oDest, ItemPropertyVampiricRegeneration(2));
        sNewname="Vampiric " + GetName(oDest);
        SetLocalInt(oDest, "Vampiric", 2);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " With each strike, you feel your foe's life force flow into your own. The weapon has the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "WeaponCap", GetLocalInt(oDest, "WeaponCap")+1);
        }
    }

/* Flaming Weapon - Requires Flame Weapon*/
else if ((GetTag(oSource)=="X2_IT_SPARSCR205" || GetTag(oSource)=="X2_IT_SPDVSCR305") && (sType=="Weapon" || sType=="Gauntlet"))
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLocalInt(oDest, "Elemental")==1)
        {
        SendMessageToPC(oPC, "This item already has a similar enchantment.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "HolyAvenger")==1)
        {
        SendMessageToPC(oPC, "The Holy Avenger resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "KiMod")>=2)
        {
        SendMessageToPC(oPC, "The Ki Weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "BGMod")>=2)
        {
        SendMessageToPC(oPC, "The Blackguard weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 10)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_FIRE, IP_CONST_DAMAGEBONUS_1d6), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyVisualEffect(ITEM_VISUAL_FIRE), oDest);
    sNewname="Flaming " + GetName(oDest);
    SetLocalInt(oDest, "Elemental", 1);
    SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " The weapon is wreathed in a dancing magical flame and has the enchanter's mark of " + GetName(oPC), TRUE);
    SetLocalInt(oDest, "WeaponCap", GetLocalInt(oDest, "WeaponCap")+1);
    }

/* Thundering Weapon - Requires Blindness Deafness*/
else if (GetTag(oSource)=="NW_IT_SPARSCR211" && (sType=="Weapon" || sType=="Gauntlet" || sType=="Ranged"))
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_WORSHIP;
    if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLocalInt(oDest, "Elemental")==1)
        {
        SendMessageToPC(oPC, "This item already has a similar enchantment.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "HolyAvenger")==1)
        {
        SendMessageToPC(oPC, "The Holy Avenger resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "KiMod")>=2)
        {
        SendMessageToPC(oPC, "The Ki Weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "BGMod")>=2)
        {
        SendMessageToPC(oPC, "The Blackguard weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 5)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SONIC, IP_CONST_DAMAGEBONUS_1d6), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyVisualEffect(ITEM_VISUAL_SONIC), oDest);
    sNewname="Thundering " + GetName(oDest);
    SetLocalInt(oDest, "Elemental", 1);
    SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " The weapon perpetually humms and vibrates. It bears the enchanter's mark of " + GetName(oPC), TRUE);
    SetLocalInt(oDest, "WeaponCap", GetLocalInt(oDest, "WeaponCap")+1);
    }

/* Frost Weapon requires Ice Storm*/
else if (GetTag(oSource)=="X2_IT_SPARSCR401" && (sType=="Weapon" || sType=="Gauntlet" || sType=="Ranged"))
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetLocalInt(oDest, "Elemental")==1)
            {
            SendMessageToPC(oPC, "This item already has a similar enchantment..");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "HolyAvenger")==1)
        {
        SendMessageToPC(oPC, "The Holy Avenger resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "KiMod")>=2)
        {
        SendMessageToPC(oPC, "The Ki Weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "BGMod")>=2)
        {
        SendMessageToPC(oPC, "The Blackguard weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
        if (GetLocalInt(oDest, "Flaming")==1)
            {
            SendMessageToPC(oPC, "This item already has a flaming enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetCasterLevel(oPC)-(nEEL) < 8)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_COLD, IP_CONST_DAMAGEBONUS_1d6), oDest);
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyVisualEffect(ITEM_VISUAL_COLD), oDest);
        sNewname="Frost " + GetName(oDest);
        SetLocalInt(oDest, "Elemental", 1);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " The weapon is perpetually covered in a magical frost regardless of the weather. It bears the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "WeaponEnchantCount", GetLocalInt(oDest, "WeaponEnchantCount")+1);
        SetLocalInt(oDest, "WeaponCap", GetLocalInt(oDest, "WeaponCap")+1);
    }

/* Shocking Weapon requires Call Lightning or Lightning Bolt*/
else if ((GetTag(oSource)=="X2_IT_SPDVSCR307" || GetTag(oSource)=="NW_IT_SPARSCR310") && (sType=="Weapon" || sType=="Gauntlet" || sType=="Ranged"))
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_WORSHIP;
    if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetLocalInt(oDest, "Elemental")==1)
            {
            SendMessageToPC(oPC, "This item already has a similar enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "HolyAvenger")==1)
        {
        SendMessageToPC(oPC, "The Holy Avenger resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "KiMod")>=2)
        {
        SendMessageToPC(oPC, "The Ki Weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "BGMod")>=2)
        {
        SendMessageToPC(oPC, "The Blackguard weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 8)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ELECTRICAL, IP_CONST_DAMAGEBONUS_1d6), oDest);
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyVisualEffect(ITEM_VISUAL_ELECTRICAL), oDest);
        sNewname="Shocking " + GetName(oDest);
        SetLocalInt(oDest, "Elemental", 1);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Electricity ripples over the weapon that bears the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "WeaponCap", GetLocalInt(oDest, "WeaponCap")+1);
    }

/* Acid Weapon requires Melf's Acid Arrow*/
else if (GetTag(oSource)=="NW_IT_SPARSCR202" && (sType=="Weapon" || sType=="Gauntlet" || sType=="Ranged"))
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetLocalInt(oDest, "Elemental")==1)
            {
            SendMessageToPC(oPC, "This item already has a similar enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "HolyAvenger")==1)
        {
        SendMessageToPC(oPC, "The Holy Avenger resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "KiMod")>=2)
        {
        SendMessageToPC(oPC, "The Ki Weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "BGMod")>=2)
        {
        SendMessageToPC(oPC, "The Blackguard weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 8)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ACID, IP_CONST_DAMAGEBONUS_1d6), oDest);
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyVisualEffect(ITEM_VISUAL_ACID), oDest);
        sNewname="Corrosive " + GetName(oDest);
        SetLocalInt(oDest, "Elemental", 1);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Acid from an unknown source drips perpetually drips from the weapon.  It has the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "WeaponCap", GetLocalInt(oDest, "WeaponCap")+1);
    }

/* Keen Weapon requires Keen Edge*/
else if (GetTag(oSource)=="X2_IT_SPARSCR303" && sType=="Weapon")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLocalInt(oDest, "Keen")==5)
        {
        SendMessageToPC(oPC, "This item already has a similar enchantment.");
        DestroyObject(oCopy);
        return;
        }
    if (IPGetIsBludgeoningWeapon(oDest))
        {
        SendMessageToPC(oPC, "You cannot perform this enchantment on a blunt weapon.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "HolyAvenger")==1)
        {
        SendMessageToPC(oPC, "The Holy Avenger resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "KiMod")>=2)
        {
        SendMessageToPC(oPC, "The Ki Weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "BGMod")>=2)
        {
        SendMessageToPC(oPC, "The Blackguard weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 5)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyKeen(), oDest);
    sNewname="Keen " + GetName(oDest);
    SetLocalInt(oDest, "Keen", 5);
    SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Weilding this weapon you find it seems to move towards your target with a will of it's own making it easier to place critical strikes. It has the enchanter's mark of " + GetName(oPC), TRUE);
    SetLocalInt(oDest, "WeaponCap", GetLocalInt(oDest, "WeaponCap")+1);
    }

/* Poison Weapon requires Poison Spell*/
else if (GetTag(oSource)=="X2_IT_SPDVSCR407" && (sType=="Weapon" || sType=="Ranged"))
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLocalInt(oDest, "Poison")==7)
        {
        SendMessageToPC(oPC, "This item already has a similar enchantment.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "WeaponEnch")<3)
        {
        SendMessageToPC(oPC, "This weapon requires more magical enhancement bonus in order to be imbued with additional traits.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "HolyAvenger")==1)
        {
        SendMessageToPC(oPC, "The Holy Avenger resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "KiMod")>=2)
        {
        SendMessageToPC(oPC, "The Ki Weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "BGMod")>=2)
        {
        SendMessageToPC(oPC, "The Blackguard weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 7)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_20,IP_CONST_POISON_1D2_STRDAMAGE), oDest);
    sNewname="Poisoned " + GetName(oDest);
    SetLocalInt(oDest, "Elemental",1);
    SetLocalInt(oDest, "Poison", 7);
    SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Weilding this weapon you find it seems to seethe magical poison. It has the enchanter's mark of " + GetName(oPC), TRUE);
    SetLocalInt(oDest, "WeaponCap", GetLocalInt(oDest, "WeaponCap")+1);
    }

/* Subtlety weapon requires improved invis */
else if (GetTag(oSource)=="NW_IT_SPARSCR408" && (sType=="Weapon" || sType=="Ranged" || sType=="Gauntlet"))
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLocalInt(oDest, "Subtle")==7)
        {
        SendMessageToPC(oPC, "This item already has a similar enchantment.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "WeaponEnch")<2)
        {
        SendMessageToPC(oPC, "This weapon requires more magical enhancement bonus in order to be imbued with additional traits.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "HolyAvenger")==1)
        {
        SendMessageToPC(oPC, "The Holy Avenger resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "KiMod")>=2)
        {
        SendMessageToPC(oPC, "The Ki Weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "BGMod")>=2)
        {
        SendMessageToPC(oPC, "The Blackguard weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 7)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusFeat(IP_CONST_FEAT_SNEAK_ATTACK_1D6), oDest);
    sNewname="Subtle " + GetName(oDest);
    SetLocalInt(oDest, "Subtle", 7);
    SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Wielding this weapon you find it seems to move towards your target with a will of it's own making it easier to place critical strikes. It has the enchanter's mark of " + GetName(oPC), TRUE);
    SetLocalInt(oDest, "WeaponCap", GetLocalInt(oDest, "WeaponCap")+1);
    }

/* Anarchic Weapon uses Confusion */
else if (GetTag(oSource)=="NW_IT_SPARSCR406" && (sType=="Weapon" || sType=="Ranged"))
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLocalInt(oDest, "Chaos")==1)
        {
        SendMessageToPC(oPC, "This item already has a similar enchantment.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "WeaponCap")>=9)
        {
        SendMessageToPC(oPC, "This item cannot accept the enchantment, it is too close to maximum value.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "HolyAvenger")==1)
        {
        SendMessageToPC(oPC, "The Holy Avenger resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "KiMod")>=2)
        {
        SendMessageToPC(oPC, "The Ki Weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "BGMod")>=2)
        {
        SendMessageToPC(oPC, "The Blackguard weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 7)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_LAWFUL,IP_CONST_DAMAGETYPE_DIVINE, IP_CONST_DAMAGEBONUS_1d6), oDest);
    sNewname="Anarchic " + GetName(oDest);
    SetLocalInt(oDest, "Chaos", 1);
    SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Weilding this weapon you find it seems to radiate chaotic and unpredictable energies. It has the enchanter's mark of " + GetName(oPC), TRUE);
    SetLocalInt(oDest, "WeaponCap", GetLocalInt(oDest, "WeaponCap")+1);
    }

/* Axiomatic Weapon uses Dismissal */
else if (GetTag(oSource)=="NW_IT_SPARSCR501" && (sType=="Weapon" || sType=="Ranged"))
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLocalInt(oDest, "Law")==1)
        {
        SendMessageToPC(oPC, "This item already has a similar enchantment.");
        DestroyObject(oCopy);
        return;
        }
     if (GetLocalInt(oDest, "HolyAvenger")==1)
        {
        SendMessageToPC(oPC, "The Holy Avenger resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "KiMod")>=2)
        {
        SendMessageToPC(oPC, "The Ki Weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "BGMod")>=2)
        {
        SendMessageToPC(oPC, "The Blackguard weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
     if (GetLocalInt(oDest, "Chaos")==1)
        {
        SendMessageToPC(oPC, "This item already has a similar enchantment.");
        DestroyObject(oCopy);
        return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 7)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_CHAOTIC,IP_CONST_DAMAGETYPE_DIVINE, IP_CONST_DAMAGEBONUS_1d6), oDest);
    sNewname="Axiomatic " + GetName(oDest);
    SetLocalInt(oDest, "Law", 1);
    SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Weilding this weapon you find it seems to radiate lawful and orderly energy. It has the enchanter's mark of " + GetName(oPC), TRUE);
    SetLocalInt(oDest, "WeaponCap", GetLocalInt(oDest, "WeaponCap")+1);
    }

/* Holy Weapon Requires Hammer of the Gods*/
else if (GetTag(oSource)=="X2_IT_SPDVSCR406" && (sType=="Weapon" || sType=="Ranged" || sType=="Gauntlet") && GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD)
    {
    if ((GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_WORSHIP;
    if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetLocalInt(oDest, "Elemental")==1)
            {
            SendMessageToPC(oPC, "This item already has a similar enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Vampiric")>=1)
            {
            SendMessageToPC(oPC, "This item has enchantments that conflict with your attempt.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "HolyAvenger")==1)
        {
        SendMessageToPC(oPC, "The Holy Avenger resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "WeaponEnch")<2)
        {
        SendMessageToPC(oPC, "This weapon requires more magical enhancement bonus in order to be imbued with additional traits.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "KiMod")>=2)
        {
        SendMessageToPC(oPC, "The Ki Weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "BGMod")>=2)
        {
        SendMessageToPC(oPC, "The Blackguard weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 7)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d6), oDest);
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyVisualEffect(ITEM_VISUAL_HOLY), oDest);
        IPSafeAddItemProperty(oDest, ItemPropertyLimitUseByAlign(IP_CONST_ALIGNMENTGROUP_GOOD), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,TRUE);
        sNewname="Holy " + GetName(oDest);
        SetLocalInt(oDest, "Elemental", 1);
        SetLocalInt(oDest, "Holy", 1);
        SetLocalInt(oDest, "Good", 1);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " The weapon has a holy glow and is empowered to fight evil. It has the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "WeaponCap", GetLocalInt(oDest, "WeaponCap")+1);
    }

/* Sanctified Weapon Requires Bless*/
else if (GetTag(oSource)=="X2_IT_SPDVSCR103" && sType=="Weapon" && GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD)
    {
    if ((GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_WORSHIP;
        if (GetLocalInt(oDest, "Sanctified")==1)
            {
            SendMessageToPC(oPC, "This item already has a similar enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Profane")==1)
            {
            SendMessageToPC(oPC, "This item already has an opposing enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "HolyAvenger")==1)
        {
        SendMessageToPC(oPC, "The Holy Avenger resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "KiMod")>=2)
        {
        SendMessageToPC(oPC, "The Ki Weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "BGMod")>=2)
        {
        SendMessageToPC(oPC, "The Blackguard weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 3)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        IPSafeAddItemProperty(oDest, ItemPropertyLimitUseByAlign(IP_CONST_ALIGNMENTGROUP_GOOD), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,TRUE);
        sNewname="Sanctified " + GetName(oDest);
        SetLocalInt(oDest, "Good", 1);
        SetLocalInt(oDest, "Sanctified", 1);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This weapon has been aligned with the powers of good. It has the mark of the holy servant, " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 500);
    }

/* Profane Weapon Requires Doom*/
else if (GetTag(oSource)=="X2_IT_SPDVSCR105" && sType=="Weapon" && GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL)
    {
    if ((GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_BLACKGUARD, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_WORSHIP;
        if (GetLocalInt(oDest, "Sanctified")==1)
            {
            SendMessageToPC(oPC, "This item already has an opposing enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "HolyAvenger")==1)
        {
        SendMessageToPC(oPC, "The Holy Avenger resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "KiMod")>=2)
        {
        SendMessageToPC(oPC, "The Ki Weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "BGMod")>=2)
        {
        SendMessageToPC(oPC, "The Blackguard weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
        if (GetLocalInt(oDest, "Profane")==1)
            {
            SendMessageToPC(oPC, "This item already has a similar enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetCasterLevel(oPC)-(nEEL) < 3)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        IPSafeAddItemProperty(oDest, ItemPropertyLimitUseByAlign(IP_CONST_ALIGNMENTGROUP_EVIL), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,TRUE);
        sNewname="Profane " + GetName(oDest);
        SetLocalInt(oDest, "Evil", 1);
        SetLocalInt(oDest, "Profane", 1);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This weapon has been aligned with the powers of evil. It has the mark of the dark servant, " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 500);
    }

/* Abiding Weapon Requires Divine Favor*/
else if (GetTag(oSource)=="X1_IT_SPDVSCR102" && sType=="Weapon" && GetAlignmentLawChaos(oPC) == ALIGNMENT_LAWFUL)
    {
    if ((GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_WORSHIP;
        if (GetLocalInt(oDest, "Rejecting")==1)
            {
            SendMessageToPC(oPC, "This item already has an opposing enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "HolyAvenger")==1)
        {
        SendMessageToPC(oPC, "The Holy Avenger resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "KiMod")>=2)
        {
        SendMessageToPC(oPC, "The Ki Weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "BGMod")>=2)
        {
        SendMessageToPC(oPC, "The Blackguard weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
        if (GetLocalInt(oDest, "Abiding")==1)
            {
            SendMessageToPC(oPC, "This item already has a similar enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetCasterLevel(oPC)-(nEEL) < 3)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        IPSafeAddItemProperty(oDest, ItemPropertyLimitUseByAlign(IP_CONST_ALIGNMENTGROUP_LAWFUL), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,TRUE);
        sNewname="Abiding " + GetName(oDest);
        SetLocalInt(oDest, "Law", 1);
        SetLocalInt(oDest, "Abiding", 1);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This weapon has been aligned with the powers of law. It has the mark of the servant of law, " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 500);
    }

/* Rejecting Weapon Requires Scare*/
else if (GetTag(oSource)=="NW_IT_SPARSCR210" && sType=="Weapon" && GetAlignmentLawChaos(oPC) == ALIGNMENT_CHAOTIC)
    {
    if ((GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_BLACKGUARD, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_WORSHIP;
        if (GetLocalInt(oDest, "Rejecting")==1)
            {
            SendMessageToPC(oPC, "This item already has a similar enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Abiding")==1)
            {
            SendMessageToPC(oPC, "This item already has an opposing enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "HolyAvenger")==1)
        {
        SendMessageToPC(oPC, "The Holy Avenger resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "KiMod")>=2)
        {
        SendMessageToPC(oPC, "The Ki Weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "BGMod")>=2)
        {
        SendMessageToPC(oPC, "The Blackguard weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 3)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        IPSafeAddItemProperty(oDest, ItemPropertyLimitUseByAlign(IP_CONST_ALIGNMENTGROUP_CHAOTIC), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,TRUE);
        sNewname="Rejecting " + GetName(oDest);
        SetLocalInt(oDest, "Chaos", 1);
        SetLocalInt(oDest, "Rejecting", 1);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This weapon has been aligned with the powers of chaos. It has the mark of the servant of chaos, " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 500);
    }

/* Weapon of Force - Bull's Strength*/
else if (GetTag(oSource)=="NW_IT_SPARSCR212" && sType=="Weapon")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLocalInt(oDest, "Force")==5)
        {
        SendMessageToPC(oPC, "This item already has a similar enchantment.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "HolyAvenger")==1)
        {
        SendMessageToPC(oPC, "The Holy Avenger resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "KiMod")>=2)
        {
        SendMessageToPC(oPC, "The Ki Weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "BGMod")>=2)
        {
        SendMessageToPC(oPC, "The Blackguard weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 5)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d8), oDest);
    sNewname=GetName(oDest) + " of Force";
    SetLocalInt(oDest, "Force", 5);
    SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " The weapon has exception balance allowing you to land more impactful blow. It has the enchanter's mark of " + GetName(oPC), TRUE);
    SetLocalInt(oDest, "WeaponCap", GetLocalInt(oDest, "WeaponCap")+1);
    }

/* Cleaving Weapon - Divine Power*/
else if (GetTag(oSource)=="X2_IT_SPDVSCR404" && sType=="Weapon")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Magic_Arms_And_Armor", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLocalInt(oDest, "Cleaving")==7)
        {
        SendMessageToPC(oPC, "This item already has a similar enchantment.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "HolyAvenger")==1)
        {
        SendMessageToPC(oPC, "The Holy Avenger resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "KiMod")>=2)
        {
        SendMessageToPC(oPC, "The Ki Weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "BGMod")>=2)
        {
        SendMessageToPC(oPC, "The Blackguard weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 7)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusFeat(IP_CONST_FEAT_CLEAVE), oDest);
    sNewname= GetName(oDest) + " of Mighty Cleaving";
    SetLocalInt(oDest, "Cleaving", 7);
    SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " The weapon seems to act almost with a will of it's own driving from one foe into the next. It has the enchanter's mark of " + GetName(oPC), TRUE);
    SetLocalInt(oDest, "WeaponCap", GetLocalInt(oDest, "WeaponCap")+1);
    }

/* Gauntlets of Ogre Power - Bull's Strength*/
else if (GetTag(oSource)=="NW_IT_SPARSCR212" && sType=="Gauntlet")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 5)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "OgreStr")==6)
            {
            SendMessageToPC(oPC, "You have reached the maximum level of strength modification possible for this item.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "OgreStr")>=2)
            {
            SetLocalInt(oDest, "OgreStr", GetLocalInt(oDest, "OgreStr")+2);
            IPSafeAddItemProperty(oDest, ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR, GetLocalInt(oDest, "OgreStr")));
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
        else {
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR, 2), oDest);
            sNewname=GetName(oDest) + " of Ogre Power";
            SetLocalInt(oDest, "OgreStr", 2);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Wearing these gaunlets you feel a surge of unnatural strength. They have the enchanter's mark of " + GetName(oPC), TRUE);
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Gauntlets of Battle Mastery requires True Strike*/
else if (GetTag(oSource)=="X1_IT_SPARSCR104" && sType=="Gauntlet")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 5)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Master")==10)
            {
            SendMessageToPC(oPC, "This item already has a similar enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Master")>=5)
            {
            SetLocalInt(oDest, "Master", GetLocalInt(oDest, "Master")+5);
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusFeat(IP_CONST_FEAT_TWO_WEAPON_FIGHTING), oDest);
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
        else {
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusFeat(IP_CONST_FEAT_AMBIDEXTROUS), oDest);
            sNewname=GetName(oDest) + " of Battle Mastery";
            SetLocalInt(oDest, "Master", 5);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Wearing these gauntlets, you feel more confident wielding weapons in both hands. They have the enchanter's mark of " + GetName(oPC), TRUE);
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Gauntlets of Divine Favor - Divine Favor*/
else if (GetTag(oSource)=="X1_IT_SPDVSCR102" && sType=="Gauntlet")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 5)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "DPGaunt")==10)
            {
            SendMessageToPC(oPC, "You have reached the maximum level of modification possible for this item.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "DPGaunt")>=5)
            {
            SetLocalInt(oDest, "DPGaunt", GetLocalInt(oDest, "DPGaunt")+5);
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_DIVINE_FAVOR_5, IP_CONST_CASTSPELL_NUMUSES_2_USES_PER_DAY), oDest);
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
        else {
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusFeat(IP_CONST_FEAT_WEAPON_PROF_MARTIAL), oDest);
            sNewname=GetName(oDest) + " of Divine Favor";
            SetLocalInt(oDest, "DPGaunt", 5);
            SetLocalInt(oDest, "iCasterLvl", 5);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Wearing these gauntlets, you feel a certainty and proficiency with the weapons used by warriors. They have the enchanter's mark of " + GetName(oPC), TRUE);
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Bracers of Discipline requires Battletide */
else if (GetTag(oSource)=="X2_IT_SPDVSCR501" && sType=="Bracer")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_WORSHIP;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 5)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Battle")>=2)
            {
            SetLocalInt(oDest, "Battle", GetLocalInt(oDest, "Battle")+2);
            IPSafeAddItemProperty(oDest, ItemPropertySkillBonus(SKILL_DISCIPLINE,GetLocalInt(oDest, "Battle")));
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
        else {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertySkillBonus(SKILL_DISCIPLINE,2), oDest);
        sNewname=GetName(oDest) +" of Battletide";
        SetLocalInt(oDest, "Battle", 2);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " These bracers grant the wearer considerable skill in resisting several combat maneuvers. It has the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Bracers of Relentless Might - Divine Power */
else if (GetTag(oSource)=="X2_IT_SPDVSCR404" && sType=="Bracer")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_WORSHIP;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 15)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
      if (GetLocalInt(oDest, "Relentless")>=6)
            {
            SendMessageToPC(oPC, "You have reached the maximum level of modification for this item.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Relentless")>=1)
            {
            SetLocalInt(oDest, "Relentless", GetLocalInt(oDest, "Relentless")+1);
            IPSafeAddItemProperty(oDest, ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR, GetLocalInt(oDest, "Relentless")));
            IPSafeAddItemProperty(oDest, ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON, GetLocalInt(oDest, "Relentless")));
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
        else {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_KNOCKDOWN), oDest);
        sNewname=GetName(oDest) +" of Relentless Might";
        SetLocalInt(oDest, "Relentless", 1);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " These bracers grant the wearer considerable skill and abilities... these could be found on champions of the realm. It has the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Bracers of Vitality - Endurance */
else if (GetTag(oSource)=="NW_IT_SPARSCR215" && sType=="Bracer")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_WORSHIP;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 9)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Vitality")==8)
            {
            SendMessageToPC(oPC, "You have reached the maximum level of constitution modification possible for this item.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Vitality")>=2)
            {
            SetLocalInt(oDest, "Vitality", GetLocalInt(oDest, "Vitality")+2);
            IPSafeAddItemProperty(oDest, ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON, GetLocalInt(oDest, "Vitality")));
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
        else {
        IPSafeAddItemProperty(oDest, ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON, 2));
        sNewname=GetName(oDest) +" of Vitality";
        SetLocalInt(oDest, "Vitality", 2);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " These bracers grant the wearer benefits to their vitality or health. It has the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Gloves of Archery requires True Strike*/
else if (GetTag(oSource)=="X1_IT_SPARSCR104" && sType=="Gloves")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 3)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Archery")>=6)
            {
            SendMessageToPC(oPC, "You have reached the maximum level of dexterity modification possible for this item.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Archery")==3)
            {
            SetLocalInt(oDest, "Archery", GetLocalInt(oDest, "Archery")+3);
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusFeat(FEAT_RAPID_SHOT), oDest);
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
        else {
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusFeat(FEAT_POINT_BLANK_SHOT), oDest);
            sNewname=GetName(oDest) + " of Archery";
            SetLocalInt(oDest, "Archery", 3);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Wearing these gloves, you feel more confident handling ranged weapons. They have the enchanter's mark of " + GetName(oPC), TRUE);
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Gloves of Dexterity - Cat's Grace*/
else if ((GetTag(oSource)=="X2_IT_SPARSCR207" || GetTag(oSource)=="NW_IT_SPARSCR213") && sType=="Gloves")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 5)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Dexterity")>=6)
            {
            SendMessageToPC(oPC, "You have reached the maximum level of dexterity modification possible for this item.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Dexterity")>=2)
            {
                SetLocalInt(oDest, "Dexterity", GetLocalInt(oDest, "Dexterity")+2);
                IPSafeAddItemProperty(oDest, ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX, GetLocalInt(oDest, "Dexterity")));
                SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
        else {
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX, 2), oDest);
            sNewname=GetName(oDest) + " of Dexterity";
            SetLocalInt(oDest, "Dexterity", 2);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Wearing these gloves you notice that you move with a bit more deftness and ease. They bear the enchanter's mark of " + GetName(oPC), TRUE);
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
    }

/* Gloves of Appraisal - Eagle's Splendor*/
else if ((GetTag(oSource)=="nw_it_sparscr219" || GetTag(oSource)=="NW_IT_SPARSCR213") && sType=="Gloves")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 5)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Appraisal")>=2)
            {
            SetLocalInt(oDest, "Appraisal", GetLocalInt(oDest, "Appraisal")+2);
            IPSafeAddItemProperty(oDest, ItemPropertySkillBonus(SKILL_APPRAISE,GetLocalInt(oDest, "Appraisal")));
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
        else {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertySkillBonus(SKILL_APPRAISE,2), oDest);
        sNewname=GetName(oDest) + " of Appraisal";
        SetLocalInt(oDest, "Appraisal", 2);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Everything you hold while wearing these gloves appears to shine just a little bit more drawing appeal from the viewer. It has the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Gloves of Riding - Expeditious Retreat*/
else if (GetTag(oSource)==" X1_IT_SPARSCR01" && sType=="Gloves")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 5)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Riding")>=2)
            {
            SetLocalInt(oDest, "Riding", GetLocalInt(oDest, "Riding")+2);
            IPSafeAddItemProperty(oDest, ItemPropertySkillBonus(SKILL_RIDE,GetLocalInt(oDest, "Riding")));
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
        else {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertySkillBonus(SKILL_RIDE,2), oDest);
        sNewname=GetName(oDest) + " of Riding";
        SetLocalInt(oDest, "Riding", 2);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Wearing these gloves, you feel certain and at ease in the saddle. It has the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Gloves of Animal Handling - Charm Person or Animal*/
else if ((GetTag(oSource)=="NW_IT_SPDVSCR202") && sType=="Gloves")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 5)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Animal")>=2)
            {
            SetLocalInt(oDest, "Animal", GetLocalInt(oDest, "Animal")+2);
            IPSafeAddItemProperty(oDest, ItemPropertySkillBonus(SKILL_ANIMAL_EMPATHY,GetLocalInt(oDest, "Animal")));
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
        else {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertySkillBonus(SKILL_ANIMAL_EMPATHY,2), oDest);
        sNewname=GetName(oDest) + "of Animal Handling";
        SetLocalInt(oDest, "Animal", 2);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " These gloves seem to improve disposition of all animals. It has the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Thieves Gloves - Knock*/
else if ((GetTag(oSource)=="NW_IT_SPARSCR216" || GetTag(oSource)=="NW_IT_SPARSCR213") && sType=="Gloves")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 5)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Thieves")>=2)
            {
            SetLocalInt(oDest, "Thieves", GetLocalInt(oDest, "Thieves")+2);
            IPSafeAddItemProperty(oDest, ItemPropertySkillBonus(SKILL_OPEN_LOCK,GetLocalInt(oDest, "Thieves")));
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
        else {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertySkillBonus(SKILL_OPEN_LOCK,2), oDest);
        sNewname="Thieves " + GetName(oDest);
        SetLocalInt(oDest, "Thieves", 2);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Everything you hold while wearing these gloves appears to shine just a little bit more drawing appeal from the viewer. It has the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Gloves of healing - Cure light wounds*/
else if (GetTag(oSource)=="X2_IT_SPDVSCR104" && sType=="Gloves")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 5)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Healing")>=2)
            {
            SetLocalInt(oDest, "Healing", GetLocalInt(oDest, "Healing")+2);
            IPSafeAddItemProperty(oDest, ItemPropertySkillBonus(SKILL_HEAL,GetLocalInt(oDest, "Healing")));
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
        else {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertySkillBonus(SKILL_HEAL,2), oDest);
        sNewname=GetName(oDest) + " of Healing";
        SetLocalInt(oDest, "Healing", 2);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " These gloves seem to impart the care and focus of an expert healer and medic. It has the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Gloves of Parrying - Requires Divine Favor*/
else if (GetTag(oSource)=="X1_IT_SPDVSCR102" && sType=="Gloves")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 5)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Parrying")>=2)
            {
            SetLocalInt(oDest, "Parrying", GetLocalInt(oDest, "Parrying")+2);
            IPSafeAddItemProperty(oDest, ItemPropertySkillBonus(SKILL_PARRY,GetLocalInt(oDest, "Parrying")));
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
        else {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertySkillBonus(SKILL_PARRY,2), oDest);
        sNewname=GetName(oDest) + " of Parrying";
        SetLocalInt(oDest, "Parrying", 2);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " These gloves seem to impart some of the technique of an expert duelist. It has the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Gloves of Spellcraft - Requires Fox's Cunning*/
else if (GetTag(oSource)=="nw_it_sparscr220" && sType=="Gloves")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 5)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Weaving")>=2)
            {
            SetLocalInt(oDest, "Weaving", GetLocalInt(oDest, "Weaving")+2);
            IPSafeAddItemProperty(oDest, ItemPropertySkillBonus(SKILL_SPELLCRAFT,GetLocalInt(oDest, "Weaving")));
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
        else {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertySkillBonus(SKILL_SPELLCRAFT,2), oDest);
        sNewname=GetName(oDest) + " of Spellcraft";
        SetLocalInt(oDest, "Weaving", 2);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " These gloves seem to impart some of the expertise of a skilled spellcaster. It has the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Gloves of Concentration - Requires Endurance*/
else if (GetTag(oSource)=="NW_IT_SPARSCR215" && sType=="Gloves")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 5)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Focus")>=2)
            {
            SetLocalInt(oDest, "Focus", GetLocalInt(oDest, "Focus")+2);
            IPSafeAddItemProperty(oDest, ItemPropertySkillBonus(SKILL_CONCENTRATION,GetLocalInt(oDest, "Focus")));
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
        else {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertySkillBonus(SKILL_CONCENTRATION,2), oDest);
        sNewname=GetName(oDest) + " of Concentration";
        SetLocalInt(oDest, "Focus", 2);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " These gloves seem to impart an intense feeling of concentration and focus. It has the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Necklace of Adaptation requires endure elements*/
else if (GetTag(oSource)=="NW_IT_SPARSCR101" && sType=="Amulet")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_WORSHIP;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 7)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Adaptation")>=5)
            {
            SendMessageToPC(oPC, "This item already bears a similar enchantment.");
            DestroyObject(oCopy);
            }
        else {
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertySpellImmunitySpecific(IP_CONST_IMMUNITYSPELL_CLOUDKILL), oDest);
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertySpellImmunitySpecific(IP_CONST_IMMUNITYSPELL_STINKING_CLOUD), oDest);
            sNewname=GetName(oDest) + " of Adaptation";
            SetLocalInt(oDest, "Adaptation", 5);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Wearing this necklace, you find that you can breathe in the midst of harmful gases as well as areas with no air at all. It bears the enchanter's mark of " + GetName(oPC), TRUE);
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Amulet of Health - Endurance*/
else if (GetTag(oSource)=="NW_IT_SPARSCR215" && sType=="Amulet")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 5)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Health")==6)
            {
            SendMessageToPC(oPC, "You have reached the maximum level of constitution modification possible for this item.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Health")>=1)
            {
            SetLocalInt(oDest, "Health", GetLocalInt(oDest, "Health")+2);
            IPSafeAddItemProperty(oDest, ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON, GetLocalInt(oDest, "Health")));
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
        else {
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON, 2), oDest);
            sNewname=GetName(oDest) + " of Health";
            SetLocalInt(oDest, "Health", 2);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Placing the pendant around your neck, you feel generally healthier and minor ailments seem to ebb away. It bears the enchanter's mark of " + GetName(oPC), TRUE);
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Amulet of Wisdom - Owl's Wisdom or Owl's Insight*/
else if ((GetTag(oSource)=="nw_it_sparscr221" || GetTag(oSource)=="X1_IT_SPDVSCR502") && sType=="Amulet")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 5)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Wisdom")==6)
            {
            SendMessageToPC(oPC, "You have reached the maximum level of wisdom modification possible for this item.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Wisdom")>=2)
            {
            SetLocalInt(oDest, "Wisdom", GetLocalInt(oDest, "Wisdom")+2);
            IPSafeAddItemProperty(oDest, ItemPropertyAbilityBonus(IP_CONST_ABILITY_WIS, GetLocalInt(oDest, "Wisdom")));
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
        else {
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyAbilityBonus(IP_CONST_ABILITY_WIS, 2), oDest);
            sNewname=GetName(oDest) + " of Wisdom";
            SetLocalInt(oDest, "Wisdom", 2);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " With this amulet you seem to feel a hightened sense of the ways of the world. It bears the enchanter's mark of " + GetName(oPC), TRUE);
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }


/* Ring of Regeneration - Monstrous Regeneration*/
else if (GetTag(oSource)=="X2_IT_SPDVSCR502" && GetTag(oDest)=="te_cebcraft028")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_WORSHIP;
    if (GetHasFeat(1440, oPC) == FALSE)//Forge Ring Feat
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 15)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "AccessoryCap")>=6)
            {
            SendMessageToPC(oPC, "This item item already has too many enchantments for this power to take hold.");
            DestroyObject(oCopy);
            return;
            }
    if (GetLocalInt(oDest, "AccessoryCap")<4)
        {
        SendMessageToPC(oPC, "This item requires more magical enhancement bonus in order to be imbued with additional traits.");
        DestroyObject(oCopy);
        return;
        }
        if (GetLocalInt(oDest, "Regeneration")>=15)
            {
            SendMessageToPC(oPC, "This item already has a similar enchantment.");
            DestroyObject(oCopy);
            return;
            }
        else {
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyRegeneration(3), oDest);
            sNewname=GetName(oDest) + " of Regeneration";
            SetLocalInt(oDest, "Regeneration", 15);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Placing this ring on your finger, you feel your injuries diminish slowly. It bears the enchanter's mark of " + GetName(oPC), TRUE);
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Ring of Protection - Mage Armor*/
else if (GetTag(oSource)=="NW_IT_SPARSCR104" && GetTag(oDest)=="te_cebcraft028")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (GetHasFeat(1440, oPC) == FALSE)//Forge Ring Feat
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 11)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Armor")>=1)
            {
            SetLocalInt(oDest, "Armor", GetLocalInt(oDest, "Armor")+1);
            IPSafeAddItemProperty(oDest, ItemPropertyACBonus(GetLocalInt(oDest, "Armor")));
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
        else {
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyACBonus(1), oDest);
            sNewname=GetName(oDest) + " of Protection";
            SetLocalInt(oDest, "Armor", 1);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Placing the ring on your finger you feel a magical force surround you with protection. It bears the enchanter's mark of " + GetName(oPC), TRUE);
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/*Ring of Animal Friendship - Charm Person or Animal*/
else if (GetTag(oSource)=="NW_IT_SPDVSCR202" && GetTag(oDest)=="te_cebcraft028")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_WORSHIP;
    if (GetHasFeat(1440, oPC) == FALSE)//Forge Ring Feat
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 11)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Animal")>=2)
            {
            SetLocalInt(oDest, "Animal", GetLocalInt(oDest, "Animal")+2);
            IPSafeAddItemProperty(oDest, ItemPropertySkillBonus(SKILL_ANIMAL_EMPATHY,GetLocalInt(oDest, "Animal")));
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
        else {
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertySkillBonus(SKILL_ANIMAL_EMPATHY,2), oDest);
            sNewname=GetName(oDest) + " of Animal Friendship";
            SetLocalInt(oDest, "Animal", 2);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Placing this ring on your finger, you feel your fear of wild animals diminish. It bears the enchanter's mark of " + GetName(oPC), TRUE);
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
    }

/*Ring of Chameleon Power - Camouflage Spell*/
else if (GetTag(oSource)=="X1_IT_SPDVSCR107" && GetTag(oDest)=="te_cebcraft028")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_WORSHIP;
    if (GetHasFeat(1440, oPC) == FALSE)//Forge Ring Feat
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 11)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Chameleon")>=2)
            {
            SetLocalInt(oDest, "Chameleon", GetLocalInt(oDest, "Chameleon")+2);
            IPSafeAddItemProperty(oDest, ItemPropertySkillBonus(SKILL_HIDE,GetLocalInt(oDest, "Chameleon")));
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
        else {
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertySkillBonus(SKILL_HIDE,2), oDest);
            sNewname=GetName(oDest) + " of Chameleon Power";
            SetLocalInt(oDest, "Chameleon", 2);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Placing this ring on your finger, you feel very confident in your ability to remain hidden. It bears the enchanter's mark of " + GetName(oPC), TRUE);
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
    }

/*Ring of Feather Fall - Shelgarn's Persistent Blade*/
else if (GetTag(oSource)=="X2_IT_SPARSCR103" && GetTag(oDest)=="te_cebcraft028")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_WORSHIP;
    if (GetHasFeat(1440, oPC) == FALSE)//Forge Ring Feat
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 11)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "FeatherFall")>=1)
            {
            SendMessageToPC(oPC, "This item already has a similar enchantment.");
            DestroyObject(oCopy);
            return;
            }
        else {
            sNewname=GetName(oDest) + " of Featherfalling";
            SetLocalInt(oDest, "FeatherFall", 1);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Placing this ring on your finger, you feel confident around heights or other falling hazards. It bears the enchanter's mark of " + GetName(oPC), TRUE);
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Ring of Mind Protection uses lesser mind blank */
else if (GetTag(oSource)=="NW_IT_SPARSCR511" && GetTag(oDest)=="te_cebcraft028")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (GetHasFeat(1440, oPC) == FALSE)//Forge Ring Feat
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 11)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "AccessoryCap")<3)
            {
            SendMessageToPC(oPC, "This item requires more magical enhancement bonus in order to be imbued with additional traits.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "AccessoryCap")==9)
            {
            SendMessageToPC(oPC, "This item cannot house this enchantment, it is too close to its maximum value.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Mind")==11)
            {
            SendMessageToPC(oPC, "This item already has a similar enchantment.");
            DestroyObject(oCopy);
            return;
            }
        else {
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_MINDSPELLS), oDest);
            sNewname=GetName(oDest) + " of Mind Protection";
            SetLocalInt(oDest, "Mind", 11);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " When you put this ring on your finger, you feel as though your will cannot be acted upon by any outside force. It has the enchanter's mark of " + GetName(oPC), TRUE);
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Ring of Invisibility - Invisibility */
else if (GetTag(oSource)=="NW_IT_SPARSCR207" && GetTag(oDest)=="te_cebcraft028")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
        if (GetHasFeat(1440, oPC) == FALSE)//Forge Ring Feat
            {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "AccessoryCap")<2)
            {
            SendMessageToPC(oPC, "This item requires more magical enhancement bonus in order to be imbued with additional traits.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Invisibility")==5)
            {
            SendMessageToPC(oPC, "This item already has a similar enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetCasterLevel(oPC)-(nEEL) < 11)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_INVISIBILITY_3, IP_CONST_CASTSPELL_NUMUSES_2_USES_PER_DAY), oDest);
        sNewname=GetName(oDest) + " of Invisibility";
        SetLocalInt(oDest, "Invisibility", 5);
        SetLocalInt(oDest, "iCasterLvl", 12);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Wearing this ring, you suddenly feel spirited away from the world. It has the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
    }

/*Ring of Evasion - Premonition*/
else if (GetTag(oSource)=="NW_IT_SPARSCR808" && GetTag(oDest)=="te_cebcraft028")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_WORSHIP;
    if (GetHasFeat(1440, oPC) == FALSE)//Forge Ring Feat
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 15)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "AccessoryCap")==9)
            {
            SendMessageToPC(oPC, "This item cannot house this enchantment, it is too close to its maximum value.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "AccessoryCap")<3)
            {
            SendMessageToPC(oPC, "This item requires more magical enhancement bonus in order to be imbued with additional traits.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Evasion")>=10)
            {
            SendMessageToPC(oPC, "This item already has a similar enchantment.");
            DestroyObject(oCopy);
            return;
            }
        else {
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusFeat(64), oDest);//evasion
            sNewname=GetName(oDest) + " of Evasion";
            SetLocalInt(oDest, "Evasion", 10);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Placing this ring on your finger, you feel confident about being able to avoid certain hazards due to your reflexes. It bears the enchanter's mark of " + GetName(oPC), TRUE);
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Ring of Shooting Stars - Requires Magic Missile*/
else if (GetTag(oSource)=="NW_IT_SPARSCR109" && GetTag(oDest)=="te_cebcraft028")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (GetHasFeat(1440, oPC) == FALSE)//Forge Ring Feat
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLocalInt(oDest, "Spined")==9)
        {
        SendMessageToPC(oPC, "You cannot perform this enchantments a second time on this item.");
        DestroyObject(oCopy);
        return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 11)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_MAGIC_MISSILE_9, IP_CONST_CASTSPELL_NUMUSES_3_USES_PER_DAY), oDest);
    sNewname=GetName(oDest)+ " of Shooting Stars";
    SetLocalInt(oDest, "Spined",9);
    SetLocalInt(oDest, "iCasterLvl", 12);
    SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This ornate ring features a few gems that twinkle like stars and these can be launched at a target in front of you on command. It holds the enchanter's mark of " + GetName(oPC), TRUE);
    SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
    }

/* Ring of Spell Resistance - Spell Resistance */
else if (GetTag(oSource)=="X2_IT_SPDVSCR507" && GetTag(oDest)=="te_cebcraft028")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (GetHasFeat(1440, oPC) == FALSE)//Forge Ring Feat
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 11)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "AccessoryCap")<3)
            {
            SendMessageToPC(oPC, "This item requires more magical enhancement bonus in order to be imbued with additional traits.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "SR")==26)
            {
            SendMessageToPC(oPC, "This item already has a similar enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "AccessoryCap")==8)
            {
            SendMessageToPC(oPC, "This item cannot house this enchantment, it is too close to its maximum value.");
            DestroyObject(oCopy);
            return;
            }
        else {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_26), oDest);
        sNewname=GetName(oDest) + " of Spell Resistance";
        SetLocalInt(oDest, "SR", 26);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " The ring shimmers with arcane defenses. It has the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Ring of the Oakfather - Call Lightning*/
else if (GetTag(oSource)=="X2_IT_SPDVSCR307" && GetTag(oDest)=="te_cebcraft028")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_WORSHIP;
    if (GetHasFeat(1440, oPC) == FALSE)//Forge Ring Feat
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 11)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "Druidspell")>=3)
        {
        SetLocalInt(oDest, "Druidspell", GetLocalInt(oDest, "Druidspell")+1);
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusLevelSpell(IP_CONST_CLASS_DRUID ,GetLocalInt(oDest, "Druidspell")/2), oDest);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    else {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusLevelSpell(IP_CONST_CLASS_DRUID ,1), oDest);
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusLevelSpell(IP_CONST_CLASS_DRUID ,1), oDest);
        sNewname=GetName(oDest) + " of the Oakfather";
        SetLocalInt(oDest, "Druidspell", 3);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Wearing this ring, druids feel the power of the Oakfather. It bears the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Ring of the Martyr - Bless Weapon*/
else if (GetTag(oSource)=="X2_IT_SPDVSCR102" && GetTag(oDest)=="te_cebcraft028")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_WORSHIP;
    if (GetHasFeat(1440, oPC) == FALSE)//Forge Ring Feat
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 11)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "Martyr")>=3)
        {
        SetLocalInt(oDest, "Martyr", GetLocalInt(oDest, "Martyr")+1);
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusLevelSpell(IP_CONST_CLASS_PALADIN ,GetLocalInt(oDest, "Martyr")/2), oDest);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    else {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusLevelSpell(IP_CONST_CLASS_PALADIN ,1), oDest);
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusLevelSpell(IP_CONST_CLASS_PALADIN ,1), oDest);
        sNewname=GetName(oDest) + " of the Martyr";
        SetLocalInt(oDest, "Martyr", 3);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Wearing this ring, paladins feel the intense passion of their cause. It bears the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Ring of the Supreme Ranger - one with the land*/
else if (GetTag(oSource)=="X1_IT_SPDVSCR203" && GetTag(oDest)=="te_cebcraft028")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_WORSHIP;
    if (GetHasFeat(1440, oPC) == FALSE)//Forge Ring Feat
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 11)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "SupremeRanger")>=3)
        {
        SetLocalInt(oDest, "SupremeRanger", GetLocalInt(oDest, "SupremeRanger")+1);
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusLevelSpell(IP_CONST_CLASS_RANGER ,GetLocalInt(oDest, "SupremeRanger")/2), oDest);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    else {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusLevelSpell(IP_CONST_CLASS_RANGER ,1), oDest);
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusLevelSpell(IP_CONST_CLASS_RANGER ,1), oDest);
        sNewname=GetName(oDest) + " of the Supreme Ranger";
        SetLocalInt(oDest, "SupremeRanger", 3);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Wearing this ring, rangers feel the cunning and strength of the Supreme Ranger, Mielikki. It bears the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Ring of The Lord of Song - Eagle's Splendor*/
else if (GetTag(oSource)=="nw_it_sparscr219" && GetTag(oDest)=="te_cebcraft028")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_WORSHIP;
    if (GetHasFeat(1440, oPC) == FALSE)//Forge Ring Feat
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 11)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "MililBless")>=3)
        {
        SetLocalInt(oDest, "MililBless", GetLocalInt(oDest, "MililBless")+1);
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusLevelSpell(IP_CONST_CLASS_BARD ,GetLocalInt(oDest, "MililBless")/2), oDest);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    else {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusLevelSpell(IP_CONST_CLASS_BARD ,1), oDest);
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusLevelSpell(IP_CONST_CLASS_BARD ,1), oDest);
        sNewname=GetName(oDest) + " of The Lord of Song";
        SetLocalInt(oDest, "MililBless", 3);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Wearing this ring, Bards feel the inspiration of Milil, The Lord of Song. It bears the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Ring of The Pantheon - Owl's Wisdom*/
else if (GetTag(oSource)=="nw_it_sparscr221" && GetTag(oDest)=="te_cebcraft028")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_WORSHIP;
    if (GetHasFeat(1440, oPC) == FALSE)//Forge Ring Feat
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 11)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "Pantheon")>=3)
        {
        SetLocalInt(oDest, "Pantheon", GetLocalInt(oDest, "Pantheon")+1);
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusLevelSpell(IP_CONST_CLASS_CLERIC ,GetLocalInt(oDest, "Pantheon")/2), oDest);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    else {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusLevelSpell(IP_CONST_CLASS_CLERIC ,1), oDest);
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusLevelSpell(IP_CONST_CLASS_CLERIC ,1), oDest);
        sNewname=GetName(oDest) + " of Pantheons";
        SetLocalInt(oDest, "Pantheon", 3);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Wearing this ring, clerics of the Realms feel a stronger connection to their deity. It bears the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Ring of Wizardry- Fox's Cunning*/
else if (GetTag(oSource)=="nw_it_sparscr220" && GetTag(oDest)=="te_cebcraft028")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_WORSHIP;
    if (GetHasFeat(1440, oPC) == FALSE)//Forge Ring Feat
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 11)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "Wizardry")>=3)
        {
        SetLocalInt(oDest, "Wizardry", GetLocalInt(oDest, "Wizardry")+1);
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusLevelSpell(IP_CONST_CLASS_WIZARD ,GetLocalInt(oDest, "Wizardry")/2), oDest);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    else {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusLevelSpell(IP_CONST_CLASS_WIZARD ,1), oDest);
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusLevelSpell(IP_CONST_CLASS_WIZARD ,1), oDest);
        sNewname=GetName(oDest) + " of Wizardry";
        SetLocalInt(oDest, "Wizardry", 3);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Wearing this ring, wizards of the Realms feel a stronger connection to the Weave. It bears the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Ring of Elemental Fire - Firebrand */
else if (GetTag(oSource)=="X1_IT_SPARSCR501" && GetTag(oDest)=="te_cebcraft028")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_WORSHIP;
    if (GetHasFeat(1440, oPC) == FALSE)//Forge Ring Feat
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 11)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "ElementalFire")==20)
        {
        SendMessageToPC(oPC, "You cannot perform this enchantment a third time on this item.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "AccessoryCap")<2)
        {
        SendMessageToPC(oPC, "This item requires more magical enhancement bonus in order to be imbued with additional traits.");
        DestroyObject(oCopy);
        return;
        }
     if (GetLocalInt(oDest, "ElementalFire")==10)
        {
        SetLocalInt(oDest, "ElementalFire", GetLocalInt(oDest, "ElementalFire")+10);
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_FIREBRAND_15, IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY), oDest);
        SetLocalInt(oDest, "iCasterLvl", 12);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    else {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_FIRE, IP_CONST_DAMAGERESIST_10), oDest);
        sNewname=GetName(oDest) + " of Elemental Fire";
        SetLocalInt(oDest, "ElementalFire", 10);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Wearing this ring, you don't seem to fear the heat of flame. It bears the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Ring of Elemental Cold - Cone of Cold */
else if (GetTag(oSource)=="NW_IT_SPARSCR507" && GetTag(oDest)=="te_cebcraft028")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_WORSHIP;
    if (GetHasFeat(1440, oPC) == FALSE)//Forge Ring Feat
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 11)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "AccessoryCap")<2)
        {
        SendMessageToPC(oPC, "This item requires more magical enhancement bonus in order to be imbued with additional traits.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "ElementalCold")==20)
        {
        SendMessageToPC(oPC, "You cannot perform this enchantment a third time on this item.");
        DestroyObject(oCopy);
        return;
        }
     if (GetLocalInt(oDest, "ElementalCold")==10)
        {
        SetLocalInt(oDest, "ElementalCold", GetLocalInt(oDest, "ElementalCold")+10);
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_CONE_OF_COLD_15, IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY), oDest);
        SetLocalInt(oDest, "iCasterLvl", 12);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    else {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_COLD, IP_CONST_DAMAGERESIST_10), oDest);
        sNewname=GetName(oDest) + " of Elemental Cold";
        SetLocalInt(oDest, "ElementalCold", 10);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Wearing this ring, you don't seem to fear the chill of cold... It bears the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Ring of Elemental Lightning - lightning bolt */
else if (GetTag(oSource)=="NW_IT_SPARSCR310" && GetTag(oDest)=="te_cebcraft028")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_WORSHIP;
    if (GetHasFeat(1440, oPC) == FALSE)//Forge Ring Feat
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 11)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "AccessoryCap")<2)
        {
        SendMessageToPC(oPC, "This item requires more magical enhancement bonus in order to be imbued with additional traits.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "ElementalShock")==20)
        {
        SendMessageToPC(oPC, "You cannot perform this enchantment a third time on this item.");
        DestroyObject(oCopy);
        return;
        }
     if (GetLocalInt(oDest, "ElementalShock")==10)
        {
        SetLocalInt(oDest, "ElementalShock", GetLocalInt(oDest, "ElementalShock")+10);
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_LIGHTNING_BOLT_10, IP_CONST_CASTSPELL_NUMUSES_2_USES_PER_DAY), oDest);
        SetLocalInt(oDest, "iCasterLvl", 12);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    else {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ELECTRICAL, IP_CONST_DAMAGERESIST_10), oDest);
        sNewname=GetName(oDest) + " of Elemental Lightning";
        SetLocalInt(oDest, "ElementalShock", 10);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Wearing this ring, you don't seem to fear the power of lightning... It bears the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Ring of Elemental Earth - Mestil's Acid Breath */
else if (GetTag(oSource)=="X2_IT_SPARSCR301" && GetTag(oDest)=="te_cebcraft028")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_WORSHIP;
    if (GetHasFeat(1440, oPC) == FALSE)//Forge Ring Feat
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLocalInt(oDest, "AccessoryCap")<2)
        {
        SendMessageToPC(oPC, "This item requires more magical enhancement bonus in order to be imbued with additional traits.");
        DestroyObject(oCopy);
        return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 11)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "ElementalEarth")==20)
        {
        SendMessageToPC(oPC, "You cannot perform this enchantment a third time on this item.");
        DestroyObject(oCopy);
        return;
        }
     if (GetLocalInt(oDest, "ElementalEarth")==10)
        {
        SetLocalInt(oDest, "ElementalEarth", GetLocalInt(oDest, "ElementalEarth")+10);
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_DRAGON_BREATH_ACID_10, IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY), oDest);
        SetLocalInt(oDest, "iCasterLvl", 12);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    else {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID, IP_CONST_DAMAGERESIST_10), oDest);
        sNewname=GetName(oDest) + " of Elemental Earth";
        SetLocalInt(oDest, "ElementalEarth", 10);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Wearing this ring, you don't seem to fear damage from acid... It bears the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Ring of Thundering - Blindness and Deafness */
else if (GetTag(oSource)=="NW_IT_SPARSCR211" && GetTag(oDest)=="te_cebcraft028")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_WORSHIP;
    if (GetHasFeat(1440, oPC) == FALSE)//Forge Ring Feat
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
if (GetCasterLevel(oPC)-(nEEL) < 11)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "AccessoryCap")<2)
        {
        SendMessageToPC(oPC, "This item requires more magical enhancement bonus in order to be imbued with additional traits.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "ElementalSound")==20)
        {
        SendMessageToPC(oPC, "You cannot perform this enchantment a third time on this item.");
        DestroyObject(oCopy);
        return;
        }
     if (GetLocalInt(oDest, "ElementalSound")==10)
        {
        SetLocalInt(oDest, "ElementalSound", GetLocalInt(oDest, "ElementalSound")+10);
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_BLINDNESS_DEAFNESS_3, IP_CONST_CASTSPELL_NUMUSES_3_USES_PER_DAY), oDest);
        SetLocalInt(oDest, "iCasterLvl", 12);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    else {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_SONIC, IP_CONST_DAMAGERESIST_10), oDest);
        sNewname=GetName(oDest) + " of Thundering";
        SetLocalInt(oDest, "ElementalSound", 10);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Wearing this ring, you don't seem to fear damage from sonic attacks... It bears the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Ring of Darkness - Vampiric Touch */
else if (GetTag(oSource)=="NW_IT_SPARSCR311" && GetTag(oDest)=="te_cebcraft028")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_WORSHIP;
    if (GetHasFeat(1440, oPC) == FALSE)//Forge Ring Feat
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 11)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "AccessoryCap")<2)
        {
        SendMessageToPC(oPC, "This item requires more magical enhancement bonus in order to be imbued with additional traits.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "ElementalDark")==20)
        {
        SendMessageToPC(oPC, "You cannot perform this enchantment a third time on this item.");
        DestroyObject(oCopy);
        return;
        }
     if (GetLocalInt(oDest, "ElementalDark")==10)
        {
        SetLocalInt(oDest, "ElementalDark", GetLocalInt(oDest, "ElementalDark")+10);
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_VAMPIRIC_TOUCH_5, IP_CONST_CASTSPELL_NUMUSES_2_USES_PER_DAY), oDest);
        SetLocalInt(oDest, "iCasterLvl", 12);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    else {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_NEGATIVE, IP_CONST_DAMAGERESIST_10), oDest);
        sNewname=GetName(oDest) + " of Darkness";
        SetLocalInt(oDest, "ElementalDark", 10);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Wearing this ring, you don't seem to fear creatures of the night... It bears the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Ring of Mystery - Negative Energy Protection */
else if (GetTag(oSource)=="X2_IT_SPDVSCR311" && GetTag(oDest)=="te_cebcraft028")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_WORSHIP;
    if (GetHasFeat(1440, oPC) == FALSE)//Forge Ring Feat
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 11)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "AccessoryCap")<2)
        {
        SendMessageToPC(oPC, "This item requires more magical enhancement bonus in order to be imbued with additional traits.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "Mystery")==20)
        {
        SendMessageToPC(oPC, "You cannot perform this enchantment a third time on this item.");
        DestroyObject(oCopy);
        return;
        }
     if (GetLocalInt(oDest, "Mystery")==10)
        {
        SetLocalInt(oDest, "Mystery", GetLocalInt(oDest, "Mystery")+10);
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_NEGATIVE_ENERGY_PROTECTION_10, IP_CONST_CASTSPELL_NUMUSES_2_USES_PER_DAY), oDest);
        SetLocalInt(oDest, "iCasterLvl", 12);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    else {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_NEGATIVE, IP_CONST_DAMAGERESIST_10), oDest);
        sNewname=GetName(oDest) + " of Mystery";
        SetLocalInt(oDest, "Mystery", 10);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Wearing this ring, you don't seem to fear creatures of the night... It bears the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Belt of Holy Might - Glyph of Warding*/
else if (GetTag(oSource)=="X2_IT_SPDVSCR306" && sType=="Belt")
{
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
        (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
        (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
        (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
        (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
        (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
        (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0))
    {
    }
    else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_WORSHIP;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
    {
        SendMessageToPC(oPC, "You do not have the required feat.");
        DestroyObject(oCopy);
        return;
    }
    if (GetCasterLevel(oPC)-(nEEL) < 7)
    {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    if (GetLocalInt(oDest, "HolyMight")>=3)
    {
        SetLocalInt(oDest, "HolyMight", GetLocalInt(oDest, "HolyMight")+1);
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusLevelSpell(IP_CONST_CLASS_CLERIC ,GetLocalInt(oDest, "HolyMight")/2), oDest);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
    }
    else
    {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusLevelSpell(IP_CONST_CLASS_CLERIC ,1), oDest);
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusLevelSpell(IP_CONST_CLASS_CLERIC ,1), oDest);
        sNewname=GetName(oDest) + " of Holy Might";
        SetLocalInt(oDest, "HolyMight", 3);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Upon donning this belt, you feel the favor of your Deity. It bears the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
    }
}

/* Belt of Giant Strength - Bull's Strength*/
else if (GetTag(oSource)=="NW_IT_SPARSCR212" && sType=="Belt")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 5)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Giant")==6)
            {
            SendMessageToPC(oPC, "You have reached the maximum level of strength modification possible for this item.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Giant")>=2)
            {
            SetLocalInt(oDest, "Giant", GetLocalInt(oDest, "Giant")+2);
            IPSafeAddItemProperty(oDest, ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR, GetLocalInt(oDest, "Giant")));
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
        else {
           AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR, 2), oDest);
            sNewname=GetName(oDest) + " of Giant Strength";
            SetLocalInt(oDest, "Giant", 2);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Wearing this belt you feel much stronger than you did before.  You consider trying to lift a horse. It bears the enchanter's mark of " + GetName(oPC), TRUE);
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
    }

/* Belt of Agility - Cat's Grace*/
else if ((GetTag(oSource)=="X2_IT_SPARSCR207" || GetTag(oSource)=="NW_IT_SPARSCR213") && sType=="Belt")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 5)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Agility")==6)
            {
            SendMessageToPC(oPC, "You have reached the maximum level of dexterity modification possible for this item.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Agility")>=2)
            {
            SetLocalInt(oDest, "Agility", GetLocalInt(oDest, "Agility")+2);
            IPSafeAddItemProperty(oDest, ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX, GetLocalInt(oDest, "Agility")));
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
        else {
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX, 2), oDest);
            sNewname=GetName(oDest) + " of Agility";
            SetLocalInt(oDest, "Agility", 2);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Wearing this item you feel your movements are much more graceful. It bears the enchanter's mark of " + GetName(oPC), TRUE);
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Belt of the Saddle Master - True Strike*/
else if (GetTag(oSource)=="X1_IT_SPARSCR104" && sType=="Belt")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 5)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "SaddleMaster")>=6)
            {
            SendMessageToPC(oPC, "This item already has all the enchantments it can gain from this magic.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "SaddleMaster")>=4)
            {
            SetLocalInt(oDest, "SaddleMaster", GetLocalInt(oDest, "SaddleMaster")+2);
            IPSafeAddItemProperty(oDest, ItemPropertySkillBonus(SKILL_RIDE,GetLocalInt(oDest, "SaddleMaster")));
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusFeat(42), oDest);//mounted archery
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
        if (GetLocalInt(oDest, "SaddleMaster")>=2)
            {
            SetLocalInt(oDest, "SaddleMaster", GetLocalInt(oDest, "SaddleMaster")+2);
            IPSafeAddItemProperty(oDest, ItemPropertySkillBonus(SKILL_RIDE,GetLocalInt(oDest, "SaddleMaster")));
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusFeat(41), oDest);//mounted combat
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
        else {
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertySkillBonus(SKILL_RIDE, 2), oDest);
            sNewname=GetName(oDest) + " of the Saddle Master";
            SetLocalInt(oDest, "SaddleMaster", 2);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This belt confers the wearer with coveted mounted combat abilities. It has the enchanter's mark of " + GetName(oPC), TRUE);
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Gloves of Dexterity - Cat's Grace*/
else if ((GetTag(oSource)=="X2_IT_SPARSCR207" || GetTag(oSource)=="NW_IT_SPARSCR213") && sType=="Gloves")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 5)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Agility")==6)
            {
            SendMessageToPC(oPC, "You have reached the maximum level of dexterity modification possible for this item.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Agility")>=2)
            {
            SetLocalInt(oDest, "Agility", GetLocalInt(oDest, "Agility")+2);
            IPSafeAddItemProperty(oDest, ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX, GetLocalInt(oDest, "Agility")));
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
        else {
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX, 2), oDest);
            sNewname=GetName(oDest) + " of Agility";
            SetLocalInt(oDest, "Agility", 2);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Wearing this item you feel your movements are much more graceful. It bears the enchanter's mark of " + GetName(oPC), TRUE);
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
    }

/* Belt of Mobility - Freedom of Movement*/
else if (GetTag(oSource)=="X2_IT_SPDVSCR405" && (sType=="Belt" || sType=="Cloak"))
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_WORSHIP;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 7)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "AccessoryCap")>=8)
            {
            SendMessageToPC(oPC, "This item has become too powerful for this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Mobility")>=7)
            {
            SendMessageToPC(oPC, "This item already has a similar enchantment.");
            DestroyObject(oCopy);
            return;
            }
        else {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyFreeAction(), oDest);
        sNewname=GetName(oDest) + " of Mobility";
        SetLocalInt(oDest, "Mobility", 7);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This item keeps unnatural forces from preventing your movement. It bears the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Belt of Protection from Arrows - Entropic Shield*/
else if (GetTag(oSource)=="X1_IT_SPDVSCR103" && sType=="Belt")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_WORSHIP;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 7)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Archer")>=1)
            {
            SendMessageToPC(oPC, "This item already has a similar enchantment.");
            DestroyObject(oCopy);
            return;
            }
        else {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_PIERCING, IP_CONST_DAMAGERESIST_5), oDest);
        sNewname=GetName(oDest) + " of Protection from Arrows";
        SetLocalInt(oDest, "Archer", 1);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This belt prevents seems to protect you from arrows and crossbow fire... It bears the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Belt of Guiding Light - Death Ward*/
else if (GetTag(oSource)=="X2_IT_SPDVSCR403" && sType=="Belt")
    {
    if (
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_WORSHIP;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 9)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest,"AccessoryCap")>=8)
            {
            SendMessageToPC(oPC, "This item has become too powerful for this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest,"GuidingLight")<=9)
            {
            SendMessageToPC(oPC, "This item already has a similar enchantment.");
            DestroyObject(oCopy);
            return;
            }
        else {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_DEATH_MAGIC), oDest);
        sNewname=GetName(oDest) + " of Guiding Light";
        SetLocalInt(oDest, "GuidingLight", 9);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This belt seems to create a protective envelope around your life energy itself. It bears the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Glamourous Helm - Eagle's Splendor */
else if (GetTag(oSource)=="nw_it_sparscr219" && sType=="Helm")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 5)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Glamour")==6)
            {
            SendMessageToPC(oPC, "You have reached the maximum level of charisma modification possible for this item.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Glamour")>=2)
            {
            SetLocalInt(oDest, "Glamour", GetLocalInt(oDest, "Glamour")+2);
            IPSafeAddItemProperty(oDest, ItemPropertyAbilityBonus(IP_CONST_ABILITY_CHA, GetLocalInt(oDest, "Glamour")));
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
        else {
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyAbilityBonus(IP_CONST_ABILITY_CHA, 2), oDest);
            sNewname= "Glamorous " + GetName(oDest);
            SetLocalInt(oDest, "Glamour", 2);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " When you don this helm you get stares from all as you wander through town.  People seem to be drawn to it's beauty and wonder.  It bears the enchanter's mark of " + GetName(oPC), TRUE);
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Helm or Cloak of Resistance - Resistance */
else if (GetTag(oSource)=="NW_IT_SPARSCR001" && (sType=="Helm" || sType=="Cloak"))
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 5)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
       if (GetLocalInt(oDest, "Resistance")>=5)
            {
            SendMessageToPC(oPC, "This item cannot be enchanted further with this magic.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Resistance")>=1)
            {
            SetLocalInt(oDest, "Resistance", GetLocalInt(oDest, "Resistance")+1);
            IPSafeAddItemProperty(oDest, ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE, GetLocalInt(oDest, "Resistance")));
            IPSafeAddItemProperty(oDest, ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX, GetLocalInt(oDest, "Resistance")));
            IPSafeAddItemProperty(oDest, ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_WILL, GetLocalInt(oDest, "Resistance")));
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
        else {
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE, 1), oDest);
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX, 1), oDest);
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_WILL, 1), oDest);
            sNewname= GetName(oDest) + " of Resistance";
            SetLocalInt(oDest, "Resistance", 1);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This item offers added protection from all manner of threats.  It bears the enchanter's mark of " + GetName(oPC), TRUE);
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Helm of Knowledge - Legend Lore*/
else if (GetTag(oSource)=="X2_IT_SPARSCR602" && sType=="Helm")
    {
    if ((GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 11)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "Knowledge")>=3)
        {
        SetLocalInt(oDest, "Knowledge", GetLocalInt(oDest, "Knowledge")+1);
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusLevelSpell(IP_CONST_CLASS_WIZARD ,GetLocalInt(oDest, "Knowledge")/2), oDest);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    else {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusLevelSpell(IP_CONST_CLASS_WIZARD ,1), oDest);
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusLevelSpell(IP_CONST_CLASS_WIZARD ,1), oDest);
        sNewname=GetName(oDest) + " of Knowledge";
        SetLocalInt(oDest, "Knowledge", 3);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Your mind fills with new capacity for arcane memorization when you don this helm.  With the new clarity you can recall more spells than normal.  It bears the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Helm of Mind Protection uses lesser mind blank */
else if (GetTag(oSource)=="NW_IT_SPARSCR511" && sType=="Helm")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 11)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "AccessoryCap")>=8)
            {
            SendMessageToPC(oPC, "This item already has a similar enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "AccessoryCap")<3)
            {
            SendMessageToPC(oPC, "This item requires more magical enhancement bonus in order to be imbued with additional traits.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Mind")==11)
            {
            SendMessageToPC(oPC, "This item already has a similar enchantment.");
            DestroyObject(oCopy);
            return;
            }
        else {
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_MINDSPELLS), oDest);
            sNewname=GetName(oDest) + " of Mind Protection";
            SetLocalInt(oDest, "Mind", 11);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " When you put this item on your head, you feel as though your will cannot be acted upon by any outside force. It has the enchanter's mark of " + GetName(oPC), TRUE);
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Helm of Intellect - Foxes Cunning */
else if (GetTag(oSource)=="nw_it_sparscr220" && sType=="Helm")
    {
    if (
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 5)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Intellect")==6)
            {
            SendMessageToPC(oPC, "You have reached the maximum level of intelligence modification possible for this item.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Intellect")>=2)
            {
            SetLocalInt(oDest, "Intellect", GetLocalInt(oDest, "Intellect")+2);
            IPSafeAddItemProperty(oDest, ItemPropertyAbilityBonus(IP_CONST_ABILITY_INT, GetLocalInt(oDest, "Intellect")));
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
        else {
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyAbilityBonus(IP_CONST_ABILITY_INT, 2), oDest);
            sNewname=GetName(oDest) + " of Intellect";
            SetLocalInt(oDest, "Intellect", 2);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " When you put this item on your head, you suddenly see the world with a bit more clarity. It has the enchanter's mark of " + GetName(oPC), TRUE);
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Helm of the Night - See Invisibility */
else if (GetTag(oSource)=="NW_IT_SPARSCR205" && sType=="Helm")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 5)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Darkvision")==5)
            {
            SendMessageToPC(oPC, "This item already has a similar enchantment.");
            DestroyObject(oCopy);
            return;
            }
        else {
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDarkvision(), oDest);
            sNewname=GetName(oDest) + " of Night";
            SetLocalInt(oDest, "Darkvision", 5);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " When you put this item on your head, you suddenly see the world with a bit more clarity. It has the enchanter's mark of " + GetName(oPC), TRUE);
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Helm of Petrification - Flesh to Stone */
else if (GetTag(oSource)=="X1_IT_SPARSCR605" && sType=="Helm")
    {
    if (
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 11)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Petrification")==11)
            {
            SendMessageToPC(oPC, "This item already has a similar enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "AccessoryCap")>=8)
            {
            SendMessageToPC(oPC, "This item has become too powerful for this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        else {
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_FLESH_TO_STONE_5, IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY), oDest);
            sNewname=GetName(oDest) + " of Petrification";
            SetLocalInt(oDest, "Petrification", 11);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " The helm grants you the power to turn whatever your turn your gaze at to stone by thought alone. It has the enchanter's mark of " + GetName(oPC), TRUE);
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Helmet of True Sight - True seeing */
else if (GetTag(oSource)=="NW_IT_SPARSCR606" && sType=="Helm")
    {
    if (
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) >= 6)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "AccessoryCap")>=8)
            {
            SendMessageToPC(oPC, "This item has become too powerful for this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Seeing")==9)
            {
            SendMessageToPC(oPC, "This item already has a similar enchantment.");
            DestroyObject(oCopy);
            return;
            }
        else {
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_TRUE_SEEING_9, IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY), oDest);
            sNewname=GetName(oDest) + " of True Sight";
            SetLocalInt(oDest, "Seeing", 9);
            SetLocalInt(oDest, "iCasterLvl", 9);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " The helm grants you the power pierce magical illusions and see things as they really are. It has the enchanter's mark of " + GetName(oPC), TRUE);
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Watcher's Helm - Ultravision */
else if (GetTag(oSource)=="NW_IT_SPARSCR214" && sType=="Helm")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetLocalInt(oDest, "AccessoryCap")>=9)
            {
            SendMessageToPC(oPC, "This item has become too powerful for this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetCasterLevel(oPC)-(nEEL) < 5)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Watchman")>=2)
            {
            SetLocalInt(oDest, "Watchman", GetLocalInt(oDest, "Watchman")+2);
            IPSafeAddItemProperty(oDest, ItemPropertySkillBonus(SKILL_SPOT,GetLocalInt(oDest, "Watchman")));
            IPSafeAddItemProperty(oDest, ItemPropertySkillBonus(SKILL_LISTEN,GetLocalInt(oDest, "Watchman")));
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
        else {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertySkillBonus(SKILL_SPOT,2), oDest);
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertySkillBonus(SKILL_LISTEN,2), oDest);
        sNewname="Watchman's " + GetName(oDest);
        SetLocalInt(oDest, "Watchman", 2);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Wearing this helm heightens your senses and your awareness of your surroundings. An enchanter's mark for  " + GetName(oPC) + " can be seen on the item.", TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Finder's Helm - find traps scroll */
else if (GetTag(oSource)=="X2_IT_SPARSCR305" && sType=="Helm")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 5)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Finder")>=2)
            {
            SetLocalInt(oDest, "Finder", GetLocalInt(oDest, "Finder")+2);
            IPSafeAddItemProperty(oDest, ItemPropertySkillBonus(SKILL_SEARCH,GetLocalInt(oDest, "Finder")));
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
        else {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertySkillBonus(SKILL_SEARCH,2), oDest);
        sNewname="Finder's " + GetName(oDest);
        SetLocalInt(oDest, "Finder", 2);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Wearing this helm hightens your senses and your awareness of your surroundings. An enchanter's mark for  " + GetName(oPC) + " can be seen on the item.", TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Loremaster's Helm - identify scroll */
else if (GetTag(oSource)=="NW_IT_SPARSCR106" && sType=="Helm")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 5)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Lore")>=2)
            {
            SetLocalInt(oDest, "Lore", GetLocalInt(oDest, "Lore")+2);
            IPSafeAddItemProperty(oDest, ItemPropertySkillBonus(SKILL_LORE,GetLocalInt(oDest, "Lore")));
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
        else {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertySkillBonus(SKILL_LORE,2), oDest);
        sNewname="Loremaster's " + GetName(oDest);
        SetLocalInt(oDest, "Lore", 2);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Wearing this item on your brow, you have a greater insight into magical wares and their origins. An enchanter's mark for  " + GetName(oPC) + " can be seen on the item.", TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Arcanist's Helm - clarity scroll */
else if (GetTag(oSource)=="NW_IT_SPARSCR217" && sType=="Helm")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 5)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Spellcraft")>=2)
            {
            SetLocalInt(oDest, "Spellcraft", GetLocalInt(oDest, "Spellcraft")+2);
            IPSafeAddItemProperty(oDest, ItemPropertySkillBonus(SKILL_SPELLCRAFT,GetLocalInt(oDest, "Spellcraft")));
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
        else {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertySkillBonus(SKILL_SPELLCRAFT,2), oDest);
        sNewname="Arcanist's " + GetName(oDest);
        SetLocalInt(oDest, "Spellcraft", 2);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Wearing this helm hightens your senses and your awareness of the Weave. An enchanter's mark for  " + GetName(oPC) + " can be seen on the item.", TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Night Walkers's Helm or Cloak - color spray scroll*/
else if (GetTag(oSource)=="NW_IT_SPARSCR110" && (sType=="Helm" || sType=="Cloak"))
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feats for this creation.");
            DestroyObject(oCopy);
            return;
        }
    if (GetHasFeat(1300, oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feats for this creation.");
            DestroyObject(oCopy);
            return;
        }
        if (GetLocalInt(oDest, "AccessoryCap")>=7)
            {
            SendMessageToPC(oPC, "This item has become too strong for this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Daywalk")==1)
            {
            SendMessageToPC(oPC, "This item already has a similar enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetCasterLevel(oPC)-(nEEL) < 5)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        else {
        sNewname="Night Walker's " + GetName(oDest);
        SetLocalInt(oDest, "Daywalk", 1);
        SetLocalInt(oDest, "ShadowWeave", 1);
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_POSITIVE, IP_CONST_DAMAGEVULNERABILITY_25_PERCENT), oDest);
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_DIVINE, IP_CONST_DAMAGEVULNERABILITY_25_PERCENT), oDest);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Wearing this helm blots out the bright light of day, enabling comfort for Underdark races subjected to daylight. An enchanter's mark for  " + GetName(oPC) + " can be seen on the item.", TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Helmet of Foresight - Premonition */
else if (GetTag(oSource)=="NW_IT_SPARSCR808" && sType=="Helm")
    {
    if (
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 15)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Precog")>=10)
            {
            SendMessageToPC(oPC, "This item already has a similar enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "AccessoryCap")<4)
            {
            SendMessageToPC(oPC, "This item requires more magical enhancement bonus in order to be imbued with additional traits.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "AccessoryCap")>=8)
            {
            SendMessageToPC(oPC, "This item has grown too strong to be enchanted with this trait.");
            DestroyObject(oCopy);
            return;
            }
        else {
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_BACKSTAB), oDest);
            sNewname=GetName(oDest) + " of Foresight";
            SetLocalInt(oDest, "Precog", 10);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " The helm grants you the power to sense danger coming before it strikes- you are immune to backstabbing. It has the enchanter's mark of " + GetName(oPC) + ". ", TRUE);
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Cloak of Darkest Night - darkness scroll*/
else if (GetTag(oSource)=="NW_IT_SPARSCR206" && sType=="Cloak")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feats for this creation.");
            DestroyObject(oCopy);
            return;
        }
    if (GetHasFeat(1300, oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feats for this creation.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 7)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Darkest")>=5)
            {
            SetLocalInt(oDest, "Darkest", GetLocalInt(oDest, "Darkest")+5);
            IPSafeAddItemProperty(oDest, ItemPropertySkillBonus(SKILL_HIDE,GetLocalInt(oDest, "Darkest")));
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
        else {
        sNewname=GetName(oDest) + " of Darkest Night";
        SetLocalInt(oDest, "Darkest", 5);
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusFeat(IP_CONST_FEAT_HIDE_IN_PLAIN_SIGHT), oDest);
        IPSafeAddItemProperty(oDest, ItemPropertySkillBonus(SKILL_HIDE,5));
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Wearing this cloak, the lines around your silhouette seem to blur, rendering you difficult to notice. An enchanter's mark for  " + GetName(oPC) + " can be seen on the item.", TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Cloak of Displacement - Displacement */
else if (GetTag(oSource)=="X1_IT_SPARSCR301" && sType=="Cloak")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetLocalInt(oDest, "Displacement")==7)
            {
            SendMessageToPC(oPC, "This item already has a similar enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "AccessoryCap")>=9)
            {
            SendMessageToPC(oPC, "This item already has a similar enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetCasterLevel(oPC)-(nEEL) < 7)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_DISPLACEMENT_9, IP_CONST_CASTSPELL_NUMUSES_2_USES_PER_DAY), oDest);
        sNewname=GetName(oDest) + " of Displacement";
        SetLocalInt(oDest, "Displacement", 7);
        SetLocalInt(oDest, "iCasterLvl", 7);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This cloak seems transparent on first glance. It has the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
    }

/* Nymph Cloak - Eagle's Splendor */
else if (GetTag(oSource)=="nw_it_sparscr219" && sType=="Cloak")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 5)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Nymph")==6)
            {
            SendMessageToPC(oPC, "You have reached the maximum level of charisma modification possible for this item.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Nymph")>=2)
            {
            SetLocalInt(oDest, "Nymph", GetLocalInt(oDest, "Nymph")+2);
            IPSafeAddItemProperty(oDest, ItemPropertyAbilityBonus(IP_CONST_ABILITY_CHA, GetLocalInt(oDest, "Nymph")));
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
        else {
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyAbilityBonus(IP_CONST_ABILITY_CHA, 2), oDest);
            sNewname= "Nymph " + GetName(oDest);
            SetLocalInt(oDest, "Nymph", 2);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " When you don this cloak you get stares from all as you wander through town.  People seem to be drawn to it's beauty and wonder.  It bears the enchanter's mark of " + GetName(oPC), TRUE);
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Cloak of Invisibility - Invisibility */
else if (GetTag(oSource)=="NW_IT_SPARSCR207" && sType=="Cloak")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetLocalInt(oDest, "Invisibility")==5)
            {
            SendMessageToPC(oPC, "This item already has a similar enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetCasterLevel(oPC)-(nEEL) < 5)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_INVISIBILITY_3, IP_CONST_CASTSPELL_NUMUSES_2_USES_PER_DAY), oDest);
        sNewname=GetName(oDest) + " of Invisibility";
        SetLocalInt(oDest, "Invisibility", 5);
        SetLocalInt(oDest, "iCasterLvl", 5);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " When you put this cloak around your shoulders, you suddenly feel spirited away from the world. It has the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
    }

/* Cloak of Spell Resistance - Spell Resistance */
else if (GetTag(oSource)=="X2_IT_SPDVSCR507" && (sType=="Cloak" || sType=="Shield" || sType=="Belt" || sType=="Armor"))
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 11)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "AccessoryCap")<2)
            {
            SendMessageToPC(oPC, "This item requires more magical enhancement bonus in order to be imbued with additional traits.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "SR")==24)
            {
            SendMessageToPC(oPC, "This item already has a similar enchantment.");
            DestroyObject(oCopy);
            return;
            }
        else {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_24), oDest);
        sNewname=GetName(oDest) + " of Spell Resistance";
        SetLocalInt(oDest, "SR", 24);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " The item shimmers with arcane defenses. It has the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Cloak of Camouflage - Camouflague */
else if (GetTag(oSource)=="X1_IT_SPDVSCR107" && sType=="Cloak")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 5)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Hiding")>=2)
            {
            SetLocalInt(oDest, "Hiding", GetLocalInt(oDest, "Hiding")+2);
            IPSafeAddItemProperty(oDest, ItemPropertySkillBonus(SKILL_HIDE,GetLocalInt(oDest, "Hiding")));
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
        else {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertySkillBonus(SKILL_HIDE,2), oDest);
        sNewname=GetName(oDest) + " of Hiding";
        SetLocalInt(oDest, "Hiding", 2);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " When you try to hide, this cloak blurs your appearance and helps to conceal you. It has the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Cloak of Negative Plane Protection - Negative Energy Protection*/
else if (GetTag(oSource)=="X2_IT_SPDVSCR311" && sType=="Cloak")
    {
    if ((GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_WORSHIP;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 7)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Deathward")==7)
            {
            SendMessageToPC(oPC, "This item already has a similar enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "AccessoryCap")<2)
            {
            SendMessageToPC(oPC, "This item requires more magical enhancement bonus in order to be imbued with additional traits.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "AccessoryCap")==9)
            {
            SendMessageToPC(oPC, "This item has become too strong for this spell.");
            DestroyObject(oCopy);
            return;
            }
        else {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_LEVEL_ABIL_DRAIN), oDest);
        sNewname=GetName(oDest) + " of Negative Plane Protection";
        SetLocalInt(oDest, "Deathward", 7);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This cloak seems to create a protective envelope around your life energy itself. It bears the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Boots of Speed or Weapon of Speed - Requires Haste */
else if (GetTag(oSource)=="NW_IT_SPARSCR312" && (sType=="Boots" || sType=="Weapon"))
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetLocalInt(oDest, "Speed")==5)
            {
            SendMessageToPC(oPC, "This item already has a similar enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "HolyAvenger")==1)
        {
        SendMessageToPC(oPC, "The Holy Avenger resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "KiMod")>=2)
        {
        SendMessageToPC(oPC, "The Ki Weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
    if (GetLocalInt(oDest, "BGMod")>=2)
        {
        SendMessageToPC(oPC, "The Blackguard weapon resists your attempt to enchant.");
        DestroyObject(oCopy);
        return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 5)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_HASTE_5, IP_CONST_CASTSPELL_NUMUSES_2_USES_PER_DAY), oDest);
        sNewname=GetName(oDest) + " of Speed";
        SetLocalInt(oDest, "Speed", 5);
        SetLocalInt(oDest, "iCasterLvl", 5);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Time seems to nearly stand still when you handle this item. Everything around you seems to move more slowly. It has the enchanter's mark of " + GetName(oPC) + ". ", TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }

/* Boots of The Gargoyle - Stoneskin */
else if (GetTag(oSource)=="NW_IT_SPARSCR403" && sType=="Boots")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetLocalInt(oDest, "Stoneskin")==7)
            {
            SendMessageToPC(oPC, "This item already has a similar enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetCasterLevel(oPC)-(nEEL) < 7)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_STONESKIN_7, IP_CONST_CASTSPELL_NUMUSES_2_USES_PER_DAY), oDest);
        sNewname=GetName(oDest) + " of the Gargoyle";
        SetLocalInt(oDest, "Stoneskin", 7);
        SetLocalInt(oDest, "iCasterLvl", 7);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " With these boots, you find you have the ability to harden your skin with the power of the earth beneath your feet. It has the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
    }

/* Boots of Tumbling - expeditious retreat */
else if (GetTag(oSource)=="X1_IT_SPARSCR101" && sType=="Boots")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 5)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Tumbling")>=2)
            {
            SetLocalInt(oDest, "Tumbling", GetLocalInt(oDest, "Tumbling")+2);
            IPSafeAddItemProperty(oDest, ItemPropertySkillBonus(SKILL_TUMBLE,GetLocalInt(oDest, "Tumbling")));
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
        else {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertySkillBonus(SKILL_TUMBLE,2), oDest);
        sNewname=GetName(oDest) + " of Tumbling";
        SetLocalInt(oDest, "Tumbling", 2);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " When you put on these boots, you feel extremely lightfooted. It has the enchanter's mark of " + GetName(oPC)+ ". ", TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Boots of Hiding - Darkness */
else if (GetTag(oSource)=="NW_IT_SPARSCR206" && sType=="Boots")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 5)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Hiding")>=2)
            {
            SetLocalInt(oDest, "Hiding", GetLocalInt(oDest, "Hiding")+2);
            IPSafeAddItemProperty(oDest, ItemPropertySkillBonus(SKILL_HIDE,GetLocalInt(oDest, "Hiding")));
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
        else {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertySkillBonus(SKILL_HIDE,2), oDest);
        sNewname=GetName(oDest) + " of Hiding";
        SetLocalInt(oDest, "Hiding", 2);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " When you try to hide, these boots blur your appearance and help to conceal you. It has the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Boots of Silent Moves - Blindness/Deafness or One with the Land*/
else if ((GetTag(oSource)=="NW_IT_SPARSCR211" || GetTag(oSource)=="X1_IT_SPDVSCR203") && sType=="Boots")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_WORSHIP;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 5)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Silent")>=2)
            {
            SetLocalInt(oDest, "Silent", GetLocalInt(oDest, "Silent")+2);
            IPSafeAddItemProperty(oDest, ItemPropertySkillBonus(SKILL_MOVE_SILENTLY,GetLocalInt(oDest, "Silent")));
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
        else {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertySkillBonus(SKILL_MOVE_SILENTLY,2), oDest);
        sNewname=GetName(oDest) + " of Silent Moves";
        SetLocalInt(oDest, "Silent", 2);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " When you put these boots on your feet, you feel light of step and as though you could walk on air. It has the enchanter's mark of " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Boots of Striding requires Endurance */
else if (GetTag(oSource)=="NW_IT_SPARSCR215" && sType=="Boots")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 5)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Striding")==6)
            {
            SendMessageToPC(oPC, "You have reached the maximum level of constitution modification possible for this item.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Striding")>=2)
            {
                SetLocalInt(oDest, "Striding", GetLocalInt(oDest, "Striding")+2);
                IPSafeAddItemProperty(oDest, ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON, GetLocalInt(oDest, "Striding")));
                SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
        else {
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON, 2), oDest);
            sNewname=GetName(oDest) + " of Striding";
            SetLocalInt(oDest, "Striding", 2);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Wearing these boots, you feel as though you could run and run without becoming winded. They bear the enchanter's mark of " + GetName(oPC), TRUE);
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Boots of Swiftness requires Fear*/
else if (GetTag(oSource)=="NW_IT_SPARSCR413" && sType=="Boots")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 7)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Swiftness")==8)
            {
            SendMessageToPC(oPC, "You have reached the maximum level of dexterity modification possible for this item.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Swiftness")>=2)
            {
                SetLocalInt(oDest, "Swiftness", GetLocalInt(oDest, "Swiftness")+2);
                IPSafeAddItemProperty(oDest, ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX, GetLocalInt(oDest, "Swiftness")));
                SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
        else {
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX, 2), oDest);
            sNewname=GetName(oDest) + " of Swiftness";
            SetLocalInt(oDest, "Swiftness", 2);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " Wearing these boots, you feel as though you could dash faster than anything in the realms... They bear the enchanter's mark of " + GetName(oPC), TRUE);
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Boots of Reflexes - Resistance */
else if (GetTag(oSource)=="NW_IT_SPARSCR001" && sType=="Boots")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 3)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Reflexes")>=2)
            {
            SetLocalInt(oDest, "Reflexes", GetLocalInt(oDest, "Reflexes")+2);
            IPSafeAddItemProperty(oDest, ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX, GetLocalInt(oDest, "Reflexes")));
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            }
        else {
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX, 2), oDest);
            sNewname= GetName(oDest) + " of Reflexes";
            SetLocalInt(oDest, "Reflexes", 2);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " These boots make the wearer much more reflexive in response to danger.  It bears the enchanter's mark of " + GetName(oPC), TRUE);
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        }
    }

/* Bane Weapon - Undead - Garnet & Arrows */
else if (GetTag(oSource)=="NW_IT_GEM011" && GetTag(oDest) == "NW_WAMAR001")
    {
    if (GetHasFeat(FEAT_FAVORED_ENEMY_UNDEAD,oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You must have a favored enemy to make this item.");
            DestroyObject(oCopy);
            return;
        }
    if (GetGold(oPC) < 1000)
        {
            SendMessageToPC(oPC, "You do not have the 1000 gold required for this creation.");
            DestroyObject(oCopy);
            return;
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        CreateItemOnObject("te_rang16", oTarget, 1);
        AssignCommand(oPC, TakeGoldFromCreature(1000, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);;
    return;
    }

//begin staff section
/*Staff of Abjuration requires minor globe of invulnerability*/
else if (GetTag(oSource)=="NW_IT_SPARSCR401" && sType=="Staff")
    {
    if ((GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (GetHasFeat(1442, oPC) == FALSE)//Craft Staff
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLocalInt(oDest, "MagicStaff")==1)
        {
        SendMessageToPC(oPC, "This staff resists any attempt to enchant it further.");
        DestroyObject(oCopy);
        return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 13)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_SHIELD_5, IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_RESIST_ELEMENTS_10, IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_DISPEL_MAGIC_10, IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_MINOR_GLOBE_OF_INVULNERABILITY_7, IP_CONST_CASTSPELL_NUMUSES_2_CHARGES_PER_USE), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_DISMISSAL_12, IP_CONST_CASTSPELL_NUMUSES_3_CHARGES_PER_USE), oDest);
    sNewname="Staff of Abjuration";
    SetLocalInt(oDest, "iCasterLvl", 13);
    SetLocalInt(oDest, "MagicStaff", 1);
    SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This staff holds several useful protective spells. It holds the enchanter's mark of " + GetName(oPC), TRUE);
    SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 32500);
    }

/*Staff of Charming requires charm monster*/
else if (GetTag(oSource)=="NW_IT_SPARSCR405" && sType=="Staff")
    {
    if ((GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (GetHasFeat(1442, oPC) == FALSE)//Craft Staff
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLocalInt(oDest, "MagicStaff")==1)
        {
        SendMessageToPC(oPC, "This staff resists any attempt to enchant it further.");
        DestroyObject(oCopy);
        return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 13)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_CHARM_PERSON_10, IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_CHARM_MONSTER_10, IP_CONST_CASTSPELL_NUMUSES_2_CHARGES_PER_USE), oDest);
    sNewname="Staff of Charming";
    SetLocalInt(oDest, "iCasterLvl", 13);
    SetLocalInt(oDest, "MagicStaff", 1);
    SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This staff holds a few enchantment spells intended for manipulating others. It holds the enchanter's mark of " + GetName(oPC), TRUE);
    SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 8250);
    }

/*Staff of Conjuration requires cloudkill*/
else if (GetTag(oSource)=="NW_IT_SPARSCR502" && sType=="Staff")
    {
    if ((GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (GetHasFeat(1442, oPC) == FALSE)//Craft Staff
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLocalInt(oDest, "MagicStaff")==1)
        {
        SendMessageToPC(oPC, "This staff resists any attempt to enchant it further.");
        DestroyObject(oCopy);
        return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 13)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_STINKING_CLOUD_5, IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_CLOUDKILL_9, IP_CONST_CASTSPELL_NUMUSES_2_CHARGES_PER_USE), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_SUMMON_CREATURE_VI_11, IP_CONST_CASTSPELL_NUMUSES_3_CHARGES_PER_USE), oDest);
    sNewname="Staff of Conjuration";
    SetLocalInt(oDest, "iCasterLvl", 13);
    SetLocalInt(oDest, "MagicStaff", 1);
    SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This staff holds a few useful conjuration spells. It holds the enchanter's mark of " + GetName(oPC), TRUE);
    SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 32500);
    }

/*Staff of Defense requires Shield of faith*/
else if (GetTag(oSource)=="X1_IT_SPDVSCR105" && sType=="Staff")
    {
    if ((GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (GetHasFeat(1442, oPC) == FALSE)//Craft Staff
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLocalInt(oDest, "MagicStaff")==1)
        {
        SendMessageToPC(oPC, "This staff resists any attempt to enchant it further.");
        DestroyObject(oCopy);
        return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 13)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_SHIELD_5, IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_SHIELD_OF_FAITH_5, IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_ENTROPIC_SHIELD_5, IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_UNDEATHS_ETERNAL_FOE_20, IP_CONST_CASTSPELL_NUMUSES_3_CHARGES_PER_USE), oDest);
    sNewname="Staff of Defense";
    SetLocalInt(oDest, "iCasterLvl", 13);
    SetLocalInt(oDest, "MagicStaff", 1);
    SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This staff holds a few useful defensive spells. It holds the enchanter's mark of " + GetName(oPC), TRUE);
    SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 24125);
    }

/*Staff of Divination requires True Seeing*/
else if (GetTag(oSource)=="NW_IT_SPARSCR606" && sType=="Staff")
    {
    if ((GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (GetHasFeat(1442, oPC) == FALSE)//Craft Staff
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLocalInt(oDest, "MagicStaff")==1)
        {
        SendMessageToPC(oPC, "This staff resists any attempt to enchant it further.");
        DestroyObject(oCopy);
        return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 13)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_FIND_TRAPS_3, IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_TRUE_SEEING_9, IP_CONST_CASTSPELL_NUMUSES_3_CHARGES_PER_USE), oDest);
    sNewname="Staff of Divination";
    SetLocalInt(oDest, "iCasterLvl", 13);
    SetLocalInt(oDest, "MagicStaff", 1);
    SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This staff holds a few useful divination spells. It holds the enchanter's mark of " + GetName(oPC), TRUE);
    SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 32500);
    }

/*Staff of Enchantment requires Mind Fog*/
else if (GetTag(oSource)=="NW_IT_SPARSCR506" && sType=="Staff")
    {
    if ((GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (GetHasFeat(1442, oPC) == FALSE)//Craft Staff
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLocalInt(oDest, "MagicStaff")==1)
        {
        SendMessageToPC(oPC, "This staff resists any attempt to enchant it further.");
        DestroyObject(oCopy);
        return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 13)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_SLEEP_5, IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_CONFUSION_10, IP_CONST_CASTSPELL_NUMUSES_2_CHARGES_PER_USE), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_MIND_FOG_9, IP_CONST_CASTSPELL_NUMUSES_2_CHARGES_PER_USE), oDest);
    sNewname="Staff of Enchantment";
    SetLocalInt(oDest, "iCasterLvl", 13);
    SetLocalInt(oDest, "MagicStaff", 1);
    SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This staff holds a few useful enchantment spells. It holds the enchanter's mark of " + GetName(oPC), TRUE);
    SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 32500);
    }

/*Staff of Evocation requires chain lightning*/
else if (GetTag(oSource)=="NW_IT_SPARSCR607" && sType=="Staff")
    {
    if ((GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (GetHasFeat(1442, oPC) == FALSE)//Craft Staff
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLocalInt(oDest, "MagicStaff")==1)
        {
        SendMessageToPC(oPC, "This staff resists any attempt to enchant it further.");
        DestroyObject(oCopy);
        return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 13)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_MAGIC_MISSILE_9, IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_SOUND_BURST_3, IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_FIREBALL_10, IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_ICE_STORM_9, IP_CONST_CASTSPELL_NUMUSES_2_CHARGES_PER_USE), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_CHAIN_LIGHTNING_11, IP_CONST_CASTSPELL_NUMUSES_3_CHARGES_PER_USE), oDest);
    sNewname="Staff of Evocation";
    SetLocalInt(oDest, "iCasterLvl", 13);
    SetLocalInt(oDest, "MagicStaff", 1);
    SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This staff holds several powerful evocation spells. It holds the enchanter's mark of " + GetName(oPC), TRUE);
    SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 32500);
    }

/*Staff of Fire requires Wall of Fire*/
else if (GetTag(oSource)=="NW_IT_SPARSCR407" && sType=="Staff")
    {
    if ((GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (GetHasFeat(1442, oPC) == FALSE)//Craft Staff
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLocalInt(oDest, "MagicStaff")==1)
        {
        SendMessageToPC(oPC, "This staff resists any attempt to enchant it further.");
        DestroyObject(oCopy);
        return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 13)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_BURNING_HANDS_5, IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_FIREBALL_10, IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_WALL_OF_FIRE_9, IP_CONST_CASTSPELL_NUMUSES_2_CHARGES_PER_USE), oDest);
    sNewname="Staff of Fire";
    SetLocalInt(oDest, "iCasterLvl", 13);
    SetLocalInt(oDest, "MagicStaff", 1);
    SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This staff holds several powerful fire spells. It holds the enchanter's mark of " + GetName(oPC), TRUE);
    SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 16000);
    }

/*Staff of Frost requires Cone of Cold*/
else if (GetTag(oSource)=="NW_IT_SPARSCR507" && sType=="Staff")
    {
    if ((GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (GetHasFeat(1442, oPC) == FALSE)//Craft Staff
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLocalInt(oDest, "MagicStaff")==1)
        {
        SendMessageToPC(oPC, "This staff resists any attempt to enchant it further.");
        DestroyObject(oCopy);
        return;

  }
    if (GetCasterLevel(oPC)-(nEEL) < 13)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_ICE_STORM_9, IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_CONE_OF_COLD_9, IP_CONST_CASTSPELL_NUMUSES_2_CHARGES_PER_USE), oDest);
    sNewname="Staff of Frost";
    SetLocalInt(oDest, "iCasterLvl", 13);
    SetLocalInt(oDest, "MagicStaff", 1);
    SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This staff holds several powerful cold spells. It holds the enchanter's mark of " + GetName(oPC), TRUE);
    SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 32000);
    }

/*Staff of Healing requires cure serious wounds*/
else if (GetTag(oSource)=="X2_IT_SPDVSCR308" && sType=="Staff")
    {
    if ((GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (GetHasFeat(1442, oPC) == FALSE)//Craft Staff
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLocalInt(oDest, "MagicStaff")==1)
        {
        SendMessageToPC(oPC, "This staff resists any attempt to enchant it further.");
        DestroyObject(oCopy);
        return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 13)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_LESSER_RESTORATION_3, IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_CURE_SERIOUS_WOUNDS_10, IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_REMOVE_BLINDNESS_DEAFNESS_5, IP_CONST_CASTSPELL_NUMUSES_2_CHARGES_PER_USE), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_REMOVE_DISEASE_5, IP_CONST_CASTSPELL_NUMUSES_3_CHARGES_PER_USE), oDest);
    sNewname="Staff of Healing";
    SetLocalInt(oDest, "iCasterLvl", 13);
    SetLocalInt(oDest, "MagicStaff", 1);
    SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This staff holds several powerful healing spells. It holds the enchanter's mark of " + GetName(oPC), TRUE);
    SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 16000);
    }

/*Staff of Illusion requires improved invisibility*/
else if (GetTag(oSource)=="NW_IT_SPARSCR408" && sType=="Staff")
    {
    if ((GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (GetHasFeat(1442, oPC) == FALSE)//Craft Staff
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLocalInt(oDest, "MagicStaff")==1)
        {
        SendMessageToPC(oPC, "This staff resists any attempt to enchant it further.");
        DestroyObject(oCopy);
        return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 13)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(556, IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE), oDest); //blur
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_INVISIBILITY_3, IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_INVISIBILITY_SPHERE_5, IP_CONST_CASTSPELL_NUMUSES_2_CHARGES_PER_USE), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_IMPROVED_INVISIBILITY_7, IP_CONST_CASTSPELL_NUMUSES_3_CHARGES_PER_USE), oDest);
    sNewname="Staff of Illusion";
    SetLocalInt(oDest, "iCasterLvl", 13);
    SetLocalInt(oDest, "MagicStaff", 1);
    SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This staff holds a several useful illusion spells. It holds the enchanter's mark of " + GetName(oPC), TRUE);
    SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 32500);
    }

/*Staff of Illumination requires sunburst*/
else if (GetTag(oSource)=="X1_IT_SPDVSCR802" && sType=="Staff")
    {
    if ((GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (GetHasFeat(1442, oPC) == FALSE)//Craft Staff
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLocalInt(oDest, "MagicStaff")==1)
        {
        SendMessageToPC(oPC, "This staff resists any attempt to enchant it further.");
        DestroyObject(oCopy);
        return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 13)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_FLARE_1, IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(563, IP_CONST_CASTSPELL_NUMUSES_2_CHARGES_PER_USE), oDest); //daylight
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_SUNBURST_20, IP_CONST_CASTSPELL_NUMUSES_3_CHARGES_PER_USE), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_NORMAL, IP_CONST_LIGHTCOLOR_WHITE), oDest);
    sNewname="Staff of Illumination";
    SetLocalInt(oDest, "iCasterLvl", 13);
    SetLocalInt(oDest, "MagicStaff", 1);
    SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This staff holds a few useful light spells. It holds the enchanter's mark of " + GetName(oPC), TRUE);
    SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 25000);
    }

/*Staff of Life requires raise dead*/
else if (GetTag(oSource)=="NW_IT_SPDVSCR501" && sType=="Staff")
    {
    if (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (GetHasFeat(1442, oPC) == FALSE)//Craft Staff
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLocalInt(oDest, "MagicStaff")==1)
        {
        SendMessageToPC(oPC, "This staff resists any attempt to enchant it further.");
        DestroyObject(oCopy);
        return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 13)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_HEAL_11, IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_RESURRECTION_13, IP_CONST_CASTSPELL_NUMUSES_5_CHARGES_PER_USE), oDest);
    sNewname="Staff of Life";
    SetLocalInt(oDest, "iCasterLvl", 13);
    SetLocalInt(oDest, "MagicStaff", 1);
    SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This staff holds a few useful spells that affect a recipient's life. It holds the enchanter's mark of " + GetName(oPC), TRUE);
    SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 32500);
    }

/*Staff of Necromancy requires circle of death*/
else if (GetTag(oSource)=="NW_IT_SPARSCR610" && sType=="Staff")
    {
    if ((GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (GetHasFeat(1442, oPC) == FALSE)//Craft Staff
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLocalInt(oDest, "MagicStaff")==1)
        {
        SendMessageToPC(oPC, "This staff resists any attempt to enchant it further.");
        DestroyObject(oCopy);
        return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 13)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_SCARE_2, IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_GHOUL_TOUCH_3, IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(568, IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE), oDest);//halt undead
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_ENERVATION_7, IP_CONST_CASTSPELL_NUMUSES_2_CHARGES_PER_USE), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_CIRCLE_OF_DEATH_11, IP_CONST_CASTSPELL_NUMUSES_3_CHARGES_PER_USE), oDest);
    sNewname="Staff of Necromancy";
    SetLocalInt(oDest, "iCasterLvl", 13);
    SetLocalInt(oDest, "MagicStaff", 1);
    SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This staff holds several powerful necromancy spells. It holds the enchanter's mark of " + GetName(oPC), TRUE);
    SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 32500);
    }

/*Staff of Passage requires Teleport scroll*/
else if (GetTag(oSource)=="te_scr_tele" && sType=="Staff")
    {
    if ((GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (GetHasFeat(1442, oPC) == FALSE)//Craft Staff
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLocalInt(oDest, "MagicStaff")==1)
        {
        SendMessageToPC(oPC, "This staff resists any attempt to enchant it further.");
        DestroyObject(oCopy);
        return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 13)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(540, IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE), oDest);//dimension door
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(541, IP_CONST_CASTSPELL_NUMUSES_2_CHARGES_PER_USE), oDest);//teleport
    sNewname="Staff of Passage";
    SetLocalInt(oDest, "iCasterLvl", 13);
    SetLocalInt(oDest, "MagicStaff", 1);
    SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This staff holds some useful transportation spells. It holds the enchanter's mark of " + GetName(oPC), TRUE);
    SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 32500);
    }

/*Staff of Power requires globe of invulnerability*/
else if (GetTag(oSource)=="NW_IT_SPARSCR601" && sType=="Staff")
    {
    if ((GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (GetHasFeat(1442, oPC) == FALSE)//Craft Staff
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLocalInt(oDest, "MagicStaff")==1)
        {
        SendMessageToPC(oPC, "This staff resists any attempt to enchant it further.");
        DestroyObject(oCopy);
        return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 13)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_MAGIC_MISSILE_9, IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_RAY_OF_ENFEEBLEMENT_2, IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_LIGHT_5, IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_LIGHTNING_BOLT_10, IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_FIREBALL_10, IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_CONE_OF_COLD_9, IP_CONST_CASTSPELL_NUMUSES_2_CHARGES_PER_USE), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_HOLD_MONSTER_7, IP_CONST_CASTSPELL_NUMUSES_2_CHARGES_PER_USE), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_GLOBE_OF_INVULNERABILITY_11, IP_CONST_CASTSPELL_NUMUSES_2_CHARGES_PER_USE), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyACBonus(2), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyEnhancementBonus(2), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE,2), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX,2), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_WILL,2), oDest);
    sNewname="Staff of Power";
    SetLocalInt(oDest, "MagicStaff", 1);
    SetLocalInt(oDest, "iCasterLvl", 13);
    SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This staff holds several powerful spells. It holds the enchanter's mark of " + GetName(oPC), TRUE);
    SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 105500);
    }

/*Staff of Transmutation requires disintegrate*/
else if (GetTag(oSource)=="te_scr_dis" && sType=="Staff")
    {
    if ((GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (GetHasFeat(1442, oPC) == FALSE)//Craft Staff
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLocalInt(oDest, "MagicStaff")==1)
        {
        SendMessageToPC(oPC, "This staff resists any attempt to enchant it further.");
        DestroyObject(oCopy);
        return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 13)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_EXPEDITIOUS_RETREAT_5, IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_POLYMORPH_SELF_7, IP_CONST_CASTSPELL_NUMUSES_2_CHARGES_PER_USE), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(571, IP_CONST_CASTSPELL_NUMUSES_3_CHARGES_PER_USE), oDest);//disintegrate
    sNewname=GetName(oDest)+ " of Disintegrate";
    SetLocalInt(oDest, "iCasterLvl", 13);
    SetLocalInt(oDest, "MagicStaff", 1);
    SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This staff holds a few useful transmutation spells. It holds the enchanter's mark of " + GetName(oPC), TRUE);
    SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 32500);
    }

/*Staff of Woodlands requires summon VI*/
else if (GetTag(oSource)=="NW_IT_SPARSCR605" && sType=="Staff")
    {
    if ((GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_CONJURE1;
    if (GetHasFeat(1442, oPC) == FALSE)//Craft Staff
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
    if (GetLocalInt(oDest, "MagicStaff")==1)
        {
        SendMessageToPC(oPC, "This staff resists any attempt to enchant it further.");
        DestroyObject(oCopy);
        return;
        }
    if (GetCasterLevel(oPC)-(nEEL) < 13)
        {
        SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
        DestroyObject(oCopy);
        return;
        }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_CHARM_PERSON_OR_ANIMAL_10, IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_BARKSKIN_12, IP_CONST_CASTSPELL_NUMUSES_2_CHARGES_PER_USE), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IP_CONST_CASTSPELL_SUMMON_CREATURE_VI_11, IP_CONST_CASTSPELL_NUMUSES_3_CHARGES_PER_USE), oDest);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(541, IP_CONST_CASTSPELL_NUMUSES_4_CHARGES_PER_USE), oDest);//summon shambling mound
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyEnhancementBonus(2), oDest);
    sNewname=GetName(oDest)+ " of Woodlands";
    SetLocalInt(oDest, "iCasterLvl", 13);
    SetLocalInt(oDest, "WoodlandStaff", 1);
    SetLocalInt(oDest, "MagicStaff", 1);
    SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This staff holds several powerful spells tied to nature. It holds the enchanter's mark of " + GetName(oPC), TRUE);
    SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 65000);
    }

/* Lich Potion uses Animate Dead and an empty bottle*/
else if (GetResRef(oSource)=="nw_it_sparscr509" && GetTag(oDest) == "NW_IT_THNMISC001")
    {
    if (GetGold(oPC) < 1000)
        {
            SendMessageToPC(oPC, "You do not have the 1000 gold required to make this concoction.");
            DestroyObject(oCopy);
            return;
        }
    SendMessageToPC(oPC, IntToString(nRoll) + "+" + IntToString(GetSkillRank(SKILL_SPELLCRAFT, oPC)) + "=" + IntToString(nRoll+GetSkillRank(SKILL_SPELLCRAFT, oPC)) + " vs DC 25");
    if (nRoll+GetSkillRank(SKILL_SPELLCRAFT, oPC) < 25)
        {
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_MEDITATE, 1.0f, 5.0f));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
            SendMessageToPC(oPC, "You fail to create the item, ruining the components.");
            DestroyObject(oSource);
            DestroyObject(oDest);
            DestroyObject(oCopy);
        }
    else
        {
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_MEDITATE, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        CreateItemOnObject("te_lichpotion", oTarget, 1);
        AssignCommand(oPC, TakeGoldFromCreature(1000, oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        }
    return;
    }

/* Lich Phylactery Greater Magic weapon on a necklace */
else if (GetResRef(oSource)=="x2_it_sparscr304" && sType == "Amulet")
    {
    if (GetGold(oPC) < (GetLevelByClass(CLASS_TYPE_WIZARD)*750))
        {
            SendMessageToPC(oPC, "You do not have the gold required to make an item of this magnitude.");
            DestroyObject(oCopy);
            return;
        }
    SendMessageToPC(oPC, IntToString(nRoll) + "+" + IntToString(GetSkillRank(SKILL_SPELLCRAFT, oPC)) + "=" + IntToString(nRoll+GetSkillRank(SKILL_SPELLCRAFT, oPC)) + " vs DC 35");
    if (nRoll+GetSkillRank(SKILL_SPELLCRAFT, oPC) < 35)
        {
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_MEDITATE, 1.0f, 5.0f));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
            SendMessageToPC(oPC, "You fail to create the item. The creation is ruined.");
            DestroyObject(oSource);
            DestroyObject(oDest);
            DestroyObject(oCopy);
        }
    else
        {
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_MEDITATE, 1.0f, 5.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
        CreateItemOnObject("te_phylactery", oTarget, 1);
        AssignCommand(oPC, TakeGoldFromCreature((GetLevelByClass(CLASS_TYPE_WIZARD)*750), oPC, TRUE));
        DestroyObject(oSource);
        DestroyObject(oDest);
        DestroyObject(oCopy);
        }
    return;
    }

/*Smoke Powder Combinations*/
/*Barrel Improvements*/

/*Crosshairs - uses Crosshairs and a heater*/
else if (GetTag(oSource)=="te_fireupg_001" && sType=="Ranged")
{
    nAnim = ANIMATION_LOOPING_GET_MID;
    if (GetLocalInt(oDest, "nGun")==0)
    {
        SendMessageToPC(oPC, "These crosshairs are meant for a smoke powder weapon.");
        DestroyObject(oCopy);
        return;
    }
    if (GetLocalInt(oDest, "Modified")>=6)
    {
        SendMessageToPC(oPC, "You cannot modify this smoke powder weapon any further.");
        DestroyObject(oCopy);
        return;
    }
    if (GetLocalInt(oDest, "Crosshairs")==2)
    {
        SendMessageToPC(oPC, "You have already added two crosshairs.");
        DestroyObject(oCopy);
        return;
    }

    //Gunsmith proficiency means no roll.
    if(GetHasFeat(1483,oPC) == TRUE)
    {
        //Crosshairs - 1 Present
        if (GetLocalInt(oDest, "Crosshairs")==1)
        {
            SendMessageToPC(oPC, "You effortlessly add the crosshairs to the smoke powder weapon.");
            SetLocalInt(oDest, "Crosshairs", GetLocalInt(oDest, "Crosshairs")+1);
            IPSafeAddItemProperty(oDest, ItemPropertyAttackBonus(GetLocalInt(oDest, "Crosshairs")));
            SetLocalInt(oDest, "Modified", GetLocalInt(oDest, "Modified")+1);
            SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 250);
            DestroyObject(oSource);
            DestroyObject(oCopy);
        }
        //Crosshairs - None Present
        else if (GetLocalInt(oDest, "Crosshairs") == 0)
        {
            SendMessageToPC(oPC, "You effortlessly add the crosshairs to the smoke powder weapon.");
            IPSafeAddItemProperty(oDest, ItemPropertyAttackBonus(1));
            SetLocalInt(oDest, "Modified", GetLocalInt(oDest, "Modified")+1);
            SetLocalInt(oDest, "Crosshairs", 1);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This smoke powder weapon has been modified with Crosshairs, giving it an attack bonus.");
            SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 250);
            DestroyObject(oSource);
            DestroyObject(oCopy);
        }
    }
    else
    //No gunsmith proficiency means roll.
    {
        //Crosshairs - 1 Present
        if (GetLocalInt(oDest, "Crosshairs")==1)
        {
            SendMessageToPC(oPC, IntToString(nRoll) + " Roll + Intelligence Modifier " + IntToString(GetAbilityModifier(ABILITY_INTELLIGENCE,oPC)) + "=" + IntToString(nRoll) + " vs. DC 15");
            if (nRoll+(GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) < 15)
            {
                AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0f, 5.0f));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
                SendMessageToPC(oPC, "The attempt to combine these two things has failed.");
                DestroyObject(oSource);
                DestroyObject(oCopy);
            }
            else
            {
                SendMessageToPC(oPC, "You manage to add the crosshairs to the smoke powder weapon.");
                AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0f, 5.0f));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
                SetLocalInt(oDest, "Crosshairs", GetLocalInt(oDest, "Crosshairs")+1);
                IPSafeAddItemProperty(oDest, ItemPropertyAttackBonus(GetLocalInt(oDest, "Crosshairs")));
                SetLocalInt(oDest, "Modified", GetLocalInt(oDest, "Modified")+1);
                SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 250);
                DestroyObject(oSource);
                DestroyObject(oCopy);
            }
        }
        //Crosshairs - None Present
        else if (GetLocalInt(oDest, "Crosshairs") == 0)
        {
            SendMessageToPC(oPC, IntToString(nRoll) + " Roll + Intelligence Modifier " + IntToString(GetAbilityModifier(ABILITY_INTELLIGENCE,oPC)) + "=" + IntToString(nRoll) + " vs. DC 15");
            if (nRoll+(GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) < 15)
            {
                AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0f, 5.0f));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
                SendMessageToPC(oPC, "The attempt to combine these two things has failed.");
                DestroyObject(oSource);
                DestroyObject(oCopy);
            }
            else
            {
                AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0f, 5.0f));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
                IPSafeAddItemProperty(oDest, ItemPropertyAttackBonus(1));
                SetLocalInt(oDest, "Modified", GetLocalInt(oDest, "Modified")+1);
                SetLocalInt(oDest, "Crosshairs", 1);
                SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This smoke powder weapon has been modified with Crosshairs, giving it an attack bonus.");
                SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 250);
                DestroyObject(oSource);
                DestroyObject(oCopy);
            }
        }
    }
    return;
}

/*Profane Horn - uses Profane Horn and a heater*/
else if (GetTag(oSource)=="te_fireupg_002" && sType=="Ranged")
{
    nAnim = ANIMATION_LOOPING_GET_MID;
    if (GetLocalInt(oDest, "nGun")==0)
    {
        SendMessageToPC(oPC, "This profane horn is meant for a smoke powder weapon.");
        DestroyObject(oCopy);
        return;
    }
    if (GetLocalInt(oDest, "Modified")>=6)
    {
        SendMessageToPC(oPC, "You cannot modify this smoke powder weapon any further.");
        DestroyObject(oCopy);
        return;
    }
    if (GetLocalInt(oDest, "SanctifiedBrass")==1)
    {
        SendMessageToPC(oPC, "You cannot add Profane Horn to this smoke powder weapon.");
        DestroyObject(oCopy);
        return;
    }
    if (GetLocalInt(oDest, "ProfaneHorn")==1)
    {
        SendMessageToPC(oPC, "You have already added Profane Horn to this smoke powder weapon.");
        DestroyObject(oCopy);
        return;
    }

    //Gunsmith proficiency means no roll.
    if(GetHasFeat(1483,oPC) == TRUE)
    {
        //Profane Horn - 0 Present
        if (GetLocalInt(oDest, "ProfaneHorn")==0)
        {
            SendMessageToPC(oPC, "You effortlessly add the Profane Horn to the smoke powder weapon.");
            SetLocalInt(oDest, "Evil", 1);
            SetLocalInt(oDest, "ProfaneHorn", 1);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This smoke powder weapon has been modified with a Profane Horn, dedicating it to the powers of evil.");
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyLimitUseByAlign(IP_CONST_ALIGNMENTGROUP_EVIL), oDest);
            SetLocalInt(oDest, "Modified", GetLocalInt(oDest, "Modified")+1);
            SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 250);
            DestroyObject(oSource);
            DestroyObject(oCopy);
        }
    }
    else
    //No gunsmith proficiency means roll.
    {
        //Profane Horn 0 present
        if (GetLocalInt(oDest, "ProfaneHorn")==0)
        {
            SendMessageToPC(oPC, IntToString(nRoll) + " Roll + Intelligence Modifier " + IntToString(GetAbilityModifier(ABILITY_INTELLIGENCE,oPC)) + "=" + IntToString(nRoll) + " vs. DC 15");
            if (nRoll+(GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) < 15)
            {
                AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0f, 5.0f));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
                SendMessageToPC(oPC, "The attempt to combine these two things has failed.");
                DestroyObject(oSource);
                DestroyObject(oCopy);
            }
            else
            {
                SendMessageToPC(oPC, "You manage to add the Profane Horn to the smoke powder weapon.");
                AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0f, 5.0f));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
                SetLocalInt(oDest, "ProfaneHorn", 1);
                SetLocalInt(oDest, "Evil", 1);
                SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This smoke powder weapon has been modified with a Profane Horn, dedicating it to the powers of evil.");
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyLimitUseByAlign(IP_CONST_ALIGNMENTGROUP_EVIL), oDest);
                SetLocalInt(oDest, "Modified", GetLocalInt(oDest, "Modified")+1);
                SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 250);
                DestroyObject(oSource);
                DestroyObject(oCopy);
            }
        }
    }
    return;
}

/*Rebelling Mark - uses Rebelling Mark and a heater*/
else if (GetTag(oSource)=="te_fireupg_003" && sType=="Ranged")
{
    nAnim = ANIMATION_LOOPING_GET_MID;
    //Int modifier to Roll.
    nRoll = nRoll + GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);

    if (GetLocalInt(oDest, "nGun")==0)
    {
        SendMessageToPC(oPC, "This Rebelling Mark is meant for a smoke powder weapon.");
        DestroyObject(oCopy);
        return;
    }
    if (GetLocalInt(oDest, "Modified")>=6)
    {
        SendMessageToPC(oPC, "You cannot modify this smoke powder weapon any further.");
        DestroyObject(oCopy);
        return;
    }
    if (GetLocalInt(oDest, "AbidingSeal")==1)
    {
        SendMessageToPC(oPC, "You cannot add an Abiding Seal to this smoke powder weapon.");
        DestroyObject(oCopy);
        return;
    }
    if (GetLocalInt(oDest, "RebellingMark")==1)
    {
        SendMessageToPC(oPC, "You have already added Rebelling Mark to this smoke powder weapon.");
        DestroyObject(oCopy);
        return;
    }

    //Gunsmith proficiency means no roll.
    if(GetHasFeat(1483,oPC) == TRUE)
    {
        //RebellingMark- 0 Present
        if (GetLocalInt(oDest, "RebellingMark")==0)
        {
            SendMessageToPC(oPC, "You effortlessly add the Rebelling Mark to the smoke powder weapon.");
            SetLocalInt(oDest, "Chaos", 1);
            SetLocalInt(oDest, "RebellingMark", 1);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This smoke powder weapon has been modified with a Rebelling Mark, dedicating it to the powers of chaos and disorder.");
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyLimitUseByAlign(IP_CONST_ALIGNMENTGROUP_CHAOTIC), oDest);
            SetLocalInt(oDest, "Modified", GetLocalInt(oDest, "Modified")+1);
            SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 250);
            DestroyObject(oSource);
            DestroyObject(oCopy);
        }
    }
    else
    //No gunsmith proficiency means roll.
    {
        //Rebelling Mark 0 present
        if (GetLocalInt(oDest, "RebellingMark")==0)
        {
            SendMessageToPC(oPC, IntToString(nRoll) + " Roll + Intelligence Modifier " + IntToString(GetAbilityModifier(ABILITY_INTELLIGENCE,oPC)) + "=" + IntToString(nRoll) + " vs. DC 15");
            if (nRoll+(GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) < 15)
            {
                AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0f, 5.0f));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
                SendMessageToPC(oPC, "The attempt to combine these two things has failed.");
                DestroyObject(oSource);
                DestroyObject(oCopy);
            }
            else
            {
                SendMessageToPC(oPC, "You manage to add the Rebelling Mark to the smoke powder weapon.");
                AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0f, 5.0f));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
                SetLocalInt(oDest, "RebellingMark", 1);
                SetLocalInt(oDest, "Chaos", 1);
                SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This smoke powder weapon has been modified with a Rebelling Mark, dedicating it to the powers of chaos and disorder.");
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyLimitUseByAlign(IP_CONST_ALIGNMENTGROUP_CHAOTIC), oDest);
                SetLocalInt(oDest, "Modified", GetLocalInt(oDest, "Modified")+1);
                SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 250);
                DestroyObject(oSource);
                DestroyObject(oCopy);
            }
        }
    }
    return;
}

/*Sanctified Brass - uses Sanctified Brass and a heater*/
else if (GetTag(oSource)=="te_fireupg_004" && sType=="Ranged")
{
    nAnim = ANIMATION_LOOPING_GET_MID;
    //Int modifier to Roll.
    nRoll = nRoll + GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);

    if (GetLocalInt(oDest, "nGun")==0)
    {
        SendMessageToPC(oPC, "This Sanctified Brass is meant for a smoke powder weapon.");
        DestroyObject(oCopy);
        return;
    }
    if (GetLocalInt(oDest, "Modified")>=6)
    {
        SendMessageToPC(oPC, "You cannot modify this smoke powder weapon any further.");
        DestroyObject(oCopy);
        return;
    }
    if (GetLocalInt(oDest, "ProfaneHorn")==1)
    {
        SendMessageToPC(oPC, "You cannot add Sanctified Brass to this smoke powder weapon.");
        DestroyObject(oCopy);
        return;
    }
    if (GetLocalInt(oDest, "SanctifiedBrass")==1)
    {
        SendMessageToPC(oPC, "You have already added Sanctified Brass to this smoke powder weapon.");
        DestroyObject(oCopy);
        return;
    }

    //Gunsmith proficiency means no roll.
    if(GetHasFeat(1483,oPC) == TRUE)
    {
        //SanctifiedBrass- 0 Present
        if (GetLocalInt(oDest, "SanctifiedBrass")==0)
        {
            SendMessageToPC(oPC, "You effortlessly add the Sanctified Brass to the smoke powder weapon.");
            SetLocalInt(oDest, "Good", 1);
            SetLocalInt(oDest, "SanctifiedBrass", 1);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This smoke powder weapon has been modified with Sanctified Brass, dedicating it to the powers of goodness.");
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyLimitUseByAlign(IP_CONST_ALIGNMENTGROUP_GOOD), oDest);
            SetLocalInt(oDest, "Modified", GetLocalInt(oDest, "Modified")+1);
            SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 250);
            DestroyObject(oSource);
            DestroyObject(oCopy);
        }
    }
    else
    //No gunsmith proficiency means roll.
    {
        //SanctifiedBrass 0 present
        if (GetLocalInt(oDest, "SanctifiedBrass")==0)
        {
            SendMessageToPC(oPC, IntToString(nRoll) + " Roll + Intelligence Modifier " + IntToString(GetAbilityModifier(ABILITY_INTELLIGENCE,oPC)) + "=" + IntToString(nRoll) + " vs. DC 15");
            if (nRoll+(GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) < 15)
            {
                AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0f, 5.0f));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
                SendMessageToPC(oPC, "The attempt to combine these two things has failed.");
                DestroyObject(oSource);
                DestroyObject(oCopy);
            }
            else
            {
                SendMessageToPC(oPC, "You manage to add the Sanctified Brass to the smoke powder weapon.");
                AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0f, 5.0f));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
                SetLocalInt(oDest, "SanctifiedBrass", 1);
                SetLocalInt(oDest, "Good", 1);
                SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This smoke powder weapon has been modified with Sanctified Brass, dedicating it to the powers of goodness.");
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyLimitUseByAlign(IP_CONST_ALIGNMENTGROUP_GOOD), oDest);
                SetLocalInt(oDest, "Modified", GetLocalInt(oDest, "Modified")+1);
                SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 250);
                DestroyObject(oSource);
                DestroyObject(oCopy);
            }
        }
    }
    return;
}

/*Astral Drift Metal - uses Astral Drift Metal and a heater*/
else if (GetTag(oSource)=="te_fireupg_005" && sType=="Ranged")
{
    nAnim = ANIMATION_LOOPING_GET_MID;
    //Int modifier to Roll.
    nRoll = nRoll + GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);

    if (GetLocalInt(oDest, "nGun")==0)
    {
        SendMessageToPC(oPC, "This Astral Drift Metal is meant for a smoke powder weapon.");
        DestroyObject(oCopy);
        return;
    }
    if (GetLocalInt(oDest, "Modified")>=6)
    {
        SendMessageToPC(oPC, "You cannot modify this smoke powder weapon any further.");
        DestroyObject(oCopy);
        return;
    }
    if (GetLocalInt(oDest, "AstralDrift")==1)
    {
        SendMessageToPC(oPC, "You have already added Astral Drift Metal to this smoke powder weapon.");
        DestroyObject(oCopy);
        return;
    }

    //Gunsmith proficiency means no roll.
    if(GetHasFeat(1483,oPC) == TRUE)
    {
        //AstralDrift- 0 Present
        if (GetLocalInt(oDest, "AstralDrift")==0)
        {
            SendMessageToPC(oPC, "You effortlessly add the Astral Drift Metal to the smoke powder weapon.");
            SetLocalInt(oDest, "GhostTouch", 1);
            SetLocalInt(oDest, "AstralDrift", 1);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This smoke powder weapon has been modified with Astral Drift Metal, enabling it to affect incorporeal beings.");
            SetLocalInt(oDest, "Modified", GetLocalInt(oDest, "Modified")+1);
            SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 500);
            DestroyObject(oSource);
            DestroyObject(oCopy);
        }
    }
    else
    //No gunsmith proficiency means roll.
    {
        //AstralDrift 0 present
        if (GetLocalInt(oDest, "AstralDrift")==0)
        {
            SendMessageToPC(oPC, IntToString(nRoll) + " Roll + Intelligence Modifier " + IntToString(GetAbilityModifier(ABILITY_INTELLIGENCE,oPC)) + "=" + IntToString(nRoll) + " vs. DC 18");
            if (nRoll+(GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) < 18)
            {
                AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0f, 5.0f));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
                SendMessageToPC(oPC, "The attempt to combine these two things has failed.");
                DestroyObject(oSource);
                DestroyObject(oCopy);
            }
            else
            {
                SendMessageToPC(oPC, "You manage to add the Astral Drift Metal to the smoke powder weapon.");
                AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0f, 5.0f));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
                SetLocalInt(oDest, "AstralDrift", 1);
                SetLocalInt(oDest, "GhostTouch", 1);
                SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This smoke powder weapon has been modified with Astral Drift Metal, enabling it to affect incorporeal beings.");
                SetLocalInt(oDest, "Modified", GetLocalInt(oDest, "Modified")+1);
                SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 500);
                DestroyObject(oSource);
                DestroyObject(oCopy);
            }
        }
    }
    return;
}

/*Silver-Barrel - uses Silver Barrel and a heater*/
else if (GetTag(oSource)=="te_fireupg_006" && sType=="Ranged")
{
    nAnim = ANIMATION_LOOPING_GET_MID;
    //Int modifier to Roll.
    nRoll = nRoll + GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);

    if (GetLocalInt(oDest, "nGun")==0)
    {
        SendMessageToPC(oPC, "This Silver Barrel is meant for a smoke powder weapon.");
        DestroyObject(oCopy);
        return;
    }
    if (GetLocalInt(oDest, "Modified")>=6)
    {
        SendMessageToPC(oPC, "You cannot modify this smoke powder weapon any further.");
        DestroyObject(oCopy);
        return;
    }
    if (GetLocalInt(oDest, "SilverBarrel")==1)
    {
        SendMessageToPC(oPC, "You have already added a Silver Barrel to this smoke powder weapon.");
        DestroyObject(oCopy);
        return;
    }

    //Gunsmith proficiency means no roll.
    if(GetHasFeat(1483,oPC) == TRUE)
    {
        //SilverBarrel- 0 Present
        if (GetLocalInt(oDest, "SilverBarrel")==0)
        {
            SendMessageToPC(oPC, "You effortlessly add the Silver Barrel to the smoke powder weapon.");
            SetLocalInt(oDest, "SilverBarrel", 1);
            SetLocalInt(oDest, "Silvered", 1);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This smoke powder weapon has been modified with a Silver Barrel, making it effective against creatures with a negative plane connection.");
            SetLocalInt(oDest, "Modified", GetLocalInt(oDest, "Modified")+1);
            SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 500);
            DestroyObject(oSource);
            DestroyObject(oCopy);
        }
    }
    else
    //No gunsmith proficiency means roll.
    {
        //SilverBarrel 0 present
        if (GetLocalInt(oDest, "SilverBarrel")==0)
        {
            SendMessageToPC(oPC, IntToString(nRoll) + " Roll + Intelligence Modifier " + IntToString(GetAbilityModifier(ABILITY_INTELLIGENCE,oPC)) + "=" + IntToString(nRoll) + " vs. DC 18");
            if (nRoll+(GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) < 18)
            {
                AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0f, 5.0f));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
                SendMessageToPC(oPC, "The attempt to combine these two things has failed.");
                DestroyObject(oSource);
                DestroyObject(oCopy);
            }
            else
            {
                SendMessageToPC(oPC, "You manage to add the Silver Barrel to the smoke powder weapon.");
                AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0f, 5.0f));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
                SetLocalInt(oDest, "SilverBarrel", 1);
                SetLocalInt(oDest, "Silvered", 1);
                SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This smoke powder weapon has been modified with a Silver Barrel, making it effective against creatures with a negative plane connection.");
                SetLocalInt(oDest, "Modified", GetLocalInt(oDest, "Modified")+1);
                SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 500);
                DestroyObject(oSource);
                DestroyObject(oCopy);
            }
        }
    }
    return;
}

/*Abiding Seal - uses Sanctified Brass and a heater*/
else if (GetTag(oSource)=="te_fireupg_007" && sType=="Ranged")
{
    nAnim = ANIMATION_LOOPING_GET_MID;
    //Int modifier to Roll.
    nRoll = nRoll + GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);

    if (GetLocalInt(oDest, "nGun")==0)
    {
        SendMessageToPC(oPC, "This Abiding Seal is meant for a smoke powder weapon.");
        DestroyObject(oCopy);
        return;
    }
    if (GetLocalInt(oDest, "Modified")>=6)
    {
        SendMessageToPC(oPC, "You cannot modify this smoke powder weapon any further.");
        DestroyObject(oCopy);
        return;
    }
    if (GetLocalInt(oDest, "RebellingMark")==1)
    {
        SendMessageToPC(oPC, "You cannot add an Abiding Seal to this smoke powder weapon.");
        DestroyObject(oCopy);
        return;
    }
    if (GetLocalInt(oDest, "AbidingSeal")==1)
    {
        SendMessageToPC(oPC, "You have already added Abiding Seal to this smoke powder weapon.");
        DestroyObject(oCopy);
        return;
    }

    //Gunsmith proficiency means no roll.
    if(GetHasFeat(1483,oPC) == TRUE)
    {
        //AbidingSeal- 0 Present
        if (GetLocalInt(oDest, "AbidingSeal")==0)
        {
            SendMessageToPC(oPC, "You effortlessly add the Abiding Seal to the smoke powder weapon.");
            SetLocalInt(oDest, "Law", 1);
            SetLocalInt(oDest, "AbidingSeal", 1);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This smoke powder weapon has been modified with an Abiding Seal, dedicating it to the powers of law and order.");
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyLimitUseByAlign(IP_CONST_ALIGNMENTGROUP_LAWFUL), oDest);
            SetLocalInt(oDest, "Modified", GetLocalInt(oDest, "Modified")+1);
            SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 250);
            DestroyObject(oSource);
            DestroyObject(oCopy);
        }
    }
    else
    //No gunsmith proficiency means roll.
    {
        //AbidingSeal 0 present
        if (GetLocalInt(oDest, "AbidingSeal")==0)
        {
            SendMessageToPC(oPC, IntToString(nRoll) + " Roll + Intelligence Modifier " + IntToString(GetAbilityModifier(ABILITY_INTELLIGENCE,oPC)) + "=" + IntToString(nRoll) + " vs. DC 15");
            if (nRoll+(GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) < 15)
            {
                AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0f, 5.0f));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
                SendMessageToPC(oPC, "The attempt to combine these two things has failed.");
                DestroyObject(oSource);
                DestroyObject(oCopy);
            }
            else
            {
                SendMessageToPC(oPC, "You manage to add the Abiding Seal to the smoke powder weapon.");
                AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0f, 5.0f));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
                SetLocalInt(oDest, "AbidingSeal", 1);
                SetLocalInt(oDest, "Law", 1);
                SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This smoke powder weapon has been modified with an Abiding Seal, dedicating it to the powers of law and order.");
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyLimitUseByAlign(IP_CONST_ALIGNMENTGROUP_LAWFUL), oDest);
                SetLocalInt(oDest, "Modified", GetLocalInt(oDest, "Modified")+1);
                SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 250);
                DestroyObject(oSource);
                DestroyObject(oCopy);
            }
        }
    }
    return;
}

/*Darkwood Stock- uses Darkwood Stock and a heater*/
else if (GetTag(oSource)=="te_fireupg_008" && sType=="Ranged")
{
    nAnim = ANIMATION_LOOPING_GET_MID;
    //Int modifier to Roll.
    nRoll = nRoll + GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);

    if (GetLocalInt(oDest, "nGun")==0)
    {
        SendMessageToPC(oPC, "This Darkwood Stock is meant for a smoke powder weapon.");
        DestroyObject(oCopy);
        return;
    }
    if (GetLocalInt(oDest, "Modified")>=6)
    {
        SendMessageToPC(oPC, "You cannot modify this smoke powder weapon any further.");
        DestroyObject(oCopy);
        return;
    }
    if (GetLocalInt(oDest, "DarkwoodStock")==1)
    {
        SendMessageToPC(oPC, "You have already added a Darkwood Stock to this smoke powder weapon.");
        DestroyObject(oCopy);
        return;
    }

    //Gunsmith proficiency means no roll.
    if(GetHasFeat(1483,oPC) == TRUE)
    {
        //DarkwoodStock- 0 Present
        if (GetLocalInt(oDest, "DarkwoodStock")==0)
        {
            SendMessageToPC(oPC, "You effortlessly add the Darkwood Stock to the smoke powder weapon.");
            SetLocalInt(oDest, "DarkwoodStock", 1);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This smoke powder weapon has been modified with a Darkwood Stock. It is now considerably lighter.");
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_40_PERCENT), oDest);
            SetLocalInt(oDest, "Modified", GetLocalInt(oDest, "Modified")+1);
            SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 125);
            DestroyObject(oSource);
            DestroyObject(oCopy);
        }
    }
    else
    //No gunsmith proficiency means roll.
    {
        //DarkwoodStock 0 present
        if (GetLocalInt(oDest, "DarkwoodStock")==0)
        {
            SendMessageToPC(oPC, IntToString(nRoll) + " Roll + Intelligence Modifier " + IntToString(GetAbilityModifier(ABILITY_INTELLIGENCE,oPC)) + "=" + IntToString(nRoll) + " vs. DC 15");
            if (nRoll+(GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) < 15)
            {
                AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0f, 5.0f));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
                SendMessageToPC(oPC, "The attempt to combine these two things has failed.");
                DestroyObject(oSource);
                DestroyObject(oCopy);
            }
            else
            {
                SendMessageToPC(oPC, "You manage to add the Abiding Seal to the smoke powder weapon.");
                AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0f, 5.0f));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
                SetLocalInt(oDest, "DarkwoodStock", 1);
                SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This smoke powder weapon has been modified with a Darkwood Stock. It is now considerably lighter.");
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_40_PERCENT), oDest);
                SetLocalInt(oDest, "Modified", GetLocalInt(oDest, "Modified")+1);
                SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 125);
                DestroyObject(oSource);
                DestroyObject(oCopy);
            }
        }
    }
    return;
}

/*Improved Smoke Powder Wells - uses Improved Smoke Powder Wells and a heater*/
else if (GetTag(oSource)=="te_fireupg_009" && sType=="Ranged")
{
    nAnim = ANIMATION_LOOPING_GET_MID;
    //Int modifier to Roll.
    nRoll = nRoll + GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);

    if (GetLocalInt(oDest, "nGun")==0)
    {
        SendMessageToPC(oPC, "These crosshairs are meant for a smoke powder weapon.");
        DestroyObject(oCopy);
        return;
    }
    if (GetLocalInt(oDest, "Modified")>=5)
    {
        SendMessageToPC(oPC, "You cannot modify this smoke powder weapon any further.");
        DestroyObject(oCopy);
        return;
    }
    if (GetLocalInt(oDest, "SmokePowderWell")==4)
    {
        SendMessageToPC(oPC, "You have already added two smoke powder wells.");
        DestroyObject(oCopy);
        return;
    }

    //Gunsmith proficiency means no roll.
    if(GetHasFeat(1483,oPC) == TRUE)
    {
        //SmokePowderWell - 2 Present
        if (GetLocalInt(oDest, "SmokePowderWell")==2)
        {
            SendMessageToPC(oPC, "You effortlessly add the Smoke Powder Well to the smoke powder weapon.");
            SetLocalInt(oDest, "SmokePowderWell", GetLocalInt(oDest, "SmokePowderWell")+2);
            IPSafeAddItemProperty(oDest, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_4));
            SetLocalInt(oDest, "Modified", GetLocalInt(oDest, "Modified")+2);
            SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 500);
            DestroyObject(oSource);
            DestroyObject(oCopy);
        }
        //SmokePowderWell- None Present
        else if (GetLocalInt(oDest, "SmokePowderWell") == 0)
        {
            SendMessageToPC(oPC, "You effortlessly add the Smoke Powder Well to the smoke powder weapon.");
            IPSafeAddItemProperty(oDest, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_2));
            SetLocalInt(oDest, "Modified", GetLocalInt(oDest, "Modified")+2);
            SetLocalInt(oDest, "SmokePowderWell", 2);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This smoke powder weapon has been modified with an Improved Smoke Powder Well. It now does extra damage.");
            SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 500);
            DestroyObject(oSource);
            DestroyObject(oCopy);
        }
    }
    else
    //No gunsmith proficiency means roll.
    {
        //SmokePowderWell - 2 Present
        if (GetLocalInt(oDest, "SmokePowderWell")==2)
        {
            SendMessageToPC(oPC, IntToString(nRoll) + " Roll + Intelligence Modifier " + IntToString(GetAbilityModifier(ABILITY_INTELLIGENCE,oPC)) + "=" + IntToString(nRoll) + " vs. DC 18");
            if (nRoll+(GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) < 18)
            {
                AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0f, 5.0f));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
                SendMessageToPC(oPC, "The attempt to combine these two things has failed.");
                DestroyObject(oSource);
                DestroyObject(oCopy);
            }
            else
            {
                SendMessageToPC(oPC, "You manage to add the Smoke Powder Well to the smoke powder weapon.");
                AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0f, 5.0f));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
                IPSafeAddItemProperty(oDest, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_4));
                SetLocalInt(oDest, "SmokePowderWell", 2);
                sNewname=GetName(oDest) + " of Power";
                SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 500);
                SetLocalInt(oDest, "Modified", GetLocalInt(oDest, "Modified")+2);
                DestroyObject(oSource);
                DestroyObject(oCopy);
            }
        }
        //SmokePowderWell - None Present
        else if (GetLocalInt(oDest, "SmokePowderWell") == 0)
        {
            SendMessageToPC(oPC, IntToString(nRoll) + " Roll + Intelligence Modifier " + IntToString(GetAbilityModifier(ABILITY_INTELLIGENCE,oPC)) + "=" + IntToString(nRoll) + " vs. DC 18");
            if (nRoll+(GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) < 18)
            {
                AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0f, 5.0f));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
                SendMessageToPC(oPC, "The attempt to combine these two things has failed.");
                DestroyObject(oSource);
                DestroyObject(oCopy);
            }
            else
            {
                AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0f, 5.0f));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
                IPSafeAddItemProperty(oDest, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_2));
                SetLocalInt(oDest, "Modified", GetLocalInt(oDest, "Modified")+2);
                SetLocalInt(oDest, "SmokePowderWell", 2);
                SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This smoke powder weapon has been modified with an Improved Smoke Powder Well. It now does extra damage.");
                SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 500);
                DestroyObject(oSource);
                DestroyObject(oCopy);
            }
        }
    }
    return;
}

/*Smoke Powder Well Cap - uses Smoke Powder Well Cap and a heater*/
else if (GetTag(oSource)=="te_fireupg_010" && sType=="Ranged")
{
    nAnim = ANIMATION_LOOPING_GET_MID;
    //Int modifier to Roll.
    nRoll = nRoll + GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);

    if (GetLocalInt(oDest, "nGun")==0)
    {
        SendMessageToPC(oPC, "This Smoke Powder Cap is meant for a smoke powder weapon.");
        DestroyObject(oCopy);
        return;
    }
    if (GetLocalInt(oDest, "Modified")>=5)
    {
        SendMessageToPC(oPC, "You cannot modify this smoke powder weapon any further.");
        DestroyObject(oCopy);
        return;
    }
    if (GetLocalInt(oDest, "SmokePowderCap")==1)
    {
        SendMessageToPC(oPC, "You have already added Smoke Powder Cap to this smoke powder weapon.");
        DestroyObject(oCopy);
        return;
    }

    //Gunsmith proficiency means no roll.
    if(GetHasFeat(1483,oPC) == TRUE)
    {
        //SmokePowderCap - 0 Present
        if (GetLocalInt(oDest, "SmokePowderCap")==0)
        {
            SendMessageToPC(oPC, "You effortlessly add the Smoke Powder Cap to the smoke powder weapon.");
            SetLocalInt(oDest, "SmokePowderCap", 1);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This smoke powder weapon has been modified with a Smoke Powder Well Cap. The damage potential of the weapon is considerably increased by it.");
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d10), oDest);
            SetLocalInt(oDest, "Modified", GetLocalInt(oDest, "Modified")+2);
            SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 500);
            DestroyObject(oSource);
            DestroyObject(oCopy);
        }
    }
    else
    //No gunsmith proficiency means roll.
    {
        //SmokePowderCap 0 present
        if (GetLocalInt(oDest, "SmokePowderCap")==0)
        {
            SendMessageToPC(oPC, IntToString(nRoll) + " Roll + Intelligence Modifier " + IntToString(GetAbilityModifier(ABILITY_INTELLIGENCE,oPC)) + "=" + IntToString(nRoll) + " vs. DC 21");
            if (nRoll+(GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) < 21)
            {
                AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0f, 5.0f));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
                SendMessageToPC(oPC, "The attempt to combine these two things has failed.");
                DestroyObject(oSource);
                DestroyObject(oCopy);
            }
            else
            {
                SendMessageToPC(oPC, "You manage to add the Smoke Powder Cap to the smoke powder weapon.");
                AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0f, 5.0f));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
                SetLocalInt(oDest, "SmokePowderCap", 1);
                SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This smoke powder weapon has been modified with a Smoke Powder Well Cap. The damage potential of the weapon is considerably increased by it.");
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d10), oDest);
                SetLocalInt(oDest, "Modified", GetLocalInt(oDest, "Modified")+2);
                SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 500);
                DestroyObject(oSource);
                DestroyObject(oCopy);
            }
        }
    }
    return;
}

/*Repeater Chamber - uses Repeater Chamber and a heater*/
else if (GetTag(oSource)=="te_fireupg_011" && sType=="Ranged")
{
    nAnim = ANIMATION_LOOPING_GET_MID;
    //Int modifier to Roll.
    nRoll = nRoll + GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);

    if (GetLocalInt(oDest, "nGun")==0)
    {
        SendMessageToPC(oPC, "This Repeater Chamber is meant for a smoke powder weapon.");
        DestroyObject(oCopy);
        return;
    }
    if (GetLocalInt(oDest, "Modified")>=5)
    {
        SendMessageToPC(oPC, "You cannot modify this smoke powder weapon any further.");
        DestroyObject(oCopy);
        return;
    }
    if (GetLocalInt(oDest, "RepeaterChamber")==1)
    {
        SendMessageToPC(oPC, "You have already added a Repeater Chamber to this smoke powder weapon.");
        DestroyObject(oCopy);
        return;
    }

    //Gunsmith proficiency means no roll.
    if(GetHasFeat(1483,oPC) == TRUE)
    {
        //RepeaterChamber - 0 Present
        if (GetLocalInt(oDest, "RepeaterChamber")==0)
        {
            SendMessageToPC(oPC, "You effortlessly add the Repeater Chamber to the smoke powder weapon.");
            SetLocalInt(oDest, "RepeaterChamber", 1);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This smoke powder weapon has been modified with a Repeating Chamber. The weapon is now much easier to reload quickly.");
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusFeat(63), oDest);//Rapid Reload
            SetLocalInt(oDest, "Modified", GetLocalInt(oDest, "Modified")+2);
            SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 500);
            DestroyObject(oSource);
            DestroyObject(oCopy);
        }
    }
    else
    //No gunsmith proficiency means roll.
    {
        //RepeaterChamber 0 present
        if (GetLocalInt(oDest, "RepeaterChamber")==0)
        {
            SendMessageToPC(oPC, IntToString(nRoll) + " Roll + Intelligence Modifier " + IntToString(GetAbilityModifier(ABILITY_INTELLIGENCE,oPC)) + "=" + IntToString(nRoll) + " vs. DC 21");
            if (nRoll+(GetAbilityModifier(ABILITY_INTELLIGENCE, oPC)) < 21)
            {
                AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0f, 5.0f));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
                SendMessageToPC(oPC, "The attempt to combine these two things has failed.");
                DestroyObject(oSource);
                DestroyObject(oCopy);
            }
            else
            {
                SendMessageToPC(oPC, "You manage to add the Repeater Chamber to the smoke powder weapon.");
                AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0f, 5.0f));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
                SetLocalInt(oDest, "RepeaterChamber", 1);
                SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This smoke powder weapon has been modified with a Repeating Chamber. The weapon is now much easier to reload quickly.");
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusFeat(63), oDest);//Rapid Reload
                SetLocalInt(oDest, "Modified", GetLocalInt(oDest, "Modified")+2);
                SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 1000);
                DestroyObject(oSource);
                DestroyObject(oCopy);
            }
        }
    }
    return;
}

//New Paladin Holy Swords//
/* Enhancement Bonus - Requires Blessed Reliquary */
else if (GetTag(oSource)=="te_palupgr001" && sType=="Weapon")
    {
    if ((GetLevelByClass(CLASS_TYPE_PALADIN, oPC) < 3) && (GetHasFeat(1247, oPC) == FALSE))
        {
            SendMessageToPC(oPC, "You must be at least a third level paladin to complete this ritual.");
            DestroyObject(oCopy);
            return;
        }
    nAnim = ANIMATION_LOOPING_WORSHIP;
        if (IPGetWeaponEnhancementBonus(oDest)==5)
            {
            SendMessageToPC(oPC, "No further rituals of this type can be attempted.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "PalMod")==10)
            {
            SendMessageToPC(oPC, "This Holy Avenger cannot be improved any further.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "BlessedReliquary")==5)
            {
            SendMessageToPC(oPC, "You cannot add any more relics of this type.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "BlessedReliquary")>=1)
            {
            SetLocalInt(oDest, "BlessedReliquary", GetLocalInt(oDest, "BlessedReliquary")+1);
            IPUpgradeWeaponEnhancementBonus(oDest, 1);
            SetLocalInt(oDest, "PalMod", GetLocalInt(oDest, "PalMod")+1);
            }
        else {
        IPUpgradeWeaponEnhancementBonus(oDest, 1);
        sNewname="Holy Avenger";
        IPSafeAddItemProperty(oDest, ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_NORMAL,IP_CONST_LIGHTCOLOR_WHITE));
        SetLocalInt(oDest, "BlessedReliquary", 1);
        SetLocalInt(oDest, "PalMod", 1);
        SetLocalInt(oDest, "WeaponEnch", 1);
        SetLocalInt(oDest, "HolyAvenger", 1);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This weapon casts a holy radius of light when it is held. It has the mark of the paladin " + GetName(oPC), TRUE);
        SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 2000);
        }
    }

/* Good Aligned Property - Requires Celestial Essence */
else if (GetTag(oSource)=="te_palupgr002" && sType=="Weapon")
    {
    if ((GetLevelByClass(CLASS_TYPE_PALADIN, oPC) < 3) && (GetHasFeat(1247, oPC) == FALSE))
        {
            SendMessageToPC(oPC, "You must be at least a third level paladin to complete this ritual.");
            DestroyObject(oCopy);
            return;
        }
    nAnim = ANIMATION_LOOPING_WORSHIP;
        if (GetLocalInt(oDest, "PalMod")==10)
            {
            SendMessageToPC(oPC, "This Holy Avenger cannot be improved any further.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "CelestialEssence")==1)
            {
            SendMessageToPC(oPC, "You cannot add any more relics of this type.");
            DestroyObject(oCopy);
            return;
            }
        else {
        IPSafeAddItemProperty(oDest, ItemPropertyLimitUseByAlign(IP_CONST_ALIGNMENTGROUP_GOOD));
        SetLocalInt(oDest, "CelestialEssence", 1);
        SetLocalInt(oDest, "Good", 1);
        SetLocalInt(oDest, "HolyAvenger", 1);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This weapon has an aura of goodness around it after being exposed to Celestial Essence. It can only be handled by those of good intent.");
        SetLocalInt(oDest, "PalMod", GetLocalInt(oDest, "PalMod")+1);
        }
    }

/* Silver Weapon Property - Requires Gilding Silver */
else if (GetTag(oSource)=="te_palupgr003" && sType=="Weapon")
    {
    if ((GetLevelByClass(CLASS_TYPE_PALADIN, oPC) < 3) && (GetHasFeat(1247, oPC) == FALSE))
        {
            SendMessageToPC(oPC, "You must be at least a third level paladin to complete this ritual.");
            DestroyObject(oCopy);
            return;
        }
    nAnim = ANIMATION_LOOPING_WORSHIP;
        if (GetLocalInt(oDest, "PalMod")==10)
            {
            SendMessageToPC(oPC, "This Holy Avenger cannot be improved any further.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "GildingSilver")==1)
            {
            SendMessageToPC(oPC, "You cannot add any more relics of this type.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Material")==3)
            {
            SendMessageToPC(oPC, "Gilding silver cannot be used on a mithril weapon.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Material")==4)
            {
            SendMessageToPC(oPC, "Gilding silver cannot be used on an adamantine weapon.");
            DestroyObject(oCopy);
            return;
            }
        else {
        IPSafeAddItemProperty(oDest, ItemPropertyMaterial(13));
        SetLocalInt(oDest, "GildingSilver", 1);
        SetLocalInt(oDest, "Silvered", 1);
        SetLocalInt(oDest, "HolyAvenger", 1);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This weapon has a sheen of Silver Gilding, making it effective against some creatures with a negative energy plane connection.");
        SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 500);
        }
    }

/* Lawful Aligned Property - Requires Nirvana Codex */
else if (GetTag(oSource)=="te_palupgr004" && sType=="Weapon")
    {
    if ((GetLevelByClass(CLASS_TYPE_PALADIN, oPC) < 3) && (GetHasFeat(1247, oPC) == FALSE))
        {
            SendMessageToPC(oPC, "You must be at least a third level paladin to complete this ritual.");
            DestroyObject(oCopy);
            return;
        }
    nAnim = ANIMATION_LOOPING_WORSHIP;
        if (GetLocalInt(oDest, "PalMod")==10)
            {
            SendMessageToPC(oPC, "This Holy Avenger cannot be improved any further.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "NirvanaCodex")==1)
            {
            SendMessageToPC(oPC, "You cannot add any more relics of this type.");
            DestroyObject(oCopy);
            return;
            }
        else {
        IPSafeAddItemProperty(oDest, ItemPropertyLimitUseByAlign(IP_CONST_ALIGNMENTGROUP_LAWFUL));
        SetLocalInt(oDest, "NirvanaCodex", 1);
        SetLocalInt(oDest, "Law", 1);
        SetLocalInt(oDest, "HolyAvenger", 1);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This weapon has an aura of law around it after being exposed to the energies of a Nirvana Codex. It can only be handled by those of a lawful intent.");
        SetLocalInt(oDest, "PalMod", GetLocalInt(oDest, "PalMod")+1);
        }
    }

/* Ghost Touch Weapon Property - Requires Netherworld Stone*/
else if (GetTag(oSource)=="te_palupgr005" && sType=="Weapon")
    {
    if ((GetLevelByClass(CLASS_TYPE_PALADIN, oPC) < 3) && (GetHasFeat(1247, oPC) == FALSE))
        {
            SendMessageToPC(oPC, "You must be at least a third level paladin to complete this ritual.");
            DestroyObject(oCopy);
            return;
        }
    nAnim = ANIMATION_LOOPING_WORSHIP;
        if (GetLocalInt(oDest, "PalMod")==10)
            {
            SendMessageToPC(oPC, "This Holy Avenger cannot be improved any further.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "NetherworldStone")==1)
            {
            SendMessageToPC(oPC, "You cannot add any more relics of this type.");
            DestroyObject(oCopy);
            return;
            }
        else {
        SetLocalInt(oDest, "NetherworldStone", 1);
        SetLocalInt(oDest, "GhostTouch", 1);
        SetLocalInt(oDest, "HolyAvenger", 1);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This weapon has a somewhat ethereal sheen, due to its treatment by a Netherworld Stone. It now affects ghosts normally.");
        SetLocalInt(oDest, "PalMod", GetLocalInt(oDest, "PalMod")+1);
        }
    }

/* Divine Damage vs. Evil Property - Requires Silver Dragon Eye*/
else if (GetTag(oSource)=="te_palupgr006" && sType=="Weapon")
    {
    if (GetLevelByClass(CLASS_TYPE_PALADIN, oPC) < 6)
        {
            SendMessageToPC(oPC, "You must be at least a sixth level paladin to complete this ritual.");
            DestroyObject(oCopy);
            return;
        }
    nAnim = ANIMATION_LOOPING_WORSHIP;
        if (GetLocalInt(oDest, "PalMod")>=9)
            {
            SendMessageToPC(oPC, "This Holy Avenger cannot be improved any further.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "PalGem")==1)
            {
            SendMessageToPC(oPC, "You cannot add another gem to this Holy Avenger.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "SilverDragonEye")==1)
            {
            SendMessageToPC(oPC, "You cannot add any more relics of this type.");
            DestroyObject(oCopy);
            return;
            }
        else {
        SetLocalInt(oDest, "SilverDragonEye", 1);
        SetLocalInt(oDest, "PalGem", 1);
        SetLocalInt(oDest, "HolyAvenger", 1);
        IPSafeAddItemProperty(oDest, ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d6));
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This weapon has been adorned with a Silver Dragon Eye, a potent crystal that channels divine energy against evil foes.");
        SetLocalInt(oDest, "PalMod", GetLocalInt(oDest, "PalMod")+2);
        }
    }

/* Fire Damage vs. Evil Property - Requires Martyr's Heartstone*/
else if (GetTag(oSource)=="te_palupgr007" && sType=="Weapon")
    {
    if (GetLevelByClass(CLASS_TYPE_PALADIN, oPC) < 6)
        {
            SendMessageToPC(oPC, "You must be at least a sixth level paladin to complete this ritual.");
            DestroyObject(oCopy);
            return;
        }
    nAnim = ANIMATION_LOOPING_WORSHIP;
        if (GetLocalInt(oDest, "PalMod")>=9)
            {
            SendMessageToPC(oPC, "This Holy Avenger cannot be improved any further.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "PalGem")==1)
            {
            SendMessageToPC(oPC, "You cannot add another gem to this Holy Avenger.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "MartyrHeartstone")==1)
            {
            SendMessageToPC(oPC, "You cannot add any more relics of this type.");
            DestroyObject(oCopy);
            return;
            }
        else {
        SetLocalInt(oDest, "MartyrHeartstone", 1);
        SetLocalInt(oDest, "PalGem", 1);
        SetLocalInt(oDest, "HolyAvenger", 1);
        IPSafeAddItemProperty(oDest, ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGEBONUS_2d6));
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This weapon has been adorned with a Martyr's Heartstone, a potent crystal that channels holy fire energy against evil foes.");
        SetLocalInt(oDest, "PalMod", GetLocalInt(oDest, "PalMod")+2);
        }
    }

/* Magic Damage vs. Evil Property - Requires Starry Dew Gem*/
else if (GetTag(oSource)=="te_palupgr008" && sType=="Weapon")
    {
    if (GetLevelByClass(CLASS_TYPE_PALADIN, oPC) < 6)
        {
            SendMessageToPC(oPC, "You must be at least a sixth level paladin to complete this ritual.");
            DestroyObject(oCopy);
            return;
        }
    nAnim = ANIMATION_LOOPING_WORSHIP;
        if (GetLocalInt(oDest, "PalMod")>=9)
            {
            SendMessageToPC(oPC, "This Holy Avenger cannot be improved any further.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "PalGem")==1)
            {
            SendMessageToPC(oPC, "You cannot add another gem to this Holy Avenger.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "StarryDew")==1)
            {
            SendMessageToPC(oPC, "You cannot add any more relics of this type.");
            DestroyObject(oCopy);
            return;
            }
        else {
        SetLocalInt(oDest, "PalGem", 1);
        SetLocalInt(oDest, "StarryDew", 1);
        SetLocalInt(oDest, "HolyAvenger", 1);
        IPSafeAddItemProperty(oDest, ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,IP_CONST_DAMAGETYPE_MAGICAL,IP_CONST_DAMAGEBONUS_2d6));
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This weapon has been adorned with a Starry Dew Gem, a potent crystal that channels magical energy against evil foes.");
        SetLocalInt(oDest, "PalMod", GetLocalInt(oDest, "PalMod")+2);
        }
    }

/* Extra Turning - Requires Saints Waters*/
else if (GetTag(oSource)=="te_palupgr010" && sType=="Weapon")
    {
    if ((GetLevelByClass(CLASS_TYPE_PALADIN, oPC) < 3) && (GetHasFeat(1247, oPC) == FALSE))
        {
            SendMessageToPC(oPC, "You must be at least a third level paladin to complete this ritual.");
            DestroyObject(oCopy);
            return;
        }
    nAnim = ANIMATION_LOOPING_WORSHIP;
        if (GetLocalInt(oDest, "PalMod")==10)
            {
            SendMessageToPC(oPC, "This Holy Avenger cannot be improved any further.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "SaintsWaters")==1)
            {
            SendMessageToPC(oPC, "You cannot add any more relics of this type.");
            DestroyObject(oCopy);
            return;
            }
        else {
        SetLocalInt(oDest, "SaintsWaters", 1);
        SetLocalInt(oDest, "HolyAvenger", 1);
        IPSafeAddItemProperty(oDest, ItemPropertyBonusFeat(IP_CONST_FEAT_EXTRA_TURNING));
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This weapon boasts a small receptacle that contains Saint's Waters, which empower turning attempts.");
        SetLocalInt(oDest, "PalMod", GetLocalInt(oDest, "PalMod")+1);
        }
    }

/* Keen Weapon Property - Requires Shattered Edge*/
else if (GetTag(oSource)=="te_palupgr009" && sType=="Weapon")
    {
    if ((GetLevelByClass(CLASS_TYPE_PALADIN, oPC) < 3) && (GetHasFeat(1247, oPC) == FALSE))
        {
            SendMessageToPC(oPC, "You must be at least a third level paladin to complete this ritual.");
            DestroyObject(oCopy);
            return;
        }
    nAnim = ANIMATION_LOOPING_WORSHIP;
        if (GetLocalInt(oDest, "PalMod")==10)
            {
            SendMessageToPC(oPC, "This Holy Avenger cannot be improved any further.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "ShatteredEdge")==1)
            {
            SendMessageToPC(oPC, "You cannot add any more relics of this type.");
            DestroyObject(oCopy);
            return;
            }
        else {
        SetLocalInt(oDest, "ShatteredEdge", 1);
        SetLocalInt(oDest, "HolyAvenger", 1);
        IPSafeAddItemProperty(oDest, ItemPropertyKeen());
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This weapon incorporates some pieces from a Shattered Edge, rendering it with the Keen property.");
        SetLocalInt(oDest, "PalMod", GetLocalInt(oDest, "PalMod")+1);
        }
    }

/* Defending Property - Requires Martyr's Blood */
else if (GetTag(oSource)=="te_palupgr011" && sType=="Weapon")
    {
    if ((GetLevelByClass(CLASS_TYPE_PALADIN, oPC) < 3) && (GetHasFeat(1247, oPC) == FALSE))
        {
            SendMessageToPC(oPC, "You must be at least a third level paladin to complete this ritual.");
            DestroyObject(oCopy);
            return;
        }
    nAnim = ANIMATION_LOOPING_WORSHIP;
        if (GetLocalInt(oDest, "PalMod")==10)
            {
            SendMessageToPC(oPC, "This Holy Avenger cannot be improved any further.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "MartyrsBlood")==5)
            {
            SendMessageToPC(oPC, "You cannot add any more relics of this type.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "BlessedReqliquary") < (GetLocalInt(oDest,"MartyrsBlood")))
            {
            SendMessageToPC(oPC, "You must added another Blessed Reliquary before you may add another Martyr's Blood.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "MartyrsBlood")>=1)
            {
            SetLocalInt(oDest, "MartyrsBlood", GetLocalInt(oDest, "MartyrsBlood")+1);
            IPSafeAddItemProperty(oDest, ItemPropertyACBonus(GetLocalInt(oDest, "MartyrsBlood")));
            SetLocalInt(oDest, "PalMod", GetLocalInt(oDest, "PalMod")+1);
            }
        else {
        IPSafeAddItemProperty(oDest, ItemPropertyACBonus(1));
        SetLocalInt(oDest, "MartyrsBlood", 1);
        SetLocalInt(oDest, "HolyAvenger", 1);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This weapon occasionally weeps a few drips of blood, after having been blessed with Martyr's Blood.");
        SetLocalInt(oDest, "PalMod", GetLocalInt(oDest, "PalMod")+1);
        }
    }

/* Bonus Vs. Outsiders - Requires Holy Chalice*/
else if (GetTag(oSource)=="te_palupgr012" && sType=="Weapon")
    {
    if ((GetLevelByClass(CLASS_TYPE_PALADIN, oPC) < 3) && (GetHasFeat(1247, oPC) == FALSE))
        {
            SendMessageToPC(oPC, "You must be at least a third level paladin to complete this ritual.");
            DestroyObject(oCopy);
            return;
        }
    nAnim = ANIMATION_LOOPING_WORSHIP;
        if (GetLocalInt(oDest, "PalMod")>=9)
            {
            SendMessageToPC(oPC, "This Holy Avenger cannot be improved any further.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "PalCreatureBonus")==1)
            {
            SendMessageToPC(oPC, "You cannot add any more relics of this type.");
            DestroyObject(oCopy);
            return;
            }
        else {
        SetLocalInt(oDest, "PalCreatureBonus", 1);
        SetLocalInt(oDest, "HolyAvenger", 1);
        IPSafeAddItemProperty(oDest, ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_OUTSIDER,4));
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This weapon has been consecrated by a Holy Chalice, giving it remarkable strength against Outsiders.");
        SetLocalInt(oDest, "PalMod", GetLocalInt(oDest, "PalMod")+2);
        }
    }

/* Bonus Vs. Shapeshifters - Requires Holy Emblem*/
else if (GetTag(oSource)=="te_palupgr013" && sType=="Weapon")
    {
    if ((GetLevelByClass(CLASS_TYPE_PALADIN, oPC) < 3) && (GetHasFeat(1247, oPC) == FALSE))
        {
            SendMessageToPC(oPC, "You must be at least a third level paladin to complete this ritual.");
            DestroyObject(oCopy);
            return;
        }
    nAnim = ANIMATION_LOOPING_WORSHIP;
        if (GetLocalInt(oDest, "PalMod")>=9)
            {
            SendMessageToPC(oPC, "This Holy Avenger cannot be improved any further.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "PalCreatureBonus")==1)
            {
            SendMessageToPC(oPC, "You cannot add any more relics of this type.");
            DestroyObject(oCopy);
            return;
            }
        else {
        SetLocalInt(oDest, "PalCreatureBonus", 1);
        SetLocalInt(oDest, "HolyAvenger", 1);
        IPSafeAddItemProperty(oDest, ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,4));
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This weapon has been consecrated by a Holy Emblem, giving it remarkable strength against Shapechangers.");
        SetLocalInt(oDest, "PalMod", GetLocalInt(oDest, "PalMod")+2);
        }
    }

/* Bonus Vs. Undead - Requires Crystal Skull*/
else if (GetTag(oSource)=="te_palupgr014" && sType=="Weapon")
    {
    if ((GetLevelByClass(CLASS_TYPE_PALADIN, oPC) < 3) && (GetHasFeat(1247, oPC) == FALSE))
        {
            SendMessageToPC(oPC, "You must be at least a third level paladin to complete this ritual.");
            DestroyObject(oCopy);
            return;
        }
    nAnim = ANIMATION_LOOPING_WORSHIP;
        if (GetLocalInt(oDest, "PalMod")>=9)
            {
            SendMessageToPC(oPC, "This Holy Avenger cannot be improved any further.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "PalCreatureBonus")==1)
            {
            SendMessageToPC(oPC, "You cannot add any more relics of this type.");
            DestroyObject(oCopy);
            return;
            }
        else {
        SetLocalInt(oDest, "PalCreatureBonus", 1);
        SetLocalInt(oDest, "HolyAvenger", 1);
        IPSafeAddItemProperty(oDest, ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD,4));
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This weapon has been consecrated by a Crystal Skull, giving it remarkable strength against Undead.");
        SetLocalInt(oDest, "PalMod", GetLocalInt(oDest, "PalMod")+2);
        }
    }

/* Bonus Vs. Dragons - Requires Draconic Emblem*/
else if (GetTag(oSource)=="te_palupgr015" && sType=="Weapon")
    {
    if ((GetLevelByClass(CLASS_TYPE_PALADIN, oPC) < 3) && (GetHasFeat(1247, oPC) == FALSE))
        {
            SendMessageToPC(oPC, "You must be at least a third level paladin to complete this ritual.");
            DestroyObject(oCopy);
            return;
        }
    nAnim = ANIMATION_LOOPING_WORSHIP;
        if (GetLocalInt(oDest, "PalMod")>=9)
            {
            SendMessageToPC(oPC, "This Holy Avenger cannot be improved any further.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "PalCreatureBonus")==1)
            {
            SendMessageToPC(oPC, "You cannot add any more relics of this type.");
            DestroyObject(oCopy);
            return;
            }
        else {
        SetLocalInt(oDest, "PalCreatureBonus", 1);
        SetLocalInt(oDest, "HolyAvenger", 1);
        IPSafeAddItemProperty(oDest, ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_DRAGON,4));
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This weapon has been consecrated by a Draconic Emblem, giving it remarkable strength against Dragons.");
        SetLocalInt(oDest, "PalMod", GetLocalInt(oDest, "PalMod")+2);
        }
    }

///General Armor Modifications//
/* Locked Gauntlet requires Gauntlet Lock*/
else if (GetTag(oSource)=="te_armorupg001" && sType=="Gauntlet")
    {
    if (FeatCheck("Armoring", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "Armoring proficiency is required to perform this action.");
            DestroyObject(oCopy);
            return;
        }
    nAnim = ANIMATION_LOOPING_GET_LOW;
        if (GetLocalInt(oDest, "GauntMod")==1)
            {
            SendMessageToPC(oPC, "This gauntlet has already been modified");
            DestroyObject(oCopy);
            return;
            }
        else {
        IPSafeAddItemProperty(oDest, ItemPropertySkillBonus(SKILL_DISCIPLINE,2));
        sNewname="Locked " + GetName(oDest);
        SetLocalInt(oDest, "GauntMod", 1);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This gauntlet has a locking mechanism that assists in the course of combat.");
        SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 150);
       }
    }

/* Gilded Armor or Shield Requires Gilding Gold*/
else if (GetTag(oSource)=="te_armorupg002" && (sType=="Armor" || sType=="Shield"))
    {
    if (FeatCheck("Armoring", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "Armoring proficiency is required to perform this action.");
            DestroyObject(oCopy);
            return;
        }
    nAnim = ANIMATION_LOOPING_GET_LOW;
        if (GetLocalInt(oDest, "ArmorMod")==2)
            {
            SendMessageToPC(oPC, "This armor cannot be modified further.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Material")==3)
            {
            SendMessageToPC(oPC, "Gilding Gold won't work on mithril items.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Material")==4)
            {
            SendMessageToPC(oPC, "Gilding Gold won't work on adamantine items.");
            DestroyObject(oCopy);
            return;
            }
        else {
        IPSafeAddItemProperty(oDest, ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_NEGATIVE,2));
        sNewname="Gilded " + GetName(oDest);
        SetLocalInt(oDest, "ArmorMod", GetLocalInt(oDest, "ArmorMod")+1);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This item is gilded, which provides protection against negative energy effects.");
        SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 1000);
       }
    }

/* Blessed Armor or Shield Requires Holy Scripture*/
else if (GetTag(oSource)=="te_armorupg003" && (sType=="Armor" || sType=="Shield"))
    {
    if ((GetLevelByClass(CLASS_TYPE_CLERIC, oPC) < 3) && (GetHasFeat(1247, oPC) == FALSE))
        {
            SendMessageToPC(oPC, "You must be at least a third level cleric to complete this ritual.");
            DestroyObject(oCopy);
            return;
        }
    nAnim = ANIMATION_LOOPING_WORSHIP;
        if (GetLocalInt(oDest, "ArmorMod")==2)
            {
            SendMessageToPC(oPC, "This armor cannot be modified further.");
            DestroyObject(oCopy);
            return;
            }
        else {
        IPSafeAddItemProperty(oDest, ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_DEATH,2));
        sNewname="Blessed " + GetName(oDest);
        SetLocalInt(oDest, "ArmorMod", GetLocalInt(oDest, "ArmorMod")+1);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This item is blessed, which provides protection against death effects.");
        SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 500);
       }
    }

/* Bonus Vs. Outsiders on armor or shield requires Holy Sigil*/
else if (GetTag(oSource)=="te_armorupg004" && (sType=="Armor" || sType=="Shield"))
    {
    if ((GetLevelByClass(CLASS_TYPE_CLERIC, oPC) < 3) && (GetHasFeat(1247, oPC) == FALSE))
        {
            SendMessageToPC(oPC, "You must be at least a third level cleric to complete this ritual.");
            DestroyObject(oCopy);
            return;
        }
    nAnim = ANIMATION_LOOPING_WORSHIP;
        if (GetLocalInt(oDest, "ArmorMod")==2)
            {
            SendMessageToPC(oPC, "This armor cannot be modified further.");
            DestroyObject(oCopy);
            return;
            }
        else {
        IPSafeAddItemProperty(oDest, ItemPropertyACBonusVsRace(IP_CONST_RACIALTYPE_OUTSIDER,2));
        sNewname="Holy " + GetName(oDest);
        SetLocalInt(oDest, "ArmorMod", GetLocalInt(oDest, "ArmorMod")+1);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This item bears a Holy Sigil, which grants protection against outsiders.");
        SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 1000);
       }
    }

/*Iron Mesh Robe requires Spool of Iron Wire*/
else if (GetTag(oSource)=="te_armorupg005" && sType=="Armor" && GetArmorType(oDest)==0)
    {
        if (FeatCheck("Tailoring", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "Tailoring proficiency is required to perform this action.");
            DestroyObject(oCopy);
            return;
        }
    nAnim = ANIMATION_LOOPING_GET_LOW;
        if (GetLocalInt(oDest, "ArmorMod")==2)
            {
            SendMessageToPC(oPC, "This armor cannot be modified further.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Mesh")==1)
            {
            SendMessageToPC(oPC, "This robe already has a mesh.");
            DestroyObject(oCopy);
            return;
            }
        else {
        IPSafeAddItemProperty(oDest, ItemPropertyACBonus(1));
        sNewname="Iron Mesh " + GetName(oDest);
        SetLocalInt(oDest, "Mesh", 1);
        SetLocalInt(oDest, "Material", 1);
        SetLocalInt(oDest, "ArmorMod", GetLocalInt(oDest, "ArmorMod")+1);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This robe has had iron wire mesh sewed into panels within the fabric. This should provide a cursory amount of protection from blows without sacrificing mobility.");
        SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 150);
       }
    }

/* Discipline Bonus requires Leather Cord on a Weapon or Shield*/
else if (GetTag(oSource)=="te_armorupg006" && (sType=="Weapon" || sType=="Shield"))
    {
        if (FeatCheck("Tailoring", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "Tailoring proficiency is required to perform this action.");
            DestroyObject(oCopy);
            return;
        }
    nAnim = ANIMATION_LOOPING_GET_LOW;
        if (GetLocalInt(oDest, "Cord")==1)
            {
            SendMessageToPC(oPC, "This item already has a cord.");
            DestroyObject(oCopy);
            return;
            }
        else {
        IPSafeAddItemProperty(oDest, ItemPropertySkillBonus(SKILL_DISCIPLINE,2));
        SetLocalInt(oDest, "Cord", 1);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This item has a Leather Cord securely attached to it that provides a measure of assurance against it being dropped or disarmed.");
        SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 150);
       }
    }

/* Luck bonus for all saves on armor requires Lucky Clover*/
else if (GetTag(oSource)=="te_armorupg007" && sType=="Armor")
    {
        if (FeatCheck("Tailoring", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "Tailoring proficiency is required to perform this action.");
            DestroyObject(oCopy);
            return;
        }
    nAnim = ANIMATION_LOOPING_GET_LOW;
        if (GetLocalInt(oDest, "ArmorMod")==1)
            {
            SendMessageToPC(oPC, "This armor cannot be modified further.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Clover")==1)
            {
            SendMessageToPC(oPC, "This armor already has a Lucky Clover.");
            DestroyObject(oCopy);
            return;
            }
        else {
        IPSafeAddItemProperty(oDest, ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_UNIVERSAL,1));
        SetLocalInt(oDest, "ArmorMod", GetLocalInt(oDest, "ArmorMod")+1);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This item bears a sewn-in Lucky Clover, which supposedly grants the wearer good luck.");
        SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 10);
       }
    }

/* Hide Bonus on Armor or Cloak requires Oak Leaf*/
else if (GetTag(oSource)=="te_armorupg008" && (sType=="Armor" || sType=="Cloak"))
    {
        if (FeatCheck("Tailoring", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "Tailoring proficiency is required to perform this action.");
            DestroyObject(oCopy);
            return;
        }
    nAnim = ANIMATION_LOOPING_GET_LOW;
        if (GetLocalInt(oDest, "ArmorMod")==2)
            {
            SendMessageToPC(oPC, "This item cannot be modified further.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "OakLeaf")==1)
            {
            SendMessageToPC(oPC, "This item already has Oak Leaves added to it.");
            DestroyObject(oCopy);
            return;
            }
        else {
        SetLocalInt(oDest, "OakLeaf", 1);
        IPSafeAddItemProperty(oDest, ItemPropertySkillBonus(FEAT_SKILL_FOCUS_HIDE,2));
        SetLocalInt(oDest, "ArmorMod", GetLocalInt(oDest, "ArmorMod")+1);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This item has soft Oak Leaves sewn into its outermost layer, which aid the wearer in remaining unseen.");
        SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 25);
       }
    }

/* Spiked Armor or Shield requires Protective Spikes*/
else if (GetTag(oSource)=="te_armorupg009" && (sType=="Armor" || sType=="Shield"))
{
    if (FeatCheck("Armoring", oPC) == FALSE)
    {
        SendMessageToPC(oPC, "Armoring proficiency is required to perform this action.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_GET_LOW;
    if (GetLocalInt(oDest, "ArmorMod")==2)
    {
        SendMessageToPC(oPC, "This item cannot be modified further.");
        DestroyObject(oCopy);
        return;
    }
    if (GetLocalInt(oDest, "Spikes")==1)
    {
        SendMessageToPC(oPC, "This item already has Protective Spikes added to it.");
        DestroyObject(oCopy);
        return;
    }
    else
    {
        IPSafeAddItemProperty(oDest, ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_ONHIT_UNIQUEPOWER, 5));
        SetLocalInt(oDest, "Spikes", 1);
        SetTag(oDest, "te_spike");
        SetLocalInt(oDest, "ArmorMod", GetLocalInt(oDest, "ArmorMod")+1);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This item features outward Protective Spikes which have been added by an armorer. Attackers up close will be at a detriment.");
        SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 500);
   }
}

/* Bonus vs. Undead on armor or Cloak requires Sacred Pattern*/
else if (GetTag(oSource)=="te_armorupg010" && (sType=="Armor" || sType=="Cloak"))
    {
        if (FeatCheck("Tailoring", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "Tailoring proficiency is required to perform this action.");
            DestroyObject(oCopy);
            return;
        }
    nAnim = ANIMATION_LOOPING_GET_LOW;
        if (GetLocalInt(oDest, "ArmorMod")==2)
            {
            SendMessageToPC(oPC, "This item cannot be modified further.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "SacredPattern")==1)
            {
            SendMessageToPC(oPC, "This item already has a Sacred Pattern added to it.");
            DestroyObject(oCopy);
            return;
            }
        else {
        SetLocalInt(oDest, "SacredPattern", 1);
        IPSafeAddItemProperty(oDest, ItemPropertyACBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD,2));
        SetLocalInt(oDest, "ArmorMod", GetLocalInt(oDest, "ArmorMod")+1);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This item has been embroidered with a Sacred Pattern, the likes of which provides a considerable amount of protection against undead. ");
        SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 1000);
       }
    }

/* Fire Resistant Armor or Shield requires Silmer's Wick*/
else if (GetTag(oSource)=="te_armorupg011" && (sType=="Armor" || sType=="Shield"))
    {
        if (FeatCheck("Tailoring", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "Tailoring proficiency is required to perform this action.");
            DestroyObject(oCopy);
            return;
        }
    nAnim = ANIMATION_LOOPING_GET_LOW;
        if (GetLocalInt(oDest, "ArmorMod")==2)
            {
            SendMessageToPC(oPC, "This item cannot be modified further.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "SilmerWick")==1)
            {
            SendMessageToPC(oPC, "This item already has Protective Spikes added to it.");
            DestroyObject(oCopy);
            return;
            }
        else {
        IPSafeAddItemProperty(oDest, ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_FIRE, 2));
        SetLocalInt(oDest, "SilmerWick", 1);
        SetLocalInt(oDest, "ArmorMod", GetLocalInt(oDest, "ArmorMod")+1);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This item features features Silmer's Wick, which has been sewn into the armor by a tailor. It has the effect of making the materials resistant to fire.");
        SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 750);
       }
    }

/*Steel Mesh Robe requires Spool of Steel Wire*/
else if (GetTag(oSource)=="te_armorupg012" && sType=="Armor" && GetArmorType(oDest)==0)
    {
        if (FeatCheck("Tailoring", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "Tailoring proficiency is required to perform this action.");
            DestroyObject(oCopy);
            return;
        }
    nAnim = ANIMATION_LOOPING_GET_LOW;
        if (GetLocalInt(oDest, "ArmorMod")==2)
            {
            SendMessageToPC(oPC, "This armor cannot be modified further.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Mesh")==1)
            {
            SendMessageToPC(oPC, "This robe already has a mesh.");
            DestroyObject(oCopy);
            return;
            }
        else {
        IPSafeAddItemProperty(oDest, ItemPropertyACBonus(1));
        sNewname="Steel Mesh " + GetName(oDest);
        SetLocalInt(oDest, "Mesh", 1);
        SetLocalInt(oDest, "Material", 2);
        SetLocalInt(oDest, "ArmorMod", GetLocalInt(oDest, "ArmorMod")+1);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This robe has had steel wire mesh sewed into panels within the fabric. This should provide a cursory amount of protection from blows without sacrificing mobility.");
        SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 300);
       }
    }

//New Monk Ki Weapons//
/* Order of the Dark Moon - Requires Crystal of the Dark Moon */
else if (GetTag(oSource)=="te_kiupgrade01" && sType=="Weapon")
    {
    if ((GetLevelByClass(CLASS_TYPE_MONK, oPC) < 3) && (GetHasFeat(1329, oPC) == FALSE))//shar
        {
            SendMessageToPC(oPC, "You must be at least a third level monk of the Dark Moon to complete this ritual.");
            DestroyObject(oCopy);
            return;
        }
    nAnim = ANIMATION_LOOPING_WORSHIP;
        if (IPGetWeaponEnhancementBonus(oDest)==5)
            {
            SendMessageToPC(oPC, "No further rituals of this type can be attempted.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "KiMod")>=10)
            {
            SendMessageToPC(oPC, "This Ki Weapon cannot be improved any further.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "KiMod")==9)
            {
            SetLocalInt(oDest, "KiMod", GetLocalInt(oDest, "KiMod")+1);
            IPUpgradeWeaponEnhancementBonus(oDest, 1);
            SetLocalInt(oDest, "iCasterLvl", 5);
            }
        if (GetLocalInt(oDest, "KiMod")==8)
            {
            SetLocalInt(oDest, "KiMod", GetLocalInt(oDest, "KiMod")+1);
            IPSafeAddItemProperty(oDest, ItemPropertyCastSpell(IP_CONST_CASTSPELL_DARKNESS_3,IP_CONST_CASTSPELL_NUMUSES_2_USES_PER_DAY));
            SetLocalInt(oDest, "iCasterLvl", 5);
            }
        if (GetLocalInt(oDest, "KiMod")==7)
            {
            SetLocalInt(oDest, "KiMod", GetLocalInt(oDest, "KiMod")+1);
            IPUpgradeWeaponEnhancementBonus(oDest, 1);
            }
        if (GetLocalInt(oDest, "KiMod")==6)
            {
            SetLocalInt(oDest, "KiMod", GetLocalInt(oDest, "KiMod")+1);
            IPSafeAddItemProperty(oDest, ItemPropertyVampiricRegeneration(4));
            }
        if (GetLocalInt(oDest, "KiMod")==5)
            {
            SetLocalInt(oDest, "KiMod", GetLocalInt(oDest, "KiMod")+1);
            IPUpgradeWeaponEnhancementBonus(oDest, 1);
            }
        if (GetLocalInt(oDest, "KiMod")==4)
            {
            SetLocalInt(oDest, "KiMod", GetLocalInt(oDest, "KiMod")+1);
            IPSafeAddItemProperty(oDest, ItemPropertyKeen());
            }
        if (GetLocalInt(oDest, "KiMod")==3)
            {
            SetLocalInt(oDest, "KiMod", GetLocalInt(oDest, "KiMod")+1);
            IPUpgradeWeaponEnhancementBonus(oDest, 1);
            }
        if (GetLocalInt(oDest, "KiMod")==2)
            {
            SetLocalInt(oDest, "KiMod", GetLocalInt(oDest, "KiMod")+1);
            IPSafeAddItemProperty(oDest, ItemPropertyVampiricRegeneration(2));
            }
        else {
        IPUpgradeWeaponEnhancementBonus(oDest, 1);
        sNewname="Dark Ki Weapon";
        SetLocalInt(oDest, "KiMod", 2);
        SetLocalInt(oDest, "Law", 1);
        SetLocalInt(oDest, "Evil", 1);
        IPSafeAddItemProperty(oDest, ItemPropertyLimitUseByClass(IP_CONST_CLASS_MONK));
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This weapon hums ever slightly with the feeling of ki. It has the mark of the monk, " + GetName(oPC) + ". ", TRUE);
        SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 1000);
        }
    }

/* Order of the Sun Soul - Requires Goblet of the Sun Soul */
else if (GetTag(oSource)=="te_kiupgrade02" && sType=="Weapon")
    {
    if ((GetLevelByClass(CLASS_TYPE_MONK, oPC) < 3) && ((GetHasFeat(1328, oPC) == FALSE) || GetHasFeat(1331, oPC) == FALSE) || GetHasFeat(1319, oPC) == FALSE)//shar, selune, lathander
        {
            SendMessageToPC(oPC, "You must be at least a third level monk of the Sun Soul to complete this ritual.");
            DestroyObject(oCopy);
            return;
        }
    nAnim = ANIMATION_LOOPING_WORSHIP;
        if (IPGetWeaponEnhancementBonus(oDest)==5)
            {
            SendMessageToPC(oPC, "No further rituals of this type can be attempted.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "KiMod")>=10)
            {
            SendMessageToPC(oPC, "This Ki Weapon cannot be improved any further.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "KiMod")==9)
            {
            SetLocalInt(oDest, "KiMod", GetLocalInt(oDest, "KiMod")+1);
            IPUpgradeWeaponEnhancementBonus(oDest, 1);
            }
        if (GetLocalInt(oDest, "KiMod")==8)
            {
            SetLocalInt(oDest, "KiMod", GetLocalInt(oDest, "KiMod")+1);
            IPSafeAddItemProperty(oDest, ItemPropertyCastSpell(IP_CONST_CASTSPELL_SUNBEAM_13,IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY));
            SetLocalInt(oDest, "iCasterLvl", 13);
            }
        if (GetLocalInt(oDest, "KiMod")==7)
            {
            SetLocalInt(oDest, "KiMod", GetLocalInt(oDest, "KiMod")+1);
            IPUpgradeWeaponEnhancementBonus(oDest, 1);
            }
        if (GetLocalInt(oDest, "KiMod")==6)
            {
            SetLocalInt(oDest, "KiMod", GetLocalInt(oDest, "KiMod")+1);
            IPSafeAddItemProperty(oDest, ItemPropertyCastSpell(IP_CONST_CASTSPELL_DARKVISION_3,IP_CONST_CASTSPELL_NUMUSES_2_USES_PER_DAY));
            SetLocalInt(oDest, "iCasterLvl", 9);
            }
        if (GetLocalInt(oDest, "KiMod")==5)
            {
            SetLocalInt(oDest, "KiMod", GetLocalInt(oDest, "KiMod")+1);
            IPUpgradeWeaponEnhancementBonus(oDest, 1);
            SetLocalInt(oDest, "iCasterLvl", 5);
            }
        if (GetLocalInt(oDest, "KiMod")==4)
            {
            SetLocalInt(oDest, "KiMod", GetLocalInt(oDest, "KiMod")+1);
            IPSafeAddItemProperty(oDest, ItemPropertyCastSpell(IP_CONST_CASTSPELL_SEARING_LIGHT_5,IP_CONST_CASTSPELL_NUMUSES_2_USES_PER_DAY));
            SetLocalInt(oDest, "iCasterLvl", 5);
            }
        if (GetLocalInt(oDest, "KiMod")==3)
            {
            SetLocalInt(oDest, "KiMod", GetLocalInt(oDest, "KiMod")+1);
            IPUpgradeWeaponEnhancementBonus(oDest, 1);
            }
        if (GetLocalInt(oDest, "KiMod")==2)
            {
            SetLocalInt(oDest, "KiMod", GetLocalInt(oDest, "KiMod")+1);
            SetLocalInt(oDest, "Silvered", 1);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This weapon has a silvery sheen, it will harm creatures as if it was true silver. It has the mark of the monk, " + GetName(oPC) + ". ", TRUE);
            }
        else {
        IPUpgradeWeaponEnhancementBonus(oDest, 1);
        sNewname="Light Ki Weapon";
        SetLocalInt(oDest, "KiMod", 2);
        SetLocalInt(oDest, "Law", 1);
        SetLocalInt(oDest, "Good", 1);
        IPSafeAddItemProperty(oDest, ItemPropertyLimitUseByClass(IP_CONST_CLASS_MONK));
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This weapon hums ever slightly with the feeling of ki. It has the mark of the monk, " + GetName(oPC) + ". ", TRUE);
        SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 1000);
        }
    }

/* Order of the Shining Hand - Requires Tablet of the Shining Hand */
else if (GetTag(oSource)=="te_kiupgrade03" && sType=="Weapon")
    {
    if ((GetLevelByClass(CLASS_TYPE_MONK, oPC) < 3) && (GetHasFeat(1306, oPC) == FALSE))//Azuth
        {
            SendMessageToPC(oPC, "You must be at least a third level monk of the Shining Hand to complete this ritual.");
            DestroyObject(oCopy);
            return;
        }
    nAnim = ANIMATION_LOOPING_WORSHIP;
        if (IPGetWeaponEnhancementBonus(oDest)==5)
            {
            SendMessageToPC(oPC, "No further rituals of this type can be attempted.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "KiMod")>=10)
            {
            SendMessageToPC(oPC, "This Ki Weapon cannot be improved any further.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "KiMod")==9)
            {
            SetLocalInt(oDest, "KiMod", GetLocalInt(oDest, "KiMod")+1);
            IPUpgradeWeaponEnhancementBonus(oDest, 1);
            }
        if (GetLocalInt(oDest, "KiMod")==8)
            {
            SetLocalInt(oDest, "KiMod", GetLocalInt(oDest, "KiMod")+1);
            IPSafeAddItemProperty(oDest, ItemPropertyCastSpell(IP_CONST_CASTSPELL_DISPEL_MAGIC_5,IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY));
            SetLocalInt(oDest, "iCasterLvl", 9);
            }
        if (GetLocalInt(oDest, "KiMod")==7)
            {
            SetLocalInt(oDest, "KiMod", GetLocalInt(oDest, "KiMod")+1);
            IPUpgradeWeaponEnhancementBonus(oDest, 1);
            }
        if (GetLocalInt(oDest, "KiMod")==6)
            {
            SetLocalInt(oDest, "KiMod", GetLocalInt(oDest, "KiMod")+1);
            IPSafeAddItemProperty(oDest, ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d8));
            }
        if (GetLocalInt(oDest, "KiMod")==5)
            {
            SetLocalInt(oDest, "KiMod", GetLocalInt(oDest, "KiMod")+1);
            IPUpgradeWeaponEnhancementBonus(oDest, 1);
            }
        if (GetLocalInt(oDest, "KiMod")==4)
            {
            SetLocalInt(oDest, "KiMod", GetLocalInt(oDest, "KiMod")+1);
            IPSafeAddItemProperty(oDest, ItemPropertyKeen());
            }
        if (GetLocalInt(oDest, "KiMod")==3)
            {
            SetLocalInt(oDest, "KiMod", GetLocalInt(oDest, "KiMod")+1);
            IPUpgradeWeaponEnhancementBonus(oDest, 1);
            }
        if (GetLocalInt(oDest, "KiMod")==2)
            {
            SetLocalInt(oDest, "KiMod", GetLocalInt(oDest, "KiMod")+1);
            SetLocalInt(oDest, "Material", 4);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This weapon has an inky sheen like that of adamantine. It will strike creatures as if it was that material. It has the mark of the monk, " + GetName(oPC) + ". ", TRUE);
            }
        else {
        IPUpgradeWeaponEnhancementBonus(oDest, 1);
        sNewname="Ki Weapon";
        SetLocalInt(oDest, "KiMod", 2);
        SetLocalInt(oDest, "Law", 1);
        IPSafeAddItemProperty(oDest, ItemPropertyLimitUseByClass(IP_CONST_CLASS_MONK));
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This weapon hums ever slightly with the feeling of ki. It has the mark of the monk, " + GetName(oPC) + ". ", TRUE);
        SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 1000);
        }
    }

/* Order of the Broken Ones - Requires Broken One's Yoke */
else if (GetTag(oSource)=="te_kiupgrade04" && sType=="Weapon")
    {
    if ((GetLevelByClass(CLASS_TYPE_MONK, oPC) < 3) && (GetHasFeat(1314, oPC) == FALSE))//Ilmater
        {
            SendMessageToPC(oPC, "You must be at least a third level monk of the Broken Ones to complete this ritual.");
            DestroyObject(oCopy);
            return;
        }
    nAnim = ANIMATION_LOOPING_WORSHIP;
        if (IPGetWeaponEnhancementBonus(oDest)==5)
            {
            SendMessageToPC(oPC, "No further rituals of this type can be attempted.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "KiMod")>=10)
            {
            SendMessageToPC(oPC, "This Ki Weapon cannot be improved any further.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "KiMod")==9)
            {
            SetLocalInt(oDest, "KiMod", GetLocalInt(oDest, "KiMod")+1);
            IPUpgradeWeaponEnhancementBonus(oDest, 1);
            }
        if (GetLocalInt(oDest, "KiMod")==8)
            {
            SetLocalInt(oDest, "KiMod", GetLocalInt(oDest, "KiMod")+1);
            IPSafeAddItemProperty(oDest, ItemPropertyCastSpell(IP_CONST_CASTSPELL_BULLS_STRENGTH_3,IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY));
            SetLocalInt(oDest, "iCasterLvl", 9);
            }
        if (GetLocalInt(oDest, "KiMod")==7)
            {
            SetLocalInt(oDest, "KiMod", GetLocalInt(oDest, "KiMod")+1);
            IPUpgradeWeaponEnhancementBonus(oDest, 1);
            }
        if (GetLocalInt(oDest, "KiMod")==6)
            {
            SetLocalInt(oDest, "KiMod", GetLocalInt(oDest, "KiMod")+1);
            IPSafeAddItemProperty(oDest, ItemPropertyACBonus(4));
            }
        if (GetLocalInt(oDest, "KiMod")==5)
            {
            SetLocalInt(oDest, "KiMod", GetLocalInt(oDest, "KiMod")+1);
            IPUpgradeWeaponEnhancementBonus(oDest, 1);
            }
        if (GetLocalInt(oDest, "KiMod")==4)
            {
            SetLocalInt(oDest, "KiMod", GetLocalInt(oDest, "KiMod")+1);
            IPSafeAddItemProperty(oDest, ItemPropertyACBonus(2));
            }
        if (GetLocalInt(oDest, "KiMod")==3)
            {
            SetLocalInt(oDest, "KiMod", GetLocalInt(oDest, "KiMod")+1);
            IPUpgradeWeaponEnhancementBonus(oDest, 1);
            }
        if (GetLocalInt(oDest, "KiMod")==2)
            {
            SetLocalInt(oDest, "KiMod", GetLocalInt(oDest, "KiMod")+1);
            SetLocalInt(oDest, "GhostTouch", 1);
            SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This weapon has a slight aura around it, like the appearance of Ghost Touch weapons. It will strike incorporeal creatures. It has the mark of the monk, " + GetName(oPC) + ". ", TRUE);
            }
        else {
        IPUpgradeWeaponEnhancementBonus(oDest, 1);
        sNewname="Light Ki Weapon";
        SetLocalInt(oDest, "KiMod", 2);
        SetLocalInt(oDest, "Law", 1);
        SetLocalInt(oDest, "Good", 1);
        IPSafeAddItemProperty(oDest, ItemPropertyLimitUseByClass(IP_CONST_CLASS_MONK));
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This weapon hums ever slightly with the feeling of ki. It has the mark of the monk, " + GetName(oPC) + ". ", TRUE);
        SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 1000);
        }
    }

/* Blackguard Weapon of the Abyss - Demonic Totem */
else if (GetTag(oSource)=="te_bgupgrade01" && sType=="Weapon")
    {
    if (GetLevelByClass(CLASS_TYPE_BLACKGUARD, oPC) < 3)
        {
            SendMessageToPC(oPC, "You must be at least a third level blackguard to complete this ritual.");
            DestroyObject(oCopy);
            return;
        }
    nAnim = ANIMATION_LOOPING_WORSHIP;
        if (IPGetWeaponEnhancementBonus(oDest)==5)
            {
            SendMessageToPC(oPC, "No further rituals of this type can be attempted.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "BGMod")>=10)
            {
            SendMessageToPC(oPC, "This blackguard weapon cannot be improved any further.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "BGMod")==9)
            {
            SetLocalInt(oDest, "BGMod", GetLocalInt(oDest, "BGMod")+1);
            IPUpgradeWeaponEnhancementBonus(oDest, 1);
            }
        if (GetLocalInt(oDest, "BGMod")==8)
            {
            SetLocalInt(oDest, "BGMod", GetLocalInt(oDest, "BGMod")+1);
            IPSafeAddItemProperty(oDest, ItemPropertyCastSpell(IP_CONST_CASTSPELL_CONFUSION_5,IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY));
            SetLocalInt(oDest, "iCasterLvl", 9);
            }
        if (GetLocalInt(oDest, "BGMod")==7)
            {
            SetLocalInt(oDest, "BGMod", GetLocalInt(oDest, "BGMod")+1);
            IPUpgradeWeaponEnhancementBonus(oDest, 1);
            }
        if (GetLocalInt(oDest, "BGMod")==6)
            {
            SetLocalInt(oDest, "BGMod", GetLocalInt(oDest, "BGMod")+1);
            IPSafeAddItemProperty(oDest, ItemPropertyCastSpell(IP_CONST_CASTSPELL_FEAR_5,IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY));
            SetLocalInt(oDest, "iCasterLvl",9);
            }
        if (GetLocalInt(oDest, "BGMod")==5)
            {
            SetLocalInt(oDest, "BGMod", GetLocalInt(oDest, "BGMod")+1);
            IPUpgradeWeaponEnhancementBonus(oDest, 1);
            }
        if (GetLocalInt(oDest, "BGMod")==4)
            {
            SetLocalInt(oDest, "BGMod", GetLocalInt(oDest, "BGMod")+1);
            IPSafeAddItemProperty(oDest, ItemPropertyKeen());
            }
        if (GetLocalInt(oDest, "BGMod")==3)
            {
            SetLocalInt(oDest, "BGMod", GetLocalInt(oDest, "BGMod")+1);
            IPUpgradeWeaponEnhancementBonus(oDest, 1);
            }
        if (GetLocalInt(oDest, "BGMod")==2)
            {
            SetLocalInt(oDest, "BGMod", GetLocalInt(oDest, "BGMod")+1);
            IPSafeAddItemProperty(oDest, ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_GOOD,IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGEBONUS_1d6));
            }
        else {
        IPUpgradeWeaponEnhancementBonus(oDest, 1);
        sNewname="Abyssal Weapon";
        SetLocalInt(oDest, "BGMod", 2);
        SetLocalInt(oDest, "Chaos", 1);
        SetLocalInt(oDest, "Evil", 1);
        IPSafeAddItemProperty(oDest, ItemPropertyLimitUseBySAlign(IP_CONST_ALIGNMENT_CE));
        IPSafeAddItemProperty(oDest, ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_LEVEL_ABIL_DRAIN));
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This weapon howls quietly with the chaos of the Abyss. It has the mark of the servant of Chaos, " + GetName(oPC) + ". ", TRUE);
        SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 1000);
        }
    }

/* Blackguard Weapon of the Hells - Trapped Soul */
else if (GetTag(oSource)=="te_bgupgrade02" && sType=="Weapon")
    {
    if (GetLevelByClass(CLASS_TYPE_BLACKGUARD, oPC) < 3)
        {
            SendMessageToPC(oPC, "You must be at least a third level blackguard to complete this ritual.");
            DestroyObject(oCopy);
            return;
        }
    nAnim = ANIMATION_LOOPING_WORSHIP;
        if (IPGetWeaponEnhancementBonus(oDest)==5)
            {
            SendMessageToPC(oPC, "No further rituals of this type can be attempted.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "BGMod")>=10)
            {
            SendMessageToPC(oPC, "This blackguard weapon cannot be improved any further.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "BGMod")==9)
            {
            SetLocalInt(oDest, "BGMod", GetLocalInt(oDest, "BGMod")+1);
            IPUpgradeWeaponEnhancementBonus(oDest, 1);
            }
        if (GetLocalInt(oDest, "BGMod")==8)
            {
            SetLocalInt(oDest, "BGMod", GetLocalInt(oDest, "BGMod")+1);
            IPSafeAddItemProperty(oDest, ItemPropertyCastSpell(IP_CONST_CASTSPELL_POISON_5,IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY));
            SetLocalInt(oDest, "iCasterLvl", 9);
            }
        if (GetLocalInt(oDest, "BGMod")==7)
            {
            SetLocalInt(oDest, "BGMod", GetLocalInt(oDest, "BGMod")+1);
            IPUpgradeWeaponEnhancementBonus(oDest, 1);
            }
        if (GetLocalInt(oDest, "BGMod")==6)
            {
            SetLocalInt(oDest, "BGMod", GetLocalInt(oDest, "BGMod")+1);
            IPSafeAddItemProperty(oDest, ItemPropertyCastSpell(IP_CONST_CASTSPELL_TRUE_STRIKE_5,IP_CONST_CASTSPELL_NUMUSES_3_USES_PER_DAY));
            SetLocalInt(oDest, "iCasterLvl",9);
            }
        if (GetLocalInt(oDest, "BGMod")==5)
            {
            SetLocalInt(oDest, "BGMod", GetLocalInt(oDest, "BGMod")+1);
            IPUpgradeWeaponEnhancementBonus(oDest, 1);
            }
        if (GetLocalInt(oDest, "BGMod")==4)
            {
            SetLocalInt(oDest, "BGMod", GetLocalInt(oDest, "BGMod")+1);
            IPSafeAddItemProperty(oDest, ItemPropertyVampiricRegeneration(2));
            }
        if (GetLocalInt(oDest, "BGMod")==3)
            {
            SetLocalInt(oDest, "BGMod", GetLocalInt(oDest, "BGMod")+1);
            IPUpgradeWeaponEnhancementBonus(oDest, 1);
            }
        if (GetLocalInt(oDest, "BGMod")==2)
            {
            SetLocalInt(oDest, "BGMod", GetLocalInt(oDest, "BGMod")+1);
            IPSafeAddItemProperty(oDest, ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_GOOD,IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGEBONUS_1d6));
            }
        else {
        IPUpgradeWeaponEnhancementBonus(oDest, 1);
        sNewname="Infernal Weapon";
        SetLocalInt(oDest, "BGMod", 2);
        SetLocalInt(oDest, "Law", 1);
        SetLocalInt(oDest, "Evil", 1);
        IPSafeAddItemProperty(oDest, ItemPropertyLimitUseBySAlign(IP_CONST_ALIGNMENT_LE));
        IPSafeAddItemProperty(oDest, ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_LEVEL_ABIL_DRAIN));
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This weapon causes feelings of unease, being aligned with the lawful forces of the Nine Hells. It has the mark of the servant of the Hells, " + GetName(oPC) + ". ", TRUE);
        SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 1000);
        }
    }

/* Ephemeral Weapon - requires reality stone*/
else if (GetTag(oSource)=="te_illucraft01" && sType=="Weapon")
    {
    if ((GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE, oPC) < 5) &&
    (GetHasFeat(1452, oPC) == FALSE) &&
    (GetHasFeat(1453, oPC) == FALSE) &&
    (GetHasFeat(1454, oPC) == FALSE) &&
    (GetHasFeat(1398, oPC) == FALSE) &&
    (GetHasFeat(1320, oPC) == FALSE))//gnomes, talfirian, leiran
        {
            SendMessageToPC(oPC, "You must possess an innate talent with illusion to complete this task.");
            DestroyObject(oCopy);
            return;
        }
    nAnim = ANIMATION_LOOPING_MEDITATE;
        if (IPGetWeaponEnhancementBonus(oDest)==5)
            {
            SendMessageToPC(oPC, "No further rituals of this type can be attempted.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "WeaponCap")>=10)
            {
            SendMessageToPC(oPC, "This weapon cannot be improved any further.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Ephemeral")>=6)
            {
            SendMessageToPC(oPC, "This weapon cannot be improved any further.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Ephemeral")==5)
            {
            SetLocalInt(oDest, "Ephemeral", GetLocalInt(oDest, "Ephemeral")+1);
            SetLocalInt(oDest, "WeaponCap", GetLocalInt(oDest, "WeaponCap")+1);
            IPUpgradeWeaponEnhancementBonus(oDest, 1);
            }
        if (GetLocalInt(oDest, "Ephemeral")==4)
            {
            SetLocalInt(oDest, "Ephemeral", GetLocalInt(oDest, "Ephemeral")+1);
            SetLocalInt(oDest, "WeaponCap", GetLocalInt(oDest, "WeaponCap")+1);
            IPSafeAddItemProperty(oDest, ItemPropertyKeen());
            }
        if (GetLocalInt(oDest, "Ephemeral")==3)
            {
            SetLocalInt(oDest, "Ephemeral", GetLocalInt(oDest, "Ephemeral")+1);
            SetLocalInt(oDest, "WeaponCap", GetLocalInt(oDest, "WeaponCap")+1);
            IPUpgradeWeaponEnhancementBonus(oDest, 1);
            }
        if (GetLocalInt(oDest, "Ephemeral")==2)
            {
            SetLocalInt(oDest, "Ephemeral", GetLocalInt(oDest, "Ephemeral")+1);
            SetLocalInt(oDest, "WeaponCap", GetLocalInt(oDest, "WeaponCap")+1);
            IPSafeAddItemProperty(oDest, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGEBONUS_1d6));
            }
        else {
        IPUpgradeWeaponEnhancementBonus(oDest, 1);
        sNewname="Ephemeral Weapon";
        SetLocalInt(oDest, "Ephemeral", 2);
        SetLocalInt(oDest, "WeaponCap", GetLocalInt(oDest, "WeaponCap")+1);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This weapon appears almost entirely insubstantial from certain angles. It bears the mark of the Illusionist,  " + GetName(oPC) + ". ", TRUE);
        }
    }

/* Ephemeral Armor or Shield  - requires reality stone*/
else if (GetTag(oSource)=="te_illucraft01" && (sType=="Shield" || sType=="Armor"))
    {
    if ((GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE, oPC) < 5) &&
    (GetHasFeat(1452, oPC) == FALSE) &&
    (GetHasFeat(1453, oPC) == FALSE) &&
    (GetHasFeat(1454, oPC) == FALSE) &&
    (GetHasFeat(1398, oPC) == FALSE) &&
    (GetHasFeat(1320, oPC) == FALSE))//gnomes, talfirian, leiran
        {
            SendMessageToPC(oPC, "You must possess an innate talent with illusion to complete this task.");
            DestroyObject(oCopy);
            return;
        }
    nAnim = ANIMATION_LOOPING_MEDITATE;
        if (GetLocalInt(oDest, "ArmorCap")>=10)
            {
            SendMessageToPC(oPC, "This armor cannot be improved any further.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Ephemeral")>=6)
            {
            SendMessageToPC(oPC, "This armor cannot be improved any further.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Ephemeral")==5)
            {
            SetLocalInt(oDest, "Ephemeral", GetLocalInt(oDest, "Ephemeral")+1);
            SetLocalInt(oDest, "ArmorCap", GetLocalInt(oDest, "ArmorCap")+1);
            SetLocalInt(oDest, "ArmorAC", GetLocalInt(oDest, "ArmorAC")+1);
            IPSafeAddItemProperty(oDest, ItemPropertyACBonus(GetLocalInt(oDest,"ArmorAC")));
            }
        if (GetLocalInt(oDest, "Ephemeral")==4)
            {
            SetLocalInt(oDest, "Ephemeral", GetLocalInt(oDest, "Ephemeral")+1);
            SetLocalInt(oDest, "ArmorCap", GetLocalInt(oDest, "ArmorCap")+1);
            IPSafeAddItemProperty(oDest, ItemPropertyArcaneSpellFailure(IP_CONST_ARCANE_SPELL_FAILURE_MINUS_30_PERCENT));
            }
        if (GetLocalInt(oDest, "Ephemeral")==3)
            {
            SetLocalInt(oDest, "Ephemeral", GetLocalInt(oDest, "Ephemeral")+1);
            SetLocalInt(oDest, "ArmorCap", GetLocalInt(oDest, "ArmorCap")+1);
            SetLocalInt(oDest, "ArmorAC", GetLocalInt(oDest, "ArmorAC")+1);
            IPSafeAddItemProperty(oDest, ItemPropertyACBonus(GetLocalInt(oDest,"ArmorAC")));
            }
        if (GetLocalInt(oDest, "Ephemeral")==2)
            {
            SetLocalInt(oDest, "Ephemeral", GetLocalInt(oDest, "Ephemeral")+1);
            SetLocalInt(oDest, "ArmorCap", GetLocalInt(oDest, "ArmorCap")+1);
            IPSafeAddItemProperty(oDest, ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_80_PERCENT));
            }
        else {
        SetLocalInt(oDest, "ArmorAC", GetLocalInt(oDest, "ArmorAC")+1);
        SetLocalInt(oDest, "ArmorCap", GetLocalInt(oDest, "ArmorCap")+1);
        IPSafeAddItemProperty(oDest, ItemPropertyACBonus(GetLocalInt(oDest,"ArmorAC")));
        sNewname="Ephemeral " + GetName(oDest);
        SetLocalInt(oDest, "Ephemeral", 2);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This item appears almost entirely insubstantial from certain angles. It bears the mark of the Illusionist,  " + GetName(oPC) + ". ", TRUE);
        }
    }

/* Ephemeral Cloak or Helmet - requires reality stone*/
else if (GetTag(oSource)=="te_illucraft01" && (sType=="Cloak" || sType=="Helm"))
    {
    if ((GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE, oPC) < 5) &&
    (GetHasFeat(1452, oPC) == FALSE) &&
    (GetHasFeat(1453, oPC) == FALSE) &&
    (GetHasFeat(1454, oPC) == FALSE) &&
    (GetHasFeat(1398, oPC) == FALSE) &&
    (GetHasFeat(1320, oPC) == FALSE))//gnomes, talfirian, leiran
        {
            SendMessageToPC(oPC, "You must possess an innate talent with illusion to complete this task.");
            DestroyObject(oCopy);
            return;
        }
    nAnim = ANIMATION_LOOPING_MEDITATE;
        if (GetLocalInt(oDest, "AccessoryCap")>=10)
            {
            SendMessageToPC(oPC, "This item cannot be improved any further.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Ephemeral")>=6)
            {
            SendMessageToPC(oPC, "This item cannot be improved any further.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "Ephemeral")==5)
            {
            SetLocalInt(oDest, "Ephemeral", GetLocalInt(oDest, "Ephemeral")+1);
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            SetLocalInt(oDest, "Resistance", GetLocalInt(oDest, "Resistance")+1);
            IPSafeAddItemProperty(oDest, ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE, GetLocalInt(oDest, "Resistance")));
            IPSafeAddItemProperty(oDest, ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX, GetLocalInt(oDest, "Resistance")));
            IPSafeAddItemProperty(oDest, ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_WILL, GetLocalInt(oDest, "Resistance")));
            }
        if (GetLocalInt(oDest, "Ephemeral")==4)
            {
            SetLocalInt(oDest, "Ephemeral", GetLocalInt(oDest, "Ephemeral")+1);
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            IPSafeAddItemProperty(oDest, ItemPropertyCastSpell(IP_CONST_CASTSPELL_IMPROVED_INVISIBILITY_7,IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY));
            SetLocalInt(oDest, "iCasterLvl", 9);
            }
        if (GetLocalInt(oDest, "Ephemeral")==3)
            {
            SetLocalInt(oDest, "Ephemeral", GetLocalInt(oDest, "Ephemeral")+1);
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            SetLocalInt(oDest, "Resistance", GetLocalInt(oDest, "Resistance")+1);
            IPSafeAddItemProperty(oDest, ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE, GetLocalInt(oDest, "Resistance")));
            IPSafeAddItemProperty(oDest, ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX, GetLocalInt(oDest, "Resistance")));
            IPSafeAddItemProperty(oDest, ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_WILL, GetLocalInt(oDest, "Resistance")));
            }
        if (GetLocalInt(oDest, "Ephemeral")==2)
            {
            SetLocalInt(oDest, "Ephemeral", GetLocalInt(oDest, "Ephemeral")+1);
            SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
            IPSafeAddItemProperty(oDest, ItemPropertyCastSpell(IP_CONST_CASTSPELL_INVISIBILITY_3,IP_CONST_CASTSPELL_NUMUSES_2_USES_PER_DAY));
            SetLocalInt(oDest, "iCasterLvl", 5);
            }
        else {
        SetLocalInt(oDest, "AccessoryCap", GetLocalInt(oDest, "AccessoryCap")+1);
        SetLocalInt(oDest, "Resistance", GetLocalInt(oDest, "Resistance")+1);
        IPSafeAddItemProperty(oDest, ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE, GetLocalInt(oDest, "Resistance")));
        IPSafeAddItemProperty(oDest, ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX, GetLocalInt(oDest, "Resistance")));
        IPSafeAddItemProperty(oDest, ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_WILL, GetLocalInt(oDest, "Resistance")));
        sNewname="Ephemeral " + GetName(oDest);
        SetLocalInt(oDest, "Ephemeral", 2);
        SetDescription(oDest, GetDescription(oDest, FALSE, TRUE) + " This item appears almost entirely insubstantial from certain angles. It bears the mark of the Illusionist,  " + GetName(oPC) + ". ", TRUE);
        }
    }

/*Lens of Detection - Requires Find Traps Scroll + ring*/
else if (GetTag(oSource)=="X2_IT_SPARSCR305" && GetTag(oDest)=="te_cebcraft028")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
        (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
        (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
        (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
        (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
        (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
        (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
        {
            SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
            DestroyObject(oCopy);
            return;
        }
    nAnim = ANIMATION_LOOPING_MEDITATE;
        if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
            {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
            }
        if (GetCasterLevel(oPC)-(nEEL) < 9)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            DestroyObject(oCopy);
            return;
            }
        if (GetLocalInt(oDest, "AccessoryCap")>=1)
            {
            SendMessageToPC(oPC, "You cannot use this magic on an already magical ring.");
            DestroyObject(oCopy);
            return;
            }
        if (GetGold(oPC) < 1750)
            {
            SendMessageToPC(oPC, "You do not have the 1750 gold required to create this item.");
            DestroyObject(oCopy);
            return;
            }
        else {
            CreateItemOnObject("te_detectionlens", oTarget, 1);
            AssignCommand(oPC, TakeGoldFromCreature(1750, oPC, TRUE));
            DestroyObject(oDest);
        }
    }

/* Chime of Opening requires Knock spell and an Amulet*/
else if (GetTag(oSource)=="NW_IT_SPARSCR216" && sType=="Amulet")
    {
    if ((GetLevelByClass(CLASS_TYPE_BARD, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_PALADIN, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_RANGER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC)>0)||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0) || (GetLevelByClass(57, oPC)>0)) {} else
    {
        SendMessageToPC(oPC, "Your class cannot perform this enchantment.");
        DestroyObject(oCopy);
        return;
    }
    nAnim = ANIMATION_LOOPING_MEDITATE;
    if (FeatCheck("Craft_Wonderous_Item", oPC) == FALSE)
        {
            SendMessageToPC(oPC, "You do not have the required feat.");
            DestroyObject(oCopy);
            return;
        }
        if (GetCasterLevel(oPC)-(nEEL) < 11)
            {
            SendMessageToPC(oPC, "You are not high enough level to perform this enchantment.");
            return;
            }
        if (GetLocalInt(oDest, "AccessoryCap")>=1)
            {
            SendMessageToPC(oPC, "You cannot use this magic on an already magical amulet.");
            return;
            }
        if (GetGold(oPC) < 1500)
            {
            SendMessageToPC(oPC, "You do not have the 1500 gold required to create this item.");
            return;
            }
        else {
            CreateItemOnObject("te_chimeopen", oTarget, 1);
            AssignCommand(oPC, TakeGoldFromCreature(1500, oPC, TRUE));
            DestroyObject(oDest);
        }
    }

///////////
//Magic Weapon, armor and accessory costs
//////////
if ((GetTag(oSource)!="te_armorupg001" && //check for mundane or silvering, aligning and light spells
GetTag(oSource)!="te_armorupg002" &&
GetTag(oSource)!="te_armorupg003" &&
GetTag(oSource)!="te_armorupg004" &&
GetTag(oSource)!="te_armorupg005" &&
GetTag(oSource)!="te_armorupg006" &&
GetTag(oSource)!="te_armorupg007" &&
GetTag(oSource)!="te_armorupg008" &&
GetTag(oSource)!="te_armorupg009" &&
GetTag(oSource)!="te_armorupg010" &&
GetTag(oSource)!="te_armorupg011" &&
GetTag(oSource)!="te_armorupg012" &&
GetTag(oSource)!="X2_IT_SPDVSCR103" &&
GetTag(oSource)!="X2_IT_SPDVSCR105" &&
GetTag(oSource)!="X1_IT_SPDVSCR102" &&
GetTag(oSource)!="NW_IT_SPARSCR210" &&
GetTag(oSource)!="NW_IT_SPARSCR004" &&
GetTag(oSource)!="te_palupgr003"))
{
if (GetLocalInt(oDest, "WeaponCap") == 1)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 1000);}
if (GetLocalInt(oDest, "WeaponCap") == 2)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 3000);}
if (GetLocalInt(oDest, "WeaponCap") == 3)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 5000);}
if (GetLocalInt(oDest, "WeaponCap") == 4)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 7000);}
if (GetLocalInt(oDest, "WeaponCap") == 5)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 9000);}
if (GetLocalInt(oDest, "WeaponCap") == 6)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 11000);}
if (GetLocalInt(oDest, "WeaponCap") == 7)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 13000);}
if (GetLocalInt(oDest, "WeaponCap") == 8)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 15000);}
if (GetLocalInt(oDest, "WeaponCap") == 9)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 17000);}
if (GetLocalInt(oDest, "WeaponCap") == 10)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 19000);}
if (GetLocalInt(oDest, "ArmorCap") == 1)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 500);}
if (GetLocalInt(oDest, "ArmorCap") == 2)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 1500);}
if (GetLocalInt(oDest, "ArmorCap") == 3)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 2500);}
if (GetLocalInt(oDest, "ArmorCap") == 4)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 3500);}
if (GetLocalInt(oDest, "ArmorCap") == 5)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 4500);}
if (GetLocalInt(oDest, "ArmorCap") == 6)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 5500);}
if (GetLocalInt(oDest, "ArmorCap") == 7)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 6500);}
if (GetLocalInt(oDest, "ArmorCap") == 8)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 7500);}
if (GetLocalInt(oDest, "ArmorCap") == 9)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 8500);}
if (GetLocalInt(oDest, "ArmorCap") == 10)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 9500);}
if (GetLocalInt(oDest, "AccessoryCap") == 1)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 500);}
if (GetLocalInt(oDest, "AccessoryCap") == 2)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 1500);}
if (GetLocalInt(oDest, "AccessoryCap") == 3)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 2500);}
if (GetLocalInt(oDest, "AccessoryCap") == 4)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 3500);}
if (GetLocalInt(oDest, "AccessoryCap") == 5)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 4500);}
if (GetLocalInt(oDest, "AccessoryCap") == 6)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 5500);}
if (GetLocalInt(oDest, "AccessoryCap") == 7)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 6500);}
if (GetLocalInt(oDest, "AccessoryCap") == 8)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 7500);}
if (GetLocalInt(oDest, "AccessoryCap") == 9)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 8500);}
if (GetLocalInt(oDest, "AccessoryCap") == 10)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 9500);}
if (GetLocalInt(oDest, "PalMod") == 1)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 1000);}
if (GetLocalInt(oDest, "PalMod") == 2)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 3000);}
if (GetLocalInt(oDest, "PalMod") == 3)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 5000);}
if (GetLocalInt(oDest, "PalMod") == 4)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 7000);}
if (GetLocalInt(oDest, "PalMod") == 5)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 9000);}
if (GetLocalInt(oDest, "PalMod") == 6)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 11000);}
if (GetLocalInt(oDest, "PalMod") == 7)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 13000);}
if (GetLocalInt(oDest, "PalMod") == 8)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 15000);}
if (GetLocalInt(oDest, "PalMod") == 9)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 17000);}
if (GetLocalInt(oDest, "PalMod") == 10)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 19000);}
if (GetLocalInt(oDest, "KiMod") == 1)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 1000);}
if (GetLocalInt(oDest, "KiMod") == 2)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 3000);}
if (GetLocalInt(oDest, "KiMod") == 3)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 5000);}
if (GetLocalInt(oDest, "KiMod") == 4)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 7000);}
if (GetLocalInt(oDest, "KiMod") == 5)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 9000);}
if (GetLocalInt(oDest, "KiMod") == 6)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 11000);}
if (GetLocalInt(oDest, "KiMod") == 7)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 13000);}
if (GetLocalInt(oDest, "KiMod") == 8)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 15000);}
if (GetLocalInt(oDest, "KiMod") == 9)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 17000);}
if (GetLocalInt(oDest, "KiMod") == 10)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 19000);}
if (GetLocalInt(oDest, "BGMod") == 1)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 1000);}
if (GetLocalInt(oDest, "BGMod") == 2)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 3000);}
if (GetLocalInt(oDest, "BGMod") == 3)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 5000);}
if (GetLocalInt(oDest, "BGMod") == 4)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 7000);}
if (GetLocalInt(oDest, "BGMod") == 5)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 9000);}
if (GetLocalInt(oDest, "BGMod") == 6)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 11000);}
if (GetLocalInt(oDest, "BGMod") == 7)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 13000);}
if (GetLocalInt(oDest, "BGMod") == 8)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 15000);}
if (GetLocalInt(oDest, "BGMod") == 9)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 17000);}
if (GetLocalInt(oDest, "BGMod") == 10)
            {SetLocalInt(oDest, "Value", GetLocalInt(oDest, "Value") + 19000);}
}

/* No Recipe */
else
    {
    SendMessageToPC(oPC, "These items cannot be combined.");
    if (GetItemStackSize(oCopy) > 1) SetItemStackSize (oCopy, GetItemStackSize(oCopy)-1);
    else DestroyObject(oCopy);
    return;
    }

/*Finalize*/
nCost=(GetLocalInt(oDest, "Value")-GetLocalInt(oCopy, "Value")-GetGoldPieceValue(oSource))*(100-(GetSkillRank(SKILL_SPELLCRAFT, oPC, FALSE)/2))/100;
SendMessageToPC(
                oPC, IntToString(GetLocalInt(oDest, "Value"))
                + "-"
                + IntToString(GetLocalInt(oCopy, "Value"))
                + "-"
                + IntToString(GetGoldPieceValue(oSource))
                + "-Bonus("
                +IntToString((100-(GetSkillRank(SKILL_SPELLCRAFT, oPC, FALSE)/2))/100)
                +")="+IntToString(nCost)
                );

if (GetLocalInt(oDest, "Value")>(GetHitDice(oPC)*5000))
    {
    SendMessageToPC(oPC, "Your attempt to enchant this item further has failed. The enchantment has become too advanced.");
    DestroyObject(oDest);
    }
else if (GetGold(oPC) > nCost)
    {
    AssignCommand(oPC, ActionPlayAnimation(nAnim, 1.0f, 5.0f));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 5.0f);
    AssignCommand(oPC, TakeGoldFromCreature(nCost, oPC, TRUE));
    SetXP(oPC, GetXP(oPC)-(nCost/10));
    DestroyObject(oSource);
    DestroyObject(oCopy);
    }
else
    {
    SendMessageToPC(oPC, "You do not have the " + IntToString(nCost) + " gold pieces required to make this item.");
    DestroyObject(oDest);
    }

SetName(oDest, sNewname);
}
