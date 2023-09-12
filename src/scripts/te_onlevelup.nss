//:://////////////////////////////////////////////
//:: OnLevelUp
//:: TE_LevelUp
//:: Function(D20) 2016
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: David Novotny
//:: Created On: March 22, 2016
//:://////////////////////////////////////////////
//Constants for all background feats.
#include "nw_i0_plot"
#include "te_functions"
#include "nwnx_creature"
#include "sf_hips_inc"


void main()
{
    SF_HipsRestrictionOnPCLevelUp();
    object oPC = GetPCLevellingUp();
    int iCL = GetHitDice(oPC);
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");

    //Restrictions
    /////
    ////
    //Bladesinger/Drow
    if (GetLevelByClass(53,oPC) >= 1 && GetItemPossessedBy(oPC,"TE_DM_BS") == OBJECT_INVALID)
    {
        int nXP = GetXP(oPC);
        int nLXP = ((iCL-1) * 1000);
        SetXP(oPC,(nXP - nLXP));
        SetXP(oPC, nXP);
        SendMessageToPC(oPC, "<cþ  >It is becoming more and more difficult to discover new insights on your own.");
        return;
    }
    //Warlock Level 5 Gate
    if ((GetLevelByClass(47,oPC) >= 7)&&(GetItemPossessedBy(oPC,"TE_DM_WAR")== OBJECT_INVALID))
    {
        int nXP = GetXP(oPC);
        int nLXP = ((iCL-1) * 1000);
        SetXP(oPC,(nXP - nLXP));
        SetXP(oPC, nXP);
        SendMessageToPC(oPC, "<cþ  >It is becoming more and more difficult to discover new insights on your own.");
        return;
    }
    //RDD Level 5 Gate
    if ((GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE,oPC) >= 5)&&(GetItemPossessedBy(oPC,"TE_DM_RDD")== OBJECT_INVALID))
    {
        int nXP = GetXP(oPC);
        int nLXP = ((iCL-1) * 1000);
        SetXP(oPC,(nXP - nLXP));
        SetXP(oPC, nXP);
        SendMessageToPC(oPC, "<cþ  >It is becoming more and more difficult to discover new insights on your own.");
        return;
    }
    //BG Level 5 Gate
    if ((GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC) >= 5)&&(GetItemPossessedBy(oPC,"TE_DM_BG")== OBJECT_INVALID))
    {
        int nXP = GetXP(oPC);
        int nLXP = ((iCL-1) * 1000);
        SetXP(oPC,(nXP - nLXP));
        SetXP(oPC, nXP);
        SendMessageToPC(oPC, "<cþ  >It is becoming more and more difficult to discover new insights on your own.");
        return;
    }
    //Druid
    if (GetLevelByClass(CLASS_TYPE_DRUID,oPC) >=1)
    {
        if ((GetLevelByClass(CLASS_TYPE_DRUID,oPC) == 12) && (GetItemPossessedBy(oPC, "TE_DM_DR1") == OBJECT_INVALID))
        {
            int nXP = GetXP(oPC);
            int nLXP = ((iCL-1) * 1000);
            SetXP(oPC,(nXP - nLXP));
            SetXP(oPC, nXP);
            SendMessageToPC(oPC, "<cþ  >You must successfully complete the Challenge to advance further in the druidic hierarchy.");
            return;
        }
        else if ((GetLevelByClass(CLASS_TYPE_DRUID,oPC) == 13) && (GetItemPossessedBy(oPC, "TE_DM_DR2") == OBJECT_INVALID))
        {
            int nXP = GetXP(oPC);
            int nLXP = ((iCL-1) * 1000);
            SetXP(oPC,(nXP - nLXP));
            SetXP(oPC, nXP);
            SendMessageToPC(oPC, "<cþ  >You must successfully complete the Challenge to advance further in the druidic hierarchy.");
            return;
        }
        else if ((GetLevelByClass(CLASS_TYPE_DRUID,oPC) == 14) && (GetItemPossessedBy(oPC, "TE_DM_DR3") == OBJECT_INVALID))
        {
            int nXP = GetXP(oPC);
            int nLXP = ((iCL-1) * 1000);
            SetXP(oPC,(nXP - nLXP));
            SetXP(oPC, nXP);
            SendMessageToPC(oPC, "<cþ  >You must successfully complete the Challenge to advance further in the druidic hierarchy.");
            return;
        }
        else if ((GetLevelByClass(CLASS_TYPE_DRUID,oPC) == 15) && (GetItemPossessedBy(oPC, "TE_DM_DR4") == OBJECT_INVALID))
        {
            int nXP = GetXP(oPC);
            int nLXP = ((iCL-1) * 1000);
            SetXP(oPC,(nXP - nLXP));
            SetXP(oPC, nXP);
            SendMessageToPC(oPC, "<cþ  >You must successfully complete the Challenge to advance further in the druidic hierarchy.");
            return;
        }
    }
    ////////////////////////////////////////////////////////////////////////
    //EX-BARB
    if(GetHasFeat(1416, oPC) == TRUE)
    {
        int nXP = GetXP(oPC);
        int nLXP = ((iCL-1) * 1000);
        SetXP(oPC,(nXP - nLXP));
        SetXP(oPC, nXP);
        SendMessageToPC(oPC, "<cþ  >You may not level in the Barbarian Class after abandoning the path...");
        return;
    }
    //EX-MONK
    if(GetHasFeat(1417, oPC) == TRUE || GetHasFeat(1420,oPC) == TRUE)
    {
        int nXP = GetXP(oPC);
        int nLXP = ((iCL-1) * 1000);
        SetXP(oPC,(nXP - nLXP));
        SetXP(oPC, nXP);
        SendMessageToPC(oPC, "<cþ  >You may not level in the Monk Class after abandoning the path...");
        return;
    }
    //EX-PALADIN
    if(GetHasFeat(1418, oPC) == TRUE || GetHasFeat(1421,oPC) == TRUE || GetHasFeat(1420,oPC) == TRUE)
    {
        int nXP = GetXP(oPC);
        int nLXP = ((iCL-1) * 1000);
        SetXP(oPC,(nXP - nLXP));
        SetXP(oPC, nXP);
        SendMessageToPC(oPC, "<cþ  >You may not level in the Paladin Class after abandoning the path...");
        return;
    }
    ////////////////////////////////////////////////////////////////////////
    if (iCL == 10)
    `   SendMessageToPC(oPC, "You have reached level 10! After Level 10, Deaths have increased consequences. You are no longer able to respawn freely and must be rescured and resurrected by a companion.");
    if (GetLevelByClass(58, oPC) == 10)
    {
        AssignCommand(oPC,ActionStartConversation(oPC,"sp_mbreaker10",TRUE,FALSE));
    }

    if (iCL == 2 && GetLevelByClass(57,oPC) == 2) {if(GetLocalInt(oItem,"Prof") < 1) {SetLocalInt(oItem,"Prof",1);SendMessageToPC(oPC,"You have gained a proficiency! This is due to your Artificer level-Up. The proficiency selection menu can be accessed by resting or typing -proficiency into the console system. Proficiencies cannot be banked, and will become void if you do not choose an additional proficiency.");
        AssignCommand(oPC,ActionStartConversation(oPC,"te_prof_lvl",TRUE,FALSE));}}
    if (GetLevelByClass(57,oPC) == 1 ||GetLevelByClass(57,oPC) == 7 || GetLevelByClass(57,oPC) == 13 || GetLevelByClass(57,oPC) == 19)
    {
        if(GetLocalInt(oItem,"Prof") < 1)
        {
            SetLocalInt(oItem,"Prof",1);
        }
        SendMessageToPC(oPC,"You have gained a proficiency! This is due to your Artificer level-Up. The proficiency selection menu can be accessed by resting or typing -proficiency into the console system. Proficiencies cannot be banked, and will become void if you do not choose an additional proficiency.");
        AssignCommand(oPC,ActionStartConversation(oPC,"te_prof_lvl",TRUE,FALSE));
        }
    if (iCL > 3 )
    {
        if(iCL == 7 || iCL == 11 || iCL == 15 || iCL == 19 || iCL == 23 || iCL == 27)
        {
            if(GetLocalInt(oItem,"Prof") < 1)
            {
                SetLocalInt(oItem,"Prof",1);
            } else if (GetLocalInt(oItem,"Prof") == 1)
            {
                SetLocalInt(oItem,"Prof",2);
            }

            SendMessageToPC(oPC,"You have gained a proficiency! The proficiency selection menu can be accessed by resting or typing -proficiency into the console system. Proficiencies cannot be banked, and will become void if you do not choose an additional proficiency.");
            AssignCommand(oPC,ActionStartConversation(oPC,"te_prof_lvl",TRUE,FALSE));
        }


        if (iCL > 20)
        {
            SetLocalInt(oItem,"iMulticlass",0);
        }
        else
        {
            ////////////////////////////////////////////////////////////////////////
            if(GetLevelByPosition(2,oPC) != 0)
            {
                int nClass1 = GetClassByPosition(1,oPC);
                int nLev1 = GetLevelByPosition(1,oPC);
                int nClass2 = GetClassByPosition(2,oPC);
                int nLev2 = GetLevelByPosition(2,oPC);
                int nClass3 = GetClassByPosition(3,oPC);
                int nLev3 = GetLevelByPosition(3,oPC);
                int nDiv12, nDiv13, nDiv23;

                if(GetRacialType(oPC) == RACIAL_TYPE_HUMAN || GetRacialType(oPC) == RACIAL_TYPE_HALFELF)
                {
                    if(GetHasFeat(BACKGROUND_TIEFLING,oPC))
                    {
                        if(nLev2 >=1 && !GetIsClassPRC(nClass2))
                        {
                            if(nClass1 == CLASS_TYPE_ROGUE)
                            {
                                if(nLev3 >=1 && !GetIsClassPRC(nClass3))
                                {
                                    nDiv23 = abs(nLev2 - nLev3);
                                    if(nDiv23 >=1)
                                    {
                                        SetLocalInt(oItem, "iMulticlass",1);
                                    }
                                    else
                                    {
                                        SetLocalInt(oItem,"iMulticlass",0);
                                    }
                                }
                                else
                                {
                                    SetLocalInt(oItem,"iMulticlass",0);
                                }
                            }
                            else if(nClass2 == CLASS_TYPE_ROGUE)
                            {
                                if(nLev3 >=1 && !GetIsClassPRC(nClass3))
                                {
                                    nDiv13 = abs(nLev1 - nLev3);
                                    if(nDiv13 >=1)
                                    {
                                        SetLocalInt(oItem, "iMulticlass",1);
                                    }
                                    else
                                    {
                                        SetLocalInt(oItem,"iMulticlass",0);
                                    }
                                }
                                else
                                {
                                    SetLocalInt(oItem,"iMulticlass",0);
                                }
                            }
                            else if(nClass3 == CLASS_TYPE_ROGUE)
                            {
                                if(nLev3 >=1 && !GetIsClassPRC(nClass3))
                                {
                                    nDiv12 = abs(nLev1 - nLev2);
                                    if(nDiv12 >=1)
                                    {
                                        SetLocalInt(oItem, "iMulticlass",1);
                                    }
                                    else
                                    {
                                        SetLocalInt(oItem,"iMulticlass",0);
                                    }
                                }
                                else
                                {
                                    SetLocalInt(oItem,"iMulticlass",0);
                                }
                            }
                            else
                            {
                                if(nLev3 >=1 && !GetIsClassPRC(nClass3))
                                {
                                    nDiv13 = abs(nLev1 - nLev3);
                                    nDiv23 = abs(nLev2 - nLev3);
                                    nDiv12 = abs(nLev1 - nLev2);

                                    if((nDiv13 >=1)||(nDiv23 >= 1)||(nDiv12 >=1))
                                    {
                                        SetLocalInt(oItem, "iMulticlass",1);
                                    }
                                    else
                                    {
                                        SetLocalInt(oItem,"iMulticlass",0);
                                    }
                                }
                                else
                                {
                                    nDiv12 = abs(nLev1 - nLev2);
                                    if(nDiv12 >= 1)
                                    {
                                        SetLocalInt(oItem, "iMulticlass",1);
                                    }
                                    else
                                    {
                                        SetLocalInt(oItem,"iMulticlass",0);
                                    }

                                }
                            }
                        }
                        else
                        {
                            SetLocalInt(oItem,"iMulticlass",0);
                        }

                    }
                    else if(GetHasFeat(BACKGROUND_AASIMAR,oPC) == TRUE)
                    {
                        if(nLev2 >=1 && !GetIsClassPRC(nClass2))
                        {
                        if(nClass1 == CLASS_TYPE_PALADIN)
                        {
                            if(nLev3 >=1 && !GetIsClassPRC(nClass3))
                            {
                                nDiv23 = abs(nLev2 - nLev3);
                                    if(nDiv23 >=1)
                                    {
                                        SetLocalInt(oItem, "iMulticlass",1);
                                    }
                                    else
                                    {
                                        SetLocalInt(oItem,"iMulticlass",0);
                                    }
                            }
                            else
                            {
                                SetLocalInt(oItem,"iMulticlass",0);
                            }
                        }
                        else if(nClass2 == CLASS_TYPE_PALADIN)
                        {
                            if(nLev3 >=1 && !GetIsClassPRC(nClass3))
                            {
                                nDiv13 = abs(nLev1 - nLev3);
                                    if(nDiv13 >=1)
                                    {
                                        SetLocalInt(oItem, "iMulticlass",1);
                                    }
                                    else
                                    {
                                        SetLocalInt(oItem,"iMulticlass",0);
                                    }
                            }
                            else
                            {
                                SetLocalInt(oItem,"iMulticlass",0);
                            }
                        }
                        else if(nClass3 == CLASS_TYPE_PALADIN)
                        {
                            if(nLev3 >=1 && !GetIsClassPRC(nClass3))
                            {
                                nDiv12 = abs(nLev1 - nLev2);
                                if(nDiv12 >=1)
                                {
                                    SetLocalInt(oItem, "iMulticlass",1);
                                }
                                else
                                {
                                    SetLocalInt(oItem,"iMulticlass",0);
                                }
                            }
                            else
                            {
                                SetLocalInt(oItem,"iMulticlass",0);
                            }
                       }
                       else
                       {
                            if(nLev3 >=1 && !GetIsClassPRC(nClass3))
                            {
                                nDiv13 = abs(nLev1 - nLev3);
                                nDiv23 = abs(nLev2 - nLev3);
                                nDiv12 = abs(nLev1 - nLev2);

                                if((nDiv13 >=1)||(nDiv23 >= 1)||(nDiv12 >=1))
                                {
                                    SetLocalInt(oItem, "iMulticlass",1);
                                }
                                else
                                {
                                    SetLocalInt(oItem,"iMulticlass",0);
                                }
                            }
                            else
                            {
                                nDiv12 = abs(nLev1 - nLev2);
                                if(nDiv12 >= 1)
                                {
                                    SetLocalInt(oItem, "iMulticlass",1);
                                }
                                else
                                {
                                    SetLocalInt(oItem,"iMulticlass",0);
                                }

                            }
                        }
                        }
                        else
                        {
                            SetLocalInt(oItem,"iMulticlass",0);
                        }
                    }
                    else
                    {
                    if(nLev3 >=1 && !GetIsClassPRC(nClass3))
                    {
                        nDiv23 = abs(nLev2 - nLev3);
                        if(nDiv23 >=1)
                        {
                            SetLocalInt(oItem, "iMulticlass",1);
                        }
                        else
                        {
                            SetLocalInt(oItem,"iMulticlass",0);
                        }
                    }
                    else
                    {
                        SetLocalInt(oItem,"iMulticlass",0);
                    }
                    }
                }
                ////////////////////////////////////////////////////////////
                //Halfling
                ////////////////////////////////////////////////////////////
                else if(GetRacialType(oPC) == RACIAL_TYPE_HALFLING)
                {
                    if(nLev2 >=1 && !GetIsClassPRC(nClass2))
                    {
                      if(nClass1 == CLASS_TYPE_ROGUE)
                      {
                        if(nLev3 >=1 && !GetIsClassPRC(nClass3))
                        {
                            nDiv23 = abs(nLev2 - nLev3);
                                if(nDiv23 >=1)
                                {
                                    SetLocalInt(oItem, "iMulticlass",1);
                                }
                                else
                                {
                                    SetLocalInt(oItem,"iMulticlass",0);
                                }
                        }
                        else
                        {
                            SetLocalInt(oItem,"iMulticlass",0);
                        }
                      }
                      else if(nClass2 == CLASS_TYPE_ROGUE)
                      {
                        if(nLev3 >=1 && !GetIsClassPRC(nClass3))
                        {
                            nDiv13 = abs(nLev1 - nLev3);
                                if(nDiv13 >=1)
                                {
                                    SetLocalInt(oItem, "iMulticlass",1);
                                }
                                else
                                {
                                    SetLocalInt(oItem,"iMulticlass",0);
                                }
                        }
                        else
                        {
                            SetLocalInt(oItem,"iMulticlass",0);
                        }
                      }
                      else if(nClass3 == CLASS_TYPE_ROGUE)
                      {
                        if(nLev3 >=1 && !GetIsClassPRC(nClass3))
                        {
                            nDiv12 = abs(nLev1 - nLev2);
                            if(nDiv12 >=1)
                            {
                                SetLocalInt(oItem, "iMulticlass",1);
                            }
                            else
                            {
                                SetLocalInt(oItem,"iMulticlass",0);
                            }
                        }
                        else
                        {
                            SetLocalInt(oItem,"iMulticlass",0);
                        }
                      }
                      else
                      {
                        if(nLev3 >=1 && !GetIsClassPRC(nClass3))
                        {
                            nDiv13 = abs(nLev1 - nLev3);
                            nDiv23 = abs(nLev2 - nLev3);
                            nDiv12 = abs(nLev1 - nLev2);

                            if((nDiv13 >=1)||(nDiv23 >= 1)||(nDiv12 >=1))
                            {
                                SetLocalInt(oItem, "iMulticlass",1);
                            }
                            else
                            {
                                SetLocalInt(oItem,"iMulticlass",0);
                            }
                        }
                        else
                        {
                            nDiv12 = abs(nLev1 - nLev2);
                            if(nDiv12 >= 1)
                            {
                                SetLocalInt(oItem, "iMulticlass",1);
                            }
                            else
                            {
                                SetLocalInt(oItem,"iMulticlass",0);
                            }

                        }
                      }
                    }
                    else
                    {
                        SetLocalInt(oItem,"iMulticlass",0);
                    }
                }
                ////////////////////////////////////////////////////////////////////
                //Gnome
                ////////////////////////////////////////////////////////////////////
                else if(GetRacialType(oPC) == RACIAL_TYPE_GNOME)
                {
                    if(nLev2 >=1 && !GetIsClassPRC(nClass2))
                    {
                    if(nClass1 == CLASS_TYPE_WIZARD)
                    {
                        if(nLev3 >=1 && !GetIsClassPRC(nClass3))
                        {
                            nDiv23 = abs(nLev2 - nLev3);
                                if(nDiv23 >=1)
                                {
                                    SetLocalInt(oItem, "iMulticlass",1);
                                }
                                else
                                {
                                    SetLocalInt(oItem,"iMulticlass",0);
                                }
                        }
                        else
                        {
                            SetLocalInt(oItem,"iMulticlass",0);
                        }
                    }
                    else if(nClass2 == CLASS_TYPE_WIZARD)
                    {
                        if(nLev3 >=1 && !GetIsClassPRC(nClass3))
                        {
                            nDiv13 = abs(nLev1 - nLev3);
                                if(nDiv13 >=1)
                                {
                                    SetLocalInt(oItem, "iMulticlass",1);
                                }
                                else
                                {
                                    SetLocalInt(oItem,"iMulticlass",0);
                                }
                        }
                        else
                        {
                            SetLocalInt(oItem,"iMulticlass",0);
                        }
                    }
                    else if(nClass3 == CLASS_TYPE_WIZARD)
                    {
                        if(nLev3 >=1 && !GetIsClassPRC(nClass3))
                        {
                            nDiv12 = abs(nLev1 - nLev2);
                            if(nDiv12 >=1)
                            {
                                SetLocalInt(oItem, "iMulticlass",1);
                            }
                            else
                            {
                                SetLocalInt(oItem,"iMulticlass",0);
                            }
                        }
                        else
                        {
                            SetLocalInt(oItem,"iMulticlass",0);
                        }
                   }
                   else
                   {
                        if(nLev3 >=1 && !GetIsClassPRC(nClass3))
                        {
                            nDiv13 = abs(nLev1 - nLev3);
                            nDiv23 = abs(nLev2 - nLev3);
                            nDiv12 = abs(nLev1 - nLev2);

                            if((nDiv13 >=1)||(nDiv23 >= 1)||(nDiv12 >=1))
                            {
                                SetLocalInt(oItem, "iMulticlass",1);
                            }
                            else
                            {
                                SetLocalInt(oItem,"iMulticlass",0);
                            }
                        }
                        else
                        {
                            nDiv12 = abs(nLev1 - nLev2);
                            if(nDiv12 >= 1)
                            {
                                SetLocalInt(oItem, "iMulticlass",1);
                            }
                            else
                            {
                                SetLocalInt(oItem,"iMulticlass",0);
                            }

                        }
                    }
                    }
                    else
                    {
                        SetLocalInt(oItem,"iMulticlass",0);
                    }
                }
                ////////////////////////////////////////////////////////////////////
                //HALF ORC
                ////////////////////////////////////////////////////////////////////
                else if(GetRacialType(oPC) == RACIAL_TYPE_HALFORC)
                {
                    if(nLev2 >=1 && !GetIsClassPRC(nClass2))
                    {
                    if(nClass1 == CLASS_TYPE_BARBARIAN)
                    {
                        if(nLev3 >=1 && !GetIsClassPRC(nClass3))
                        {
                            nDiv23 = abs(nLev2 - nLev3);
                                if(nDiv23 >=1)
                                {
                                    SetLocalInt(oItem, "iMulticlass",1);
                                }
                                else
                                {
                                    SetLocalInt(oItem,"iMulticlass",0);
                                }
                        }
                        else
                        {
                            SetLocalInt(oItem,"iMulticlass",0);
                        }
                    }
                    else if(nClass2 == CLASS_TYPE_BARBARIAN)
                    {
                        if(nLev3 >=1 && !GetIsClassPRC(nClass3))
                        {
                            nDiv13 = abs(nLev1 - nLev3);
                                if(nDiv13 >=1)
                                {
                                    SetLocalInt(oItem, "iMulticlass",1);
                                }
                                else
                                {
                                    SetLocalInt(oItem,"iMulticlass",0);
                                }
                        }
                        else
                        {
                            SetLocalInt(oItem,"iMulticlass",0);
                        }
                    }
                    else if(nClass3 == CLASS_TYPE_BARBARIAN)
                    {
                        if(nLev3 >=1 && !GetIsClassPRC(nClass3))
                        {
                            nDiv12 = abs(nLev1 - nLev2);
                            if(nDiv12 >=1)
                            {
                                SetLocalInt(oItem, "iMulticlass",1);
                            }
                            else
                            {
                                SetLocalInt(oItem,"iMulticlass",0);
                            }
                        }
                        else
                        {
                            SetLocalInt(oItem,"iMulticlass",0);
                        }
                   }
                   else
                   {
                        if(nLev3 >=1 && !GetIsClassPRC(nClass3))
                        {
                            nDiv13 = abs(nLev1 - nLev3);
                            nDiv23 = abs(nLev2 - nLev3);
                            nDiv12 = abs(nLev1 - nLev2);

                            if((nDiv13 >=1)||(nDiv23 >= 1)||(nDiv12 >=1))
                            {
                                SetLocalInt(oItem, "iMulticlass",1);
                            }
                            else
                            {
                                SetLocalInt(oItem,"iMulticlass",0);
                            }
                        }
                        else
                        {
                            nDiv12 = abs(nLev1 - nLev2);
                            if(nDiv12 >= 1)
                            {
                                SetLocalInt(oItem, "iMulticlass",1);
                            }
                            else
                            {
                                SetLocalInt(oItem,"iMulticlass",0);
                            }

                        }
                    }
                    }
                    else
                    {
                        SetLocalInt(oItem,"iMulticlass",0);
                    }
                }
                ////////////////////////////////////////////////////////////////////
                //DWARF
                ////////////////////////////////////////////////////////////////////
                else if(GetRacialType(oPC) == RACIAL_TYPE_DWARF)
                {
                    if(nLev2 >=1 && !GetIsClassPRC(nClass2))
                    {
                    if(nClass1 == CLASS_TYPE_FIGHTER)
                    {
                        if(nLev3 >=1 && !GetIsClassPRC(nClass3))
                        {
                            nDiv23 = abs(nLev2 - nLev3);
                                if(nDiv23 >=1)
                                {
                                    SetLocalInt(oItem, "iMulticlass",1);
                                }
                                else
                                {
                                    SetLocalInt(oItem,"iMulticlass",0);
                                }
                        }
                        else
                        {
                            SetLocalInt(oItem,"iMulticlass",0);
                        }
                    }
                    else if(nClass2 == CLASS_TYPE_FIGHTER)
                    {
                        if(nLev3 >=1 && !GetIsClassPRC(nClass3))
                        {
                            nDiv13 = abs(nLev1 - nLev3);
                                if(nDiv13 >=1)
                                {
                                    SetLocalInt(oItem, "iMulticlass",1);
                                }
                                else
                                {
                                    SetLocalInt(oItem,"iMulticlass",0);
                                }
                        }
                        else
                        {
                            SetLocalInt(oItem,"iMulticlass",0);
                        }
                    }
                    else if(nClass3 == CLASS_TYPE_FIGHTER)
                    {
                        if(nLev3 >=1 && !GetIsClassPRC(nClass3))
                        {
                            nDiv12 = abs(nLev1 - nLev2);
                            if(nDiv12 >=1)
                            {
                                SetLocalInt(oItem, "iMulticlass",1);
                            }
                            else
                            {
                                SetLocalInt(oItem,"iMulticlass",0);
                            }
                        }
                        else
                        {
                            SetLocalInt(oItem,"iMulticlass",0);
                        }
                   }
                   else
                   {
                        if(nLev3 >=1 && !GetIsClassPRC(nClass3))
                        {
                            nDiv13 = abs(nLev1 - nLev3);
                            nDiv23 = abs(nLev2 - nLev3);
                            nDiv12 = abs(nLev1 - nLev2);

                            if((nDiv13 >=1)||(nDiv23 >= 1)||(nDiv12 >=1))
                            {
                                SetLocalInt(oItem, "iMulticlass",1);
                            }
                            else
                            {
                                SetLocalInt(oItem,"iMulticlass",0);
                            }
                        }
                        else
                        {
                            nDiv12 = abs(nLev1 - nLev2);
                            if(nDiv12 >= 1)
                            {
                                SetLocalInt(oItem, "iMulticlass",1);
                            }
                            else
                            {
                                SetLocalInt(oItem,"iMulticlass",0);
                            }

                        }
                    }
                    }
                    else
                    {
                        SetLocalInt(oItem,"iMulticlass",0);
                    }
                }
                ////////////////////////////////////////////////////////////////////
                //ELF
                ////////////////////////////////////////////////////////////////////
                else if(GetRacialType(oPC) == RACIAL_TYPE_ELF)
                {
                    if(GetHasFeat(BACKGROUND_DARK_ELF,oPC)||GetHasFeat(BACKGROUND_SILVER_ELF,oPC)||GetHasFeat(BACKGROUND_GOLD_ELF,oPC))
                    {
                        if(nLev2 >=1 && !GetIsClassPRC(nClass2))
                        {
                            if(nClass1 == CLASS_TYPE_WIZARD)
                            {
                                if(nLev3 >=1 && !GetIsClassPRC(nClass3))
                                {
                                    nDiv23 = abs(nLev2 - nLev3);
                                        if(nDiv23 >=1)
                                        {
                                            SetLocalInt(oItem, "iMulticlass",1);
                                        }
                                        else
                                        {
                                            SetLocalInt(oItem,"iMulticlass",0);
                                        }
                                }
                                else
                                {
                                    SetLocalInt(oItem,"iMulticlass",0);
                                }
                            }
                            else if(nClass2 == CLASS_TYPE_WIZARD)
                            {
                                if(nLev3 >=1 && !GetIsClassPRC(nClass3))
                                {
                                    nDiv13 = abs(nLev1 - nLev3);
                                        if(nDiv13 >=1)
                                        {
                                            SetLocalInt(oItem, "iMulticlass",1);
                                        }
                                        else
                                        {
                                            SetLocalInt(oItem,"iMulticlass",0);
                                        }
                                }
                                else
                                {
                                    SetLocalInt(oItem,"iMulticlass",0);
                                }
                            }
                            else if(nClass3 == CLASS_TYPE_WIZARD)
                            {
                                if(nLev3 >=1 && !GetIsClassPRC(nClass3))
                                {
                                    nDiv12 = abs(nLev1 - nLev2);
                                    if(nDiv12 >=1)
                                    {
                                        SetLocalInt(oItem, "iMulticlass",1);
                                    }
                                    else
                                    {
                                        SetLocalInt(oItem,"iMulticlass",0);
                                    }
                                }
                                else
                                {
                                    SetLocalInt(oItem,"iMulticlass",0);
                                }
                           }
                           else
                           {
                                if(nLev3 >=1 && !GetIsClassPRC(nClass3))
                                {
                                    nDiv13 = abs(nLev1 - nLev3);
                                    nDiv23 = abs(nLev2 - nLev3);
                                    nDiv12 = abs(nLev1 - nLev2);

                                    if((nDiv13 >=1)||(nDiv23 >= 1)||(nDiv12 >=1))
                                    {
                                        SetLocalInt(oItem, "iMulticlass",1);
                                    }
                                    else
                                    {
                                        SetLocalInt(oItem,"iMulticlass",0);
                                    }
                                }
                                else
                                {
                                    nDiv12 = abs(nLev1 - nLev2);
                                    if(nDiv12 >= 1)
                                    {
                                        SetLocalInt(oItem, "iMulticlass",1);
                                    }
                                    else
                                    {
                                        SetLocalInt(oItem,"iMulticlass",0);
                                    }

                                }
                            }
                        }
                        else
                        {
                            SetLocalInt(oItem,"iMulticlass",0);
                        }
                    }
                    else if(GetHasFeat(BACKGROUND_COPPER_ELF,oPC))
                    {
                        if(nLev2 >=1 && !GetIsClassPRC(nClass2))
                        {
                            if(nClass1 == CLASS_TYPE_RANGER)
                            {
                                if(nLev3 >=1 && !GetIsClassPRC(nClass3))
                                {
                                    nDiv23 = abs(nLev2 - nLev3);
                                        if(nDiv23 >=1)
                                        {
                                            SetLocalInt(oItem, "iMulticlass",1);
                                        }
                                        else
                                        {
                                            SetLocalInt(oItem,"iMulticlass",0);
                                        }
                                }
                                else
                                {
                                    SetLocalInt(oItem,"iMulticlass",0);
                                }
                            }
                            else if(nClass2 == CLASS_TYPE_RANGER)
                            {
                                if(nLev3 >=1 && !GetIsClassPRC(nClass3))
                                {
                                    nDiv13 = abs(nLev1 - nLev3);
                                        if(nDiv13 >=1)
                                        {
                                            SetLocalInt(oItem, "iMulticlass",1);
                                        }
                                        else
                                        {
                                            SetLocalInt(oItem,"iMulticlass",0);
                                        }
                                }
                                else
                                {
                                    SetLocalInt(oItem,"iMulticlass",0);
                                }
                            }
                            else if(nClass3 == CLASS_TYPE_RANGER)
                            {
                                if(nLev3 >=1 && !GetIsClassPRC(nClass3))
                                {
                                    nDiv12 = abs(nLev1 - nLev2);
                                    if(nDiv12 >=1)
                                    {
                                        SetLocalInt(oItem, "iMulticlass",1);
                                    }
                                    else
                                    {
                                        SetLocalInt(oItem,"iMulticlass",0);
                                    }
                                }
                                else
                                {
                                    SetLocalInt(oItem,"iMulticlass",0);
                                }
                           }
                           else
                           {
                                if(nLev3 >=1 && !GetIsClassPRC(nClass3))
                                {
                                    nDiv13 = abs(nLev1 - nLev3);
                                    nDiv23 = abs(nLev2 - nLev3);
                                    nDiv12 = abs(nLev1 - nLev2);

                                    if((nDiv13 >=1)||(nDiv23 >= 1)||(nDiv12 >=1))
                                    {
                                        SetLocalInt(oItem, "iMulticlass",1);
                                    }
                                    else
                                    {
                                        SetLocalInt(oItem,"iMulticlass",0);
                                    }
                                }
                                else
                                {
                                    nDiv12 = abs(nLev1 - nLev2);
                                    if(nDiv12 >= 1)
                                    {
                                        SetLocalInt(oItem, "iMulticlass",1);
                                    }
                                    else
                                    {
                                        SetLocalInt(oItem,"iMulticlass",0);
                                    }

                                }
                            }
                        }
                        else
                        {
                            SetLocalInt(oItem,"iMulticlass",0);
                        }
                    }
                    else if(GetHasFeat(BACKGROUND_GREEN_ELF,oPC))
                    {
                        if(nLev2 >=1 && !GetIsClassPRC(nClass2))
                        {
                            if(nClass1 == CLASS_TYPE_SORCERER)
                            {
                                if(nLev3 >=1 && !GetIsClassPRC(nClass3))
                                {
                                    nDiv23 = abs(nLev2 - nLev3);
                                        if(nDiv23 >=1)
                                        {
                                            SetLocalInt(oItem, "iMulticlass",1);
                                        }
                                        else
                                        {
                                            SetLocalInt(oItem,"iMulticlass",0);
                                        }
                                }
                                else
                                {
                                    SetLocalInt(oItem,"iMulticlass",0);
                                }
                            }
                            else if(nClass2 == CLASS_TYPE_SORCERER)
                            {
                                if(nLev3 >=1 && !GetIsClassPRC(nClass3))
                                {
                                    nDiv13 = abs(nLev1 - nLev3);
                                        if(nDiv13 >=1)
                                        {
                                            SetLocalInt(oItem, "iMulticlass",1);
                                        }
                                        else
                                        {
                                            SetLocalInt(oItem,"iMulticlass",0);
                                        }
                                }
                                else
                                {
                                    SetLocalInt(oItem,"iMulticlass",0);
                                }
                            }
                            else if(nClass3 == CLASS_TYPE_SORCERER)
                            {
                                if(nLev3 >=1 && !GetIsClassPRC(nClass3))
                                {
                                    nDiv12 = abs(nLev1 - nLev2);
                                    if(nDiv12 >=1)
                                    {
                                        SetLocalInt(oItem, "iMulticlass",1);
                                    }
                                    else
                                    {
                                        SetLocalInt(oItem,"iMulticlass",0);
                                    }
                                }
                                else
                                {
                                    SetLocalInt(oItem,"iMulticlass",0);
                                }
                           }
                           else
                           {
                                if(nLev3 >=1 && !GetIsClassPRC(nClass3))
                                {
                                    nDiv13 = abs(nLev1 - nLev3);
                                    nDiv23 = abs(nLev2 - nLev3);
                                    nDiv12 = abs(nLev1 - nLev2);

                                    if((nDiv13 >=1)||(nDiv23 >= 1)||(nDiv12 >=1))
                                    {
                                        SetLocalInt(oItem, "iMulticlass",1);
                                    }
                                    else
                                    {
                                        SetLocalInt(oItem,"iMulticlass",0);
                                    }
                                }
                                else
                                {
                                    nDiv12 = abs(nLev1 - nLev2);
                                    if(nDiv12 >= 1)
                                    {
                                        SetLocalInt(oItem, "iMulticlass",1);
                                    }
                                    else
                                    {
                                        SetLocalInt(oItem,"iMulticlass",0);
                                    }
                                }
                            }
                        }
                        else
                        {
                            SetLocalInt(oItem,"iMulticlass",0);
                        }
                    }
                }
            }
            else
            {
                SetLocalInt(oItem,"iMulticlass",0);
            }
         }

        ////////////////////////////////////////////////////////////////////////
        SendMessageToPC(oPC, "<c  þ>You receive a stipend from your labors.");
        //Main Gold gains
        if (GetHasFeat(BACKGROUND_AFFLUENCE,oPC) == TRUE)
        {
            RewardGP(1000, oPC, FALSE);
        }
        else if (GetHasFeat(BACKGROUND_BRAWLER,oPC) == TRUE)
        {
            RewardGP(25, oPC, FALSE);
        }
        else if (GetHasFeat(BACKGROUND_COSMOPOLITAN,oPC) == TRUE)
        {
            RewardGP(100, oPC, FALSE);
        }
        else if (GetHasFeat(BACKGROUND_CRUSADER,oPC) == TRUE)
        {
            RewardGP(200, oPC, FALSE);
        }
        else if (GetHasFeat(BACKGROUND_DUELIST,oPC) == TRUE)
        {
            RewardGP(50, oPC, FALSE);
        }
        else if (GetHasFeat(BACKGROUND_EVANGELIST,oPC) == TRUE)
        {
            RewardGP(75, oPC, FALSE);
        }
        else if (GetHasFeat(BACKGROUND_FORESTER,oPC) == TRUE)
        {
            RewardGP(35, oPC, FALSE);
        }
        else if (GetHasFeat(BACKGROUND_HARD_LABORER,oPC) == TRUE)
        {
            RewardGP(25, oPC, FALSE);
        }
        else if (GetHasFeat(BACKGROUND_HEALER,oPC) == TRUE)
        {
            RewardGP(125, oPC, FALSE);
        }
        else if (GetHasFeat(BACKGROUND_KNIGHT,oPC) == TRUE)
        {
            RewardGP(500, oPC, FALSE);
        }
        else if (GetHasFeat(BACKGROUND_HEDGEMAGE,oPC) == TRUE)
        {
            RewardGP(50, oPC, FALSE);
        }
        else if (GetHasFeat(BACKGROUND_METALSMITH ,oPC) == TRUE)
        {
            RewardGP(200, oPC, FALSE);
        }
        else if (GetHasFeat(BACKGROUND_MENDICANT,oPC) == TRUE)
        {
            RewardGP(0, oPC, FALSE);
        }
        else if (GetHasFeat(BACKGROUND_MERCHANT,oPC) == TRUE)
        {
            RewardGP(250, oPC, FALSE);
        }
        else if (GetHasFeat(BACKGROUND_MINSTREL,oPC) == TRUE)
        {
            RewardGP(100, oPC, FALSE);
        }
        else if (GetHasFeat(BACKGROUND_OCCULTIST,oPC) == TRUE)
        {
            RewardGP(50, oPC, FALSE);
        }
        else if (GetHasFeat(BACKGROUND_SABOTEUR,oPC) == TRUE)
        {
            RewardGP(75, oPC, FALSE);
        }
        else if (GetHasFeat(BACKGROUND_SCOUT,oPC) == TRUE)
        {
            RewardGP(75, oPC, FALSE);
        }
        else if (GetHasFeat(BACKGROUND_SNEAK,oPC) == TRUE)
        {
            RewardGP(50, oPC, FALSE);
        }
        else if (GetHasFeat(BACKGROUND_SOLDIER,oPC) == TRUE)
        {
            RewardGP(300, oPC, FALSE);
        }
        else if (GetHasFeat(BACKGROUND_TRAVELER,oPC) == TRUE)
        {
            RewardGP(25, oPC, FALSE);
        }
        else if (GetHasFeat(BACKGROUND_SPELLFIRE,oPC) == TRUE)
        {
            RewardGP(50, oPC, FALSE);
        }
        else if (GetHasFeat(BACKGROUND_NAT_LYCAN,oPC) == TRUE)
        {
            RewardGP(50, oPC, FALSE);
        }
        else if (GetHasFeat(BACKGROUND_SHADOW,oPC) == TRUE)
        {
            RewardGP(50, oPC, FALSE);
        }
        else if (GetHasFeat(BACKGROUND_COPPER_ELF,oPC) == TRUE)
        {
            RewardGP(50, oPC, FALSE);
        }
        else if (GetHasFeat(BACKGROUND_GREEN_ELF,oPC) == TRUE)
        {
            RewardGP(50, oPC, FALSE);
        }
        else if (GetHasFeat(BACKGROUND_DARK_ELF,oPC) == TRUE)
        {
            RewardGP(50, oPC, FALSE);
        }
        else if (GetHasFeat(BACKGROUND_SILVER_ELF,oPC) == TRUE)
        {
            RewardGP(50, oPC, FALSE);
        }
        else if (GetHasFeat(BACKGROUND_GOLD_ELF,oPC) == TRUE)
        {
            RewardGP(50, oPC, FALSE);
        }
        else if (GetHasFeat(BACKGROUND_GOLD_DWARF,oPC) == TRUE)
        {
            RewardGP(150, oPC, FALSE);
        }
        else if (GetHasFeat(BACKGROUND_GREY_DWARF,oPC) == TRUE)
        {
            RewardGP(150, oPC, FALSE);
        }
        else if (GetHasFeat(BACKGROUND_SHIELD_DWARF,oPC) == TRUE)
        {
            RewardGP(150, oPC, FALSE);
        }
        else if (GetHasFeat(BACKGROUND_OUTSIDER,oPC) == TRUE)
        {
            RewardGP(50, oPC, FALSE);
        }
        else if (GetHasFeat(BACKGROUND_SHIELD_DWARF,oPC) == TRUE)
        {
            RewardGP(50, oPC, FALSE);
        }
        else if (GetHasFeat(BACKGROUND_OUTSIDER,oPC) == TRUE)
        {
            RewardGP(50, oPC, FALSE);
        }
        else if (GetHasFeat(BACKGROUND_CARAVANNER, oPC) == TRUE)
        {
            RewardGP(250, oPC, FALSE);
        }
                else if (GetHasFeat(BACKGROUND_CHURCH_ACOLYTE, oPC) == TRUE)
        {
            RewardGP(100, oPC, FALSE);
        }
                else if (GetHasFeat(BACKGROUND_CIRCLE_BORN, oPC) == TRUE)
        {
            RewardGP(50, oPC, FALSE);
        }
                else if (GetHasFeat(BACKGROUND_ENLIGHTENED_STUDENT, oPC) == TRUE)
        {
            RewardGP(150, oPC, FALSE);
        }
                else if (GetHasFeat(BACKGROUND_HAREM_TRAINED, oPC) == TRUE)
        {
            RewardGP(300, oPC, FALSE);
        }
                else if (GetHasFeat(BACKGROUND_HARPER, oPC) == TRUE)
        {
            RewardGP(300, oPC, FALSE);
        }
                else if (GetHasFeat(BACKGROUND_KNIGHT_SQUIRE, oPC) == TRUE)
        {
            RewardGP(250, oPC, FALSE);
        }
                else if (GetHasFeat(BACKGROUND_TALFIRIAN, oPC) == TRUE)
        {
            RewardGP(200, oPC, FALSE);
        }
                else if (GetHasFeat(BACKGROUND_THEOCRAT, oPC) == TRUE)
        {
            RewardGP(350, oPC, FALSE);
        }
        else if (GetHasFeat(BACKGROUND_WARD_TRIAD, oPC) == TRUE)
        {
            RewardGP(100, oPC, FALSE);
        }
                else if (GetHasFeat(BACKGROUND_ZHENTARIM, oPC) == TRUE)
        {
            RewardGP(750, oPC, FALSE);
        }

    }
    else if (iCL <= 3)
    {
        if(GetClassByPosition(2,oPC) != CLASS_TYPE_INVALID)
        {
            SetXP(oPC, 50);
            SetXP(oPC, 3001);
            SendMessageToPC(oPC,"You must level-up in the same class for your first three levels. There are no restrictions afterwards.");
        }
    }

    //Racial/Class Language Reapplication:
    if((GetRacialType(oPC) == RACIAL_TYPE_ELF)||(GetRacialType(oPC) == RACIAL_TYPE_HALFELF))
    {
        SetLocalInt(oItem,"1",1);
    }
    if(GetRacialType(oPC) == RACIAL_TYPE_GNOME)
    {
        SetLocalInt(oItem,"2",1);
    }
    if(GetRacialType(oPC) == RACIAL_TYPE_HALFLING)
    {
        SetLocalInt(oItem,"3",1);
    }
    if(GetRacialType(oPC) == RACIAL_TYPE_DWARF)
    {
        SetLocalInt(oItem,"4",1);
    }
    if(GetRacialType(oPC) == RACIAL_TYPE_HALFORC)
    {
        SetLocalInt(oItem,"5",1);
    }
    if((GetLevelByClass(CLASS_TYPE_RANGER,oPC) >= 8 )||( GetLevelByClass(CLASS_TYPE_DRUID,oPC) >= 5 ))
    {
        SetLocalInt(oItem,"8",1);
    }
    if((GetLevelByClass(CLASS_TYPE_ROGUE,oPC)) >= 1 ||( GetLevelByClass(CLASS_TYPE_ASSASSIN,oPC) >= 1 ))
    {
        SetLocalInt(oItem,"9",1);
    }
    if(GetLevelByClass(CLASS_TYPE_DRUID,oPC) >= 5)
    {
        SetLocalInt(oItem,"14",1);
    }
    if(GetHasFeat(BACKGROUND_CALISHITE_TRAINED,oPC) ==TRUE)
    {
        SetLocalInt(oItem,"23",1);
    }
    if(GetHasFeat(BACKGROUND_TALFIRIAN,oPC) ==TRUE)
    {
        SetLocalInt(oItem,"38",1);
    }
    if(GetHasFeat(BACKGROUND_CIRCLE_BORN,oPC) == TRUE)
    {
        SetLocalInt(oItem,"8",1);
    }
    if(GetHasFeat(BACKGROUND_DARK_ELF,oPC) == TRUE)
    {
        SetLocalInt(oItem,"13",1);
        SetLocalInt(oItem,"81",1);
        SetLocalInt(oItem,"46",1);
    }
    if(GetHasFeat(BACKGROUND_GREY_DWARF,oPC) == TRUE)
    {
        SetLocalInt(oItem,"64",1);
        SetLocalInt(oItem,"46",1);
    }
    if(GetHasFeat(ETHNICITY_CALISHITE,oPC) == TRUE)
    {
        SetLocalInt(oItem,"23",1);
    }
    if(GetHasFeat(ETHNICITY_CHONDATHAN,oPC) == TRUE)
    {
        SetLocalInt(oItem,"53",1);
    }
    if(GetHasFeat(ETHNICITY_DAMARAN,oPC) == TRUE)
    {
        SetLocalInt(oItem,"56",1);
    }
    if(GetHasFeat(ETHNICITY_ILLUSKAN,oPC) == TRUE)
    {
        SetLocalInt(oItem,"22",1);
    }
    if(GetHasFeat(ETHNICITY_MULAN,oPC) == TRUE)
    {
        SetLocalInt(oItem,"27",1);
    }
    if(GetHasFeat(ETHNICITY_RASHEMI,oPC) == TRUE)
    {
        SetLocalInt(oItem,"30",1);
    }
    if(GetHasFeat(1137,oPC) == TRUE)
    {
        SetLocalInt(oItem,"11",1);
    }
    if(GetHasFeat(1139,oPC) == TRUE)
    {
        SetLocalInt(oItem,"12",1);
    }


}
