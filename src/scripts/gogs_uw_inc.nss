///////////////////////////GOG's Underwater System//////////////////////////////
//Created By : GOG
//Created On : Dec. 8th 2009
//Script Type: #include
////////////////////////////////////////////////////////////////////////////////
//Notes:
//-This is meant to be used as an #include for underwater area functions.
//-If criteria is not met, creatures in water area will recieve an attack
// penalty and a movement speed decrease. Freedom of Movement negates the speed
// decease.
//-Any creatures that are not equipped with a drowning prevention item or using
// a water breathing reagant/spell will take drowning damage every area HB.
//-All creatures in area will have their foostep sound changed to
// "FOOTSTEP_TYPE_SHARK" and will be restored upon leaving the under water area.
//-Creatures that are meant to live in the water area or spawn in the water area
// and are not to be effected, must have the following local integer set on
// them. "UNDER_WATER_IMMUNE" set to 1.
//-DMs are not effected at all.
//-RACIAL_TYPE_UNDEAD is not effected by drowning but still recieves the other
// effects.
//-RACIAL_TYPE_CONSTRUCT is not effected by drowning but still recieves the
// other effects.
//-Water Elementals are not effected at all.
//-Followers and henchmen WILL be effected as well.
////////////////////////////////////////////////////////////////////////////////
//The following constants may be changed to fit your needs. If you do make any
//changes make sure you "build" your mod afterward. Otherwise the changes will
//not take effect.
////////////////////////////////////////////////////////////////////////////////

//Amount of damage to take every x seconds from drowning. Default 10.
const int DROWNING_DAMAGE = 1;

//Amount of attack penalty for being underwater. Default 5.
const int ATTACK_DECREASE = 5;

//% of movement speed decrease. 0-99. Higher number = slower. Default 30.
const int MOVE_DECREASE   = 30;

//Turn bubbles effect off and on. TRUE = on. FALSE = off. Default TRUE.
const int BUBBLES_ON      = TRUE;

//If you want an item simply possessed by the creature to give immunity, enter
//the tag of your item below. Do not leave blank. If you do not provide a tag,
//leave a random string that will not match and of your item tags in game.
//Default "TAG_OF_POSSESSED_IMMUNITY_ITEM_HERE".
const string IMMUNE_ITEM  = "TAG_OF_POSSESSED_IMMUNITY_ITEM_HERE";

//Tags of your items that prevent drowning. Examples already below. Do not leave
//blank. If you do not provide a tag, leave a random string that will not match
//any of your item tags in game. Default "xxxxx".
const string HELM    = "HELM_OF_GILLS";
const string ARMOR   = "ARMOR_OF_THE_FISH";
const string CLOAK   = "xxxxx";
const string BOOTS   = "xxxxx";
const string BELT    = "xxxxx";
const string ARMS    = "xxxxx";
const string AMULET  = "MERMAID_AMULET";
const string RING1   = "RING_OF_WATER_BREATHING";
const string RING2   = "RING_OF_WATER_BREATHING";

//If set to TRUE, up to 10 subraces may be excluded. Default TRUE
const int EXCLUDE_SR = TRUE;
//Subraces not effected by being underwater. Do not leave blank. If you do not
//provide a string leave a random string that will not match any of your other
//subrace names. Default "Name of subrace#".
const string SR1     = "Mermaid";
const string SR2     = "Name of subrace2";
const string SR3     = "Name of subrace3";
const string SR4     = "Name of subrace4";
const string SR5     = "Name of subrace5";
const string SR6     = "Name of subrace6";
const string SR7     = "Name of subrace7";
const string SR8     = "Name of subrace8";
const string SR9     = "Name of subrace9";
const string SR10    = "Name of subrace10";

////////////////////////////////////////////////////////////////////////////////
int GetHasWaterBreathItemEquipped(object oCreature);
int GetHasWaterBreathItemEquipped(object oCreature)
{
if (GetTag(GetItemInSlot(INVENTORY_SLOT_HEAD, oCreature))      == HELM   ||
    GetTag(GetItemInSlot(INVENTORY_SLOT_CHEST, oCreature))     == ARMOR  ||
    GetTag(GetItemInSlot(INVENTORY_SLOT_CLOAK, oCreature))     == CLOAK  ||
    GetTag(GetItemInSlot(INVENTORY_SLOT_BOOTS, oCreature))     == BOOTS  ||
    GetTag(GetItemInSlot(INVENTORY_SLOT_BELT, oCreature))      == BELT   ||
    GetTag(GetItemInSlot(INVENTORY_SLOT_ARMS, oCreature))      == ARMS   ||
    GetTag(GetItemInSlot(INVENTORY_SLOT_NECK, oCreature))      == AMULET ||
    GetTag(GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oCreature)) == RING1  ||
    GetTag(GetItemInSlot(INVENTORY_SLOT_LEFTRING, oCreature))  == RING2)
    return TRUE;
else return FALSE;
}
////////////////////////////////////////////////////////////////////////////////
int GetIsWaterSubrace(object oCreature);
int GetIsWaterSubrace(object oCreature)
{
int iWaterRace;
if (EXCLUDE_SR == TRUE)
    {
    if (GetSubRace(oCreature) == SR1 ||
        GetSubRace(oCreature) == SR2 ||
        GetSubRace(oCreature) == SR3 ||
        GetSubRace(oCreature) == SR4 ||
        GetSubRace(oCreature) == SR5 ||
        GetSubRace(oCreature) == SR6 ||
        GetSubRace(oCreature) == SR7 ||
        GetSubRace(oCreature) == SR8 ||
        GetSubRace(oCreature) == SR9 ||
        GetSubRace(oCreature) == SR10)
        iWaterRace = TRUE;
    else iWaterRace = FALSE;
    }
return iWaterRace;
}
////////////////////////////////////////////////////////////////////////////////
float BubbleDelay();
float BubbleDelay()
{
float fDelay;
switch(Random(10))
    {
    case 0: fDelay = 0.3;break;
    case 1: fDelay = 0.6;break;
    case 2: fDelay = 0.9;break;
    case 3: fDelay = 1.3;break;
    case 4: fDelay = 1.6;break;
    case 5: fDelay = 1.9;break;
    case 6: fDelay = 2.3;break;
    case 7: fDelay = 2.6;break;
    case 8: fDelay = 2.9;break;
    case 9: fDelay = 3.3;break;
    }
    return fDelay;
}
////////////////////////////////////////////////////////////////////////////////
int GetNumEffectsFromObject(object oCreature, object oCreator);
int GetNumEffectsFromObject(object oCreature, object oCreator)
{
int iEffects = 0;
effect eEffect = GetFirstEffect(oCreature);
while (GetIsEffectValid(eEffect))
    {
    if (GetEffectCreator(eEffect) == oCreator)
        {
        iEffects++;
        }
    eEffect = GetNextEffect(oCreature);
    }
return iEffects;
}
////////////////////////////////////////////////////////////////////////////////
int GetIsWaterImmune(object oCreature);
int GetIsWaterImmune(object oCreature)
{
int iImmune     = GetLocalInt(oCreature, "UNDER_WATER_IMMUNE");
int iWaterRace  = GetIsWaterSubrace(oCreature);
if (iWaterRace  == TRUE) return TRUE;
if (iImmune     == TRUE) return TRUE;
if (GetAppearanceType(oCreature) == APPEARANCE_TYPE_ELEMENTAL_WATER ||
    GetAppearanceType(oCreature) == APPEARANCE_TYPE_ELEMENTAL_WATER_ELDER &&
    GetRacialType(oCreature)     == RACIAL_TYPE_ELEMENTAL)return TRUE;
else return FALSE;
}
////////////////////////////////////////////////////////////////////////////////
void ApplyUnderWaterEffects(object oCreature);
void ApplyUnderWaterEffects(object oCreature)
{
effect eWaterDamage = EffectDamage(DROWNING_DAMAGE, DAMAGE_TYPE_POSITIVE, DAMAGE_POWER_ENERGY);
effect eWaterSlow   = SupernaturalEffect(EffectMovementSpeedDecrease(MOVE_DECREASE));
effect eBubbles     = SupernaturalEffect(EffectVisualEffect(566));
effect eLowerAttack = SupernaturalEffect(EffectAttackDecrease(ATTACK_DECREASE));
int iUWEffectOn     = GetLocalInt(oCreature, "UNDER_WATER_ON");
int iSharkStep      = GetLocalInt(oCreature, "SHARK_FOOTSTEP");
int iReagant        = GetLocalInt(oCreature, "WATER_BREATH_ACTIVE");
int iAreaEffects    = GetNumEffectsFromObject(oCreature, OBJECT_SELF);
int iImmune         = GetIsWaterImmune(oCreature);
int iWaterItem      = GetHasWaterBreathItemEquipped(oCreature);
float fBubbleDelay  = BubbleDelay();

//Line used for testing:
//AssignCommand(oCreature, ActionSpeakString("Beat"));

if (GetIsDM(oCreature)) return;
if (iSharkStep != TRUE)
    {
    SetFootstepType(FOOTSTEP_TYPE_SHARK, oCreature);
    SetLocalInt(oCreature, "SHARK_FOOTSTEP", TRUE);
    }
if (iImmune == TRUE) return;
if (GetItemPossessedBy(oCreature, IMMUNE_ITEM) != OBJECT_INVALID) return;
if (iAreaEffects == 0)
    {
    SetLocalInt(oCreature, "UNDER_WATER_ON", FALSE);
    }
if (iUWEffectOn != TRUE)
    {
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eWaterSlow, oCreature);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLowerAttack, oCreature);
    if (BUBBLES_ON == TRUE)
        {
        DelayCommand(fBubbleDelay, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBubbles, oCreature));
        }
    SetLocalInt(oCreature, "UNDER_WATER_ON", TRUE);
    }
}
////////////////////////////////////////////////////////////////////////////////
void RemoveUnderWaterEffects(object oCreature);
void RemoveUnderWaterEffects(object oCreature)
{
object oArea = OBJECT_SELF;
effect eEffect = GetFirstEffect(oCreature);
    while (GetIsEffectValid(eEffect))
        {
        if (GetEffectCreator(eEffect) == oArea)
        RemoveEffect(oCreature, eEffect);
        eEffect = GetNextEffect(oCreature);
        }
    SetFootstepType(FOOTSTEP_TYPE_DEFAULT, oCreature);
    SetLocalInt(oCreature, "UNDER_WATER_ON", FALSE);
    SetLocalInt(oCreature, "SHARK_FOOTSTEP", FALSE);
}
////////////////////////////////////////////////////////////////////////////////
