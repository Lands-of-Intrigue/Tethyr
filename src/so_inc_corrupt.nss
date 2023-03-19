#include "so_inc_constants"
#include "so_inc_general"
//Corruption Stage One


string GiftToString(int nGift)
{
    switch(nGift)
    {
        case CORRUPTION_GIFT_OF_AGILITY:
        {
            return "Gift of Agility";
        }
        break;
        case CORRUPTION_GIFT_OF_THE_BEAST:
        {
            return "Gift of the Beast";
        }
        break;
        case CORRUPTION_GIFT_OF_THE_MIND:
        {
            return "Gift of the Mind";
        }
        break;
        case CORRUPTION_GIFT_OF_THE_UNNATURAL:
        {
            return "Gift of the Unnatural";
        }
        break;
        case CORRUPTION_GIFT_OF_THE_MANIPULATOR:
        {
            return "Gift of the Manipulator";
        }
        break;
        case CORRUPTION_GIFT_OF_THE_SEER:
        {
            return "Gift of the Seer";
        }
        break;
        case CORRUPTION_GIFT_OF_THE_MIST:
        {
            return "Gift of the Mist";
        }
        break;
        case CORRUPTION_GIFT_OF_DARKNESS:
        {
            return "Gift of Darkness";
        }
        break;
    }
    return "None";
}

string CurseToString(int nCurse)
{
    switch(nCurse)
    {
        case CORRUPTION_CURSE_OF_ANXIETY:
        {
            return "Curse of Anxiety";
        }
        break;
        case CORRUPTION_CURSE_OF_MISFORTUNE:
        {
            return "Curse of Misfortune";
        }
        break;
        case CORRUPTION_CURSE_OF_DELUSION:
        {
            return "Curse of Delusion";
        }
        break;
        case CORRUPTION_CURSE_OF_ENFEEBLEMENT:
        {
            return "Curse of Enfeeblement";
        }
        break;
        case CORRUPTION_CURSE_OF_MALADROIT:
        {
            return "Curse of Maladroit";
        }
        break;
        case CORRUPTION_CURSE_OF_DECREPITUDE:
        {
            return "Curse of Decrepitude";
        }
        break;
        case CORRUPTION_CURSE_OF_OBLIVIOUSNESS:
        {
            return "Curse of Obliviousness";
        }
        break;
        case CORRUPTION_CURSE_OF_REPUGNANCE:
        {
            return "Curse of Repugnance";
        }
        break;
    }
    return "None";
}

void SetCorruptionGift(object oPC, int nGiftSlot, int nGift)
{
    object oSkin=GetSkin(oPC);
    switch(nGiftSlot)
    {
        case 1:
        {
            SetLocalInt(oSkin,DATABASE_PC_CORRUPTION_GIFT_1,nGift);
        }
        break;
        case 2:
        {
            SetLocalInt(oSkin,DATABASE_PC_CORRUPTION_GIFT_2,nGift);
        }
        break;
    }
}

void SetCorruptionCurse(object oPC, int nCurseSlot, int nCurse)
{
    object oSkin=GetSkin(oPC);
    switch(nCurseSlot)
    {
        case 1:
        {
            SetLocalInt(oSkin,DATABASE_PC_CORRUPTION_CURSE_1,nCurse);
        }
        break;
        case 2:
        {
            SetLocalInt(oSkin,DATABASE_PC_CORRUPTION_CURSE_2,nCurse);
        }
        break;
    }
}

int GetCorruptionGift(object oPC, int nGiftSlot)
{
    object oSkin=GetSkin(oPC);
    switch(nGiftSlot)
    {
        case 1:
        {
            return GetLocalInt(oSkin,DATABASE_PC_CORRUPTION_GIFT_1);
        }
        break;
        case 2:
        {
            return GetLocalInt(oSkin,DATABASE_PC_CORRUPTION_GIFT_2);
        }
        break;
    }
    return 0;
}

int GetCorruptionCurse(object oPC, int nCurseSlot)
{
    object oSkin=GetSkin(oPC);
    switch(nCurseSlot)
    {
        case 1:
        {
            return GetLocalInt(oSkin,DATABASE_PC_CORRUPTION_CURSE_1);
        }
        break;
        case 2:
        {
            return GetLocalInt(oSkin,DATABASE_PC_CORRUPTION_CURSE_2);
        }
        break;
    }
    return 0;
}


void SetCorruptionStage(object oPC, int nStage)
{
    object oSkin=GetSkin(oPC);
    SetLocalInt(oSkin,DATABASE_PC_CORRUPTION_STAGE,nStage);
}

int GetCorruptionStage(object oPC)
{
    object oSkin=GetSkin(oPC);
    return GetLocalInt(oSkin,DATABASE_PC_CORRUPTION_STAGE);
}

void SetupCorruptionConversation(object oPC)
{
    SetCustomToken(CUSTOM_TOKEN_DM_TOOL_CORRUPTION_SETUP_TARGET_NAME,GetName(oPC));
    SetCustomToken(CUSTOM_TOKEN_DM_TOOL_CORRUPTION_SETUP_TARGET_STAGE,IntToString(GetCorruptionStage(oPC)));
    SetCustomToken(CUSTOM_TOKEN_DM_TOOL_CORRUPTION_SETUP_TARGET_GIFT_1,GiftToString(GetCorruptionGift(oPC,1)));
    SetCustomToken(CUSTOM_TOKEN_DM_TOOL_CORRUPTION_SETUP_TARGET_GIFT_2,GiftToString(GetCorruptionGift(oPC,2)));
    SetCustomToken(CUSTOM_TOKEN_DM_TOOL_CORRUPTION_SETUP_TARGET_CURSE_1,CurseToString(GetCorruptionCurse(oPC,1)));
    SetCustomToken(CUSTOM_TOKEN_DM_TOOL_CORRUPTION_SETUP_TARGET_CURSE_2,CurseToString(GetCorruptionCurse(oPC,2)));
}



/*itemproperty GetGiftIP(int nStage, int nGift)
{
    if(nStage==1)
    {
        switch(nGift)
        {
            case 1:
        }
    }
}*/


/*
EffectAbilityIncrease

EffectACIncrease

EffectConcealment

EffectDamageReduction

EffectHaste

EffectImmunity

EffectMovementSpeedIncrease

EffectRegenerate

EffectSavingThrowIncrease

EffectSeeInvisible

EffectSkillIncrease

EffectSpellResistanceIncrease

EffectTrueSeeing

EffectUltravision




EffectAbilityDecrease

EffectACDecrease

EffectAreaOfEffect

EffectAttackDecrease

EffectBlindness

EffectDamageDecrease

EffectDamageImmunityDecrease

EffectDeaf

EffectMissChance

EffectMovementSpeedDecrease

EffectSavingThrowDecrease

EffectSilence

EffectSkillDecrease

EffectSlow

EffectSpellFailure

EffectSpellResistanceDecrease





Gift of agility:

ItemPropertyFreeAction

ItemPropertyHaste

ItemPropertyImprovedEvasion

ItemPropertySpellImmunitySpecific
IP_CONST_IMMUNITYSPELL_WEB
IP_CONST_IMMUNITYSPELL_SLOW

ItemPropertyBonusFeat

IP_CONST_FEAT_DODGE
IP_CONST_FEAT_MOBILITY
IP_CONST_FEAT_WHIRLWIND

ItemPropertyBonusSavingThrow

ItemPropertyImmunityMisc
IP_CONST_IMMUNITYMISC_KNOCKDOWN



Gift of Mind:

ItemPropertyBonusSavingThrow

ItemPropertyBonusSpellResistance

ItemPropertyImmunityMisc
IP_CONST_IMMUNITYMISC_FEAR
IP_CONST_IMMUNITYMISC_MINDSPELLS

ItemPropertyBonusSavingThrow

ItemPropertyBonusFeat
IP_CONST_FEAT_COMBAT_CASTING




Gift of the Unnatrual:

ItemPropertyImmunityMisc
IP_CONST_IMMUNITYMISC_CRITICAL_HITS
IP_CONST_IMMUNITYMISC_BACKSTAB
IP_CONST_IMMUNITYMISC_POISON
IP_CONST_IMMUNITYMISC_DISEASE

ItemPropertyBonusSavingThrow

ItemPropertyRegeneration





Gift of the Beast:

ItemPropertyBonusFeat
IP_CONST_FEAT_CLEAVE
IP_CONST_FEAT_POWERATTACK
IP_CONST_FEAT_WEAPSPEUNARM
IP_CONST_FEAT_IMPCRITUNARM

ItemPropertyDamageReduction

ItemPropertyACBonus





Gift of the Manipulator:

ItemPropertySpellImmunitySpecific
IP_CONST_IMMUNITYSPELL_CHARM_MONSTER
IP_CONST_IMMUNITYSPELL_CHARM_PERSON
IP_CONST_IMMUNITYSPELL_CHARM_PERSON_OR_ANIMAL
IP_CONST_IMMUNITYSPELL_DOMINATE_ANIMAL
IP_CONST_IMMUNITYSPELL_DOMINATE_MONSTER
IP_CONST_IMMUNITYSPELL_DOMINATE_PERSON
IP_CONST_IMMUNITYSPELL_SILENCE

Gift of the Seer:

ItemPropertyDarkvision

ItemPropertyTrueSeeing

ItemPropertyImmunityMisc
IP_CONST_IMMUNITYMISC_BACKSTAB



Gift of Darkness:

ItemPropertyImmunityMisc
IP_CONST_IMMUNITYMISC_DEATH_MAGIC
IP_CONST_IMMUNITYMISC_LEVEL_ABIL_DRAIN

ItemPropertyDamageImmunity

ItemPropertySpellImmunitySpecific
IP_CONST_IMMUNITYSPELL_BESTOW_CURSE

ItemPropertySpellImmunitySchool
IP_CONST_SPELLSCHOOL_NECROMANCY









ItemPropertyImmunityMisc
IP_CONST_IMMUNITYMISC_BACKSTAB
IP_CONST_IMMUNITYMISC_CRITICAL_HITS
IP_CONST_IMMUNITYMISC_DEATH_MAGIC
IP_CONST_IMMUNITYMISC_DISEASE
IP_CONST_IMMUNITYMISC_FEAR
IP_CONST_IMMUNITYMISC_LEVEL_ABIL_DRAIN
IP_CONST_IMMUNITYMISC_KNOCKDOWN
IP_CONST_IMMUNITYMISC_MINDSPELLS
IP_CONST_IMMUNITYMISC_PARALYSIS
IP_CONST_IMMUNITYMISC_POISON






ItemPropertyAbilityBonus

ItemPropertyACBonus

ItemPropertyArcaneSpellFailure

ItemPropertyBonusFeat

ItemPropertyBonusSavingThrow

ItemPropertyBonusSpellResistance

ItemPropertyDamageBonus

ItemPropertyDamageImmunity

ItemPropertyDamageReduction

ItemPropertyDamageResistance

ItemPropertyDamageVulnerability

ItemPropertyDamageVulnerability

ItemPropertyDarkvision

ItemPropertyDecreaseAbility

ItemPropertyDecreaseAC

ItemPropertyDecreaseSkill

ItemPropertyFreeAction

ItemPropertyHaste

ItemPropertyImmunityMisc

ItemPropertyImmunityToSpellLevel

ItemPropertyImprovedEvasion

ItemPropertyLight

ItemPropertyReducedSavingThrow

ItemPropertyReducedSavingThrowVsX

ItemPropertyRegeneration

ItemPropertySkillBonus

ItemPropertySpellImmunitySpecific
IP_CONST_IMMUNITYSPELL_WEB
IP_CONST_IMMUNITYSPELL_SLOW


ItemPropertySpellImmunitySchool

ItemPropertyTrueSeeing

Curses:

Curse of anxiety:

-4 Concentration.

-4 Bluff

-4 Intimidate

-4 Taunt

5% Arcane Spell Failure.



Curse of misfortune:

-1 to all saves

-1 to Attack Bonus



Curse of Deception:

-1 Wisdom

-4 Spot

-4 Listen

-4 Search



Curse of the Jaded:

-1 Strength

-4 Discipline

-1 Will save.


Curse of Clumbsyness:

-1 Dex

-4 Tumble

-1 Reflex


Curse of Sickness:

-1 Con

-1 Fortitude save.


Curse of Forgetting:

-1 Int

-4 Spellcraft

-4 Lore


Curse of the Appaling:

-1 Charisma

-4 Persuade






ItemPropertyArcaneSpellFailure

ItemPropertyAttackPenalty

ItemPropertyDamagePenalty

ItemPropertyDamageVulnerability

ItemPropertyDecreaseAbility

ItemPropertyDecreaseSkill

ItemPropertyReducedSavingThrow

ItemPropertyReducedSavingThrowVsX



