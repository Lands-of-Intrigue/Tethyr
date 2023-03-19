#include "date_time_functs"
#include "nwnx_time"
void main()
{
    object oPC = GetItemActivator();
    object oDrug = GetItemActivated();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");
    int nAddictionState;
    int nAddictionStrength;
    int nLastUsed;
    int nSaves;
    int nTimesUsed;
    int nTimeNow = NWNX_Time_GetTimeStamp();
    int nOverdose;
    int nDuration;
    int nDuration2;
    string sDrug;
    effect eSecondary;
    effect eOverdose;

    ////////////////////////////////////////////////////////////////////////////
    //Addictions
    // 1     Negligible   DC 4     1 Day      1d3-2 DEX
    // 2     Low          DC 6     10 Days    1d3 DEX
    // 3     Medium       DC 10    5 Days     1d4 DEX, 1d4 WIS
    // 4     High         DC 14    2 Days     1d6 DEX, 1d4 WIS
    // 5     Extreme      DC 25    1 Day      1d6 DEX, 1d6 WIS, 1d6 CON
    // 6     Vicious      DC 36    1 Day      1d8 DEX, 1d8 WIS, 1d6 CON
    ////////////////////////////////////////////////////////////////////////////
    // Addiction - Strong drugs increase one step for every two full months of addiction
    // User that becomes cured of addiction does so at same addiction rating to previous recovery
    ////////////////////////////////////////////////////////////////////////////
    // VARIABLE LIST
    ////////////////////////////////////////////////////////////////////////////
    // Integer - nDrug01AddStat | 1 for Addicted, 0 for Recovered/Not Addicted
    // Integer - nDrug01Addict  | 0-6
    // Integer - nDrug01LastUse | Timestamp
    // Integer - nDrug01Save    | Number of Successful saving throws towards overcoming addiction
    // Integer - nDrug01Use    | Number of times used drug
    ////////////////////////////////////////////////////////////////////////////


    ////////////////////////////////////////////////////////////////////////////
    //Haunspeir
    ////////////////////////////////////////////////////////////////////////////
    // Initial   = 1d4 Damage
    // Secondary = 1d4+1 Enhancement to Intelligence for 1d10+15 Minutes
    //           = Piercing and Slashing Vulnerability (+1 damage)
    // Overdose  = Multiple doses within 24 hours, 2d4 points of damage
    //           = Piercing and Slashing Vulnerability (+2 damage)
    // Addiction = 2 (low)
    ////////////////////////////////////////////////////////////////////////////
    if      (GetResRef(oDrug) == "haunspeir")
    {
        sDrug               = "nDrug01";
        nOverdose       = 24*60*60;
        nDuration       = d10(1)+15;
        nAddictionState     = GetLocalInt(oItem,sDrug+"AddStat");
        nAddictionStrength  = GetLocalInt(oItem,sDrug+"Addict");
        nLastUsed           = GetLocalInt(oItem,sDrug+"LastUse");
        nSaves              = GetLocalInt(oItem,sDrug+"Save");
        nTimesUsed          = GetLocalInt(oItem,sDrug+"Use");

        SetLocalInt(oItem, sDrug+"LastUse",nTimeNow);
        SetLocalInt(oItem, sDrug+"Save",0);
        SetLocalInt(oItem, sDrug+"Use",nTimesUsed+1);

        //If not addicted, you are now.
        if(nAddictionState == 0)    {SetLocalInt(oItem,sDrug+"AddStat",TRUE);}
        //If first time, set addiction strength.
        if(nAddictionStrength == 0) {SetLocalInt(oItem,sDrug+"Addict",2);}
        //If not first time, check uses and see if need to step addiction.
        else
        {
            //If used less than 60 times, no advancement, otherwise milestones
            if      (nTimesUsed == 60 || nTimesUsed == 120 || nTimesUsed == 180 || nTimesUsed == 240 || nTimesUsed == 300 || nTimesUsed == 360 || nTimesUsed == 420 || nTimesUsed == 480)
            {SetLocalInt(oItem,sDrug+"Addict",nAddictionStrength+1);}

            if(GetLocalInt(oItem,sDrug+"Addict") >= 6)
            {SetLocalInt(oItem,sDrug+"Addict",6);}
        }

        //Not an Overdose. Timestamp for overdose is less than current timestamp
        if(nLastUsed+nOverdose <= nTimeNow)
        {
            //Initial Effects
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d4(1)),oPC);
            eSecondary = EffectAbilityIncrease(ABILITY_WISDOM,d4(1)+1);
            eSecondary = EffectLinkEffects(EffectDamageImmunityDecrease(DAMAGE_TYPE_SLASHING,5),eSecondary);
            eSecondary = EffectLinkEffects(EffectDamageImmunityDecrease(DAMAGE_TYPE_PIERCING,5),eSecondary);
            DelayCommand(RoundsToSeconds(d4(1)),ApplyEffectToObject(DURATION_TYPE_TEMPORARY,SupernaturalEffect(eSecondary),oPC,IntToFloat(nDuration)));
        }
        else
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d4(2)),oPC);
            eOverdose = EffectDamageImmunityDecrease(DAMAGE_TYPE_SLASHING,10);
            eOverdose = EffectLinkEffects(EffectDamageImmunityDecrease(DAMAGE_TYPE_PIERCING,10),eOverdose);
            DelayCommand(RoundsToSeconds(d4(1)),ApplyEffectToObject(DURATION_TYPE_TEMPORARY,SupernaturalEffect(eOverdose),oPC,IntToFloat(nDuration)));
        }
    }
    ////////////////////////////////////////////////////////////////////////////
    //Kammarth
    ////////////////////////////////////////////////////////////////////////////
    // Initial   = Expeditious Retreat 1d4 + 1 Minutes
    // Secondary = +2 Dexterity
    // Overdose  = Multiple doses within 24 hours, 2d4 points of damage
    //           = Piercing and Slashing Vulnerability (+2 damage)
    // Addiction = 2 (low)
    ////////////////////////////////////////////////////////////////////////////
    else if (GetResRef(oDrug) == "kammarth")
    {
        sDrug               = "nDrug02";
        nOverdose           = 8*60*60;
        nDuration           = d4(1)+1;
        nDuration2          = d4(2);
        nAddictionState     = GetLocalInt(oItem,sDrug+"AddStat");
        nAddictionStrength  = GetLocalInt(oItem,sDrug+"Addict");
        nLastUsed           = GetLocalInt(oItem,sDrug+"LastUse");
        nSaves              = GetLocalInt(oItem,sDrug+"Save");
        nTimesUsed          = GetLocalInt(oItem,sDrug+"Use");

        SetLocalInt(oItem, sDrug+"LastUse",nTimeNow);
        SetLocalInt(oItem, sDrug+"Save",0);
        SetLocalInt(oItem, sDrug+"Use",nTimesUsed+1);

        //If not addicted, you are now.
        if(nAddictionState == 0)    {SetLocalInt(oItem,sDrug+"AddStat",TRUE);}
        //If first time, set addiction strength.
        if(nAddictionStrength == 0) {SetLocalInt(oItem,sDrug+"Addict",2);}
        //If not first time, check uses and see if need to step addiction.
        else
        {
            //If used less than 60 times, no advancement, otherwise milestones
            if      (nTimesUsed == 60 || nTimesUsed == 120 || nTimesUsed == 180 || nTimesUsed == 240 || nTimesUsed == 300 || nTimesUsed == 360 || nTimesUsed == 420 || nTimesUsed == 480)
            {SetLocalInt(oItem,sDrug+"Addict",nAddictionStrength+1);}

            if(GetLocalInt(oItem,sDrug+"Addict") >= 6)
            {SetLocalInt(oItem,sDrug+"Addict",6);}
        }

        //Not an Overdose. Timestamp for overdose is less than current timestamp
        if(nLastUsed+nOverdose <= nTimeNow)
        {
            //Initial Effects
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectMovementSpeedIncrease(150),oPC,IntToFloat(nDuration));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityIncrease(ABILITY_DEXTERITY,2),oPC,IntToFloat(nDuration));
        }
        else
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d4(1)),oPC);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectParalyze(),oPC,IntToFloat(nDuration));
        }
    }
    else if (GetResRef(oDrug) == "rhul")    {}
    //Skip JHUILD
    else if (GetResRef(oDrug) == "jhuild")  {}
    else if (GetResRef(oDrug) == "katakuda"){}
    else if (GetResRef(oDrug) == "sezarad") {}
}

////////////////////////////////////////////////////////////////////////////////
////////// OLD DRUG SCRIPTS -- FOR EFFECTS REFERENCE ONLY, NO FUNCTIONS REP'D
////////////////////////////////////////////////////////////////////////////////
/*
ExecuteScript("sas_activate", OBJECT_SELF);
object oUsed = GetItemActivated();
//--------------------- DRUGS ARE BAD, M'KAY -----------------------------------
//______________________________________________________________________________
if(GetResRef(oUsed) == "haunspeir")
    {
    object oPC = GetItemActivator();
    SetLocalObject(GetModule(), "PC_DRUG_USER", oPC);
    //see if the PC can use the drug:
    int nCheck1 = d20() + GetSkillRank(SKILL_DISCIPLINE, oPC);
    int nCheck2 = d20() + GetSkillRank(SKILL_CONCENTRATION, oPC);
    int nCheck3 = d20() + (GetSkillRank(SKILL_HEAL, oPC) / 2);
    if(nCheck1 >= 12 || nCheck2 >= 12 || nCheck3 >= 12)
        {
        int nThisTripHour = GetTimeHour();
        int nThisTripDay = GetCalendarDay();
        int nThisTripMonth = GetCalendarMonth();
        int nThisTripYear = GetCalendarYear();
        string sThisTrip = IntToString(nThisTripMonth) + "/" + IntToString(nThisTripDay) + "/" + IntToString(nThisTripYear) + "/" + IntToString(nThisTripHour);
        //check to see if the PC took this drug too soon
        if(GetLocalString(GetItemPossessedBy(oPC,"PC_Data_Object"), "LAST_HUANSPEIR_TRIP") == "" || TimeSince(GetLocalString(GetItemPossessedBy(oPC,"PC_Data_Object"), "LAST_HUANSPEIR_TRIP"), sThisTrip, "hours") >= 24)
            {//if the last drug use was more than one day ago, the PC can use it again...
            //tell the PC they took the drug successfully
            SendMessageToPC(oPC, "You ingested the Haunspeir");
            //make the visuals:
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_DUR_SANCTUARY), oPC);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_BLINDDEAF), oPC);
            //make the effects:
            float fLast = (d10() + 15.0) * 2.0;//how long the effect will last(calc'd to number of "real-time" seconds
            int nAdd = d4() + 1;//the increase in intelligence
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(d4(), DAMAGE_TYPE_SLASHING, DAMAGE_POWER_NORMAL), oPC);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAbilityIncrease(ABILITY_INTELLIGENCE, nAdd), oPC, fLast);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageDecrease(1, DAMAGE_TYPE_SLASHING), oPC, fLast);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageDecrease(1, DAMAGE_TYPE_BLUDGEONING), oPC, fLast);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageDecrease(1, DAMAGE_TYPE_PIERCING), oPC, fLast);
            DelayCommand(fLast, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_MIND), oPC));
            //set up the overdose system:
            int nYear = GetCalendarYear();
            int nMonth = GetCalendarMonth();
            int nDay = GetCalendarDay();
            int nHour = GetTimeHour();
            int nMinute = GetTimeMinute();
            string sLastTrip = IntToString(nMonth) + "/" + IntToString(nDay) + "/" + IntToString(nYear) + "/" + IntToString(nHour);
            //record the date and time of this trip:
            SetLocalString(GetItemPossessedBy(oPC,"PC_Data_Object"), "LAST_HUANSPEIR_TRIP", sLastTrip);
            //setup addiction stuff

            }
         else//overdose
            {
            int nDamage = d4() + d4();
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(nDamage, DAMAGE_TYPE_SLASHING, DAMAGE_POWER_NORMAL), oPC);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY), oPC);
            string sOD = "You just overdosed on Haunspeir, taking " + IntToString(nDamage) + " damage";
            SendMessageToPC(oPC, sOD);
            }
        }//end nCheck's if
    else
        SendMessageToPC(oPC, "You didn't ingest the Haunspeir");
    }//end Huanspeir
//______________________________________________________________________________
if(GetResRef(oUsed) == "jhuild")
    {
    object oPC = GetItemActivator();
    //see if the PC can use the drug:
    int nCheck1 = d20() + GetSkillRank(SKILL_DISCIPLINE, oPC);
    int nCheck2 = d20() + GetSkillRank(SKILL_CONCENTRATION, oPC);
    int nCheck3 = d20() + (GetSkillRank(SKILL_HEAL, oPC) / 2);
    if(nCheck1 >= 15 || nCheck2 >= 15 || nCheck3 >= 15)
        {
        //tell the PC they took the drug successfully
        SendMessageToPC(oPC, "You drank the Jhuild");
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PULSE_HOLY), oPC);
        int nLast = d3();//1d3 hours of game time
        float fTime = nLast * 120.0;//get the number of seconds the effect will last
        //now make the real effects
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAbilityDecrease(2, ABILITY_WISDOM), oPC, fTime);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAbilityIncrease(2, ABILITY_STRENGTH), oPC, fTime);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSavingThrowDecrease(SAVING_THROW_ALL, 5, SAVING_THROW_TYPE_MIND_SPELLS), oPC, fTime);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSavingThrowDecrease(SAVING_THROW_ALL, 5, SAVING_THROW_TYPE_FEAR), oPC, fTime);
        DelayCommand(fTime, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_FIRE), oPC));
        //no overdose, no addiction :-)
        }
    else
        SendMessageToPC(oPC, "You didn't drink the Jhuild");
    }
//______________________________________________________________________________
if(GetResRef(oUsed) == "kammarth")
    {
    object oPC = GetItemActivator();
    //see if the PC can use the drug:
    int nCheck1 = d20() + GetSkillRank(SKILL_DISCIPLINE, oPC);
    int nCheck2 = d20() + GetSkillRank(SKILL_CONCENTRATION, oPC);
    int nCheck3 = d20() + (GetSkillRank(SKILL_HEAL, oPC) / 2);
    if(nCheck1 >= 10 || nCheck2 >= 10 || nCheck3 >= 10)
        {
        int nThisTripHour = GetTimeHour();
        int nThisTripDay = GetCalendarDay();
        int nThisTripMonth = GetCalendarMonth();
        int nThisTripYear = GetCalendarYear();
        string sThisTrip = IntToString(nThisTripMonth) + "/" + IntToString(nThisTripDay) + "/" + IntToString(nThisTripYear) + "/" + IntToString(nThisTripHour);
        //check to see if the PC took this drug too soon
        if(GetLocalString(GetItemPossessedBy(oPC,"PC_Data_Object"), "LAST_KAMMARTH_TRIP") == "" || TimeSince(GetLocalString(GetItemPossessedBy(oPC,"PC_Data_Object"), "LAST_KAMMARTH_TRIP"), sThisTrip, "hours") >= 8)
            {
            //tell the PC they took the drug successfully
            SendMessageToPC(oPC, "You touched the Kammarth");
            //make the visual effects:
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PULSE_COLD), oPC);
            int nIEffect = d4() + 1;
            float fIEffect = nIEffect * 2.0;//make the initial effect game-time length
            int nSEffect = d4();
            float fSEffect = nSEffect * 120.0;
            //Initial Effect: The PC becomes frieghtened for 1d4+1 game-time minutes
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectFrightened(), oPC, fIEffect);
            //Secondary Effect: plus 2 to dexterity for 1d4 hours
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAbilityIncrease(2, ABILITY_DEXTERITY), oPC, fSEffect);
            DelayCommand(fIEffect + fSEffect, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_SONIC), oPC));
            SetLocalString(GetItemPossessedBy(oPC,"PC_Data_Object"), "LAST_KAMMARTH_TRIP", sThisTrip);
            //setup addiction rules:

            }
         else//overdose
            {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY), oPC);
            int nDamage = d4();
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE, DAMAGE_POWER_NORMAL), oPC);
            float fPTime = (d4() + d4()) * 2.0;
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectParalyze(), oPC, fPTime);
            string sODMessage = "You just overdosed on Kammarth, Taking " + IntToString(nDamage) + " damage. You're paralyzed for " + FloatToString(fPTime) + " seconds";
            SendMessageToPC(oPC, sODMessage);
            }
        }
    else
        SendMessageToPC(oPC, "You didn't touch the Kammarth");
    }
//______________________________________________________________________________
if(GetResRef(oUsed) == "mordaynvapor")
    {
    object oPC = GetItemActivator();
    //see if the PC can use the drug:
    int nCheck1 = d20() + GetSkillRank(SKILL_DISCIPLINE, oPC);
    int nCheck2 = d20() + GetSkillRank(SKILL_CONCENTRATION, oPC);
    int nCheck3 = d20() + (GetSkillRank(SKILL_HEAL, oPC) / 2);
    if(nCheck1 >= 17 || nCheck2 >= 17 || nCheck3 >= 17)
        {
        int nThisTripHour = GetTimeHour();
        int nThisTripDay = GetCalendarDay();
        int nThisTripMonth = GetCalendarMonth();
        int nThisTripYear = GetCalendarYear();
        string sThisTrip = IntToString(nThisTripMonth) + "/" + IntToString(nThisTripDay) + "/" + IntToString(nThisTripYear) + "/" + IntToString(nThisTripHour);
        //check to see if the PC took this drug too soon
        if(GetLocalString(GetItemPossessedBy(oPC,"PC_Data_Object"), "LAST_MVAPOR_TRIP") == "" || TimeSince(GetLocalString(GetItemPossessedBy(oPC,"PC_Data_Object"), "LAST_MVAPOR_TRIP"), sThisTrip, "hours") >= 3)
            {
            //tell the PC they took the drug successfully
            SendMessageToPC(oPC, "You inhaled the Mordayn Vapor");
            //make the visual effects:
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_BLINDDEAF), oPC);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE), oPC);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_DUR_PROT_PREMONITION), oPC);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_DUR_MIND_AFFECTING_POSITIVE), oPC);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(AOE_PER_FOGACID), GetLocation(oPC));
            //make the effects:
            float fDur = (d12() + 10.0) * 2.0;
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectUltravision(), oPC, fDur);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectTrueSeeing(), oPC, fDur);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSeeInvisible(), oPC, fDur);
            //Secondary Effect: loss of constitution and wisdom
            DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAbilityDecrease(d4(), ABILITY_CONSTITUTION), oPC, 15.0));
            DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAbilityDecrease(d4(), ABILITY_WISDOM), oPC, 15.0));
            DelayCommand(fDur, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_HOLY), oPC));
            DelayCommand(fDur, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_HEAL), oPC));
            SetLocalString(GetItemPossessedBy(oPC,"PC_Data_Object"), "LAST_MVAPOR_TRIP", sThisTrip);
            //setup the addiction rules:

            }
        else//overdose
            {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY), oPC);
            int nSave = WillSave(oPC, 17, SAVING_THROW_TYPE_POISON);
            switch(nSave)
                {
                case 0://the PC failed the save
                    SendMessageToPC(oPC, "You just overdosed on Mardayn Vapor and died");
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(TRUE), oPC);
                    break;
                case 1://the PC passed the save
                    SendMessageToPC(oPC, "You just overdosed on Mardayn Vapor but didn't die");
                    //setup the addiction rules:

                    break;
                case 2://the PC was immune to the save
                    SendMessageToPC(oPC, "You just overdosed on Mardayn Vapor but didn't die");
                    //setup the addiction rules:

                    break;
                }
            }
        }
    else
        SendMessageToPC(oPC, "You didn't inhale the Mordayn Vapor");
    }
//______________________________________________________________________________
if(GetResRef(oUsed) == "katakuda")
    {
    object oPC = GetItemActivator();
    //see if the PC can use the drug:
    int nCheck1 = d20() + GetSkillRank(SKILL_DISCIPLINE, oPC);
    int nCheck2 = d20() + GetSkillRank(SKILL_CONCENTRATION, oPC);
    int nCheck3 = d20() + (GetSkillRank(SKILL_HEAL, oPC) / 2);
    if(nCheck1 >= 18 || nCheck2 >= 18 || nCheck3 >= 18 || GetLevelByClass(CLASS_TYPE_MONK, oPC) >= 1)
        {
        int nThisTripHour = GetTimeHour();
        int nThisTripDay = GetCalendarDay();
        int nThisTripMonth = GetCalendarMonth();
        int nThisTripYear = GetCalendarYear();
        string sThisTrip = IntToString(nThisTripMonth) + "/" + IntToString(nThisTripDay) + "/" + IntToString(nThisTripYear) + "/" + IntToString(nThisTripHour);
        //check to see if the PC took this drug too soon
        if(GetLocalString(GetItemPossessedBy(oPC,"PC_Data_Object"), "LAST_KATAKUDA_TRIP") == "" || TimeSince(GetLocalString(GetItemPossessedBy(oPC,"PC_Data_Object"), "LAST_KATAKUDA_TRIP"), sThisTrip, "hours") >= 48)
            {
            //tell the PC they took the drug successfully
            SendMessageToPC(oPC, "You touched the Katakuda");
            //make the visual effects:
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_AC_BONUS), oPC);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_PROT_BARKSKIN), oPC, 60.0);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_FIRESTORM), oPC);
            //Secondary effect: +3 to natual AC
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectACIncrease(3, AC_NATURAL_BONUS, AC_VS_DAMAGE_TYPE_ALL), oPC, 60.0);
            //Side Effects: Muscle spasms and dexterity decrease
            DelayCommand(60.1, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oPC, 3.0));
            DelayCommand(60.1, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAbilityDecrease( (d4()+1 ), ABILITY_DEXTERITY), oPC, 15.0));
            DelayCommand(75.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_ODD), oPC));
            SetLocalString(GetItemPossessedBy(oPC,"PC_Data_Object"), "LAST_KATAKUDA_TRIP", sThisTrip);
            }
        else//overdose
            {
            SendMessageToPC(oPC, "You overdosed on Katakuda causing only +2 to Natural Armor");
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY), oPC);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectACIncrease(2, AC_NATURAL_BONUS, AC_VS_DAMAGE_TYPE_ALL), oPC, 60.0);
            }
        }
    else
        SendMessageToPC(oPC, "You didn't touch the Katakuda");
    }
//______________________________________________________________________________
if(GetResRef(oUsed) == "rhul")
    {
    object oPC = GetItemActivator();
    //see if the PC can use the drug:
    int nCheck1 = d20() + GetSkillRank(SKILL_DISCIPLINE, oPC);
    int nCheck2 = d20() + GetSkillRank(SKILL_CONCENTRATION, oPC);
    int nCheck3 = d20() + (GetSkillRank(SKILL_HEAL, oPC) / 2);
    if(nCheck1 >= 15 || nCheck2 >= 15 || nCheck3 >= 15)
        {
        int nThisTripHour = GetTimeHour();
        int nThisTripDay = GetCalendarDay();
        int nThisTripMonth = GetCalendarMonth();
        int nThisTripYear = GetCalendarYear();
        string sThisTrip = IntToString(nThisTripMonth) + "/" + IntToString(nThisTripDay) + "/" + IntToString(nThisTripYear) + "/" + IntToString(nThisTripHour);
        //check to see if the PC took this drug too soon
        if(GetLocalString(GetItemPossessedBy(oPC,"PC_Data_Object"), "LAST_RHUL_TRIP") == "" || TimeSince(GetLocalString(GetItemPossessedBy(oPC,"PC_Data_Object"), "LAST_RHUL_TRIP"), sThisTrip, "hours") >= 1)
            {
            //tell the PC they took the drug successfully
            SendMessageToPC(oPC, "You drank the Rhul");
            //make the visual effects:
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_AC_BONUS), oPC);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_KNOCK), oPC);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_ELEMENTAL_SHIELD), oPC, 15.0);
            //initial effect: +4 to strength and cons: -4 to wisdon
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAbilityIncrease(4, ABILITY_STRENGTH), oPC, 15.0);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAbilityIncrease(4, ABILITY_CONSTITUTION), oPC, 15.0);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAbilityDecrease(4, ABILITY_WISDOM), oPC, 15.0);
            //secondary effect: fatigue
            DelayCommand(15.1, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSlow(), oPC, 10.0));
            DelayCommand(25.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_EVIL), oPC));
            SetLocalString(GetItemPossessedBy(oPC,"PC_Data_Object"), "LAST_RHUL_TRIP", sThisTrip);
            //setup addiction rules

            }
        else//overdose
            {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY), oPC);
            int nIntelDam = d4();
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAbilityDecrease(ABILITY_INTELLIGENCE, nIntelDam), oPC, 60.0);
            SendMessageToPC(oPC, "You overdosed on Rhul, taking " + IntToString(nIntelDam) + " temporary intelligence damage");
            }
        }
    else
        SendMessageToPC(oPC, "You didn't drink the Rhul");
    }
//______________________________________________________________________________
if(GetResRef(oUsed) == "sezaradroot")
    {
    object oPC = GetItemActivator();
    //see if the PC can use the drug:
    int nCheck1 = d20() + GetSkillRank(SKILL_DISCIPLINE, oPC);
    int nCheck2 = d20() + GetSkillRank(SKILL_CONCENTRATION, oPC);
    int nCheck3 = d20() + (GetSkillRank(SKILL_HEAL, oPC) / 2);
    if(nCheck1 >= 14 || nCheck2 >= 14 || nCheck3 >= 14)
        {
        int nThisTripHour = GetTimeHour();
        int nThisTripDay = GetCalendarDay();
        int nThisTripMonth = GetCalendarMonth();
        int nThisTripYear = GetCalendarYear();
        string sThisTrip = IntToString(nThisTripMonth) + "/" + IntToString(nThisTripDay) + "/" + IntToString(nThisTripYear) + "/" + IntToString(nThisTripHour);
        //tell the PC they took the drug successfully
        SendMessageToPC(oPC, "You ingested the Sezarad Root");
        //make the visual effects:
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEALING_G), oPC);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE), oPC);
        //make the effects:
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectTemporaryHitpoints(d8()), oPC, 30.0);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAbilityDecrease(d4(), ABILITY_WISDOM), oPC, 30.0);
        DelayCommand(30.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_ACID), oPC));
        //setup addiction rules

        }
    else
        SendMessageToPC(oPC, "You didn't ingest the Sezarad Root");
    }
//______________________________________________________________________________
if(GetResRef(oUsed) == "ziran")
    {
    object oPC = GetItemActivator();
    //see if the PC can use the drug:
    int nCheck1 = d20() + GetSkillRank(SKILL_DISCIPLINE, oPC);
    int nCheck2 = d20() + GetSkillRank(SKILL_CONCENTRATION, oPC);
    int nCheck3 = d20() + (GetSkillRank(SKILL_HEAL, oPC) / 2);
    if(nCheck1 >= 17 || nCheck2 >= 17 || nCheck3 >= 17)
        {
        int nThisTripHour = GetTimeHour();
        int nThisTripDay = GetCalendarDay();
        int nThisTripMonth = GetCalendarMonth();
        int nThisTripYear = GetCalendarYear();
        string sThisTrip = IntToString(nThisTripMonth) + "/" + IntToString(nThisTripDay) + "/" + IntToString(nThisTripYear) + "/" + IntToString(nThisTripHour);
        //tell the PC they took the drug successfully
        SendMessageToPC(oPC, "You ingested the Ziran");
        float fDur = d3() * 120.0;//1d3 hours
        //make the visual effects:
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_FREEDOM_OF_MOVEMENT), oPC, fDur);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_MAGICAL_VISION), oPC);
        //make the effects:
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDazed(), oPC, 4.0);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAbilityIncrease(2, ABILITY_DEXTERITY), oPC, fDur);
        DelayCommand(fDur, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAbilityDecrease(2, ABILITY_CONSTITUTION), oPC, 45.0));
        DelayCommand(fDur + 45.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_SONIC), oPC));
        //setup  addiction rules

        }
    else
        SendMessageToPC(oPC, "You didn't ingest the Ziran");
    }
//______________________________________________________________________________
//-------------------- END DRUGS ARE BAD ---------------------------------------
*/

