//:://////////////////////////////////////////////////
//:: Tethyr's Examine Tool
//:: TE_EXAMINE
//:: Copyright (c) 2015 Function(D20)
//:///////////////////////////////////////////////////
//:///////////////////////////////////////////////////
//:: Created By: David Novotny
//:: Created On: March 7, 2015
//:///////////////////////////////////////////////////
#include "NW_I0_GENERIC"
#include "nwnx_rename"

void main()
{
        object oPC = OBJECT_SELF;
        object oTarget = GetSpellTargetObject();
        int nPCSpot1 = GetSkillRank(SKILL_SPOT, oPC);
        int nPCSpot2 = GetSkillRank(SKILL_SPOT, oTarget);
        int nPCBluff = GetSkillRank(SKILL_BLUFF,oTarget);
        int nPCPerform = GetSkillRank(SKILL_PERFORM,oTarget);
        int nPCSpellcraft = GetSkillRank(SKILL_SPELLCRAFT,oPC);
        int nSTR = GetAbilityScore(oTarget, ABILITY_STRENGTH, FALSE);
        int nDEX = GetAbilityScore(oTarget, ABILITY_DEXTERITY, FALSE);
        int nCON = GetAbilityScore(oTarget, ABILITY_CONSTITUTION, FALSE);
        int nDiplo = GetSkillRank(SKILL_PERSUADE, oPC, FALSE);
        int nIntim = GetSkillRank(SKILL_INTIMIDATE, oPC, FALSE);
        int nBluff = GetSkillRank(SKILL_BLUFF, oPC, FALSE);
        string nTruename = GetName(oTarget);
        string nDisgname = NWNX_Rename_GetPCNameOverride(oTarget);

        if(GetLocalInt(oTarget,"nDisguiseName") == 1)
        {
            nTruename = GetLocalString(oTarget,"sOriginalName");
        }

        string nPCName = GetName(oPC);

        int nAbjuration = 0;
        int nConjuration = 0;
        int nDivination = 0;
        int nEnchantment = 0;
        int nEvocation = 0;
        int nGeneral = 0;
        int nNecromancy = 0;
        int nIllusion = 0;
        int nTransmutation = 0;

        int nLastExamine = GetLocalInt(oPC,"ExamineLast");
        int nTimeNow = (GetTimeHour()*100+GetTimeMinute());
        int nTimeDiff = abs(nLastExamine-nTimeNow);

        if(nLastExamine == 0)
        {
            nTimeDiff = 3;
        }

        if(nTimeDiff <= 1)
        {
            SendMessageToPC(oPC,"You may only examine something once per minute.");
            return;
        }
        else
        {
            SetLocalInt(oPC,"ExamineLast",nTimeNow);
        }

        if(GetObjectType(oTarget) == OBJECT_TYPE_ITEM)
        {
            int nMaterial = GetLocalInt(oTarget,"Material");

            if(nMaterial == 1 && GetSkillRank(SKILL_LORE) == 5)
            {SendMessageToPC(oPC,"This item is made of iron.");}
            if(nMaterial == 2 && GetSkillRank(SKILL_LORE) ==  7)
            {SendMessageToPC(oPC,"This item is made of steel.");}
            if(nMaterial == 3 && GetSkillRank(SKILL_LORE) ==  9)
            {SendMessageToPC(oPC,"This item is made of mithral.");}
            if(nMaterial == 4 && GetSkillRank(SKILL_LORE) ==  10)
            {SendMessageToPC(oPC,"This item is made of adamantine.");}
            if(nMaterial == 5 && GetSkillRank(SKILL_LORE) ==  5)
            {SendMessageToPC(oPC,"This item is made of wood.");}
            if(nMaterial == 6 && GetSkillRank(SKILL_LORE) ==  6)
            {SendMessageToPC(oPC,"This item is made of darkwood.");}
            if(nMaterial == 7 && GetSkillRank(SKILL_LORE) ==  5)
            {SendMessageToPC(oPC,"This item is made of hide.");}
            if(nMaterial == 12 && GetSkillRank(SKILL_LORE) ==  8)
            {SendMessageToPC(oPC,"This item is made of dragon hide.");}

            if(GetLocalInt(oTarget,"Masterwork") == 1)
            {SendMessageToPC(oPC,"This item is clearly of masterwork quality.");}

            int nDecay = GetLocalInt(oTarget,"Decay");
            int nDecayChk = 20 - nDecay;

            if(nPCSpot1 > 20-nDecay)
            {
                if(nDecay < 3)                       {SendMessageToPC(oPC,"This item seems to be near pristine.");}
                else if(nDecay >= 3 && nDecay < 5)   {SendMessageToPC(oPC,"This item seems to be slightly damaged.");}
                else if(nDecay >= 5 && nDecay < 10)  {SendMessageToPC(oPC,"This item seems to be deteriorated and will need servicing soon.");}
                else if(nDecay >= 10 && nDecay < 15) {SendMessageToPC(oPC,"This item seems to be nearly destroyed and will need servicing immediately.");}
                else if(nDecay >= 15 && nDecay < 19) {SendMessageToPC(oPC,"This item seems to as though it may fall apart at any moment.");}
            }
            else if (nDecay > 15)
            {
                SendMessageToPC(oPC,"This item seems to as though it may fall apart at any moment.");
            }

            int nDC = 20;

            if(GetLocalInt(oTarget,"ShadowWeave") == 1)
            {
                if(GetHasFeat(1176,oTarget)==TRUE)
                {
                    nDC = 15;
                }
                else
                {
                    nDC = 25;
                }
            }

            if(nPCSpellcraft > nDC)
            {
                nAbjuration += GetLocalInt(oTarget,"Archer");
                nAbjuration += GetLocalInt(oTarget,"Deathward");
                nAbjuration += GetLocalInt(oTarget,"Fortify");
                nAbjuration += GetLocalInt(oTarget,"Mind");
                nAbjuration += GetLocalInt(oTarget,"Mobility");
                nAbjuration += GetLocalInt(oTarget,"Reflexes");
                nAbjuration += GetLocalInt(oTarget,"Resistance");
                nAbjuration += GetLocalInt(oTarget,"SR");
                nAbjuration += GetLocalInt(oTarget,"Stoneskin");
                nConjuration += GetLocalInt(oTarget,"Regeneration");
                nConjuration += GetLocalInt(oTarget,"Wolf");
                nDivination += GetLocalInt(oTarget,"Finder");
                nDivination += GetLocalInt(oTarget,"Seeing");
                nDivination += GetLocalInt(oTarget,"Watchman");
                nEnchantment += GetLocalInt(oTarget,"Archery");
                nEnchantment += GetLocalInt(oTarget,"Cleaving");
                nEnchantment += GetLocalInt(oTarget,"Darkvision");
                nEnchantment += GetLocalInt(oTarget,"Master");
                nEvocation += GetLocalInt(oTarget,"Battle");
                nEvocation += GetLocalInt(oTarget,"Chaos");
                nEvocation += GetLocalInt(oTarget,"Elemental");
                nEvocation += GetLocalInt(oTarget,"Force");
                nEvocation += GetLocalInt(oTarget,"Holy");
                nEvocation += GetLocalInt(oTarget,"HolyMight");
                nEvocation += GetLocalInt(oTarget,"Keen");
                nEvocation += GetLocalInt(oTarget,"Law");
                nEvocation += GetLocalInt(oTarget,"Mighty");
                nEvocation += GetLocalInt(oTarget,"Returning");
                nEvocation += GetLocalInt(oTarget,"Spined");
                nGeneral += GetLocalInt(oTarget,"Knowledge");
                nGeneral += GetLocalInt(oTarget,"Lore");
                nGeneral += GetLocalInt(oTarget,"Spellcraft");
                nIllusion += GetLocalInt(oTarget,"Colors");
                nIllusion += GetLocalInt(oTarget,"Displacement");
                nIllusion += GetLocalInt(oTarget,"Glamer");
                nIllusion += GetLocalInt(oTarget,"Hiding");
                nIllusion += GetLocalInt(oTarget,"Invisibility");
                nIllusion += GetLocalInt(oTarget,"Shadow");
                nIllusion += GetLocalInt(oTarget,"Silent");
                nIllusion += GetLocalInt(oTarget,"Subtle");
                nEvocation += GetLocalInt(oTarget,"SpellPower");
                nNecromancy += GetLocalInt(oTarget,"Poison");
                nNecromancy += GetLocalInt(oTarget,"Vampiric");
                nNecromancy += GetLocalInt(oTarget,"Vorpal");
                nNecromancy += GetLocalInt(oTarget,"UndeadControl");
                nTransmutation += GetLocalInt(oTarget,"Agility");
                nTransmutation += GetLocalInt(oTarget,"Animal");
                nTransmutation += GetLocalInt(oTarget,"Appraisal");
                nTransmutation += GetLocalInt(oTarget,"Armor");
                nTransmutation += GetLocalInt(oTarget,"Dexterity");
                nTransmutation += GetLocalInt(oTarget,"Giant");
                nTransmutation += GetLocalInt(oTarget,"Glamour");
                nTransmutation += GetLocalInt(oTarget,"Health");
                nTransmutation += GetLocalInt(oTarget,"Intellect");
                nTransmutation += GetLocalInt(oTarget,"Nymph");
                nTransmutation += GetLocalInt(oTarget,"OgreStr");
                nTransmutation += GetLocalInt(oTarget,"Petrification");
                nTransmutation += GetLocalInt(oTarget,"Speed");
                nTransmutation += GetLocalInt(oTarget,"Striding");
                nTransmutation += GetLocalInt(oTarget,"Thieves");
                nTransmutation += GetLocalInt(oTarget,"Tumbling");
                nTransmutation += GetLocalInt(oTarget,"WeaponEnchantCount");
                nTransmutation += GetLocalInt(oTarget,"Wisdom");

                if(nAbjuration >= 1 && nAbjuration <= 5)
                {
                    SendMessageToPC(oPC,GetName(oTarget)+" seems to possess a faint aura of Abjuration.");
                }
                else if(nAbjuration > 5 && nAbjuration <=10)
                {
                    SendMessageToPC(oPC,GetName(oTarget)+" seems to possess a moderate aura of Abjuration.");
                }
                else if(nAbjuration > 10 && nAbjuration <=15)
                {
                    SendMessageToPC(oPC,GetName(oTarget)+" seems to possess a strong aura of Abjuration.");
                }
                else if(nAbjuration > 15)
                {
                    SendMessageToPC(oPC,GetName(oTarget)+" seems to possess a overwhelming aura of Abjuration.");
                }
                else{}

                if(nConjuration >= 1 && nConjuration <= 5)
                {
                    SendMessageToPC(oPC,GetName(oTarget)+" seems to possess a faint aura of Conjuration.");
                }
                else if(nConjuration > 5 && nConjuration <=10)
                {
                    SendMessageToPC(oPC,GetName(oTarget)+" seems to possess a moderate aura of Conjuration.");
                }
                else if(nConjuration > 10 && nConjuration <=15)
                {
                    SendMessageToPC(oPC,GetName(oTarget)+" seems to possess a strong aura of Conjuration.");
                }
                else if(nConjuration > 15)
                {
                    SendMessageToPC(oPC,GetName(oTarget)+" seems to possess a overwhelming aura of Conjuration.");
                }
                else{}

                if(nDivination >= 1 && nDivination <= 5)
                {
                    SendMessageToPC(oPC,GetName(oTarget)+" seems to possess a faint aura of Divination.");
                }
                else if(nDivination > 5 && nDivination <=10)
                {
                    SendMessageToPC(oPC,GetName(oTarget)+" seems to possess a moderate aura of Divination.");
                }
                else if(nDivination > 10 && nDivination <=15)
                {
                    SendMessageToPC(oPC,GetName(oTarget)+" seems to possess a strong aura of Divination.");
                }
                else if(nDivination > 15)
                {
                    SendMessageToPC(oPC,GetName(oTarget)+" seems to possess a overwhelming aura of Divination.");
                }
                else{}

                if(nEnchantment >= 1 && nEnchantment <= 5)
                {
                    SendMessageToPC(oPC,GetName(oTarget)+" seems to possess a faint aura of Enchantment.");
                }
                else if(nEnchantment > 5 && nEnchantment <=10)
                {
                    SendMessageToPC(oPC,GetName(oTarget)+" seems to possess a moderate aura of Enchantment.");
                }
                else if(nEnchantment > 10 && nEnchantment <=15)
                {
                    SendMessageToPC(oPC,GetName(oTarget)+" seems to possess a strong aura of Enchantment.");
                }
                else if(nEnchantment > 15)
                {
                    SendMessageToPC(oPC,GetName(oTarget)+" seems to possess a overwhelming aura of Enchantment.");
                }
                else{}

                if(nEvocation >= 1 && nEvocation <= 5)
                {
                    SendMessageToPC(oPC,GetName(oTarget)+" seems to possess a faint aura of Evocation.");
                }
                else if(nEvocation > 5 && nEvocation <=10)
                {
                    SendMessageToPC(oPC,GetName(oTarget)+" seems to possess a moderate aura of Evocation.");
                }
                else if(nEvocation > 10 && nEvocation <=15)
                {
                    SendMessageToPC(oPC,GetName(oTarget)+" seems to possess a strong aura of Evocation.");
                }
                else if(nEvocation > 15)
                {
                    SendMessageToPC(oPC,GetName(oTarget)+" seems to possess a overwhelming aura of Evocation.");
                }
                else{}

                if(nGeneral >= 1 && nGeneral <= 5)
                {
                    SendMessageToPC(oPC,GetName(oTarget)+" seems to possess a faint aura of General magic.");
                }
                else if(nGeneral > 5 && nGeneral <=10)
                {
                    SendMessageToPC(oPC,GetName(oTarget)+" seems to possess a moderate aura of General magic.");
                }
                else if(nGeneral > 10 && nGeneral <=15)
                {
                    SendMessageToPC(oPC,GetName(oTarget)+" seems to possess a strong aura of General magic.");
                }
                else if(nGeneral > 15)
                {
                    SendMessageToPC(oPC,GetName(oTarget)+" seems to possess a overwhelming aura of General magic.");
                }
                else{}

                if(nNecromancy >= 1 && nNecromancy <= 5)
                {
                    SendMessageToPC(oPC,GetName(oTarget)+" seems to possess a faint aura of Necromancy.");
                }
                else if(nNecromancy > 5 && nNecromancy <=10)
                {
                    SendMessageToPC(oPC,GetName(oTarget)+" seems to possess a moderate aura of Necromancy.");
                }
                else if(nNecromancy > 10 && nNecromancy <=15)
                {
                    SendMessageToPC(oPC,GetName(oTarget)+" seems to possess a strong aura of Necromancy.");
                }
                else if(nNecromancy > 15)
                {
                    SendMessageToPC(oPC,GetName(oTarget)+" seems to possess a overwhelming aura of Necromancy.");
                }
                else{}

                if(nTransmutation >= 1 && nTransmutation <= 5)
                {
                    SendMessageToPC(oPC,GetName(oTarget)+" seems to possess a faint aura of Transmutation.");
                }
                else if(nTransmutation > 5 && nTransmutation <=10)
                {
                    SendMessageToPC(oPC,GetName(oTarget)+" seems to possess a moderate aura of Transmutation.");
                }
                else if(nTransmutation > 10 && nTransmutation <=15)
                {
                    SendMessageToPC(oPC,GetName(oTarget)+" seems to possess a strong aura of Transmutation.");
                }
                else if(nTransmutation > 15)
                {
                    SendMessageToPC(oPC,GetName(oTarget)+" seems to possess a overwhelming aura of Transmutation.");
                }
            }
        }
        else if (GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
        {

            // Roll Modifiers
            if (GetLevelByClass(CLASS_TYPE_DRUID, oTarget) > 13)
            {
                nPCBluff = nPCBluff + 20;
                nPCPerform = nPCPerform + 20;
            }

            if (GetLevelByClass(CLASS_TYPE_ASSASSIN, oTarget) > 0)
            {
                nPCBluff = nPCBluff + 5;
                nPCPerform = nPCPerform + 5;
            }

            if (GetHasFeat(BACKGROUND_COSMOPOLITAN,oTarget)== TRUE)
            {
                nPCBluff = nPCBluff + 2;
                nPCPerform = nPCPerform + 2;
            }

            if(GetHasFeat(1482,oTarget) == TRUE)
            {
                nPCBluff = nPCBluff + 5;
                nPCPerform = nPCPerform + 5;
            }

            if (GetHasFeat(BACKGROUND_SCOUT, oPC) == TRUE)
            {
                nPCSpot1 = nPCSpot1 + 2;
            }

            if (GetHasFeat(1484, oPC) == TRUE)
            {
                nPCSpot1 = nPCSpot1 + 5;
            }

            if (nPCSpot2 > nPCSpot1)
            {
                SendMessageToPC(oTarget,nPCName + " is staring at you.");
                nPCBluff = nPCBluff + 5;
                nPCPerform = nPCPerform + 5;
            }
            //End roll modifiers

            if (GetIsPC(oTarget) == TRUE)
            {
                //NAME STUFF
                    if (nPCBluff >= nPCPerform) //Use Bluff instead of Perform
                    {
                        if (nPCBluff >= nPCSpot1) //YOU LOST!
                        {
                            SendMessageToPC(oPC,"Name: " + nDisgname);
                            if (GetLocalInt(oTarget,"iDisguise") == 1)
                                {
                                    //LOSING CASE, You don't know if this person is attempting to disguise themself.
                                    SendMessageToPC(oPC,"This character is not attempting to disguise themself.");
                                    if(nPCSpot2 > nPCSpot1)
                                    {
                                        SendMessageToPC(oTarget,"Your disguise has passed scrutiny.");
                                    }
                                }
                                else
                                {
                                    SendMessageToPC(oPC,"This character is not attempting to disguise themself.");
                                }

                            if ((GetHasFeat(BACKGROUND_TIEFLING,oTarget)==TRUE) || (GetHasFeat(BACKGROUND_AASIMAR,oTarget)==TRUE))
                            {
                                SendMessageToPC(oPC, "The person in front of you gives you a sense of unease as if they are not of this world.");
                            }
                        }
                        else if (nPCBluff < nPCSpot1) //YOU WON
                        {
                            SendMessageToPC(oPC,"Name: " + nTruename);
                            if (GetLocalInt(oTarget,"iDisguise") == 1)
                                {
                                    SendMessageToPC(oPC,"This character is attempting to disguise themself. You doubt whether your gleanings on them have merit.");
                                    if(nPCSpot2 > nPCSpot1)
                                    {
                                        SendMessageToPC(oTarget,"Your disguise has not passed scrutiny!");
                                    }
                                }
                                else
                                {
                                    SendMessageToPC(oPC,"This character is not attempting to disguise themself.");
                                }

                            if ((GetHasFeat(BACKGROUND_TIEFLING,oTarget)==TRUE) || (GetHasFeat(BACKGROUND_AASIMAR,oTarget)==TRUE))
                            {
                                SendMessageToPC(oPC, "The person in front of you gives you a sense of unease as if they are not of this world.");
                            }
                            if (GetLevelByClass(CLASS_TYPE_DRAGONDISCIPLE,oTarget))
                            {
                                SendMessageToPC(oPC, "The person in front of you possesses traits that are clearly not normal for humanoids. Their skin seems to have a ruby colored flecks and scales sprouting from it.");
                            }
                        }
                    }
                    else // Use Perform instead of Bluff
                    {
                        if (nPCPerform >= nPCSpot1) //YOU LOST
                        {
                            SendMessageToPC(oPC,"Name: " + nDisgname);
                            if (GetLocalInt(oTarget, "iDisguise") == 1)
                                {
                                    //LOSING CASE, You don't know if this person is attempting to disguise themself.
                                    SendMessageToPC(oPC,"This character is not attempting to disguise themself.");
                                    if(nPCSpot2 > nPCSpot1)
                                    {
                                        SendMessageToPC(oTarget,"Your disguise has passed scrutiny.");
                                    }
                                }
                                else
                                {
                                    SendMessageToPC(oPC,"This character is not attempting to disguise themself.");
                                }
                            if ((GetHasFeat(BACKGROUND_TIEFLING,oTarget)==TRUE) || (GetHasFeat(BACKGROUND_AASIMAR,oTarget)==TRUE))
                            {
                                SendMessageToPC(oPC, "The person in front of you gives you a sense of unease as if they are not of this world.");
                            }
                        }
                        else if (nPCPerform < nPCSpot1) //YOU WON
                        {
                            SendMessageToPC(oPC,"Name: " + nTruename);
                            if (GetLocalInt(oTarget,"iDisguise") == 1)
                                {
                                    SendMessageToPC(oPC,"This character is attempting to disguise themself. You doubt whether your gleanings on them have merit.");
                                    if(nPCSpot2 > nPCSpot1)
                                    {
                                        SendMessageToPC(oTarget,"Your disguise has not passed scrutiny!");
                                    }
                                }
                                else
                                {
                                    SendMessageToPC(oPC,"This character is not attempting to disguise themself.");
                                }
                            if ((GetHasFeat(BACKGROUND_TIEFLING,oTarget)==TRUE) || (GetHasFeat(BACKGROUND_AASIMAR,oTarget)==TRUE))
                            {
                                SendMessageToPC(oPC, "The person in front of you gives you a sense of unease as if they are not of this world.");
                            }
                        }
                    }

                //End name stuff
            string nFeedback = "Magical Warding: ";

                //MAGIC STUFF
                if (GetHasFeat(1176,oTarget)==TRUE)
                {
                    nFeedback += "This individual appears to have no currently active magical effects that you can detect.\n";
                }
                else
                {
                    if (nPCSpellcraft >= 15)
                    {

                        if (GetHasEffect(38,oTarget) && GetHasEffect(46,oTarget) && GetHasEffect(52,oTarget))
                        {
                            nFeedback += "This individual appears to be heavily warded.\n";
                        }
                        else if (GetHasEffect(38,oTarget) || GetHasEffect(46,oTarget) || GetHasEffect(52,oTarget))
                        {
                            nFeedback += "This individual appears to be warded for combat.\n";
                        }
                        else
                        {
                            nFeedback += "This individual appears to have no currently active magical effects that you can detect.\n";
                        }
                    }
                    else
                    {
                        nFeedback += "This individual appears to have no currently active magical effects that you can detect.\n";
                    }
                }

                if(nPCSpellcraft >= 15)
                {
                    nFeedback += "Magical Auras: ";
                    object oItem = GetFirstItemInInventory(oTarget);

                    while (oItem != OBJECT_INVALID)
                    {
                        nAbjuration += GetLocalInt(oItem,"Archer");
                        nAbjuration += GetLocalInt(oItem,"Deathward");
                        nAbjuration += GetLocalInt(oItem,"Fortify");
                        nAbjuration += GetLocalInt(oItem,"Mind");
                        nAbjuration += GetLocalInt(oItem,"Mobility");
                        nAbjuration += GetLocalInt(oItem,"Reflexes");
                        nAbjuration += GetLocalInt(oItem,"Resistance");
                        nAbjuration += GetLocalInt(oItem,"SR");
                        nAbjuration += GetLocalInt(oItem,"Stoneskin");
                        nConjuration += GetLocalInt(oItem,"Regeneration");
                        nConjuration += GetLocalInt(oItem,"Wolf");
                        nDivination += GetLocalInt(oItem,"Finder");
                        nDivination += GetLocalInt(oItem,"Seeing");
                        nDivination += GetLocalInt(oItem,"Watchman");
                        nEnchantment += GetLocalInt(oItem,"Archery");
                        nEnchantment += GetLocalInt(oItem,"Cleaving");
                        nEnchantment += GetLocalInt(oItem,"Darkvision");
                        nEnchantment += GetLocalInt(oItem,"Master");
                        nEvocation += GetLocalInt(oItem,"Battle");
                        nEvocation += GetLocalInt(oItem,"Chaos");
                        nEvocation += GetLocalInt(oItem,"Elemental");
                        nEvocation += GetLocalInt(oItem,"Force");
                        nEvocation += GetLocalInt(oItem,"Holy");
                        nEvocation += GetLocalInt(oItem,"HolyMight");
                        nEvocation += GetLocalInt(oItem,"Keen");
                        nEvocation += GetLocalInt(oItem,"Law");
                        nEvocation += GetLocalInt(oItem,"Mighty");
                        nEvocation += GetLocalInt(oItem,"Returning");
                        nEvocation += GetLocalInt(oItem,"Spined");
                        nGeneral += GetLocalInt(oItem,"Knowledge");
                        nGeneral += GetLocalInt(oItem,"Lore");
                        nGeneral += GetLocalInt(oItem,"Spellcraft");
                        nIllusion += GetLocalInt(oItem,"Colors");
                        nIllusion += GetLocalInt(oItem,"Displacement");
                        nIllusion += GetLocalInt(oItem,"Glamer");
                        nIllusion += GetLocalInt(oItem,"Hiding");
                        nIllusion += GetLocalInt(oItem,"Invisibility");
                        nIllusion += GetLocalInt(oItem,"Shadow");
                        nIllusion += GetLocalInt(oItem,"Silent");
                        nIllusion += GetLocalInt(oItem,"Subtle");
                        nEvocation += GetLocalInt(oItem,"SpellPower");
                        nNecromancy += GetLocalInt(oItem,"Poison");
                        nNecromancy += GetLocalInt(oItem,"Vampiric");
                        nNecromancy += GetLocalInt(oItem,"Vorpal");
                        nNecromancy += GetLocalInt(oItem,"UndeadControl");
                        nTransmutation += GetLocalInt(oItem,"Agility");
                        nTransmutation += GetLocalInt(oItem,"Animal");
                        nTransmutation += GetLocalInt(oItem,"Appraisal");
                        nTransmutation += GetLocalInt(oItem,"Armor");
                        nTransmutation += GetLocalInt(oItem,"Dexterity");
                        nTransmutation += GetLocalInt(oItem,"Giant");
                        nTransmutation += GetLocalInt(oItem,"Glamour");
                        nTransmutation += GetLocalInt(oItem,"Health");
                        nTransmutation += GetLocalInt(oItem,"Intellect");
                        nTransmutation += GetLocalInt(oItem,"Nymph");
                        nTransmutation += GetLocalInt(oItem,"OgreStr");
                        nTransmutation += GetLocalInt(oItem,"Petrification");
                        nTransmutation += GetLocalInt(oItem,"Speed");
                        nTransmutation += GetLocalInt(oItem,"Striding");
                        nTransmutation += GetLocalInt(oItem,"Thieves");
                        nTransmutation += GetLocalInt(oItem,"Tumbling");
                        nTransmutation += GetLocalInt(oItem,"WeaponEnchantCount");
                        nTransmutation += GetLocalInt(oItem,"Wisdom");
                        oItem = GetNextItemInInventory(oTarget);
                    }

                    if(nAbjuration >= 1 && nAbjuration <= 5)                    {nFeedback += "Abjuration - Faint \n";}
                    else if(nAbjuration > 5 && nAbjuration <=10)                {nFeedback += "Abjuration - Moderate \n";}
                    else if(nAbjuration > 10 && nAbjuration <=15)               {nFeedback += "Abjuration - Strong \n";}
                    else if(nAbjuration > 15)                                   {nFeedback += "Abjuration - Overwhelming \n";}

                    if(nConjuration >= 1 && nConjuration <= 5)                  {nFeedback += "Conjuration - Faint \n";}
                    else if(nConjuration > 5 && nConjuration <=10)              {nFeedback += "Conjuration - Moderate \n";}
                    else if(nConjuration > 10 && nConjuration <=15)             {nFeedback += "Conjuration - Strong \n";}
                    else if(nConjuration > 15)                                  {nFeedback += "Conjuration - Overwhelming \n";}

                    if(nDivination >= 1 && nDivination <= 5)                    {nFeedback += "Divination - Faint \n";}
                    else if(nDivination > 5 && nDivination <=10)                {nFeedback += "Divination - Moderate \n";}
                    else if(nDivination > 10 && nDivination <=15)               {nFeedback += "Divination - Strong \n";}
                    else if(nDivination > 15)                                   {nFeedback += "Divination - Overwhelming. \n";}

                    if(nEnchantment >= 1 && nEnchantment <= 5)                  {nFeedback += "Enchantment - Faint \n";}
                    else if(nEnchantment > 5 && nEnchantment <=10)              {nFeedback += "Enchantment - Moderate \n";}
                    else if(nEnchantment > 10 && nEnchantment <=15)             {nFeedback += "Enchantment - Strong \n";}
                    else if(nEnchantment > 15)                                  {nFeedback += "Enchantment - Overwhelming. \n";}

                    if(nEvocation >= 1 && nEvocation <= 5)                      {nFeedback += "Evocation - Faint \n";}
                    else if(nEvocation > 5 && nEvocation <=10)                  {nFeedback += "Evocation - Moderate \n";}
                    else if(nEvocation > 10 && nEvocation <=15)                 {nFeedback += "Evocation - Strong \n";}
                    else if(nEvocation > 15)                                    {nFeedback += "Evocation - Overwhelming \n";}

                    if(nGeneral >= 1 && nGeneral <= 5)                          {nFeedback += "General Magic - Faint \n";}
                    else if(nGeneral > 5 && nGeneral <=10)                      {nFeedback += "General Magic - Moderate \n";}
                    else if(nGeneral > 10 && nGeneral <=15)                     {nFeedback += "General Magic - Strong \n";}
                    else if(nGeneral > 15)                                      {nFeedback += "General Magic - Overwhelming \n";}

                    if(nNecromancy >= 1 && nNecromancy <= 5)                    {nFeedback += "Necromancy - Faint \n";}
                    else if(nNecromancy > 5 && nNecromancy <=10)                {nFeedback += "Necromancy - Moderate \n";}
                    else if(nNecromancy > 10 && nNecromancy <=15)               {nFeedback += "Necromancy - Strong \n";}
                    else if(nNecromancy > 15)                                   {nFeedback += "Necromancy - Overwhelming \n";}

                    if(nTransmutation >= 1 && nTransmutation <= 5)              {nFeedback += "Transmutation - Faint \n";}
                    else if(nTransmutation > 5 && nTransmutation <=10)          {nFeedback += "Transmutation - Moderate \n";}
                    else if(nTransmutation > 10 && nTransmutation <=15)         {nFeedback += "Transmutation - Strong \n";}
                    else if(nTransmutation > 15)                                {nFeedback += "Transmutation - Overwhelming \n";}
                }

                if(GetLevelByClass(51,oPC) >= 5 && GetLevelByClass(CLASS_TYPE_PALADIN,oTarget) >= 1)
                {
                    nFeedback += "Aura of Grace: This individual's aura of good is ";
                    if(GetLocalInt(GetItemPossessedBy(oTarget,"PC_Data_Object"),"nPiety") >= 80)
                    {
                        nFeedback += "intact. They appear to have favor with their deity. \n";
                    }
                    else if(GetLocalInt(GetItemPossessedBy(oTarget,"PC_Data_Object"),"nPiety") < 80 && GetLocalInt(GetItemPossessedBy(oTarget,"PC_Data_Object"),"nPiety") >= 40)
                    {
                        nFeedback += " fractured. They still have favor with their deity, but their lifestyle is not fully in accordance with their vows. \n";
                    }
                    else if (GetLocalInt(GetItemPossessedBy(oTarget,"PC_Data_Object"),"nPiety") < 40 && GetLocalInt(GetItemPossessedBy(oTarget,"PC_Data_Object"),"nPiety") >= 10)
                    {
                        nFeedback += " shattered. They appear to have nearly fallen out of favor with their deity. \n" ;
                    }
                    else
                    {
                        nFeedback += " absent. They appear to have completely fallen out of favor with their deity. \n" ;
                    }
                }

                //End magical stuff

                nFeedback += "Physical Characteristics: ";
                //Class Standing
                if(GetLocalInt(oTarget,"nDisStand") > 0)
                {
                    if(GetLocalInt(oTarget,"nDisStand") == 1)       {nFeedback += "This person appears to carry themselves like a peasant ";}
                    else if(GetLocalInt(oTarget,"nDisStand") == 2)  {nFeedback += "This person appears to carry themselves like a lesser noble ";}
                    else if(GetLocalInt(oTarget,"nDisStand") == 3)  {nFeedback += "This person appears to carry themselves like a noble ";}
                }
                else
                {
                    if(GetHasFeat(1150,oTarget) == TRUE)            {nFeedback += "This person appears to carry themselves like a peasant ";}
                    else if(GetHasFeat(1151,oTarget) == TRUE)       {nFeedback += "This person appears to carry themselves like a lesser noble ";}
                    else if(GetHasFeat(1152,oTarget) == TRUE)       {nFeedback += "This person appears to carry themselves like a noble ";}
                }

                nFeedback += "and seems to have ";

                //ABILITY STUFF
                if(nSTR < 12 || GetLocalInt(oTarget,"nDisSTR") == 1)                            {nFeedback += "less than average strength, ";}
                else if (( (nSTR >= 12)&&(nSTR < 15) ) || GetLocalInt(oTarget,"nDisSTR") == 2)  {nFeedback += "average strength, ";}
                else if (( (nSTR >= 15)&&(nSTR < 19) ) || GetLocalInt(oTarget,"nDisSTR") == 3)  {nFeedback += "exceptional strength, ";}
                else if (nSTR >= 20 || GetLocalInt(oTarget,"nDisSTR") == 4)                     {nFeedback += "extraordinary strength, ";}

                if(nDEX < 12|| GetLocalInt(oTarget,"nDisDEX") == 1)                             {nFeedback += "less than average agility, ";}
                else if (( (nDEX >= 12)&&(nDEX < 15) ) || GetLocalInt(oTarget,"nDisDEX") == 2)  {nFeedback += "average agility, ";}
                else if (( (nDEX >= 15)&&(nDEX < 19) )|| GetLocalInt(oTarget,"nDisDEX") == 3)   {nFeedback += "exceptional agility, ";}
                else if (nDEX >= 20 || GetLocalInt(oTarget,"nDisDEX") == 4)                     {nFeedback += "extraordinary agility, ";}

                if(nCON < 12 || GetLocalInt(oTarget,"nDisCON") == 1)                            {nFeedback += "and less than average hardiness. ";}
                else if (( (nCON >= 12)&&(nCON < 15) ) || GetLocalInt(oTarget,"nDisCON") == 2)  {nFeedback += "and average hardiness. ";}
                else if (( (nCON >= 15)&&(nCON < 19) ) || GetLocalInt(oTarget,"nDisCON") == 3)  {nFeedback += "and exceptional hardiness. ";}
                else if (nCON >= 20 || GetLocalInt(oTarget,"nDisCON") == 4)                     {nFeedback += "and extraordinary hardiness. ";}
                //End ability stuff

                object oDataObject = GetItemPossessedBy(oTarget,"PC_Data_Object");
                int nExhaust = GetLocalInt(oDataObject,"nExhaust");
                int nFatigue = GetLocalInt(oDataObject,"nFatigue");
                int nBlood   = GetLocalInt(oDataObject,"nBlood");
                int nSticky  = GetLocalInt(oDataObject,"nSticky");
                int nDust    = GetLocalInt(oDataObject,"nDust");
                int nPlan    = GetLocalInt(oDataObject,"nPlan");
                int nWet     = GetLocalInt(oDataObject,"nWet");
                int nMud     = GetLocalInt(oDataObject,"nMud");

                nFeedback += "Their clothing is ";

                if(nBlood >= 25)    {nFeedback += "soiled with blood, ";}
                else                {nFeedback += "free of blood, ";}
                if(nSticky >= 25)   {nFeedback += "covered in something sticky, ";}
                else                {nFeedback += "free of stickiness, ";}
                if(nDust >= 25)     {nFeedback += "doused with dust, ";}
                else                {nFeedback += "free of dust, ";}
                if(nPlan >= 25)     {nFeedback += "smells otherworldly, ";}
                if(nWet >= 50)      {nFeedback += "dripping wet, ";}
                if(nMud >= 30)      {nFeedback += "and their boots are muddy.";}
                else                {nFeedback += "and their boots are clean.";}

                if(nFatigue == TRUE)
                {
                    if(nExhaust == TRUE){nFeedback += "\nThey appear to be exhausted.";}
                    else{                nFeedback += "\nThey appear appear to be fatigued.";}
                }

                object oInsig = GetItemPossessedBy(oTarget,"te_insignia");
                int nHonor = GetLocalInt(oInsig,"nHonor");
                int nHonorTotal = GetLocalInt(oInsig,"nHonorTotal");

                if(GetLocalInt(oTarget,"iDisguise") != 1)
                {
                    nFeedback+="\nNotoriety: ";
                    if(GetLocalString(oInsig,"Settlement") == "sLock")          {nFeedback += "They are wearing an insignia of Lockwood Falls and ";}
                    else if(GetLocalString(oInsig,"Settlement") == "sBrost")    {nFeedback += "They are wearing an insignia of Brost and ";}
                    else if(GetLocalString(oInsig,"Settlement") == "sSpire")    {nFeedback += "They are wearing an insignia of Southspire Hold and ";}
                    else if(GetLocalString(oInsig,"Settlement") == "sSwamp")    {nFeedback += "They are wearing an insignia of Swamprise Keep and "; }
                    else if(GetLocalString(oInsig,"Settlement") == "sTejarn")   {nFeedback += "They are wearing an insignia of Tejarn Gate and ";}
                    else                                                        {nFeedback += "They are not wearing any insignia and ";}

                    if(nHonor > 5)                                              {nFeedback += "you have heard of this individual recently performing deeds of valor.";}
                    else if (nHonor == 0 && nHonorTotal > 100)                  {nFeedback += "you have heard of this individual performing deeds of valor in the past.";}
                    else                                                        {nFeedback += "you haven't heard of any deeds of valor that this person has performed.";}
                }

                //Natty Lycan Stuff
                if ( (GetHasFeat(BACKGROUND_FORESTER,oPC) == TRUE) && (GetHasFeat(BACKGROUND_NAT_LYCAN,oTarget) == TRUE) )
                {
                    nFeedback += "\nThe person before you seems on edge and overly aware of their surroundings. They have a feral feel about them that reminds you of the wolves you have often encountered in the forest. ";
                }

                if ( (GetHasFeat(BACKGROUND_NAT_LYCAN,oPC)== TRUE) && (GetHasFeat(BACKGROUND_NAT_LYCAN,oTarget) == TRUE) )
                {
                    nFeedback += "\nThe scent before you is a familiar one...The scent of a werewolf, much like yourself. ";
                }
                 //End Natty Lycan Stuff

                //Weird Class Things.
                if(GetHasFeat(1137, oPC) == TRUE && GetHasFeat(1137,oTarget) == TRUE)
                {
                    nFeedback += " There is something oddly familiar about this person, and after a moment you are reminded of your patron from the lower planes...";
                }

                if(GetHasFeat(1139, oPC) == TRUE && GetHasFeat(1139,oTarget) == TRUE)
                {
                    nFeedback += " There is something oddly familiar about this person, and after a moment you are reminded of your patron from the lower planes...";
                }

                SendMessageToPC(oPC,nFeedback);
            }
            else
            {SendMessageToPC(oPC,"Not a valid target of the examine tool.");}
        }
}
