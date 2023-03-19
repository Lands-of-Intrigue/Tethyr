//::///////////////////////////////////////////////
//:: Name
//:: FileName
//:: Copyright (c) 2005 The Ravenloft PW Project
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Axel Gottlieb Michelsen
//:: Created On: Beer, Gin, other intoxicating substances.
//:://////////////////////////////////////////////

#include "so_inc_database"
#include "so_inc_factions"
#include "so_inc_constants"
#include "so_inc_general"

void MakeCorporeal(object oPC, object oCorpse);


void SetHitPoints(int nHitPoints, object oPC){
    int nPCHP = GetCurrentHitPoints(oPC);
    if(nPCHP < nHitPoints){
        effect eHeal = EffectHeal(nHitPoints - nPCHP);
        AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPC));
    }
    else if(nPCHP > nHitPoints){
        effect eDammage = EffectDamage(nPCHP-nHitPoints,DAMAGE_TYPE_POSITIVE);
        AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_INSTANT, eDammage, oPC));
    }
    else if(nPCHP == nHitPoints){
        //do nothing. The player already has the right amount of HP.
    }
}

const string sCorpseInInventory = "Illegal use of spell. Place corpse on ground before use.";
const string sNotACorpse = "The target of the spell is not a corpse.";

void SetDeathState(object oPC, int nState)
{
    object oSkin=GetSkin(oPC);
    SetLocalInt(oSkin, DATABASE_PC_DEATH_STATE, nState);
}

int GetDeathState(object oPC)
{
    object oSkin=GetSkin(oPC);
    return GetLocalInt(oSkin, DATABASE_PC_DEATH_STATE);
}

void SetSpirit(object oPC, int bState=TRUE)
{
    if(bState==TRUE)
    {
        //SetPlotFlag(oPC,TRUE);
        effect eSpirit=EffectConcealment(100);
        AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(eSpirit),oPC));
        eSpirit=EffectDamageImmunityIncrease(DAMAGE_TYPE_ACID,100);
        AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(eSpirit),oPC));
        eSpirit=EffectDamageImmunityIncrease(DAMAGE_TYPE_BASE_WEAPON,100);
        AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(eSpirit),oPC));
        eSpirit=EffectDamageImmunityIncrease(DAMAGE_TYPE_BLUDGEONING,100);
        AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(eSpirit),oPC));
        eSpirit=EffectDamageImmunityIncrease(DAMAGE_TYPE_COLD,100);
        AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(eSpirit),oPC));
        eSpirit=EffectDamageImmunityIncrease(DAMAGE_TYPE_DIVINE,100);
        AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(eSpirit),oPC));
        eSpirit=EffectDamageImmunityIncrease(DAMAGE_TYPE_ELECTRICAL,100);
        AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(eSpirit),oPC));
        eSpirit=EffectDamageImmunityIncrease(DAMAGE_TYPE_FIRE,100);
        AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(eSpirit),oPC));
        eSpirit=EffectDamageImmunityIncrease(DAMAGE_TYPE_MAGICAL,100);
        AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(eSpirit),oPC));
        eSpirit=EffectDamageImmunityIncrease(DAMAGE_TYPE_NEGATIVE,100);
        AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(eSpirit),oPC));
        eSpirit=EffectDamageImmunityIncrease(DAMAGE_TYPE_PIERCING,100);
        AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(eSpirit),oPC));
        eSpirit=EffectDamageImmunityIncrease(DAMAGE_TYPE_SLASHING,100);
        AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(eSpirit),oPC));
        eSpirit=EffectDamageImmunityIncrease(DAMAGE_TYPE_SONIC,100);
        AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(eSpirit),oPC));
        eSpirit=EffectVisualEffect(VFX_DUR_GLOW_WHITE);
        AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(eSpirit),oPC));

        eSpirit=EffectImmunity(IMMUNITY_TYPE_DEATH);
        AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(eSpirit),oPC));
        eSpirit=EffectImmunity(IMMUNITY_TYPE_NEGATIVE_LEVEL);
        AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(eSpirit),oPC));
        eSpirit=EffectImmunity(IMMUNITY_TYPE_POISON);
        AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(eSpirit),oPC));
        eSpirit=EffectImmunity(IMMUNITY_TYPE_DISEASE);
        AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(eSpirit),oPC));
        eSpirit=EffectImmunity(IMMUNITY_TYPE_CURSED);
        AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(eSpirit),oPC));
        eSpirit=EffectImmunity(IMMUNITY_TYPE_CONFUSED);
        AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(eSpirit),oPC));
        eSpirit=EffectImmunity(IMMUNITY_TYPE_ABILITY_DECREASE);
        AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(eSpirit),oPC));
        eSpirit=EffectImmunity(IMMUNITY_TYPE_FEAR);
        AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(eSpirit),oPC));
        eSpirit=EffectImmunity(IMMUNITY_TYPE_SLEEP);
        AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(eSpirit),oPC));
        eSpirit=EffectImmunity(IMMUNITY_TYPE_PARALYSIS);
        AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(eSpirit),oPC));
        eSpirit=EffectImmunity(IMMUNITY_TYPE_SLOW);
        AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(eSpirit),oPC));
        eSpirit=EffectImmunity(IMMUNITY_TYPE_TRAP);
        AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(eSpirit),oPC));



        eSpirit=EffectSpellImmunity(SPELL_ALL_SPELLS);
        AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(eSpirit),oPC));
        eSpirit=EffectSkillDecrease(SKILL_DISABLE_TRAP,50);
        AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(eSpirit),oPC));
        eSpirit=EffectSkillDecrease(SKILL_PICK_POCKET,50);
        AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(eSpirit),oPC));
        eSpirit=EffectSkillDecrease(SKILL_OPEN_LOCK,50);
        AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(eSpirit),oPC));
        eSpirit=EffectDazed();
        AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(eSpirit),oPC));
        eSpirit=EffectSpellFailure(100);
        AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(eSpirit),oPC));
        eSpirit=EffectMissChance(100);
        AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(eSpirit),oPC));
        eSpirit=EffectTrueSeeing();
        AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(eSpirit),oPC));
        //eSpirit=EffectVisualEffect(VFX_DUR_GHOST_SMOKE_2);
        //AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(eSpirit),oPC));
        eSpirit=EffectCutsceneGhost();
        AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(eSpirit),oPC));
        eSpirit=EffectEthereal();
        AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(eSpirit),oPC));
        eSpirit=EffectInvisibility(INVISIBILITY_TYPE_IMPROVED);
        AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(eSpirit),oPC));
        eSpirit=EffectSkillIncrease(SKILL_MOVE_SILENTLY,100);
        AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(eSpirit),oPC));
        eSpirit=EffectSkillIncrease(SKILL_HIDE,100);
        AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(eSpirit),oPC));
        //eSpirit=EffectMovementSpeedIncrease(99);
        //AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(eSpirit),oPC));
        //eSpirit=EffectVisualEffect(VFX_DUR_GHOST_TRANSPARENT);
        //AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(eSpirit),oPC));
        object oSkin=GetSkin(oPC);
        SetLocalInt(oSkin, DATABASE_PC_DEATH_STATE, nSpirit);
        SetFactionByID(oPC,5);
    }
    else
    {
        //SetPlotFlag(oPC,FALSE);
        //ForceRest(oPC);
        object oSkin=GetSkin(oPC);
        SetLocalInt(oSkin, DATABASE_PC_DEATH_STATE, nWell);
        effect eSpirit=GetFirstEffect(oPC);
        while(GetIsEffectValid(eSpirit))
        {
            //if(GetEffectType(eSpirit)!=EFFECT_TYPE_AREA_OF_EFFECT)
            //{
                if(GetEffectCreator(eSpirit)==GetModule())
                {
                    DelayCommand(0.0,RemoveEffect(oPC,eSpirit));
                }
            //}
            eSpirit=GetNextEffect(oPC);
        }
        ApplyPersistentVisualEffects(oPC);
        DelayCommand(0.0,SetFactionByID(oPC,GetLocalInt(oSkin,DATABASE_PC_INNATE_FACTION)));
        if(!GetLocalInt(GetSkin(oPC),DATABASE_PC_DEATH_RESURRECTED))//&&!GetLocalInt(GetSkin(oPC),DATABASE_PC_DEATH_RAISED))
        {
            SetLocalInt(GetSkin(oPC),DATABASE_PC_DEATH_REPERCUSSION,TRUE);
            SetLocalInt(GetSkin(oPC),DATABASE_PC_REST_TIME_1,TimeStamp());
            SetLocalInt(GetSkin(oPC),DATABASE_PC_REST_TIME_2,TimeStamp());
            SetLocalInt(GetSkin(oPC),DATABASE_PC_REST_TIME_3,TimeStamp());
        }
        ExecuteScript("rl_pchide_set",oPC);
        if(!GetLocalInt(GetSkin(oPC),DATABASE_PC_DEATH_RESURRECTED))
        {
            //Added a short delay to prevent death repercurssions constitution drain from killing the character upon raise.
            DelayCommand(3.0,SetHitPoints(GetHitDice(oPC),oPC));
        }
        DeleteLocalInt(GetSkin(oPC),DATABASE_PC_DEATH_RESURRECTED);
        DeleteLocalInt(GetSkin(oPC),DATABASE_PC_DEATH_RAISED);
        DeleteLocalInt(GetSkin(oPC),DATABASE_PC_DEATH_IRREVOCABLE_WOUND);
        DeleteLocalInt(GetSkin(oPC),DATABASE_PC_DEATH_BURNED_CORPSE);
        SendMessageToPC(oPC,"((You have returned to life. Please know that all information you've learned while being in the after-life or as a ghost form may not be considered known by your character in his/her living state.))");
    }
}

location getDeathSpawnPoint(int nHD){
    int nNumber=Random(3);
    if(nHD<1)
    {
        nHD=1;
    }
    else if(nHD>nNumberOfNELevels)
    {
        nHD=nNumberOfNELevels;
    }
    /*int nHD = GetHitDice(oPC);
    if(nHD <= 5){
        nHD = 0;
        nNumber = Random(nNumberOfDeadWPLow);
    }
    else if(nHD <= 10){
        nHD = 1;
        nNumber = Random(nNumberOfDeadWPMid);
    }
    else{
        nHD = 2;
        nNumber = Random(nNumberOfDeadWPHigh);
    }*/
    //debug code. Comment the following statement to exit debug mode :).
    //return GetLocation(GetObjectByTag(sDeadWP));         (ed: doh! you could have told me that when you gave me the scripts!)
    return GetLocation(GetCachedWaypointByTag(sDeadWP+IntToString(nHD)+"_"+IntToString(nNumber)));
}

//raises a dead person or corpse. Returns ressurected object if the person could be ressurected,
//else returns OBJECT_INVALID. If nHitPoints=-1 then the target is raised to full health.
object raise(object oCorpse, object oCaster, int bFullHealth=FALSE){
    //if the caster tries to ressurect something that isn't an object.
    if(!GetIsObjectValid(oCorpse)){
        SendMessageToPC(oCaster, sNotACorpse);
        return OBJECT_INVALID;
    }
    //If the player hasn't moved to the plane of death yet or if an NPC is the target of the spell.
    if(GetIsDead(oCorpse)&&GetObjectType(oCorpse)==OBJECT_TYPE_CREATURE){
        if(GetCurrentHitPoints(oCorpse) > -10){
            SendMessageToPC(oCaster, sNotACorpse);
            return OBJECT_INVALID;
        }
        SignalEvent(oCorpse, EventSpellCastAt(OBJECT_SELF, SPELL_RESURRECTION, FALSE));
        SetLocalInt(oCorpse, DATABASE_PC_DEATH_STATE, nWell);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), oCorpse);
        return oCorpse;
    }
    //Commented out to prevent raising ghosts.
    /*if(GetObjectType(oCorpse)==OBJECT_TYPE_CREATURE&&GetDeathState(oCorpse)==nSpirit)
    {
        int nID=GetID(oCorpse);
        oCorpse=GetLocalObject(GetCacheObjectPlayer(),MODULE_PLAYER_CORPSE+IntToString(nID));
    }*/

    //the following lines finds the character who should be the target of the spell. (ugly brute force algorithm :)

    //the case where sombody tries to ressurect something that isn't a corpse.
    if(GetLocalString(oCorpse, CORPSE_PLAYER_NAME) == ""){
        SendMessageToPC(oCaster, sNotACorpse);
        return OBJECT_INVALID;
    }
    //ed: Following removed and replaced with -hopefully- more efficient code.
    //
    //The case where somebody tries to ressurect somebody they are carrying arround.
    /*object oItem = GetFirstItemInInventory(oCaster);
    while(oItem != OBJECT_INVALID && oItem != oCorpse){
        oItem = GetNextItemInInventory(oCaster);
    }
    if(oItem == oCorpse){*/
    //
    if(GetItemPossessor(oCorpse)!=OBJECT_INVALID)
    {
        SendMessageToPC(oCaster, sCorpseInInventory);
        return OBJECT_INVALID;
    }
    int nDone = FALSE;
    location lLocation = GetLocation(oCorpse);
    object oPC=GetLocalObject(GetCacheObjectPlayer(),MODULE_PLAYER+IntToString(GetLocalInt(oCorpse,CORPSE_PLAYER_ID)));
    //if the person could not be found return, and stop doing stuff. (sorry)
    if(oPC == OBJECT_INVALID){
        return OBJECT_INVALID;
    }
    //else ressurect the person.
    //replace the corpse with the person.
    //DestroyObject(oCorpse);
    SignalEvent(oPC, EventSpellCastAt(OBJECT_SELF, SPELL_RESURRECTION, FALSE));
    //AssignCommand(oPC, JumpToLocation(lLocation));
    //object oSkin=GetSkin(oPC);
    //SetLocalInt(oSkin, DATABASE_PC_DEATH_STATE, nWell);
    //PCDataWriteInt(oPC,0,DATABASE_PC_IS_DEAD);
    if(bFullHealth)
    {
        SetLocalInt(GetSkin(oPC),DATABASE_PC_DEATH_RESURRECTED,TRUE);
    }
    else
    {
        SetLocalInt(GetSkin(oPC),DATABASE_PC_DEATH_RAISED,TRUE);
    }
    AssignCommand(oPC,ClearAllActions());
    AssignCommand(oPC,JumpToLocation(lLocation));

    //MakeCorporeal(oPC,oCorpse);
    return oPC;
}

void DropCorpses(object oPC)
{
   //drop corpses
    object oItem = GetFirstItemInInventory(oPC);
    location lLoc=GetLocation(oPC);
    if(!GetIsLocationValid(lLoc))
    {
        lLoc=PCRestoreLocation(oPC);
    }
    while(oItem != OBJECT_INVALID){
        if(GetTag(oItem) == sCorpseTag){

            object oTemp=CopyObject(oItem,lLoc);
            SetLocalString(oTemp,CORPSE_PLAYER_NAME,GetLocalString(oItem,CORPSE_PLAYER_NAME));
            SetLocalInt(oTemp,CORPSE_PLAYER_ID,GetLocalInt(oItem,CORPSE_PLAYER_ID));
            SetLocalObject(GetCacheObjectPlayer(),MODULE_PLAYER_CORPSE+IntToString(GetLocalInt(oItem,CORPSE_PLAYER_ID)),oTemp);
           //CopyItem(oItem, OBJECT_INVALID, TRUE); ed: Inserting OBJECT_INVALD will not make it appear on ground if the copied objects location is the inventory. Using CopyObject instead
            SetPlotFlag(oItem,FALSE);
            DelayCommand(0.0,DestroyObject(oItem));
            //Precaution. I don't know how data is handled by bioware, so I restart the search.(ed: you can delay the command to ensure it isn't executed before end of script)
            //oItem = GetFirstItemInInventory(oPC);
        }
        oItem = GetNextItemInInventory(oPC);
    }
}

void MakeCorporeal(object oPC, object oCorpse)
{
    //object oContent=GetFirstItemInInventory(oCorpse);
    //int nInventorySlot;
    //int nContentType;
    //int nRingAmount=0;
    location lTarget=GetLocation(oCorpse);
    //AssignCommand(oPC,ClearAllActions(TRUE));
    object oSkin=GetSkin(oPC);
    SetLocalInt(oSkin, DATABASE_PC_DEATH_STATE, nWell);
    AssignCommand(oPC,JumpToLocation(lTarget));
    /*while(oContent!=OBJECT_INVALID)
    {
        nContentType=GetBaseItemType(oContent);
        switch(nContentType)
        {
            case BASE_ITEM_RING:
            if(nRingAmount==0)
            {
                nInventorySlot=INVENTORY_SLOT_RIGHTRING;
                nRingAmount++;
            }
            else
            {
                nInventorySlot=INVENTORY_SLOT_LEFTRING;
            }
            break;
            case BASE_ITEM_AMULET:
            nInventorySlot=INVENTORY_SLOT_NECK;
            break;
            case BASE_ITEM_ARMOR:
            nInventorySlot=INVENTORY_SLOT_CHEST;
            break;
            case BASE_ITEM_ARROW:
            nInventorySlot=INVENTORY_SLOT_ARROWS;
            break;
            case BASE_ITEM_BELT:
            nInventorySlot=INVENTORY_SLOT_BELT;
            break;
            case BASE_ITEM_BOLT:
            nInventorySlot=INVENTORY_SLOT_BOLTS;
            break;
            case BASE_ITEM_BOOTS:
            nInventorySlot=INVENTORY_SLOT_BOOTS;
            break;
            case BASE_ITEM_BRACER:
            nInventorySlot=INVENTORY_SLOT_ARMS;
            break;
            case BASE_ITEM_BULLET:
            nInventorySlot=INVENTORY_SLOT_BULLETS;
            break;
            case BASE_ITEM_CLOAK:
            nInventorySlot=INVENTORY_SLOT_CLOAK;
            break;
            case BASE_ITEM_GLOVES:
            nInventorySlot=INVENTORY_SLOT_ARMS;
            break;
            case BASE_ITEM_HELMET:
            nInventorySlot=INVENTORY_SLOT_HEAD;
            break;
            default:
            nInventorySlot=-1;
            break;
        }
        AssignCommand(oPC,ActionTakeItem(oContent,oCorpse));
        AssignCommand(oPC,ActionEquipItem(oContent,nInventorySlot));
        oContent=GetNextItemInInventory(oCorpse);
    }*/
    SetPlotFlag(oCorpse,FALSE);
    AssignCommand(oPC,ActionDoCommand(DestroyObject(oCorpse)));
    AssignCommand(oPC,ActionDoCommand(DeleteLocalObject(GetModule(),MODULE_PLAYER_CORPSE+GetDeity(oPC))));
    AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK,0.75,3.0));

    //AssignCommand(oPC,ActionDoCommand(SetCommandable(TRUE,oPC)));
    //SetCommandable(FALSE,oPC);
}


object MakeCorpse(object oPC, location lSiteOfDeath)
{
    object oCorpse = OBJECT_INVALID;
    string sCorpseTemplate=sCorpseBluePrint;
    string sGender="Male";
    if(GetGender(oPC)==GENDER_FEMALE)
    {
        sCorpseTemplate=sCorpseBluePrintFemale;
        sGender="Female";
    }
    string sRace=GetRacialTypeName(oPC);
    if(GetLocalInt(GetSkin(oPC),DATABASE_PC_DEATH_BURNED_CORPSE))
    {
        sCorpseTemplate=sCorpseBluePrintRemains;
        oCorpse=CreateObject(OBJECT_TYPE_ITEM, sCorpseTemplate, lSiteOfDeath, FALSE, sCorpseTag);
        SetName(oCorpse,"Remains of "+GetName(oPC)+", "+sRace+" "+sGender);
        SetLocalString(oCorpse, CORPSE_PLAYER_NAME, GetName(oPC));
        SetLocalInt(oCorpse, CORPSE_PLAYER_ID, StringToInt(GetDeity(oPC)));
        SetLocalObject(GetCacheObjectPlayer(),MODULE_PLAYER_CORPSE+GetDeity(oPC),oCorpse);
        return oCorpse;
    }

    oCorpse=CreateObject(OBJECT_TYPE_ITEM, sCorpseTemplate, lSiteOfDeath, FALSE, sCorpseTag);
    SetName(oCorpse,"Corpse of "+GetName(oPC)+", "+sRace+" "+sGender);
    SetLocalString(oCorpse, CORPSE_PLAYER_NAME, GetName(oPC));
    SetLocalInt(oCorpse, CORPSE_PLAYER_ID, StringToInt(GetDeity(oPC)));
    SetLocalObject(GetCacheObjectPlayer(),MODULE_PLAYER_CORPSE+GetDeity(oPC),oCorpse);
    switch(GetRacialType(oPC))
    {
        case RACIAL_TYPE_DWARF:
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyWeightIncrease(IP_CONST_WEIGHTINCREASE_50_LBS), oCorpse);
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyWeightIncrease(IP_CONST_WEIGHTINCREASE_30_LBS), oCorpse);
        break;
        case RACIAL_TYPE_ELF:
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyWeightIncrease(IP_CONST_WEIGHTINCREASE_50_LBS), oCorpse);
        break;
        case RACIAL_TYPE_GNOME:
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyWeightIncrease(IP_CONST_WEIGHTINCREASE_30_LBS), oCorpse);
        break;
        case RACIAL_TYPE_HALFELF:
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyWeightIncrease(IP_CONST_WEIGHTINCREASE_50_LBS), oCorpse);
        break;
        case RACIAL_TYPE_HALFLING:
        break;
        case RACIAL_TYPE_HALFORC:
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyWeightIncrease(IP_CONST_WEIGHTINCREASE_100_LBS), oCorpse);
        break;
        case RACIAL_TYPE_HUMAN:
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyWeightIncrease(IP_CONST_WEIGHTINCREASE_50_LBS), oCorpse);
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyWeightIncrease(IP_CONST_WEIGHTINCREASE_30_LBS), oCorpse);
        break;
        default:
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyWeightIncrease(IP_CONST_WEIGHTINCREASE_50_LBS), oCorpse);
            AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyWeightIncrease(IP_CONST_WEIGHTINCREASE_30_LBS), oCorpse);
        break;
    }

    return oCorpse;
}

void MakeCorpseVoid(object oPC, location lSiteOfDeath)
{
    MakeCorpse(oPC, lSiteOfDeath);
}


object MakeCoffin(object oPC, location lCoffinLocation)
{
    object oModule=GetModule();

    object oSkin= GetSkin(oPC);
    object oCoffin = CreateObject(OBJECT_TYPE_PLACEABLE, PC_VAMPIRE_COFFIN_BLUEPRINT, lCoffinLocation, FALSE);
    object oCache=GetCacheObjectPlayer();
    if(GetIsObjectValid(oCoffin))
    {
        object oOldCoffin=GetLocalObject(oCache, PC_VAMPIRE_COFFIN+GetDeity(oPC));
        if(GetIsObjectValid(oOldCoffin))
        {
            DestroyObject(oOldCoffin);
        }
        SetLocalInt(oSkin, DATABASE_PC_VAMPIRE_COFFIN_VALID, 1);
        SetName(oCoffin, GetName(oPC)+"'s Coffin");
        SetLocalInt(oCoffin, PC_VAMPIRE_COFFIN_OWNER_ID, StringToInt(GetDeity(oPC)));
        vector vCoffinPosition = GetPosition(oCoffin);
        SendMessageToPC(oPC, "As you sprinkle the dirt inside the hastily set coffin, you feel a part of yourself is now bound with it. Upon death, you will have to make your way to your coffin to regain your form.");
        //Set location with individual variables instead of the Location
        SetLocalFloat(oSkin, DATABASE_PC_VAMPIRE_COFFIN_LOCATION_X,  vCoffinPosition.x);
        SetLocalFloat(oSkin, DATABASE_PC_VAMPIRE_COFFIN_LOCATION_Y,  vCoffinPosition.y);
        SetLocalFloat(oSkin, DATABASE_PC_VAMPIRE_COFFIN_LOCATION_Z,  vCoffinPosition.z);
        SetLocalFloat(oSkin, DATABASE_PC_VAMPIRE_COFFIN_LOCATION_FACING, GetFacing(oCoffin));
        SetLocalString(oSkin, DATABASE_PC_VAMPIRE_COFFIN_LOCATION_AREA, GetTag(GetArea(oCoffin)));
        SetCachedVersionDatabaseInt(DATABASE_VAMPIRE_COFFINS, GetDeity(oPC)+DATABASE_VAMPIRE_COFFIN_STATE, DATABASE_VAMPIRE_COFFIN_STATE_INTACT);
        SetLocalObject(oCache,PC_VAMPIRE_COFFIN+GetDeity(oPC), oCoffin);
    }
    return oCoffin;
}


void MakeCoffinVoid(object oPC, location lCoffinLocation)
{
    MakeCoffin(oPC, lCoffinLocation);
}


