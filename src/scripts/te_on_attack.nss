#include "te_functions"
#include "nwnx_damage"
#include "x2_inc_itemprop"
#include "x0_i0_match"
#include "loi_functions"
#include "nwnx_time"
int GetMaterialACBonus(object oItem);

//1 = Tiny, 2 = Small, 3 = Medium, 4 = Large
int GetWeaponSize(object oItem);

//1 = Piercing, 2 = Bludge, 3 = Slash; 4 = Pierce/Slash, 5 = Bludge/Slash
int GetBaseDamageType(object oItem);

void main()
{
    struct NWNX_Damage_AttackEventData data;

    //Get all the data of the damage event
    data = NWNX_Damage_GetAttackEventData();

    object oTarget = data.oTarget;
    object oAttacker = OBJECT_SELF;
    int iBludgeoning = data.iBludgeoning;
    int iPierce = data.iPierce;
    int iSlash = data.iSlash;
    int iMagical = data.iMagical;
    int iAcid = data.iAcid;
    int iCold = data.iCold;
    int iDivine = data.iDivine;
    int iElectrical = data.iElectrical;
    int iFire = data.iFire;
    int iNegative = data.iNegative;
    int iPositive = data.iPositive;
    int iSonic = data.iSonic;
    int iBase = data.iBase;

    // 1-based index of the attack in current combat round
    int iAttackNumber = data.iAttackNumber;

    // 1=hit, 3=critical hit, 4=miss, 8=concealed
    int iAttackResult = data.iAttackResult;

    // 1=main hand, 2=offhand, 3-5=creature, 6=haste
    int iAttackType = data.iAttackType;

    // 0=neither, 1=sneak attack, 2=death attack, 3=both
    int iSneakAttack = data.iSneakAttack;

    //Attacker Data for On-Attack Spells!
    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oAttacker);
    int    iWeapon = GetIsObjectValid(oWeapon);

    object oGloves = GetItemInSlot(INVENTORY_SLOT_ARMS,oAttacker);
    int    iGloves = GetIsObjectValid(oGloves);

    if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
    {
        if(iWeapon == FALSE && iGloves == FALSE)
        {
            if(GetItemPossessedBy(oAttacker,"te_item_8043") != OBJECT_INVALID)
            {
                if(GetIsUndead(oTarget) != TRUE && GetRacialType(oTarget) != RACIAL_TYPE_OUTSIDER            &&
                                                   GetRacialType(oTarget) != RACIAL_TYPE_CONSTRUCT           &&
                                                   GetRacialType(oTarget) != RACIAL_TYPE_ELEMENTAL           &&
                                                   GetRacialType(oTarget) != RACIAL_TYPE_HUMANOID_GOBLINOID  &&
                                                   GetRacialType(oTarget) != RACIAL_TYPE_HUMANOID_MONSTROUS  &&
                                                   GetRacialType(oTarget) != RACIAL_TYPE_HUMANOID_REPTILIAN  &&
                                                   GetRacialType(oTarget) != RACIAL_TYPE_OOZE)
                {
                    if(GetLocalInt(oAttacker,"nSlamTime") < NWNX_Time_GetTimeStamp())
                    {
                        SetLocalInt(oAttacker,"nSlamTime",NWNX_Time_GetTimeStamp()+6);
                        if(iAttackResult == 1 || iAttackResult == 3)
                        {
                            int nVampSave = 10+ (GetHitDice(oAttacker)/2) + GetAbilityModifier(ABILITY_CHARISMA,oAttacker);
                            if(FortitudeSave(oTarget,nVampSave,SAVING_THROW_TYPE_NEGATIVE,oAttacker) == 0)
                            {
                                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectTemporaryHitpoints(10),oAttacker,TurnsToSeconds(6));
                                ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectNegativeLevel(2),oTarget);
                                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY), oTarget);
                                SendMessageToPC(oAttacker,"You feel the energy draining from your victim.");
                                SendMessageToPC(oTarget,"You feel your energy being drained.");
                                if(GetIsPC(oTarget) == TRUE && GetLocalInt(GetItemPossessedBy(oTarget,"PC_Data_Object"),"ShoonAfflic") == 0 && GetPCAffliction(oTarget) != 2)
                                {
                                    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_EVIL_HELP),oTarget);
                                    SetLocalInt(GetItemPossessedBy(oTarget,"PC_Data_Object"),"ShoonAfflic",3);
                                    AddJournalQuestEntry("te_shoondisease",1,oTarget);
                                    SendMessageToPC(oTarget,"You feel a darkness worm its way into you...");
                                }
                            }
                        }
                    }
                }
            }
        }

        if(iWeapon == FALSE)
        {

        }

        if(iAttackResult == 3 && GetLocalInt(oAttacker,"SUBDUAL") == 0)
        {
            //Base
            int nRoll = d12(1);
            nRoll = nRoll + GetBaseAttackBonus(oAttacker)/2;

            //oTarget Armors
            int    nAC     = 0;
            object oArmor  = GetItemInSlot(INVENTORY_SLOT_CHEST,oTarget);
            int    iArmor  = GetIsObjectValid(oArmor);

            if(iArmor == TRUE)
            {
                nAC = nAC + GetItemACValue(oArmor)+GetMaterialACBonus(oArmor);
            }

            object oBrace  = GetItemInSlot(INVENTORY_SLOT_ARMS,oTarget);
            int    iBrace  = GetIsObjectValid(oBrace);
            if(iBrace == TRUE)
            {
                nAC = nAC + 1+GetMaterialACBonus(oBrace);
            }

            object oShield = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oTarget);
            int    iShield = GetIsObjectValid(oShield);
            if(iShield == TRUE)
            {
                nAC = nAC + GetItemACValue(oShield)+GetMaterialACBonus(oShield);
            }

            object oHelmet = GetItemInSlot(INVENTORY_SLOT_HEAD,oTarget);
            int    iHelmet = GetIsObjectValid(oHelmet);
            if(iHelmet == TRUE)
            {
                nAC = nAC + 1+GetMaterialACBonus(oHelmet);
            }

            int nAttackSlot;

            //Main Hand Attack
            object oWeapon;
            int nSize;
            int nDamageType;
            int nMaterial;

            if(iAttackType == 1)
            {
                oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oAttacker);
                nMaterial = GetMaterialACBonus(oWeapon);
                nSize = GetWeaponSize(oWeapon);
                nDamageType = GetBaseDamageType(oWeapon);
            }
            else if(iAttackType == 2)
            {
                oWeapon = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oAttacker);
                nMaterial = GetMaterialACBonus(oWeapon);
                nSize = GetWeaponSize(oWeapon);
                nDamageType = GetBaseDamageType(oWeapon);
            }
            else
            {
                nSize = 3;
                nDamageType = 4;
                nMaterial = 0;
            }

            if(nSize == 1 || nSize == 2)
            {
                nRoll = nRoll + 2;
            }
            else if(nSize == 3)
            {
                nRoll = nRoll + 4;
            }
            else if(nSize == 4)
            {
                nRoll = nRoll + 6;
            }
            else
            {
                nRoll = nRoll + 2;
            }

            nRoll = nRoll + nMaterial;
            int nSeverity = nRoll - nAC;
            int nDeathSaveDC = (10+(GetHitDice(oAttacker)/2)+GetAbilityModifier(ABILITY_STRENGTH,oAttacker));
            int nDeathSave;

            if(GetHasFeat(1480,oAttacker) == TRUE)
            {
                nSeverity = nSeverity + 2;
                nDeathSaveDC = nDeathSaveDC + 2;
            }

            if(GetLocalInt(oWeapon,"nGun") == 1)
            {
                nSeverity = nSeverity+5;
            }

            if(GetLocalInt(oAttacker,"MonkStyle") == 1 || GetLocalInt(oAttacker,"MonkStyle") == 3 || GetLocalInt(oAttacker,"MonkStyle") == 4)
            {
                nSeverity = nSeverity +5;
            }

            if(GetLocalInt(oTarget,"MonkStyle") == 2)
            {
                nSeverity = nSeverity -5;
            }

            if(GetLocalInt(oAttacker,"MonkStyle") == 5)
            {
                nSeverity = nSeverity+3;
            }

            if(GetLocalInt(oTarget,"MonkStyle") == 5)
            {
                nSeverity = nSeverity-3;
            }

            if(GetRacialType(oTarget) == RACIAL_TYPE_DRAGON)
            {
                nSeverity = nSeverity - (GetHitDice(oTarget)/2);
            }

            if(GetLastAttackMode(oTarget) == COMBAT_MODE_PARRY)
            {
                int nParry1 = 2*GetSkillRank(SKILL_PARRY,oTarget,FALSE)/5;

                nSeverity = nSeverity-nParry1;
            }

            if(GetLastAttackMode(oTarget) == COMBAT_MODE_EXPERTISE)
            {
                nSeverity = nSeverity-5;
            }

            if(GetLastAttackMode(oTarget) == COMBAT_MODE_IMPROVED_EXPERTISE)
            {
                nSeverity = nSeverity-10;
            }
            //SendMessageToPC(oAttacker,"Debug: Severity Roll for Critical Hit "+IntToString(nSeverity)+" Roll+BAB/2: "+IntToString(nRoll));

            if(nSeverity <= 3)
            {
                SendMessageToPC(oAttacker,"Your critical hit only created normal shock damage.");
            }
            else if(nSeverity >= 4 && nSeverity <=8 && GetIsDead(oTarget) == FALSE)
            {
                nDeathSave = FortitudeSave(oTarget,nDeathSaveDC,SAVING_THROW_TYPE_DEATH,oAttacker);

                if(nDeathSave == 0)
                {
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectAttackDecrease(2,ATTACK_BONUS_MISC),oTarget);
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT,MagicalEffect(EffectSpellFailure(10,SPELL_SCHOOL_GENERAL)),oTarget);
                    SendMessageToPC(oAttacker,"You have grazed your target with your critical hit!");
                    SendMessageToPC(oTarget,"You have suffered a graze from a critical hit!");
                    //Piercing Table
                    if(nDamageType = 1)
                    {
                        switch (nSeverity)
                        {
                         case  4: {ApplyEffectToObject(DURATION_TYPE_PERMANENT,ExtraordinaryEffect(EffectMovementSpeedDecrease(25)),oTarget); break;}
                         case  5: {data.iBase = data.iBase + (data.iBase/10); break;}
                         case  6: {ApplyEffectToObject(DURATION_TYPE_PERMANENT,ExtraordinaryEffect(EffectMovementSpeedDecrease(25)),oTarget); break;}
                         case  7: {data.iBase = data.iBase + (data.iBase/10); break;}
                         case  8: {data.iBase = data.iBase + (data.iBase/10); break;}
                        }
                    }
                    //Bludgeoning Table
                    else if(nDamageType = 2)
                    {
                        switch (nSeverity)
                        {
                         case  4: {ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectStunned(),oTarget,6.0f); break;}
                         case  5: {ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectKnockdown(),oTarget,6.0f); break;}
                         case  6: {ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectStunned(),oTarget,6.0f); break;}
                         case  7: {ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectKnockdown(),oTarget,6.0f); break;}
                         case  8: {ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectStunned(),oTarget,6.0f); break;}
                        }
                    }
                    //Slashing Table
                    else if(nDamageType = 3)
                    {
                        switch (nSeverity)
                        {
                         case  4: {data.iBase = data.iBase + (data.iBase/10); break;}
                         case  5: {data.iBase = data.iBase + (data.iBase/10); break;}
                         case  6: {data.iBase = data.iBase + (data.iBase/10); break;}
                         case  7: {ApplyEffectToObject(DURATION_TYPE_PERMANENT,ExtraordinaryEffect(EffectMovementSpeedDecrease(25)),oTarget); break;}
                         case  8: {ApplyEffectToObject(DURATION_TYPE_PERMANENT,ExtraordinaryEffect(EffectMovementSpeedDecrease(25)),oTarget); break;}
                        }
                    }
                    //Combined Table
                    else
                    {
                        switch (nSeverity)
                        {
                         case  4: {data.iBase = data.iBase + (data.iBase/10); break;}
                         case  5: {ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectStunned(),oTarget,6.0f); break;}
                         case  6: {ApplyEffectToObject(DURATION_TYPE_PERMANENT,ExtraordinaryEffect(EffectMovementSpeedDecrease(25)),oTarget); break;}
                         case  7: {ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectStunned(),oTarget,6.0f); break;}
                         case  8: {ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectKnockdown(),oTarget,6.0f); break;}
                        }
                    }
                }

            }
            else if(nSeverity >= 9 && nSeverity <=13 && GetIsDead(oTarget) == FALSE)
            {
                nDeathSave = FortitudeSave(oTarget,(10+(GetHitDice(oAttacker)/2)+GetAbilityModifier(ABILITY_STRENGTH,oAttacker)),SAVING_THROW_TYPE_DEATH,oAttacker);
                if(nDeathSave == 0)
                {
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT,ExtraordinaryEffect(EffectAttackDecrease(4,ATTACK_BONUS_MISC)),oTarget);
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT,ExtraordinaryEffect(EffectSpellFailure(20,SPELL_SCHOOL_GENERAL)),oTarget);
                    SendMessageToPC(oAttacker,"You have landed a solid blow with your critical hit!");
                    SendMessageToPC(oTarget,"You have been struck soundly by a critical hit!");
                    //Piercing Table
                    if(nDamageType = 1)
                    {
                        switch (nSeverity)
                        {
                         case  9: {ApplyEffectToObject(DURATION_TYPE_PERMANENT,ExtraordinaryEffect(EffectMovementSpeedDecrease(50)),oTarget); break;}
                         case 10: {ApplyEffectToObject(DURATION_TYPE_PERMANENT,ExtraordinaryEffect(EffectMovementSpeedDecrease(50)),oTarget); break;}
                         case 11: {ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectStunned(),oTarget,6.0f); break;}
                         case 12: {data.iBase = data.iBase + (data.iBase/10); break;}
                         case 13: {data.iBase = data.iBase + (data.iBase/10); break;}
                        }
                    }
                    //Bludgeoning Table
                    else if(nDamageType = 2)
                    {
                        switch (nSeverity)
                        {
                         case  9: {ApplyEffectToObject(DURATION_TYPE_PERMANENT,ExtraordinaryEffect(EffectMovementSpeedDecrease(25)),oTarget); break;}
                         case 10: {ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectKnockdown(),oTarget,6.0f); break;}
                         case 11: {ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectStunned(),oTarget,RoundsToSeconds(d4(1))); break;}
                         case 12: {ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectKnockdown(),oTarget,6.0f); break;}
                         case 13: {ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectStunned(),oTarget,RoundsToSeconds(d4(1))); break;}
                        }
                    }
                    //Slashing Table
                    else if(nDamageType = 3)
                    {
                        switch (nSeverity)
                        {
                         case  9: {data.iBase = data.iBase + (data.iBase/10); break;}
                         case 10: {data.iBase = data.iBase + (data.iBase/10); break;}
                         case 11: {data.iBase = data.iBase + (data.iBase/10); break;}
                         case 12: {ApplyEffectToObject(DURATION_TYPE_PERMANENT,ExtraordinaryEffect(EffectMovementSpeedDecrease(50)),oTarget); break;}
                         case 13: {ApplyEffectToObject(DURATION_TYPE_PERMANENT,ExtraordinaryEffect(EffectMovementSpeedDecrease(50)),oTarget); break;}
                        }
                    }
                    //Combined Table
                    else
                    {
                        switch (nSeverity)
                        {
                         case  9: {data.iBase = data.iBase + (data.iBase/10); break;}
                         case 10: {ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectStunned(),oTarget,RoundsToSeconds(d4(1))); break;}
                         case 11: {ApplyEffectToObject(DURATION_TYPE_PERMANENT,ExtraordinaryEffect(EffectMovementSpeedDecrease(50)),oTarget); break;}
                         case 12: {ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectStunned(),oTarget,RoundsToSeconds(d4(1))); break;}
                         case 13: {ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectKnockdown(),oTarget,6.0f); break;}
                        }
                    }
                }
            }
            else if(nSeverity >= 14 && nSeverity <=18 && GetIsDead(oTarget) == FALSE)
            {
                nDeathSave = FortitudeSave(oTarget,(10+(GetHitDice(oAttacker)/2)+GetAbilityModifier(ABILITY_STRENGTH,oAttacker)),SAVING_THROW_TYPE_DEATH,oAttacker);
                if(nDeathSave == 0)
                {
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT,ExtraordinaryEffect(EffectAttackDecrease(6,ATTACK_BONUS_MISC)),oTarget);
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT,ExtraordinaryEffect(EffectSpellFailure(40,SPELL_SCHOOL_GENERAL)),oTarget);
                    SendMessageToPC(oTarget,"You have been injured by a critical hit!");
                    SendMessageToPC(oAttacker,"You have inflicted an injury with your critical hit!");
                    //Piercing Table
                    if(nDamageType = 1)
                    {
                        switch (nSeverity)
                        {
                         case 14: {ApplyEffectToObject(DURATION_TYPE_PERMANENT,ExtraordinaryEffect(EffectMovementSpeedDecrease(75)),oTarget); break;}
                         case 15: {ApplyEffectToObject(DURATION_TYPE_PERMANENT,ExtraordinaryEffect(EffectMovementSpeedDecrease(75)),oTarget); break;}
                         case 16: {ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectStunned(),oTarget,6.0f); break;}
                         case 17: {data.iBase = data.iBase + (data.iBase/2); break;}
                         case 18: {data.iBase = data.iBase + (data.iBase/2); break;}
                        }
                    }
                    //Bludgeoning Table
                    else if(nDamageType = 2)
                    {
                        switch (nSeverity)
                        {
                         case 14: {ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectStunned(),oTarget,RoundsToSeconds(d4(1))); break;}
                         case 15: {ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectKnockdown(),oTarget,6.0f); break;}
                         case 16: {ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectStunned(),oTarget,RoundsToSeconds(d4(1))); break;}
                         case 17: {ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectKnockdown(),oTarget,6.0f); break;}
                         case 18: {ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectStunned(),oTarget,RoundsToSeconds(d4(1))); break;}
                        }
                    }
                    //Slashing Table
                    else if(nDamageType = 3)
                    {
                        switch (nSeverity)
                        {
                         case 14: {data.iBase = data.iBase + (data.iBase/10); break;}
                         case 15: {data.iBase = data.iBase + (data.iBase/10); break;}
                         case 16: {data.iBase = data.iBase + (data.iBase/10); break;}
                         case 17: {data.iBase = data.iBase + (data.iBase/2); break;}
                         case 18: {data.iBase = data.iBase + (data.iBase/2); break;}
                        }
                    }
                    //Combined Table
                    else
                    {
                        switch (nSeverity)
                        {
                         case 14: {data.iBase = data.iBase + (data.iBase/10); break;}
                         case 15: {ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectStunned(),oTarget,RoundsToSeconds(d4(1))); break;}
                         case 16: {ApplyEffectToObject(DURATION_TYPE_PERMANENT,ExtraordinaryEffect(EffectMovementSpeedDecrease(75)),oTarget); break;}
                         case 17: {ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectStunned(),oTarget,RoundsToSeconds(d4(1))); break;}
                         case 18: {ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectKnockdown(),oTarget,6.0f); break;}
                        }
                    }
                }
            }
            else if(nSeverity >= 19 && GetIsDead(oTarget) == FALSE)
            {
                nDeathSave = FortitudeSave(oTarget,(10+(GetHitDice(oAttacker)/2)+GetAbilityModifier(ABILITY_STRENGTH,oAttacker)),SAVING_THROW_TYPE_DEATH,oAttacker);
                int nDeathMsg = d8(1);
                if(nDeathSave == 0 && GetIsDead(oTarget) != TRUE)
                {
                    if(GetIsPC(oTarget) == TRUE){CreatePCBody(oTarget,TRUE);}
                    SendMessageToPC(oAttacker,"You have inflicted a devastating critical with your critical hit! Fatality!");

                    if(nDeathMsg = 1)
                    {SendMessageToPC(oTarget,"Whoopsie! You've suffered from a critical hit. You are dead.");}
                    else if (nDeathMsg = 2)
                    {SendMessageToPC(oTarget,"Fatality! "+GetName(oAttacker)+" wins! You are dead.");}
                    else if (nDeathMsg = 3)
                    {SendMessageToPC(oTarget,"You have suffered critical damage to an unprotected area of your body. Without metal armor to protect against such an attack, you are unable to defend from this lethal blow. You are dead.");}
                    else if (nDeathMsg = 4)
                    {SendMessageToPC(oTarget,"You remember that one time a dwarf attempted to sell you Adamantine Armor. It might have helped to prevent the blow you just died from. You are dead.");}
                    else if (nDeathMsg = 5)
                    {SendMessageToPC(oTarget,"Bad End. You are dead.");}
                    else if (nDeathMsg = 6)
                    {SendMessageToPC(oTarget,"Your head is cleanly separated from your body and you are briefly treated to a new perspective on life. You are dead.");}
                    else if (nDeathMsg = 7)
                    {SendMessageToPC(oTarget,"Save versus death: Automatic Failure. You are dead.");}
                    else if (nDeathMsg = 8)
                    {SendMessageToPC(oTarget,"You reconsider your life choices as you unsuccessfully attempt to tuck your entrails back where they belong. You are dead.");}
                    DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(TRUE,TRUE),oTarget));
                }
            }
        }
        else if(iAttackResult == 3 && GetLocalInt(oAttacker,"SUBDUAL") == 1)
        {
            //Base
            int nRoll = d12(1);
            nRoll = nRoll + GetBaseAttackBonus(oAttacker)/2;

            //oTarget Armors
            int    nAC     = 0;
            object oArmor  = GetItemInSlot(INVENTORY_SLOT_CHEST,oTarget);
            int    iArmor  = GetIsObjectValid(oArmor);

            if(iArmor == TRUE)
            {
                nAC = nAC + GetItemACValue(oArmor)+GetMaterialACBonus(oArmor);
            }

            object oBrace  = GetItemInSlot(INVENTORY_SLOT_ARMS,oTarget);
            int    iBrace  = GetIsObjectValid(oBrace);
            if(iBrace == TRUE)
            {
                nAC = nAC + 1+GetMaterialACBonus(oBrace);
            }

            object oShield = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oTarget);
            int    iShield = GetIsObjectValid(oShield);
            if(iShield == TRUE)
            {
                nAC = nAC + GetItemACValue(oShield)+GetMaterialACBonus(oShield);
            }

            object oHelmet = GetItemInSlot(INVENTORY_SLOT_HEAD,oTarget);
            int    iHelmet = GetIsObjectValid(oHelmet);
            if(iHelmet == TRUE)
            {
                nAC = nAC + 1+GetMaterialACBonus(oHelmet);
            }

            int nAttackSlot;

            //Main Hand Attack
            object oWeapon;
            int nSize = 0;
            int nDamageType = 0;
            int nMaterial = 0;
            int nMerciful = 0;

            if(iAttackType == 1)
            {
                oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oAttacker);
                nMaterial = GetMaterialACBonus(oWeapon);
                nSize = GetWeaponSize(oWeapon);
                nDamageType = GetBaseDamageType(oWeapon);
                nMerciful = GetLocalInt(oWeapon,"Merciful");
            }
            else if(iAttackType == 2)
            {
                oWeapon = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oAttacker);
                nMaterial = GetMaterialACBonus(oWeapon);
                nSize = GetWeaponSize(oWeapon);
                nDamageType = GetBaseDamageType(oWeapon);
                nMerciful = GetLocalInt(oWeapon,"Merciful");
            }
            else
            {
                nSize = 3;
                nDamageType = 4;
                nMaterial = 0;
            }

            if(nSize == 1 || nSize == 2)
            {
                nRoll = nRoll + 2;
            }
            else if(nSize == 3)
            {
                nRoll = nRoll + 4;
            }
            else if(nSize == 4)
            {
                nRoll = nRoll + 6;
            }
            else
            {
                nRoll = nRoll + 2;
            }

            nRoll = nRoll + nMaterial;
            int nSeverity = nRoll - nAC;
            int nDeathSaveDC = (10+(GetHitDice(oAttacker)/2)+GetAbilityModifier(ABILITY_STRENGTH,oAttacker));
            int nDeathSave;

            if(GetHasFeat(1480,oAttacker) == TRUE)
            {
                nSeverity = nSeverity + 2;
                nDeathSaveDC = nDeathSaveDC + 2;
            }

            if(GetLocalInt(oAttacker,"MonkStyle") == 1 || GetLocalInt(oAttacker,"MonkStyle") == 3 || GetLocalInt(oAttacker,"MonkStyle") == 4)
            {
                nSeverity = nSeverity +5;
            }

            if(GetLocalInt(oTarget,"MonkStyle") == 2)
            {
                nSeverity = nSeverity -5;
            }

            if(GetLocalInt(oAttacker,"MonkStyle") == 5)
            {
                nSeverity = nSeverity+3;
            }

            if(GetLocalInt(oTarget,"MonkStyle") == 5)
            {
                nSeverity = nSeverity-3;
            }

            if(GetRacialType(oTarget) == RACIAL_TYPE_DRAGON)
            {
                nSeverity = nSeverity - (GetHitDice(oTarget)/2);
            }

            if(iSneakAttack > 0)
            {
                nSeverity = nSeverity +5;
            }

            //Bludgeoning Weapon
            if(nDamageType == 2)
            {
                nSeverity = nSeverity +5;
            }

            if(nMerciful == 1)
            {
                nSeverity = nSeverity +5;
            }

            if(GetLastAttackMode(oTarget) == COMBAT_MODE_PARRY)
            {
                int nParry2 = 2*GetSkillRank(SKILL_PARRY,oTarget,FALSE)/5;

                nSeverity = nSeverity-nParry2;
            }

            if(GetLastAttackMode(oTarget) == COMBAT_MODE_EXPERTISE)
            {
                nSeverity = nSeverity-5;
            }

            if(GetLastAttackMode(oTarget) == COMBAT_MODE_IMPROVED_EXPERTISE)
            {
                nSeverity = nSeverity-10;
            }

            effect eSubdualed = EffectLinkEffects(EffectStunned(),EffectKnockdown());

            if(nSeverity <= 3)
            {
                DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSubdualed,oTarget,6.0));
            }
            else if(nSeverity >= 4 && nSeverity <=8 && GetIsDead(oTarget) == FALSE)
            {
                DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSubdualed,oTarget,12.0));
            }
            else if(nSeverity >= 9 && nSeverity <=13 && GetIsDead(oTarget) == FALSE)
            {
                DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSubdualed,oTarget,18.0));
            }
            else if(nSeverity >= 14 && nSeverity <=18 && GetIsDead(oTarget) == FALSE)
            {
                DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSubdualed,oTarget,24.0));
            }
            else if(nSeverity >= 19 && GetIsDead(oTarget) == FALSE)
            {
                DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSubdualed,oTarget,30.0));
            }
        }
        // 0=neither, 1=sneak attack, 2=death attack, 3=both
        if(GetLocalInt(oAttacker,"SUBDUAL") == 1 && iSneakAttack > 0)
        {
            SendMessageToPC(oAttacker,"You have utilized your sneak attack to try and subdual your opponent instead of dealing damage!");
            data.iSneakAttack = 0;
        }
    }

    if(GetLocalInt(oAttacker,"SUBDUAL") == 1)
    {
        data.iBase = iBase/5;
        if(iAttackType == 3)
        {
            data.iBase = iBase/10;
        }
    }

    NWNX_Damage_SetAttackEventData(data);
}

int GetMaterialACBonus(object oItem)
{
    int nMaterialType = GetLocalInt(oItem,"Material");
    int nReturn = 0;
    switch (nMaterialType)
    {
        case 1:  {nReturn =  1; break;}
        case 2:  {nReturn =  2; break;}
        case 3:  {nReturn =  2; break;}
        case 4:  {nReturn =  3; break;}
        case 5:  {nReturn =  0; break;}
        case 6:  {nReturn =  1; break;}
        case 7:  {nReturn =  0; break;}
        case 8:  {nReturn =  1; break;}
        case 9:  {nReturn =  0; break;}
        case 10: {nReturn =  0; break;}
        case 11: {nReturn =  0; break;}
        case 12: {nReturn =  2; break;}
        case 13: {nReturn =  0; break;}
        case 14: {nReturn =  0; break;}
        default: {nReturn =  0; break;}
    }
    return nReturn;
}

int GetWeaponSize(object oItem)
{
    int nItemType = GetBaseItemType(oItem);
    int nReturn = 0;
    switch (nItemType)
    {
        case 0: {nReturn = 2; break;}
        case 1: {nReturn = 3; break;}
        case 2: {nReturn = 3; break;}
        case 3: {nReturn = 3; break;}
        case 4: {nReturn = 3; break;}
        case 5: {nReturn = 3; break;}
        case 6: {nReturn = 4; break;}
        case 7: {nReturn = 3; break;}
        case 8: {nReturn = 4; break;}
        case 9: {nReturn = 2; break;}
        case 10: {nReturn = 4; break;}
        case 11: {nReturn = 3; break;}
        case 12: {nReturn = 4; break;}
        case 13: {nReturn = 4; break;}
        case 14: {nReturn = 0; break;}
        case 15: {nReturn = 2; break;}
        case 16: {nReturn = 0; break;}
        case 17: {nReturn = 0; break;}
        case 18: {nReturn = 4; break;}
        case 19: {nReturn = 0; break;}
        case 20: {nReturn = 0; break;}
        case 21: {nReturn = 0; break;}
        case 22: {nReturn = 1; break;}
        case 23: {nReturn = 0; break;}
        case 24: {nReturn = 0; break;}
        case 25: {nReturn = 0; break;}
        case 26: {nReturn = 0; break;}
        case 27: {nReturn = 0; break;}
        case 28: {nReturn = 3; break;}
        case 29: {nReturn = 0; break;}
        case 30: {nReturn = 3; break;}
        case 31: {nReturn = 2; break;}
        case 32: {nReturn = 4; break;}
        case 33: {nReturn = 4; break;}
        case 34: {nReturn = 0; break;}
        case 35: {nReturn = 4; break;}
        case 36: {nReturn = 0; break;}
        case 37: {nReturn = 2; break;}
        case 38: {nReturn = 2; break;}
        case 39: {nReturn = 0; break;}
        case 40: {nReturn = 2; break;}
        case 41: {nReturn = 3; break;}
        case 42: {nReturn = 1; break;}
        case 43: {nReturn = 0; break;}
        case 44: {nReturn = 0; break;}
        case 45: {nReturn = 3; break;}
        case 46: {nReturn = 0; break;}
        case 47: {nReturn = 3; break;}
        case 48: {nReturn = 2; break;}
        case 49: {nReturn = 0; break;}
        case 50: {nReturn = 4; break;}
        case 51: {nReturn = 3; break;}
        case 52: {nReturn = 0; break;}
        case 53: {nReturn = 3; break;}
        case 54: {nReturn = 0; break;}
        case 55: {nReturn = 4; break;}
        case 56: {nReturn = 0; break;}
        case 57: {nReturn = 0; break;}
        case 58: {nReturn = 4; break;}
        case 59: {nReturn = 1; break;}
        case 60: {nReturn = 2; break;}
        case 61: {nReturn = 2; break;}
        case 62: {nReturn = 0; break;}
        case 63: {nReturn = 2; break;}
        case 64: {nReturn = 0; break;}
        case 65: {nReturn = 0; break;}
        case 66: {nReturn = 0; break;}
        case 67: {nReturn = 0; break;}
        case 68: {nReturn = 0; break;}
        case 69: {nReturn = 3; break;}
        case 70: {nReturn = 3; break;}
        case 71: {nReturn = 3; break;}
        case 72: {nReturn = 3; break;}
        case 73: {nReturn = 0; break;}
        case 74: {nReturn = 0; break;}
        case 75: {nReturn = 0; break;}
        case 76: {nReturn = 0; break;}
        case 77: {nReturn = 0; break;}
        case 78: {nReturn = 0; break;}
        case 79: {nReturn = 0; break;}
        case 80: {nReturn = 0; break;}
        case 81: {nReturn = 0; break;}
        case 82: {nReturn = 0; break;}
        case 83: {nReturn = 0; break;}
        case 84: {nReturn = 0; break;}
        case 85: {nReturn = 0; break;}
        case 86: {nReturn = 0; break;}
        case 87: {nReturn = 0; break;}
        case 88: {nReturn = 0; break;}
        case 89: {nReturn = 0; break;}
        case 90: {nReturn = 0; break;}
        case 91: {nReturn = 0; break;}
        case 92: {nReturn = 2; break;}
        case 93: {nReturn = 3; break;}
        case 94: {nReturn = 2; break;}
        case 95: {nReturn = 4; break;}
        case 96: {nReturn = 0; break;}
        case 97: {nReturn = 0; break;}
        case 98: {nReturn = 0; break;}
        case 99: {nReturn = 0; break;}
        case 100: {nReturn = 0; break;}
        case 101: {nReturn = 0; break;}
        case 102: {nReturn = 0; break;}
        case 103: {nReturn = 0; break;}
        case 104: {nReturn = 0; break;}
        case 105: {nReturn = 0; break;}
        case 106: {nReturn = 0; break;}
        case 107: {nReturn = 0; break;}
        case 108: {nReturn = 3; break;}
        case 109: {nReturn = 0; break;}
        case 110: {nReturn = 0; break;}
        case 111: {nReturn = 2; break;}
        case 112: {nReturn = 0; break;}
        case 113: {nReturn = 0; break;}
        case 114: {nReturn = 0; break;}
        case 115: {nReturn = 0; break;}
        case 116: {nReturn = 0; break;}
        case 117: {nReturn = 0; break;}
        case 118: {nReturn = 0; break;}
        case 119: {nReturn = 0; break;}
        case 120: {nReturn = 0; break;}
        case 121: {nReturn = 0; break;}
        case 122: {nReturn = 0; break;}
        case 123: {nReturn = 0; break;}
        case 124: {nReturn = 0; break;}
        case 125: {nReturn = 0; break;}
        case 126: {nReturn = 0; break;}
        case 127: {nReturn = 0; break;}
        case 128: {nReturn = 0; break;}
        case 129: {nReturn = 0; break;}
        case 130: {nReturn = 0; break;}
        case 131: {nReturn = 0; break;}
        case 132: {nReturn = 0; break;}
        case 133: {nReturn = 0; break;}
        case 134: {nReturn = 0; break;}
        case 135: {nReturn = 0; break;}
        case 136: {nReturn = 0; break;}
        case 137: {nReturn = 0; break;}
        case 138: {nReturn = 0; break;}
        case 139: {nReturn = 0; break;}
        case 140: {nReturn = 0; break;}
        case 141: {nReturn = 0; break;}
        case 142: {nReturn = 0; break;}
        case 143: {nReturn = 0; break;}
        case 144: {nReturn = 0; break;}
        case 145: {nReturn = 0; break;}
        case 146: {nReturn = 0; break;}
        case 147: {nReturn = 0; break;}
        case 148: {nReturn = 0; break;}
        case 149: {nReturn = 0; break;}
        case 150: {nReturn = 0; break;}
        case 151: {nReturn = 0; break;}
        case 152: {nReturn = 0; break;}
        case 153: {nReturn = 0; break;}
        case 154: {nReturn = 0; break;}
        case 155: {nReturn = 0; break;}
        case 156: {nReturn = 0; break;}
        case 157: {nReturn = 0; break;}
        case 158: {nReturn = 0; break;}
        case 159: {nReturn = 0; break;}
        case 160: {nReturn = 0; break;}
        case 161: {nReturn = 0; break;}
        case 162: {nReturn = 0; break;}
        case 163: {nReturn = 0; break;}
        case 164: {nReturn = 0; break;}
        case 165: {nReturn = 0; break;}
        case 166: {nReturn = 0; break;}
        case 167: {nReturn = 0; break;}
        case 168: {nReturn = 0; break;}
        case 169: {nReturn = 0; break;}
        case 170: {nReturn = 0; break;}
        case 171: {nReturn = 0; break;}
        case 172: {nReturn = 0; break;}
        case 173: {nReturn = 0; break;}
        case 174: {nReturn = 0; break;}
        case 175: {nReturn = 0; break;}
        case 176: {nReturn = 0; break;}
        case 177: {nReturn = 0; break;}
        case 178: {nReturn = 0; break;}
        case 179: {nReturn = 0; break;}
        case 180: {nReturn = 0; break;}
        case 181: {nReturn = 0; break;}
        case 182: {nReturn = 0; break;}
        case 183: {nReturn = 0; break;}
        case 184: {nReturn = 0; break;}
        case 185: {nReturn = 0; break;}
        case 186: {nReturn = 0; break;}
        case 187: {nReturn = 0; break;}
        case 188: {nReturn = 0; break;}
        case 189: {nReturn = 0; break;}
        case 190: {nReturn = 0; break;}
        case 191: {nReturn = 0; break;}
        case 192: {nReturn = 0; break;}
        case 193: {nReturn = 0; break;}
        case 194: {nReturn = 0; break;}
        case 195: {nReturn = 0; break;}
        case 196: {nReturn = 0; break;}
        case 197: {nReturn = 0; break;}
        case 198: {nReturn = 0; break;}
        case 199: {nReturn = 0; break;}
        case 200: {nReturn = 0; break;}
        case 201: {nReturn = 0; break;}
        case 202: {nReturn = 1; break;}
        case 203: {nReturn = 0; break;}
        case 204: {nReturn = 0; break;}
        case 205: {nReturn = 0; break;}
        case 206: {nReturn = 0; break;}
        case 207: {nReturn = 0; break;}
        case 208: {nReturn = 0; break;}
        case 209: {nReturn = 0; break;}
        case 210: {nReturn = 3; break;}
        case 211: {nReturn = 0; break;}
        case 212: {nReturn = 0; break;}
        case 213: {nReturn = 0; break;}
        case 214: {nReturn = 0; break;}
        case 215: {nReturn = 0; break;}
        case 216: {nReturn = 0; break;}
        case 217: {nReturn = 0; break;}
        case 218: {nReturn = 0; break;}
        case 219: {nReturn = 0; break;}
        case 220: {nReturn = 0; break;}
        case 221: {nReturn = 0; break;}
        case 222: {nReturn = 0; break;}
        case 223: {nReturn = 0; break;}
        case 224: {nReturn = 0; break;}
        case 225: {nReturn = 0; break;}
        case 226: {nReturn = 0; break;}
        case 227: {nReturn = 0; break;}
        case 228: {nReturn = 0; break;}
        case 229: {nReturn = 0; break;}
        case 230: {nReturn = 0; break;}
        case 231: {nReturn = 0; break;}
        case 232: {nReturn = 0; break;}
        case 233: {nReturn = 0; break;}
        case 234: {nReturn = 0; break;}
        case 235: {nReturn = 0; break;}
        case 236: {nReturn = 0; break;}
        case 237: {nReturn = 0; break;}
        case 238: {nReturn = 0; break;}
        case 239: {nReturn = 0; break;}
        case 240: {nReturn = 0; break;}
        case 241: {nReturn = 0; break;}
        case 242: {nReturn = 0; break;}
        case 243: {nReturn = 0; break;}
        case 244: {nReturn = 0; break;}
        case 245: {nReturn = 0; break;}
        case 246: {nReturn = 0; break;}
        case 247: {nReturn = 0; break;}
        case 248: {nReturn = 0; break;}
        case 249: {nReturn = 0; break;}
        case 250: {nReturn = 0; break;}
        case 251: {nReturn = 0; break;}
        case 252: {nReturn = 0; break;}
        case 253: {nReturn = 0; break;}
        case 254: {nReturn = 0; break;}
        case 255: {nReturn = 0; break;}
        case 256: {nReturn = 0; break;}
        case 257: {nReturn = 0; break;}
        case 258: {nReturn = 0; break;}
        case 259: {nReturn = 0; break;}
        case 260: {nReturn = 0; break;}
        case 261: {nReturn = 0; break;}
        case 262: {nReturn = 0; break;}
        case 263: {nReturn = 0; break;}
        case 264: {nReturn = 0; break;}
        case 265: {nReturn = 0; break;}
        case 266: {nReturn = 0; break;}
        case 267: {nReturn = 0; break;}
        case 268: {nReturn = 0; break;}
        case 269: {nReturn = 0; break;}
        case 270: {nReturn = 0; break;}
        case 271: {nReturn = 0; break;}
        case 272: {nReturn = 0; break;}
        case 273: {nReturn = 0; break;}
        case 274: {nReturn = 0; break;}
        case 275: {nReturn = 0; break;}
        case 276: {nReturn = 0; break;}
        case 277: {nReturn = 0; break;}
        case 278: {nReturn = 0; break;}
        case 279: {nReturn = 0; break;}
        case 280: {nReturn = 0; break;}
        case 281: {nReturn = 0; break;}
        case 282: {nReturn = 0; break;}
        case 283: {nReturn = 0; break;}
        case 284: {nReturn = 0; break;}
        case 285: {nReturn = 0; break;}
        case 286: {nReturn = 0; break;}
        case 287: {nReturn = 0; break;}
        case 288: {nReturn = 0; break;}
        case 289: {nReturn = 0; break;}
        case 290: {nReturn = 0; break;}
        case 291: {nReturn = 0; break;}
        case 292: {nReturn = 0; break;}
        case 293: {nReturn = 0; break;}
        case 294: {nReturn = 0; break;}
        case 295: {nReturn = 0; break;}
        case 296: {nReturn = 0; break;}
        case 297: {nReturn = 0; break;}
        case 298: {nReturn = 0; break;}
        case 299: {nReturn = 0; break;}
        case 300: {nReturn = 3; break;}
        case 301: {nReturn = 3; break;}
        case 302: {nReturn = 2; break;}
        case 303: {nReturn = 1; break;}
        case 304: {nReturn = 2; break;}
        case 305: {nReturn = 4; break;}
        case 306: {nReturn = 0; break;}
        case 307: {nReturn = 0; break;}
        case 308: {nReturn = 2; break;}
        case 309: {nReturn = 1; break;}
        case 310: {nReturn = 1; break;}
        case 311: {nReturn = 0; break;}
        case 312: {nReturn = 2; break;}
        case 313: {nReturn = 1; break;}
        case 314: {nReturn = 1; break;}
        case 315: {nReturn = 0; break;}
        case 316: {nReturn = 4; break;}
        case 317: {nReturn = 3; break;}
        case 318: {nReturn = 4; break;}
        case 319: {nReturn = 3; break;}
        case 320: {nReturn = 4; break;}
        case 321: {nReturn = 4; break;}
        case 322: {nReturn = 2; break;}
        case 323: {nReturn = 2; break;}
        case 324: {nReturn = 3; break;}
        case 325: {nReturn = 3; break;}
        case 326: {nReturn = 2; break;}
        case 327: {nReturn = 3; break;}
        case 328: {nReturn = 0; break;}
        case 329: {nReturn = 4; break;}
        case 330: {nReturn = 3; break;}
        case 331: {nReturn = 4; break;}
        case 332: {nReturn = 2; break;}
        case 333: {nReturn = 2; break;}
        case 334: {nReturn = 0; break;}
        case 335: {nReturn = 0; break;}
        case 336: {nReturn = 0; break;}
        case 337: {nReturn = 0; break;}
        case 338: {nReturn = 0; break;}
        case 339: {nReturn = 0; break;}
        case 340: {nReturn = 0; break;}
        case 341: {nReturn = 0; break;}
        case 342: {nReturn = 0; break;}
        case 343: {nReturn = 0; break;}
        case 344: {nReturn = 0; break;}
        case 345: {nReturn = 0; break;}
        case 346: {nReturn = 0; break;}
        case 347: {nReturn = 0; break;}
        case 348: {nReturn = 0; break;}
        case 349: {nReturn = 0; break;}
        case 350: {nReturn = 0; break;}
        case 351: {nReturn = 0; break;}
        case 352: {nReturn = 0; break;}
        case 353: {nReturn = 0; break;}
        case 354: {nReturn = 0; break;}
        case 355: {nReturn = 0; break;}
        case 356: {nReturn = 0; break;}
        case 357: {nReturn = 0; break;}
        case 358: {nReturn = 0; break;}
        case 359: {nReturn = 0; break;}
        case 360: {nReturn = 0; break;}
        case 361: {nReturn = 0; break;}
        case 362: {nReturn = 0; break;}
        case 363: {nReturn = 0; break;}
        case 364: {nReturn = 0; break;}
        case 365: {nReturn = 0; break;}
        case 366: {nReturn = 0; break;}
        case 367: {nReturn = 2; break;}
        case 368: {nReturn = 0; break;}
        case 369: {nReturn = 0; break;}
        case 370: {nReturn = 0; break;}
        case 371: {nReturn = 0; break;}
        case 372: {nReturn = 0; break;}
        case 373: {nReturn = 0; break;}
        case 374: {nReturn = 0; break;}
        case 375: {nReturn = 0; break;}
        case 376: {nReturn = 0; break;}
        case 377: {nReturn = 0; break;}
        case 378: {nReturn = 0; break;}
        case 379: {nReturn = 0; break;}
        case 380: {nReturn = 0; break;}
        case 381: {nReturn = 0; break;}
        case 382: {nReturn = 0; break;}
        case 383: {nReturn = 0; break;}
        case 384: {nReturn = 0; break;}
        case 385: {nReturn = 0; break;}
        case 386: {nReturn = 0; break;}
        case 387: {nReturn = 0; break;}
        case 388: {nReturn = 0; break;}
        case 389: {nReturn = 0; break;}
        case 390: {nReturn = 0; break;}
        case 391: {nReturn = 0; break;}
        case 392: {nReturn = 0; break;}
        case 393: {nReturn = 0; break;}
        case 394: {nReturn = 0; break;}
        case 395: {nReturn = 0; break;}
        case 396: {nReturn = 0; break;}
        case 397: {nReturn = 0; break;}
        case 398: {nReturn = 0; break;}
        case 399: {nReturn = 0; break;}
        case 400: {nReturn = 0; break;}
        case 401: {nReturn = 0; break;}
        case 402: {nReturn = 0; break;}
        case 403: {nReturn = 0; break;}
        case 404: {nReturn = 0; break;}
        case 405: {nReturn = 0; break;}
        case 406: {nReturn = 0; break;}
        case 407: {nReturn = 0; break;}
        case 408: {nReturn = 0; break;}
        case 409: {nReturn = 0; break;}
        case 410: {nReturn = 0; break;}
        case 411: {nReturn = 0; break;}
        case 412: {nReturn = 0; break;}
        case 413: {nReturn = 0; break;}
        case 414: {nReturn = 0; break;}
        case 415: {nReturn = 0; break;}
        case 416: {nReturn = 0; break;}
        case 417: {nReturn = 0; break;}
        case 418: {nReturn = 0; break;}
        case 419: {nReturn = 0; break;}
        case 420: {nReturn = 0; break;}
        case 421: {nReturn = 0; break;}
        case 422: {nReturn = 0; break;}
        case 423: {nReturn = 0; break;}
        case 424: {nReturn = 0; break;}
        case 425: {nReturn = 0; break;}
        case 426: {nReturn = 0; break;}
        case 427: {nReturn = 0; break;}
        case 428: {nReturn = 0; break;}
        case 429: {nReturn = 0; break;}
        case 430: {nReturn = 0; break;}
        case 431: {nReturn = 0; break;}
        case 432: {nReturn = 0; break;}
        case 433: {nReturn = 0; break;}
        case 434: {nReturn = 0; break;}
        case 435: {nReturn = 0; break;}
        case 436: {nReturn = 0; break;}
        case 437: {nReturn = 0; break;}
        case 438: {nReturn = 0; break;}
        case 439: {nReturn = 0; break;}
        case 440: {nReturn = 0; break;}
        case 441: {nReturn = 0; break;}
        case 442: {nReturn = 0; break;}
        case 443: {nReturn = 0; break;}
        case 444: {nReturn = 0; break;}
        case 445: {nReturn = 0; break;}
        case 446: {nReturn = 0; break;}
        case 447: {nReturn = 0; break;}
        case 448: {nReturn = 0; break;}
        case 449: {nReturn = 0; break;}
        case 450: {nReturn = 0; break;}
        case 451: {nReturn = 0; break;}
        case 452: {nReturn = 0; break;}
        case 453: {nReturn = 0; break;}
        case 454: {nReturn = 0; break;}
        case 455: {nReturn = 0; break;}
        case 456: {nReturn = 0; break;}
        case 457: {nReturn = 0; break;}
        case 458: {nReturn = 0; break;}
        case 459: {nReturn = 0; break;}
        case 460: {nReturn = 0; break;}
        case 461: {nReturn = 0; break;}
        case 462: {nReturn = 0; break;}
        case 463: {nReturn = 0; break;}
        case 464: {nReturn = 0; break;}
        case 465: {nReturn = 0; break;}
        case 466: {nReturn = 0; break;}
        case 467: {nReturn = 0; break;}
        case 468: {nReturn = 0; break;}
        case 469: {nReturn = 0; break;}
        case 470: {nReturn = 0; break;}
        case 471: {nReturn = 0; break;}
        case 472: {nReturn = 0; break;}
        case 473: {nReturn = 0; break;}
        case 474: {nReturn = 0; break;}
        case 475: {nReturn = 0; break;}
        case 476: {nReturn = 0; break;}
        case 477: {nReturn = 0; break;}
        case 478: {nReturn = 0; break;}
        case 479: {nReturn = 0; break;}
        case 480: {nReturn = 0; break;}
        case 481: {nReturn = 0; break;}
        case 482: {nReturn = 0; break;}
        case 483: {nReturn = 0; break;}
        case 484: {nReturn = 0; break;}
        case 485: {nReturn = 0; break;}
        case 486: {nReturn = 0; break;}
        case 487: {nReturn = 0; break;}
        case 488: {nReturn = 0; break;}
        case 489: {nReturn = 0; break;}
        case 490: {nReturn = 0; break;}
        case 491: {nReturn = 0; break;}
        case 492: {nReturn = 0; break;}
        case 493: {nReturn = 0; break;}
        case 494: {nReturn = 0; break;}
        case 495: {nReturn = 0; break;}
        case 496: {nReturn = 0; break;}
        case 497: {nReturn = 0; break;}
        case 498: {nReturn = 0; break;}
        case 499: {nReturn = 0; break;}
        case 500: {nReturn = 4; break;}
        case 501: {nReturn = 0; break;}
        case 502: {nReturn = 0; break;}
        case 503: {nReturn = 0; break;}
        case 504: {nReturn = 0; break;}
        case 505: {nReturn = 0; break;}
        case 506: {nReturn = 0; break;}
        case 507: {nReturn = 0; break;}
        case 508: {nReturn = 0; break;}
        case 509: {nReturn = 0; break;}
        default:  {nReturn = 0;}

    }

    return nReturn;
}

int GetBaseDamageType(object oItem)
{
    int nItemType = GetBaseItemType(oItem);
    int nReturn = 0;
    switch (nItemType)
    {
        case 0: {nReturn = 1; break;}
        case 1: {nReturn = 3; break;}
        case 2: {nReturn = 3; break;}
        case 3: {nReturn = 3; break;}
        case 4: {nReturn = 2; break;}
        case 5: {nReturn = 2; break;}
        case 6: {nReturn = 1; break;}
        case 7: {nReturn = 1; break;}
        case 8: {nReturn = 1; break;}
        case 9: {nReturn = 2; break;}
        case 10: {nReturn = 4; break;}
        case 11: {nReturn = 1; break;}
        case 12: {nReturn = 3; break;}
        case 13: {nReturn = 3; break;}
        case 14: {nReturn = 0; break;}
        case 15: {nReturn = 0; break;}
        case 16: {nReturn = 0; break;}
        case 17: {nReturn = 0; break;}
        case 18: {nReturn = 3; break;}
        case 19: {nReturn = 0; break;}
        case 20: {nReturn = 0; break;}
        case 21: {nReturn = 0; break;}
        case 22: {nReturn = 1; break;}
        case 23: {nReturn = 0; break;}
        case 24: {nReturn = 0; break;}
        case 25: {nReturn = 0; break;}
        case 26: {nReturn = 0; break;}
        case 27: {nReturn = 0; break;}
        case 28: {nReturn = 2; break;}
        case 29: {nReturn = 0; break;}
        case 30: {nReturn = 1; break;}
        case 31: {nReturn = 1; break;}
        case 32: {nReturn = 2; break;}
        case 33: {nReturn = 3; break;}
        case 34: {nReturn = 0; break;}
        case 35: {nReturn = 2; break;}
        case 36: {nReturn = 2; break;}
        case 37: {nReturn = 2; break;}
        case 38: {nReturn = 3; break;}
        case 39: {nReturn = 0; break;}
        case 40: {nReturn = 3; break;}
        case 41: {nReturn = 3; break;}
        case 42: {nReturn = 3; break;}
        case 43: {nReturn = 0; break;}
        case 44: {nReturn = 0; break;}
        case 45: {nReturn = 2; break;}
        case 46: {nReturn = 0; break;}
        case 47: {nReturn = 5; break;}
        case 48: {nReturn = 2; break;}
        case 49: {nReturn = 0; break;}
        case 50: {nReturn = 2; break;}
        case 51: {nReturn = 1; break;}
        case 52: {nReturn = 0; break;}
        case 53: {nReturn = 3; break;}
        case 54: {nReturn = 0; break;}
        case 55: {nReturn = 4; break;}
        case 56: {nReturn = 0; break;}
        case 57: {nReturn = 0; break;}
        case 58: {nReturn = 1; break;}
        case 59: {nReturn = 1; break;}
        case 60: {nReturn = 3; break;}
        case 61: {nReturn = 2; break;}
        case 62: {nReturn = 0; break;}
        case 63: {nReturn = 3; break;}
        case 64: {nReturn = 0; break;}
        case 65: {nReturn = 0; break;}
        case 66: {nReturn = 0; break;}
        case 67: {nReturn = 0; break;}
        case 68: {nReturn = 0; break;}
        case 69: {nReturn = 3; break;}
        case 70: {nReturn = 1; break;}
        case 71: {nReturn = 2; break;}
        case 72: {nReturn = 4; break;}
        case 73: {nReturn = 0; break;}
        case 74: {nReturn = 0; break;}
        case 75: {nReturn = 0; break;}
        case 76: {nReturn = 0; break;}
        case 77: {nReturn = 0; break;}
        case 78: {nReturn = 2; break;}
        case 79: {nReturn = 0; break;}
        case 80: {nReturn = 0; break;}
        case 81: {nReturn = 0; break;}
        case 82: {nReturn = 0; break;}
        case 83: {nReturn = 0; break;}
        case 84: {nReturn = 0; break;}
        case 85: {nReturn = 0; break;}
        case 86: {nReturn = 0; break;}
        case 87: {nReturn = 0; break;}
        case 88: {nReturn = 0; break;}
        case 89: {nReturn = 0; break;}
        case 90: {nReturn = 0; break;}
        case 91: {nReturn = 0; break;}
        case 92: {nReturn = 1; break;}
        case 93: {nReturn = 2; break;}
        case 94: {nReturn = 2; break;}
        case 95: {nReturn = 1; break;}
        case 96: {nReturn = 0; break;}
        case 97: {nReturn = 0; break;}
        case 98: {nReturn = 0; break;}
        case 99: {nReturn = 0; break;}
        case 100: {nReturn = 0; break;}
        case 101: {nReturn = 0; break;}
        case 102: {nReturn = 0; break;}
        case 103: {nReturn = 0; break;}
        case 104: {nReturn = 0; break;}
        case 105: {nReturn = 0; break;}
        case 106: {nReturn = 0; break;}
        case 107: {nReturn = 0; break;}
        case 108: {nReturn = 3; break;}
        case 109: {nReturn = 0; break;}
        case 110: {nReturn = 0; break;}
        case 111: {nReturn = 3; break;}
        case 112: {nReturn = 0; break;}
        case 113: {nReturn = 0; break;}
        case 114: {nReturn = 0; break;}
        case 115: {nReturn = 0; break;}
        case 116: {nReturn = 0; break;}
        case 117: {nReturn = 0; break;}
        case 118: {nReturn = 0; break;}
        case 119: {nReturn = 0; break;}
        case 120: {nReturn = 0; break;}
        case 121: {nReturn = 0; break;}
        case 122: {nReturn = 0; break;}
        case 123: {nReturn = 0; break;}
        case 124: {nReturn = 0; break;}
        case 125: {nReturn = 0; break;}
        case 126: {nReturn = 0; break;}
        case 127: {nReturn = 0; break;}
        case 128: {nReturn = 0; break;}
        case 129: {nReturn = 0; break;}
        case 130: {nReturn = 0; break;}
        case 131: {nReturn = 0; break;}
        case 132: {nReturn = 0; break;}
        case 133: {nReturn = 0; break;}
        case 134: {nReturn = 0; break;}
        case 135: {nReturn = 0; break;}
        case 136: {nReturn = 0; break;}
        case 137: {nReturn = 0; break;}
        case 138: {nReturn = 0; break;}
        case 139: {nReturn = 0; break;}
        case 140: {nReturn = 0; break;}
        case 141: {nReturn = 0; break;}
        case 142: {nReturn = 0; break;}
        case 143: {nReturn = 0; break;}
        case 144: {nReturn = 0; break;}
        case 145: {nReturn = 0; break;}
        case 146: {nReturn = 0; break;}
        case 147: {nReturn = 0; break;}
        case 148: {nReturn = 0; break;}
        case 149: {nReturn = 0; break;}
        case 150: {nReturn = 0; break;}
        case 151: {nReturn = 0; break;}
        case 152: {nReturn = 0; break;}
        case 153: {nReturn = 0; break;}
        case 154: {nReturn = 0; break;}
        case 155: {nReturn = 0; break;}
        case 156: {nReturn = 0; break;}
        case 157: {nReturn = 0; break;}
        case 158: {nReturn = 0; break;}
        case 159: {nReturn = 0; break;}
        case 160: {nReturn = 0; break;}
        case 161: {nReturn = 0; break;}
        case 162: {nReturn = 0; break;}
        case 163: {nReturn = 0; break;}
        case 164: {nReturn = 0; break;}
        case 165: {nReturn = 0; break;}
        case 166: {nReturn = 0; break;}
        case 167: {nReturn = 0; break;}
        case 168: {nReturn = 0; break;}
        case 169: {nReturn = 0; break;}
        case 170: {nReturn = 0; break;}
        case 171: {nReturn = 0; break;}
        case 172: {nReturn = 0; break;}
        case 173: {nReturn = 0; break;}
        case 174: {nReturn = 0; break;}
        case 175: {nReturn = 0; break;}
        case 176: {nReturn = 0; break;}
        case 177: {nReturn = 0; break;}
        case 178: {nReturn = 0; break;}
        case 179: {nReturn = 0; break;}
        case 180: {nReturn = 0; break;}
        case 181: {nReturn = 0; break;}
        case 182: {nReturn = 0; break;}
        case 183: {nReturn = 0; break;}
        case 184: {nReturn = 0; break;}
        case 185: {nReturn = 0; break;}
        case 186: {nReturn = 0; break;}
        case 187: {nReturn = 0; break;}
        case 188: {nReturn = 0; break;}
        case 189: {nReturn = 0; break;}
        case 190: {nReturn = 0; break;}
        case 191: {nReturn = 0; break;}
        case 192: {nReturn = 0; break;}
        case 193: {nReturn = 0; break;}
        case 194: {nReturn = 0; break;}
        case 195: {nReturn = 0; break;}
        case 196: {nReturn = 0; break;}
        case 197: {nReturn = 0; break;}
        case 198: {nReturn = 0; break;}
        case 199: {nReturn = 0; break;}
        case 200: {nReturn = 0; break;}
        case 201: {nReturn = 0; break;}
        case 202: {nReturn = 1; break;}
        case 203: {nReturn = 0; break;}
        case 204: {nReturn = 0; break;}
        case 205: {nReturn = 0; break;}
        case 206: {nReturn = 0; break;}
        case 207: {nReturn = 0; break;}
        case 208: {nReturn = 0; break;}
        case 209: {nReturn = 0; break;}
        case 210: {nReturn = 1; break;}
        case 211: {nReturn = 0; break;}
        case 212: {nReturn = 0; break;}
        case 213: {nReturn = 0; break;}
        case 214: {nReturn = 0; break;}
        case 215: {nReturn = 0; break;}
        case 216: {nReturn = 0; break;}
        case 217: {nReturn = 0; break;}
        case 218: {nReturn = 0; break;}
        case 219: {nReturn = 0; break;}
        case 220: {nReturn = 0; break;}
        case 221: {nReturn = 0; break;}
        case 222: {nReturn = 0; break;}
        case 223: {nReturn = 0; break;}
        case 224: {nReturn = 0; break;}
        case 225: {nReturn = 0; break;}
        case 226: {nReturn = 0; break;}
        case 227: {nReturn = 0; break;}
        case 228: {nReturn = 0; break;}
        case 229: {nReturn = 0; break;}
        case 230: {nReturn = 0; break;}
        case 231: {nReturn = 0; break;}
        case 232: {nReturn = 0; break;}
        case 233: {nReturn = 0; break;}
        case 234: {nReturn = 0; break;}
        case 235: {nReturn = 0; break;}
        case 236: {nReturn = 0; break;}
        case 237: {nReturn = 0; break;}
        case 238: {nReturn = 0; break;}
        case 239: {nReturn = 0; break;}
        case 240: {nReturn = 0; break;}
        case 241: {nReturn = 0; break;}
        case 242: {nReturn = 0; break;}
        case 243: {nReturn = 0; break;}
        case 244: {nReturn = 0; break;}
        case 245: {nReturn = 0; break;}
        case 246: {nReturn = 0; break;}
        case 247: {nReturn = 0; break;}
        case 248: {nReturn = 0; break;}
        case 249: {nReturn = 0; break;}
        case 250: {nReturn = 0; break;}
        case 251: {nReturn = 0; break;}
        case 252: {nReturn = 0; break;}
        case 253: {nReturn = 0; break;}
        case 254: {nReturn = 0; break;}
        case 255: {nReturn = 0; break;}
        case 256: {nReturn = 0; break;}
        case 257: {nReturn = 0; break;}
        case 258: {nReturn = 0; break;}
        case 259: {nReturn = 0; break;}
        case 260: {nReturn = 0; break;}
        case 261: {nReturn = 0; break;}
        case 262: {nReturn = 0; break;}
        case 263: {nReturn = 0; break;}
        case 264: {nReturn = 0; break;}
        case 265: {nReturn = 0; break;}
        case 266: {nReturn = 0; break;}
        case 267: {nReturn = 0; break;}
        case 268: {nReturn = 0; break;}
        case 269: {nReturn = 0; break;}
        case 270: {nReturn = 0; break;}
        case 271: {nReturn = 0; break;}
        case 272: {nReturn = 0; break;}
        case 273: {nReturn = 0; break;}
        case 274: {nReturn = 0; break;}
        case 275: {nReturn = 0; break;}
        case 276: {nReturn = 0; break;}
        case 277: {nReturn = 0; break;}
        case 278: {nReturn = 0; break;}
        case 279: {nReturn = 0; break;}
        case 280: {nReturn = 0; break;}
        case 281: {nReturn = 0; break;}
        case 282: {nReturn = 0; break;}
        case 283: {nReturn = 0; break;}
        case 284: {nReturn = 0; break;}
        case 285: {nReturn = 0; break;}
        case 286: {nReturn = 0; break;}
        case 287: {nReturn = 0; break;}
        case 288: {nReturn = 0; break;}
        case 289: {nReturn = 0; break;}
        case 290: {nReturn = 0; break;}
        case 291: {nReturn = 0; break;}
        case 292: {nReturn = 0; break;}
        case 293: {nReturn = 0; break;}
        case 294: {nReturn = 0; break;}
        case 295: {nReturn = 0; break;}
        case 296: {nReturn = 0; break;}
        case 297: {nReturn = 0; break;}
        case 298: {nReturn = 0; break;}
        case 299: {nReturn = 0; break;}
        case 300: {nReturn = 1; break;}
        case 301: {nReturn = 1; break;}
        case 302: {nReturn = 1; break;}
        case 303: {nReturn = 2; break;}
        case 304: {nReturn = 2; break;}
        case 305: {nReturn = 4; break;}
        case 306: {nReturn = 0; break;}
        case 307: {nReturn = 0; break;}
        case 308: {nReturn = 2; break;}
        case 309: {nReturn = 1; break;}
        case 310: {nReturn = 1; break;}
        case 311: {nReturn = 0; break;}
        case 312: {nReturn = 2; break;}
        case 313: {nReturn = 3; break;}
        case 314: {nReturn = 2; break;}
        case 315: {nReturn = 0; break;}
        case 316: {nReturn = 3; break;}
        case 317: {nReturn = 2; break;}
        case 318: {nReturn = 2; break;}
        case 319: {nReturn = 4; break;}
        case 320: {nReturn = 4; break;}
        case 321: {nReturn = 3; break;}
        case 322: {nReturn = 1; break;}
        case 323: {nReturn = 3; break;}
        case 324: {nReturn = 4; break;}
        case 325: {nReturn = 2; break;}
        case 326: {nReturn = 2; break;}
        case 327: {nReturn = 2; break;}
        case 328: {nReturn = 0; break;}
        case 329: {nReturn = 2; break;}
        case 330: {nReturn = 3; break;}
        case 331: {nReturn = 2; break;}
        case 332: {nReturn = 2; break;}
        case 333: {nReturn = 3; break;}
        case 334: {nReturn = 0; break;}
        case 335: {nReturn = 0; break;}
        case 336: {nReturn = 0; break;}
        case 337: {nReturn = 0; break;}
        case 338: {nReturn = 0; break;}
        case 339: {nReturn = 0; break;}
        case 340: {nReturn = 0; break;}
        case 341: {nReturn = 0; break;}
        case 342: {nReturn = 0; break;}
        case 343: {nReturn = 0; break;}
        case 344: {nReturn = 0; break;}
        case 345: {nReturn = 0; break;}
        case 346: {nReturn = 0; break;}
        case 347: {nReturn = 0; break;}
        case 348: {nReturn = 0; break;}
        case 349: {nReturn = 0; break;}
        case 350: {nReturn = 0; break;}
        case 351: {nReturn = 0; break;}
        case 352: {nReturn = 0; break;}
        case 353: {nReturn = 0; break;}
        case 354: {nReturn = 0; break;}
        case 355: {nReturn = 0; break;}
        case 356: {nReturn = 0; break;}
        case 357: {nReturn = 0; break;}
        case 358: {nReturn = 0; break;}
        case 359: {nReturn = 0; break;}
        case 360: {nReturn = 0; break;}
        case 361: {nReturn = 0; break;}
        case 362: {nReturn = 2; break;}
        case 363: {nReturn = 0; break;}
        case 364: {nReturn = 0; break;}
        case 365: {nReturn = 0; break;}
        case 366: {nReturn = 0; break;}
        case 367: {nReturn = 0; break;}
        case 368: {nReturn = 0; break;}
        case 369: {nReturn = 0; break;}
        case 370: {nReturn = 0; break;}
        case 371: {nReturn = 0; break;}
        case 372: {nReturn = 0; break;}
        case 373: {nReturn = 0; break;}
        case 374: {nReturn = 0; break;}
        case 375: {nReturn = 0; break;}
        case 376: {nReturn = 0; break;}
        case 377: {nReturn = 0; break;}
        case 378: {nReturn = 0; break;}
        case 379: {nReturn = 0; break;}
        case 380: {nReturn = 0; break;}
        case 381: {nReturn = 0; break;}
        case 382: {nReturn = 0; break;}
        case 383: {nReturn = 0; break;}
        case 384: {nReturn = 0; break;}
        case 385: {nReturn = 0; break;}
        case 386: {nReturn = 0; break;}
        case 387: {nReturn = 0; break;}
        case 388: {nReturn = 0; break;}
        case 389: {nReturn = 0; break;}
        case 390: {nReturn = 0; break;}
        case 391: {nReturn = 0; break;}
        case 392: {nReturn = 0; break;}
        case 393: {nReturn = 0; break;}
        case 394: {nReturn = 0; break;}
        case 395: {nReturn = 0; break;}
        case 396: {nReturn = 0; break;}
        case 397: {nReturn = 0; break;}
        case 398: {nReturn = 0; break;}
        case 399: {nReturn = 0; break;}
        case 400: {nReturn = 0; break;}
        case 401: {nReturn = 0; break;}
        case 402: {nReturn = 0; break;}
        case 403: {nReturn = 0; break;}
        case 404: {nReturn = 0; break;}
        case 405: {nReturn = 0; break;}
        case 406: {nReturn = 0; break;}
        case 407: {nReturn = 0; break;}
        case 408: {nReturn = 0; break;}
        case 409: {nReturn = 0; break;}
        case 410: {nReturn = 0; break;}
        case 411: {nReturn = 0; break;}
        case 412: {nReturn = 0; break;}
        case 413: {nReturn = 0; break;}
        case 414: {nReturn = 0; break;}
        case 415: {nReturn = 0; break;}
        case 416: {nReturn = 0; break;}
        case 417: {nReturn = 0; break;}
        case 418: {nReturn = 0; break;}
        case 419: {nReturn = 0; break;}
        case 420: {nReturn = 0; break;}
        case 421: {nReturn = 0; break;}
        case 422: {nReturn = 0; break;}
        case 423: {nReturn = 0; break;}
        case 424: {nReturn = 0; break;}
        case 425: {nReturn = 0; break;}
        case 426: {nReturn = 0; break;}
        case 427: {nReturn = 0; break;}
        case 428: {nReturn = 0; break;}
        case 429: {nReturn = 0; break;}
        case 430: {nReturn = 0; break;}
        case 431: {nReturn = 0; break;}
        case 432: {nReturn = 0; break;}
        case 433: {nReturn = 0; break;}
        case 434: {nReturn = 0; break;}
        case 435: {nReturn = 0; break;}
        case 436: {nReturn = 0; break;}
        case 437: {nReturn = 0; break;}
        case 438: {nReturn = 0; break;}
        case 439: {nReturn = 0; break;}
        case 440: {nReturn = 0; break;}
        case 441: {nReturn = 0; break;}
        case 442: {nReturn = 0; break;}
        case 443: {nReturn = 0; break;}
        case 444: {nReturn = 0; break;}
        case 445: {nReturn = 0; break;}
        case 446: {nReturn = 0; break;}
        case 447: {nReturn = 0; break;}
        case 448: {nReturn = 0; break;}
        case 449: {nReturn = 0; break;}
        case 450: {nReturn = 0; break;}
        case 451: {nReturn = 0; break;}
        case 452: {nReturn = 0; break;}
        case 453: {nReturn = 0; break;}
        case 454: {nReturn = 0; break;}
        case 455: {nReturn = 0; break;}
        case 456: {nReturn = 0; break;}
        case 457: {nReturn = 0; break;}
        case 458: {nReturn = 0; break;}
        case 459: {nReturn = 0; break;}
        case 460: {nReturn = 0; break;}
        case 461: {nReturn = 0; break;}
        case 462: {nReturn = 0; break;}
        case 463: {nReturn = 0; break;}
        case 464: {nReturn = 0; break;}
        case 465: {nReturn = 0; break;}
        case 466: {nReturn = 0; break;}
        case 467: {nReturn = 0; break;}
        case 468: {nReturn = 0; break;}
        case 469: {nReturn = 0; break;}
        case 470: {nReturn = 0; break;}
        case 471: {nReturn = 0; break;}
        case 472: {nReturn = 0; break;}
        case 473: {nReturn = 0; break;}
        case 474: {nReturn = 0; break;}
        case 475: {nReturn = 0; break;}
        case 476: {nReturn = 0; break;}
        case 477: {nReturn = 0; break;}
        case 478: {nReturn = 0; break;}
        case 479: {nReturn = 0; break;}
        case 480: {nReturn = 0; break;}
        case 481: {nReturn = 0; break;}
        case 482: {nReturn = 0; break;}
        case 483: {nReturn = 0; break;}
        case 484: {nReturn = 0; break;}
        case 485: {nReturn = 0; break;}
        case 486: {nReturn = 0; break;}
        case 487: {nReturn = 0; break;}
        case 488: {nReturn = 0; break;}
        case 489: {nReturn = 0; break;}
        case 490: {nReturn = 0; break;}
        case 491: {nReturn = 0; break;}
        case 492: {nReturn = 0; break;}
        case 493: {nReturn = 0; break;}
        case 494: {nReturn = 0; break;}
        case 495: {nReturn = 0; break;}
        case 496: {nReturn = 0; break;}
        case 497: {nReturn = 0; break;}
        case 498: {nReturn = 0; break;}
        case 499: {nReturn = 0; break;}
        case 500: {nReturn = 2; break;}
        case 501: {nReturn = 0; break;}
        case 502: {nReturn = 0; break;}
        case 503: {nReturn = 0; break;}
        case 504: {nReturn = 0; break;}
        case 505: {nReturn = 0; break;}
        case 506: {nReturn = 0; break;}
        case 507: {nReturn = 0; break;}
        case 508: {nReturn = 0; break;}
        case 509: {nReturn = 0; break;}

        default:  {nReturn = 0;}

    }
    return nReturn;
}
