#include "nwnx_time"
#include "ccc_inc_traps"

//Triggers a trap based on the type of chest
void TriggerTrap(object oPC,int nType);
//Gets loot
void DoLoot(object oPC,int nType);
//Returns the string of an item from a given table
// nTable 0 = Loot0, nTable 1 = Loot1, nTable 2 = Loot2, nTable 3 = Loot3
// nTable 4 = Gems, nTable 5 = Hist
string GetLootItem(int nTable);

void MakePlagueItem(object oCaster);

void main()
{
    object oPC = GetLastUsedBy();
    object oTarget = oPC;
    int nMinutes = 120;
    int nType = GetLocalInt(OBJECT_SELF,"LootType");
    int nNum = 1;
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");
    int nDust = GetLocalInt(oItem,"nDust");
    int nBlood = GetLocalInt(oItem,"nBlood");
    int nTimeNow = NWNX_Time_GetTimeStamp();
    int nInteract = GetLocalInt(OBJECT_SELF,"nInteract");
    int nNextLoot = NWNX_Time_GetTimeStamp() + (nMinutes*60);
    int nD201;
    int nD202;
    int nD203;
    int nD204;
    int nLastLoot = GetLocalInt(OBJECT_SELF,"nLastLoot");
    object oThief  = GetItemPossessedBy(oPC,"te_thieftools");
    object oPrybar = GetItemPossessedBy(oPC,"te_prybar");
    object oChime  = GetItemPossessedBy(oPC,"te_chimeopen");
    object oLens   = GetItemPossessedBy(oPC,"te_detectionlens");
    object oGlove  = GetItemInSlot(INVENTORY_SLOT_ARMS,oPC);
    if(GetLocalInt(oGlove,"TrapAvoid") != 1) {oGlove = OBJECT_INVALID;}

    // DC Value by type
    int nDetectDC, nTrapDC, nOpenDC;
    //Trigger TRUE FALSE
    int nDetect,nTrap,nLock;
    //Breakable Object TRUE FALSE
    int nThief = FALSE;
    int nPry = FALSE;

    SetLocalInt(OBJECT_SELF,"nInteract",nTimeNow+61);

    if(nInteract >= nTimeNow)
    {
        SendMessageToPC(oPC,"Someone else is currently interacting with this chest.");
        return;
    }

    if(nType == 0)
    {
        nDetectDC = 20; //Search
        nTrapDC   = 20; //Disable Trap
        nOpenDC   = 20; //Open Lock
    }
    else if (nType == 1)
    {
        nDetectDC = 25; //Search
        nTrapDC   = 25; //Disable Trap
        nOpenDC   = 25; //Open Lock
        nNextLoot += (60*(Random(180)));
    }
    else if  (nType == 2)
    {
        nDetectDC = 30; //Search
        nTrapDC   = 30; //Disable Trap
        nOpenDC   = 30; //Open Lock
        nNextLoot += (60*(Random(180)+30));
    }
    else if  (nType == 3)
    {
        nDetectDC = 35; //Search
        nTrapDC   = 35; //Disable Trap
        nOpenDC   = 35; //Open Lock
        nNextLoot += (60*(Random(180)+60));
    }
    else if  (nType == 4)
    {
        nDetectDC = 40; //Search
        nTrapDC   = 40; //Disable Trap
        nOpenDC   = 40; //Open Lock
        nNextLoot += (60*(Random(180)+90));
    }

    if(nLastLoot > nTimeNow)
    {
        SendMessageToPC(oPC,"This chest has been emptied of valuable items.");
    }
    else
    {
        if(GetIsInCombat(oPC) == TRUE)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneImmobilize(),oPC,12.0f);
            AssignCommand(oPC, PlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 12.0));
            SendMessageToPC(oPC,"You automatically fail to open a chest when trying to search in the middle of battle.");
            return;
        }
        else
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneImmobilize(),oPC,60.0f);
            AssignCommand(oPC, PlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 60.0));
        }

        //AUTO WIN ITEMS
        if(oChime != OBJECT_INVALID)
        {
            nLock = TRUE;
            SetItemCharges(oChime,GetItemCharges(oChime)-1);
        }

        if(oGlove != OBJECT_INVALID)
        {
            nTrap = TRUE;
            SetItemCharges(oGlove,GetItemCharges(oGlove)-1);
        }

        if(oLens != OBJECT_INVALID)
        {
            nDetect = TRUE;
            SetItemCharges(oLens,GetItemCharges(oLens)-1);
        }
        /////////////////////////////////////////////////////
        //Normal degrade items
        if(nLock != TRUE && oThief != OBJECT_INVALID)
        {
            SetItemCharges(oThief,GetItemCharges(oThief)-1);
        }


        //Detect Trap
        if(nDetect != TRUE)
        {
            if(d20(1) + GetSkillRank(SKILL_SEARCH,oPC) >= nDetectDC){nDetect = TRUE;}
            else{nDetect = FALSE;}
        }

        //Disable Trap
        if(nTrap != TRUE && oGlove == OBJECT_INVALID)
        {
            if(nDetect == FALSE){nTrap = FALSE;}
            else
            {
                if(d20(1) + GetSkillRank(SKILL_DISABLE_TRAP,oPC) >= nTrapDC){nTrap = TRUE;}
                else{nTrap = FALSE;}
            }
        }

        //Open Lock
        if(nLock == FALSE)
        {
            if(oThief == OBJECT_INVALID &&
               oPrybar== OBJECT_INVALID )
            {
                nLock == FALSE;
                DelayCommand(25.0,SendMessageToPC(oPC,"You have no thieves tools or pry bar and cannot break into the chest."));
                return;
            }
            else if(oThief != OBJECT_INVALID && nLock == FALSE)
            {
                nD203 = d20(1);
                DelayCommand(25.0,SendMessageToPC(oPC,"You begin using your thieves tools to try and break into the chest."));
                if(nD203 == 1)
                {
                    nLock = FALSE;
                    nThief = TRUE;
                    DelayCommand(30.0,SendMessageToPC(oPC,"Your thieves tools break!"));
                }
                else if(nD203 + GetSkillRank(SKILL_OPEN_LOCK,oPC) >= nOpenDC)
                {
                    nLock = TRUE;
                }
                else
                {
                    nLock = FALSE;
                }
            }
            else if(oPrybar != OBJECT_INVALID && nLock == FALSE)
            {
                nD204 = d20(1);
                DelayCommand(35.0,SendMessageToPC(oPC,"You begin using your pry bar to try and break into the chest."));
                if(nD204 == 1)
                {
                    nLock = FALSE;
                    nPry = TRUE;
                    DelayCommand(35.0,SendMessageToPC(oPC,"Your metal pry bar breaks!"));
                }
                else if(nD204 + GetAbilityModifier(ABILITY_STRENGTH,oPC) >= nOpenDC-4){nLock = TRUE;}
                else{nLock = FALSE;}
            }
        }

        if(nDetect == TRUE){DelayCommand(10.0,SendMessageToPC(oPC,"As you begin to examine the chest, you find signs that it is trapped..."));}
        if(nTrap == TRUE)
        {
            DelayCommand(20.0,SendMessageToPC(oPC,"You successfully disable a trap..."));
        }
        else
        {
            DelayCommand(20.0,SendMessageToPC(oPC,"You trigger a trap!"));
            DelayCommand(20.0,TriggerTrap(oPC,nType));
        }

        if(nLock == TRUE)
        {
            DelayCommand(50.0,SendMessageToPC(oPC,"You successfully open the chest!"));
            //////////////////////////////////////////////////////
            // LOOOOOOOOOT
            //////////////////////////////////////////////////////
            DelayCommand(60.0,DoLoot(oPC,nType));
            SetLocalInt(OBJECT_SELF,"nLastLoot",nNextLoot);
        }
        else
        {
            DelayCommand(60.0,SendMessageToPC(oPC,"You fail to open the chest."));

            if(nPry == TRUE)
            {
                //DelayCommand(50.0,SendMessageToPC(oPC,"Your metal pry bar breaks!"));
                DestroyObject(oPrybar,60.0);
            }

            if(nThief == TRUE)
            {
                //DelayCommand(50.0,SendMessageToPC(oPC,"Your thieves tools break!"));
                if(GetItemStackSize(oThief) == 1)
                {
                    DestroyObject(oThief,60.0);
                }
                else
                {
                    DelayCommand(60.0,SetItemStackSize(oThief,GetItemStackSize(oThief)-1));
                }

            }
        }

        //
    }
}
void TriggerTrap(object oPC,int nType)
{
    int nRandom;

    //Locked Crate
    if(nType == 0)
    {
        CustomDoTrapSpike(oPC,d6(3),15);
    }
    //Strongbox
    else if(nType == 1)
    {
        nRandom = Random(10);
        if(nRandom == 0)        HolyTrap(oPC,d10(5),d4(3),15);
        else if(nRandom == 1)   AcidBlob(oPC,d6(5),3,20);
        else if(nRandom == 2)   FireTrap(oPC,RADIUS_SIZE_SMALL,d6(8),20);
        else if(nRandom == 3)   TrapDoElectricalDamage(d6(15), 22, 4,oPC);
        else if(nRandom == 4)   CustomDoTrapSpike(oPC,d6(3),15);
        else if(nRandom == 5)   GasTrap(oPC,"NW_T1_GasAvgC1",2);
        else if(nRandom == 6)   FrostTrap(oPC,d4(3),13,2);
        else if(nRandom == 7)   NegativeTrap(oPC,1,d6(3),15,0);
        else if(nRandom == 8)   SonicTrap(oPC,d4(3),RADIUS_SIZE_MEDIUM,14,2);
        else if(nRandom == 9)   AcidSplash(oPC,d8(3),14);
    }
    //Safe
    else if(nType == 2)
    {
        nRandom = Random(10);
        if(nRandom == 0) CustomDoTrapSpike(oPC,d6(5),15);
        else if(nRandom == 1)AcidSplash(oPC,d8(5),17);
        else if(nRandom == 2)SonicTrap(oPC,d4(5),RADIUS_SIZE_MEDIUM,17,3);
        else if(nRandom == 3)NegativeTrap(oPC,2,d6(5),18,0);
        else if(nRandom == 4)FrostTrap(oPC,d4(5),14,3);
        else if(nRandom == 5)GasTrap(oPC,"NW_T1_GasStrC1",2);
        else if(nRandom == 6)TrapDoElectricalDamage(d6(20),26,5,oPC);
        else if(nRandom == 7)FireTrap(oPC,RADIUS_SIZE_MEDIUM,d6(15),23);
        else if(nRandom == 8)AcidBlob(oPC,d6(12),4,25);
        else if(nRandom == 9)HolyTrap(oPC,d10(8),d4(6),18);

    }
    //Repository
    else if(nType == 3)
    {
        nRandom = Random(10);
        if(nRandom == 0)     CustomDoTrapSpike(oPC,d6(25),15);
        else if(nRandom == 1)AcidSplash(oPC,d8(8),20);
        else if(nRandom == 2)SonicTrap(oPC,d4(8),RADIUS_SIZE_MEDIUM,20,4);
        else if(nRandom == 3)NegativeTrap(oPC,1,d6(8),21,1);
        else if(nRandom == 4)FrostTrap(oPC,d4(8),15,4);
        else if(nRandom == 5)GasTrap(oPC,"NW_T1_GasDeadC1",2);
        else if(nRandom == 6)TrapDoElectricalDamage(d6(30),28,6,oPC);
        else if(nRandom == 7)FireTrap(oPC,RADIUS_SIZE_MEDIUM,d6(25),26);
        else if(nRandom == 8)AcidBlob(oPC,d6(18),5,25);
        else if(nRandom == 9)HolyTrap(oPC,d10(12),d4(8),21);

    }
    //Cache
    else if(nType == 4)
    {
        nRandom = Random(4);

        if(nRandom == 0) SonicTrap(oPC,d4(40),RADIUS_SIZE_MEDIUM,30,4);
        else if(nRandom == 1)FrostTrap(oPC,d4(40),30,4);
        else if(nRandom == 2)TrapDoElectricalDamage(d6(60),35,6,oPC);
        else if(nRandom == 3)FireTrap(oPC,RADIUS_SIZE_MEDIUM,d6(50),33);

    }
    //Plaguelands Loot
    else if(nType == 5)
    {
        nRandom = Random(4);

        if(nRandom == 0) SonicTrap(oPC,d4(50),RADIUS_SIZE_MEDIUM,30,4);
        else if(nRandom == 1)FrostTrap(oPC,d4(50),30,4);
        else if(nRandom == 2)TrapDoElectricalDamage(d6(65),35,6,oPC);
        else if(nRandom == 3)FireTrap(oPC,RADIUS_SIZE_MEDIUM,d6(55),33);
    }
}

void DoLoot(object oPC,int nType)
{
    int nD20 = d20(1);
    int nSkill = GetSkillRank(SKILL_SEARCH,oPC,FALSE);
    int nRoll = nD20+nSkill;
    int nGold = 0;
    int nGem = 0;
    int nHist = 0;
    int nLoot0 = 0;
    int nLoot1 = 0;
    int nLoot2 = 0;
    int nLoot3 = 0;
    int nLoot4 = 0;
    int nD1001;
    int nD1002;
    int nGoldThreshold;

    int i, j, k, l, m, n, o;

    if(nType = 0)
    {
        nGold = 100+Random(100);
        nD1001 = d100(1);
        nD1002 = d100(1);
        if(nD1001 >= 71 && nD1001 < 96)
        {
            nGem = d4(1);
        }
        else if(nD1001 >= 96)
        {
            nHist = d3(1);
        }

        if(nD1002 >= 43 && nD1002 <= 62) //43-62 1d4 Loot 0
        {
            nLoot0 = d4(1);
        }
        else if(nD1002 >= 63) //63-100 1 Loot 1
        {
            nLoot1   = 1;
        }
    }
    else if(nType = 1) //6th Level CR chest
    {
        nGold = 200+Random(200);
        nD1001 = d100(1);
        nD1002 = d100(1);
        if(nD1001 >= 57 && nD1001 < 93)
        {
            nGem = d4(1);
        }
        else if(nD1001 >= 94)
        {
            nHist = d4(1);
        }

        if(nD1002 >= 55 && nD1002 <= 59) //43-62 1d4 Loot 0
        {
            nLoot0 = d4(1);
        }
        else if(nD1002 >= 60 && nD1002 <=99) //63-100 1 Loot 1
        {
            nLoot1   = d3(1);
        }
        else if(nD1002 == 100)
        {
            nLoot2 = 1;
        }
    }
    else if(nType = 2) //8th Level CR chest
    {
        nGold = 300+Random(300);
        nD1001 = d100(1);
        nD1002 = d100(1);
        if(nD1001 >= 46 && nD1001 < 85)
        {
            nGem = d4(1);
        }
        else if(nD1001 >= 85)
        {
            nHist = d4(1);
        }

        if(nD1002 >= 49 && nD1002 <= 96) //43-62 1d4 Loot 0
        {
            nLoot1 = d3(1);
        }
        else if(nD1002 >= 97 && nD1002 <=100) //63-100 1 Loot 1
        {
            nLoot2   = 1;
        }
    }
    else if(nType = 3) //10th Level CR chest
    {
        nGold = 400+Random(400);
        nD1001 = d100(1);
        nD1002 = d100(1);
        if(nD1001 >= 36 && nD1001 < 79)
        {
            nGem = d6(1);
        }
        else if(nD1001 >= 79)
        {
            nHist = d4(1);
        }

        if(nD1002 >= 44 && nD1002 <= 91) //43-62 1d4 Loot 0
        {
            nLoot1 = d4(1);
        }
        else if(nD1002 >= 92 && nD1002 <=100) //63-100 1 Loot 1
        {
            nLoot2   = 1;
        }
    }
    else if(nType = 4) //15th Level CR chest
    {
        nGold = 500+Random(500);
        nD1001 = d100(1);
        nD1002 = d100(1);
        if(nD1001 >= 10 && nD1001 < 65)
        {
            nGem = d10(3);
        }
        else if(nD1001 >= 66)
        {
            nHist = d8(2);
        }

        if(nD1002 >= 12 && nD1002 <= 46) //43-62 1d4 Loot 0
        {
            nLoot2 = d4(1);
        }
        else if(nD1002 >= 47 && nD1002 <=90) //63-100 1 Loot 1
        {
            nLoot3   = 1;
        }
        else if(nD1002 >=91) //91-100 Plaguelands Special Enchants
        {
            nLoot4 = 1;
        }
    }
    else if(nType = 5) //20th Level Cr chest
    {
        nGold = 750 + Random(600);
        nD1001 = d100(1);
        nD1002 = d100(1);
         if(nD1001 >= 10 && nD1001 < 65)
        {
            nGem = d10(2);
        }
        else if(nD1001 >= 66)
        {
            nHist = d8(2);
        }
         if(nD1002 >= 12 && nD1002 <= 46) //43-62 1d4 Loot 0
        {
            nLoot1 = d4(1);
        }
        else if(nD1002 >= 47 && nD1002 <=90) //63-100 1 Loot 1
        {
            nLoot2   = 1;
        }
        else if(nD1002 >=91)
        {
            nLoot3 = 1;
        }
    }

    if(nGold > 0)
    {
        GiveGoldToCreature(oPC,nGold);
    }

    if(nGem > 0)
    {
        for (o = 0; o < nHist; o++)
        {
            CreateItemOnObject(GetLootItem(4),oPC);
        }
    }
    if(nHist > 0)
    {
        for (i = 0; i < nHist; i++)
        {
            CreateItemOnObject(GetLootItem(5),oPC);
        }
    }

    if(nLoot0 > 0)
    {
        for (j = 0; j < nLoot0; j++)
        {
            CreateItemOnObject(GetLootItem(0),oPC);
        }
    }

    if(nLoot1 > 0)
    {
        for (k = 0; k < nLoot1; k++)
        {
            string resref = GetLootItem(1);
            if ((resref == "te_item_6018") ||
                (resref == "te_item_9008") ||
                (resref == "te_item_1001") ||
                (resref == "te_item_6019") ||
                (resref == "te_item_6017"))
                {
                   CreateItemOnObject(resref,oPC, d12(1));
                }
            else
            {
                 CreateItemOnObject(resref,oPC);
            }
        }
    }

    if(nLoot2 > 0)
    {
        for (m = 0; m < nLoot2; m++)
        {
            CreateItemOnObject(GetLootItem(2),oPC);
        }
    }

    if(nLoot3 > 0)
    {
        for (n = 0; n < nLoot3; n++)
        {
            CreateItemOnObject(GetLootItem(3),oPC);
        }
    }
    if(nLoot4 > 0)
    {
        for (n = 0; n < nLoot4; n++)
        {
            MakePlagueItem(oPC);
        }
    }
}

//Returns the string of an item from a given table
// nTable 0 = Loot0, nTable 1 = Loot1, nTable 2 = Loot2, nTable 3 = Loot3
// nTable 4 = Gems, nTable 5 = Hist, nTable 6 = Scrolls, nTable 7 N/A
string GetLootItem(int nTable)
{
    int nRandom;
    if(nTable == 0)
    {
        nRandom = Random(90)+1;
        if(nRandom == 1) return "irongauntletsmw";
        else if(nRandom == 2) return "te_basic001";
        else if(nRandom == 3) return "te_basic002";
        else if(nRandom == 4) return "te_basic003";
        else if(nRandom == 5) return "te_basic004";
        else if(nRandom == 6) return "te_basic005";
        else if(nRandom == 7) return "te_basic006";
        else if(nRandom == 8) return "te_basic007";
        else if(nRandom == 9) return "te_basic008";
        else if(nRandom == 10) return "te_basic009";
        else if(nRandom == 11) return "te_basic010";
        else if(nRandom == 12) return "te_basic011";
        else if(nRandom == 13) return "te_basic012";
        else if(nRandom == 14) return "te_basic013";
        else if(nRandom == 15) return "te_basic014";
        else if(nRandom == 16) return "te_basic015";
        else if(nRandom == 17) return "te_basic016";
        else if(nRandom == 18) return "te_basic017";
        else if(nRandom == 19) return "te_basic018";
        else if(nRandom == 20) return "te_basic019";
        else if(nRandom == 21) return "te_basic020";
        else if(nRandom == 22) return "te_basic021";
        else if(nRandom == 23) return "te_basic022";
        else if(nRandom == 24) return "te_basic023";
        else if(nRandom == 25) return "te_basic024";
        else if(nRandom == 26) return "te_basic025";
        else if(nRandom == 27) return "te_basic026";
        else if(nRandom == 28) return "te_basic027";
        else if(nRandom == 29) return "te_basic028";
        else if(nRandom == 30) return "te_basic029";
        else if(nRandom == 31) return "te_basic030";
        else if(nRandom == 32) return "te_basic031";
        else if(nRandom == 33) return "te_basic032";
        else if(nRandom == 34) return "te_basic033";
        else if(nRandom == 35) return "te_basic034";
        else if(nRandom == 36) return "te_basic035";
        else if(nRandom == 37) return "te_basic036";
        else if(nRandom == 38) return "te_basic037";
        else if(nRandom == 39) return "te_cestys";
        else if(nRandom == 40) return "te_item_5001";
        else if(nRandom == 41) return "te_item_5002";
        else if(nRandom == 42) return "te_item_5003";
        else if(nRandom == 43) return "te_item_5005";
        else if(nRandom == 44) return "te_item_5006";
        else if(nRandom == 45) return "te_item_5007";
        else if(nRandom == 46) return "te_item_5008";
        else if(nRandom == 47) return "te_item_5009";
        else if(nRandom == 48) return "te_item_5010";
        else if(nRandom == 49) return "te_item_5011";
        else if(nRandom == 50) return "te_item_5012";
        else if(nRandom == 51) return "te_item_5013";
        else if(nRandom == 52) return "te_item_5014";
        else if(nRandom == 53) return "te_item_5015";
        else if(nRandom == 54) return "te_item_5016";
        else if(nRandom == 55) return "te_item_5017";
        else if(nRandom == 56) return "te_item_5017b";
        else if(nRandom == 57) return "te_item_5018";
        else if(nRandom == 58) return "te_item_5021b";
        else if(nRandom == 59) return "te_item_5021bmw";
        else if(nRandom == 60) return "te_item_5021c";
        else if(nRandom == 61) return "te_item_5021cmw";
        else if(nRandom == 62) return "te_item_5021d";
        else if(nRandom == 63) return "te_item_5021dmw";
        else if(nRandom == 64) return "te_item_5021emw";
        else if(nRandom == 65) return "te_item_5021fmw";
        else if(nRandom == 66) return "te_item_5021gmw";
        else if(nRandom == 67) return "te_item_5021h";
        else if(nRandom == 68) return "te_item_5021hmw";
        else if(nRandom == 69) return "te_item_5021imw";
        else if(nRandom == 70) return "te_item_5021j";
        else if(nRandom == 71) return "te_item_5021jmw";
        else if(nRandom == 72) return "te_item_5021k";
        else if(nRandom == 73) return "te_item_5021kmw";
        else if(nRandom == 74) return "te_item_5021l";
        else if(nRandom == 75) return "te_item_5021lmw";
        else if(nRandom == 76) return "te_item_5021mmw";
        else if(nRandom == 77) return "te_item_5021nmw";
        else if(nRandom == 78) return "te_item_5022";
        else if(nRandom == 79) return "te_item_5023";
        else if(nRandom == 80) return "te_item_5026";
        else if(nRandom == 81) return "te_item_8326";
        else if(nRandom == 82) return "te_item_8327";
        else if(nRandom == 83) return "te_item_8515";
        else if(nRandom == 84) return "te_item_8516";
        else if(nRandom == 85) return "te_item_8517";
        else if(nRandom == 86) return "te_item_8568";
        else if(nRandom == 87) return "te_item_8569";
        else if(nRandom == 88) return "te_item_8570";
        else if(nRandom == 89) return "te_item_8581";
        else if(nRandom == 90) return "te_item_8658";
        else if(nRandom == 91) return "te_ridinggloves";
        else return "";
    }
    else if (nTable == 1)
    {
        nRandom = Random(43)+1;
        if(nRandom == 1) return "te_enchsmallshie";
        else if(nRandom == 2) return "te_item_01000";
        else if(nRandom == 3) return "te_item_01012";
        else if(nRandom == 4) return "te_item_01013";
        else if(nRandom == 5) return "te_item_01020";
        else if(nRandom == 6) return "te_item_1001";
        else if(nRandom == 7) return "te_item_1002";
        else if(nRandom == 8) return "te_item_1003";
        else if(nRandom == 9) return "te_item_1004";
        else if(nRandom == 10) return "te_item_1005";
        else if(nRandom == 11) return "te_item_1006";
        else if(nRandom == 12) return "te_item_1007";
        else if(nRandom == 13) return "te_item_1010";
        else if(nRandom == 14) return "te_item_1011";
        else if(nRandom == 15) return "te_item_1012";
        else if(nRandom == 16) return "te_item_2004";
        else if(nRandom == 17) return "te_item_2011";
        else if(nRandom == 18) return "te_item_2012";
        else if(nRandom == 19) return "te_item_2014";
        else if(nRandom == 20) return "te_item_3002";
        else if(nRandom == 21) return "te_item_3007";
        else if(nRandom == 22) return "te_item_5004";
        else if(nRandom == 23) return "te_item_5019";
        else if(nRandom == 24) return "te_item_5020";
        else if(nRandom == 25) return "te_item_6017";
        else if(nRandom == 26) return "te_item_6018";
        else if(nRandom == 27) return "te_item_6019";
        else if(nRandom == 28) return "te_item_8331";
        else if(nRandom == 29) return "te_item_8336";
        else if(nRandom == 30) return "te_item_8339";
        else if(nRandom == 31) return "te_item_8369";
        else if(nRandom == 32) return "te_item_8371";
        else if(nRandom == 33) return "te_item_8518";
        else if(nRandom == 34) return "te_item_8519";
        else if(nRandom == 35) return "te_item_8520";
        else if(nRandom == 36) return "te_item_8521";
        else if(nRandom == 37) return "te_item_8522";
        else if(nRandom == 38) return "te_item_8566";
        else if(nRandom == 39) return "te_item_8577";
        else if(nRandom == 40) return "te_item_8622";
        else if(nRandom == 41) return "te_item_9008";
        else if(nRandom == 42) return "te_item1008";
        else if(nRandom == 43) return "te_tag_2016";
        else return "";
    }
    else if (nTable == 2)
    {
        nRandom = Random(40)+1;
        if(nRandom == 1) return "te_item_01002";
        else if(nRandom == 2) return "te_item_01004";
        else if(nRandom == 3) return "te_item_01005";
        else if(nRandom == 4) return "te_item_01006";
        else if(nRandom == 5) return "te_item_01008";
        else if(nRandom == 6) return "te_item_01009";
        else if(nRandom == 7) return "te_item_01014";
        else if(nRandom == 8) return "te_item_01015";
        else if(nRandom == 9) return "te_item_01016";
        else if(nRandom == 10) return "te_item_01017";
        else if(nRandom == 11) return "te_item_01018";
        else if(nRandom == 12) return "te_item_01019";
        else if(nRandom == 13) return "te_item_01021";
        else if(nRandom == 14) return "te_item_01022";
        else if(nRandom == 15) return "te_item_1009";
        else if(nRandom == 16) return "te_item_2001";
        else if(nRandom == 17) return "te_item_2002";
        else if(nRandom == 18) return "te_item_2003";
        else if(nRandom == 19) return "te_item_2005";
        else if(nRandom == 20) return "te_item_2008";
        else if(nRandom == 21) return "te_item_2013";
        else if(nRandom == 22) return "te_item_2015";
        else if(nRandom == 23) return "te_item_2017";
        else if(nRandom == 24) return "te_item_3001";
        else if(nRandom == 25) return "te_item_3006";
        else if(nRandom == 26) return "te_item_7006";
        else if(nRandom == 27) return "te_item_7016";
        else if(nRandom == 28) return "te_item_8060";
        else if(nRandom == 29) return "te_item_8061";
        else if(nRandom == 30) return "te_item_8329";
        else if(nRandom == 31) return "te_item_8330";
        else if(nRandom == 32) return "te_item_8332";
        else if(nRandom == 33) return "te_item_8333";
        else if(nRandom == 34) return "te_item_8334";
        else if(nRandom == 35) return "te_item_8335";
        else if(nRandom == 36) return "te_item_8358";
        else if(nRandom == 37) return "te_item_8552";
        else if(nRandom == 38) return "te_item_8556";
        else if(nRandom == 39) return "te_item_8575";
        else if(nRandom == 40) return "te_item_8606";
        else if(nRandom == 41) return "te_item_9009";
        else return "";
    }
    else if (nTable == 3)
    {
        nRandom = Random(40)+1;
        if(nRandom == 1) return "ringofspellresis";
        else if(nRandom == 2) return "te_hammerow";
        else if(nRandom == 3) return "te_item_01003";
        else if(nRandom == 4) return "te_item_01007";
        else if(nRandom == 5) return "te_item_01010";
        else if(nRandom == 6) return "te_item_01011";
        else if(nRandom == 7) return "te_item_01034";
        else if(nRandom == 8) return "te_item_2006";
        else if(nRandom == 9) return "te_item_2007";
        else if(nRandom == 10) return "te_item_2009";
        else if(nRandom == 11) return "te_item_2010";
        else if(nRandom == 12) return "te_item_3003";
        else if(nRandom == 13) return "te_item_3004";
        else if(nRandom == 14) return "te_item_3005";
        else if(nRandom == 15) return "te_item_3008";
        else if(nRandom == 16) return "te_item_3009";
        else if(nRandom == 17) return "te_item_3010";
        else if(nRandom == 18) return "te_item_3011";
        else if(nRandom == 19) return "te_item_3014";
        else if(nRandom == 20) return "te_item_3015";
        else if(nRandom == 21) return "te_item_3016";
        else if(nRandom == 22) return "te_item_4001";
        else if(nRandom == 23) return "te_item_4002";
        else if(nRandom == 24) return "te_item_4003";
        else if(nRandom == 25) return "te_item_4004";
        else if(nRandom == 26) return "te_item_4005";
        else if(nRandom == 27) return "te_item_4006";
        else if(nRandom == 28) return "te_item_4008";
        else if(nRandom == 29) return "te_item_4009";
        else if(nRandom == 30) return "te_item_4010";
        else if(nRandom == 31) return "te_item_6002";
        else if(nRandom == 32) return "te_item_6016";
        else if(nRandom == 33) return "te_item_6020";
        else if(nRandom == 34) return "te_item_7001";
        else if(nRandom == 35) return "te_item_7007";
        else if(nRandom == 36) return "te_item_8359";
        else if(nRandom == 37) return "te_item_8360";
        else if(nRandom == 38) return "te_item_8367";
        else if(nRandom == 39) return "te_item_8368";
        else if(nRandom == 40) return "te_item_8662";
        else return "";
    }
    else if(nTable == 4)
    {
        nRandom = Random(53)+1;
        if(nRandom == 1) return "crpi_o_agate";
        else if(nRandom == 2) return "crpi_f_alexandri";
        else if(nRandom == 3) return "crpi_f_amber";
        else if(nRandom == 4) return "crpi_f_amethyst";
        else if(nRandom == 5) return "crpi_p_aquamarin";
        else if(nRandom == 6) return "crpi_o_azurite";
        else if(nRandom == 7) return "it_comp_blackon";
        else if(nRandom == 8) return "it_comp_blkonx10";
        else if(nRandom == 9) return "it_comp_blkonx15";
        else if(nRandom == 10) return "crpi_g_blackopal";
        else if(nRandom == 11) return "crpi_p_blackperl";
        else if(nRandom == 12) return "crpi_g_blacksaph";
        else if(nRandom == 13) return "crpi_s_bloodston";
        else if(nRandom == 14) return "crpi_s_carnelian";
        else if(nRandom == 15) return "crpi_s_chalcedon";
        else if(nRandom == 16) return "crpi_f_chrysober";
        else if(nRandom == 17) return "crpi_s_chrysopra";
        else if(nRandom == 18) return "crpi_s_citrine";
        else if(nRandom == 19) return "crpi_f_coral";
        else if(nRandom == 20) return "it_comp_gemcut";
        else if(nRandom == 21) return "it_comp_gemench";
        else if(nRandom == 22) return "crpi_g_diamond";
        else if(nRandom == 23) return "crpi_g_emerald";
        else if(nRandom == 24) return "it_comp_gemfine";
        else if(nRandom == 25) return "crpi_g_fireopal";
        else if(nRandom == 26) return "crpi_p_garnet";
        else if(nRandom == 27) return "crpi_o_hematite";
        else if(nRandom == 28) return "crpi_f_jade";
        else if(nRandom == 29) return "crpi_s_jasper";
        else if(nRandom == 30) return "crpi_f_jet";
        else if(nRandom == 31) return "crpi_o_lapislazu";
        else if(nRandom == 32) return "crpi_o_malachite";
        else if(nRandom == 33) return "crpi_s_moonstone";
        else if(nRandom == 34) return "crpi_o_obsidian";
        else if(nRandom == 35) return "crpi_s_onyx";
        else if(nRandom == 36) return "crpi_g_opal";
        else if(nRandom == 37) return "crpi_f_pearl";
        else if(nRandom == 38) return "crpi_p_peridot";
        else if(nRandom == 39) return "crpi_o_quartz";
        else if(nRandom == 40) return "crpi_o_rhodochro";
        else if(nRandom == 41) return "crpi_s_rockcryst";
        else if(nRandom == 42) return "crpi_g_ruby";
        else if(nRandom == 43) return "crpi_g_sapphire";
        else if(nRandom == 44) return "crpi_s_sardonyx";
        else if(nRandom == 45) return "crpi_p_spinel";
        else if(nRandom == 46) return "crpi_s_starrose";
        else if(nRandom == 47) return "crpi_g_starruby";
        else if(nRandom == 48) return "crpi_g_starsapph";
        else if(nRandom == 49) return "crpi_o_tigereye";
        else if(nRandom == 50) return "crpi_p_topaz";
        else if(nRandom == 51) return "crpi_f_tourmalin";
        else if(nRandom == 52) return "crpi_o_turquoise";
        else if(nRandom == 53) return "crpi_s_zircon";
        else return "";
    }
    else if(nTable == 5)
    {
        nRandom = Random(28)+1;
        if(nRandom == 1) return "te_item_0018";
        else if(nRandom == 2) return "te_item_8211";
        else if(nRandom == 3) return "te_item_8212";
        else if(nRandom == 4) return "te_item_8213";
        else if(nRandom == 5) return "te_item_8214";
        else if(nRandom == 6) return "te_item_8215";
        else if(nRandom == 7) return "te_item_8216";
        else if(nRandom == 8) return "te_item_0013";
        else if(nRandom == 9) return "te_item_0014";
        else if(nRandom == 10) return "te_item_0005";
        else if(nRandom == 11) return "te_item_8727";
        else if(nRandom == 12) return "te_item_8728";
        else if(nRandom == 13) return "te_item_8729";
        else if(nRandom == 14) return "te_item_8730";
        else if(nRandom == 15) return "te_item_8731";
        else if(nRandom == 16) return "te_item_8732";
        else if(nRandom == 17) return "te_item_8733";
        else if(nRandom == 18) return "te_item_8734";
        else if(nRandom == 19) return "te_item_8735";
        else if(nRandom == 20) return "te_item_8736";
        else if(nRandom == 21) return "te_item_8737";
        else if(nRandom == 22) return "te_item_8738";
        else if(nRandom == 23) return "te_item_8739";
        else if(nRandom == 24) return "te_item_8740";
        else if(nRandom == 25) return "te_item_8741";
        else if(nRandom == 26) return "te_item_8742";
        else if(nRandom == 27) return "te_item_8743";
        else if(nRandom == 28) return "te_item_8744";
        else if(nRandom == 29) return "te_item_8745";
        else return "";
    }
    else return "";
}

void MakePlagueItem(object oCaster)
{
    int nItemCat = Random(15)+1;
    string sResRef;
    object oEndItem = OBJECT_INVALID;


    if(nItemCat == 1) //Ring
    {
        sResRef = "te_basic048";
    }
    else if(nItemCat == 2)//Boots
    {
        sResRef = "te_basic046";
    }
    else if(nItemCat == 3)//Belt
    {
        sResRef = "te_basic045";
    }
    else if(nItemCat == 4)//Helmet
    {
        sResRef = "te_basic043";
    }
    else if(nItemCat == 5)//Bracer
    {
        sResRef = "te_basic044";
    }
    else if(nItemCat == 6)//Amulet
    {
        sResRef = "te_basic047";
    }
    else if(nItemCat == 7)//Cloak
    {
        sResRef = "te_basic049";
    }
    else if(nItemCat == 8)//Light Armor
    {
         nItemCat = Random(4)+1;
        if(nItemCat == 1) //Chain Shirt
        {
            sResRef = "nw_aarcl012";
        }
        else if(nItemCat == 2) //Leather Armor
        {
            sResRef = "nw_aarcl001";
        }
        else if(nItemCat == 3) //Padded Armor
        {
            sResRef = "nw_aarcl009";
        }
        else if(nItemCat == 4) //Studded Leather Armor
        {
            sResRef = "nw_aarcl002";
        }
    }
    else if(nItemCat == 9)//Medium Armor
    {
        nItemCat = Random(4)+1;
        if(nItemCat == 1) //Breastplate
        {
            sResRef = "nw_aarcl010";
        }
        else if(nItemCat == 2) //Chainmail
        {
            sResRef = "nw_aarcl004";
        }
        else if(nItemCat == 3) //Hide Armor
        {
            sResRef = "nw_aarcl008";
        }
        else if(nItemCat == 4) //Scale Mail
        {
            sResRef = "nw_aarcl003";
        }
    }
    else if(nItemCat == 10)//Heavy Armor
    {
        nItemCat = Random(4)+1;
        if(nItemCat == 1) //Banded
        {
            sResRef = "nw_aarcl011";
        }
        else if(nItemCat == 2) //Full Plate
        {
            sResRef = "nw_aarcl007";
        }
        else if(nItemCat == 3) //Half Plate
        {
            sResRef = "nw_aarcl006";
        }
        else if(nItemCat == 4) //Splint Mail
        {
            sResRef = "nw_aarcl005";
        }
    }
    else if(nItemCat == 11)//Shield
    {
        nItemCat = Random(3)+1;
        if(nItemCat == 1) //Tower
        {
            sResRef = "nw_ashto001";
        }
        else if(nItemCat == 2) //Large
        {
            sResRef = "nw_ashlw001";
        }
        else if(nItemCat == 3) //Small
        {
            sResRef = "nw_ashsw001";
        }
    }
    else if(nItemCat == 12)//Exotic Weapon
    {
        nItemCat = Random(10)+1;
        if(nItemCat == 1) // Kama
        {
            sResRef = "nw_wspka001";
        }
        else if(nItemCat == 2) // Fan
        {
            sResRef = "te_basic039";
        }
        else if(nItemCat == 3) //Kukri
        {
            sResRef = "nw_wspku001";
        }
        else if(nItemCat == 4) //Whip
        {
            sResRef = "x2_it_wpwhip";
        }
        else if(nItemCat == 5) //Dwarven Waraxe
        {
            sResRef = "te_basic038";
        }
        else if(nItemCat == 6) //Scythe
        {
            sResRef = "nw_wplsc001";
        }
        else if(nItemCat == 7) //Bastard Sword
        {
            sResRef = "nw_wswbs001";
        }
        else if(nItemCat == 8) //Dire Mace
        {
            sResRef = "nw_wdbma001";
        }
        else if(nItemCat == 9) //Double Axe
        {
            sResRef = "nw_wdbax001";
        }
        else if(nItemCat == 10) //Double Sword/Two Bladed Sword
        {
            sResRef = "nw_wdbsw001";
        }
    }
    else if(nItemCat == 13)//Martial Weapon
    {
        nItemCat = Random(13)+1;
        if(nItemCat == 1) //BattleAxe
        {
            sResRef = "nw_waxbt001";
        }
        else if(nItemCat == 2) //Greataxe
        {
            sResRef = "nw_waxgr001";
        }
        else if(nItemCat == 3) //GreatSword
        {
            sResRef = "nw_wswgs001";
        }
        else if(nItemCat == 4) //Halberd
        {
            sResRef = "te_basic040";
        }
        else if(nItemCat == 5) //Handaxe
        {
            sResRef = "nw_waxhn001";
        }
        else if(nItemCat == 6) //Heavy Flail
        {
            sResRef = "nw_wblfh001";
        }
        else if(nItemCat == 7) //Light Flail
        {
            sResRef = "nw_wblfl001";
        }
        else if(nItemCat == 8) //Light Hammer
        {
            sResRef = "nw_wbhl001";
        }
        else if(nItemCat == 9) //Longsword
        {
            sResRef = "nw_wswls001";
        }
        else if(nItemCat == 10) //Rapier
        {
            sResRef = "nw_wswrp001";
        }
        else if(nItemCat == 11) //Scimitar
        {
            sResRef = "nw_wswsc001";
        }
        else if(nItemCat == 12) //Shortsword
        {
            sResRef = "nw_wswss001";
        }
        else if(nItemCat == 13) //Warhammer
        {
            sResRef = "nw_wblhw005";
        }
    }
    else if(nItemCat == 14)//Simple Weapon
    {
        nItemCat = Random(7)+1;
        if(nItemCat == 1) // Club
        {
            sResRef = "nw_wblcl001";
        }
        else if(nItemCat == 2) //Dagger
        {
            sResRef = "nw_wswdg001";
        }
        else if(nItemCat == 3) //Mace
        {
            sResRef = "nw_wblml001";
        }
        else if(nItemCat == 4) //Sickle
        {
            sResRef = "nw_wspsc001";
        }
        else if(nItemCat == 5) //Spear
        {
            sResRef = "nw_wplss001";
        }
        else if(nItemCat == 6) //Morningstar
        {
            sResRef = "nw_wblms001";
        }
        else if(nItemCat == 7) //Quarterstaff
        {
            sResRef = "nw_wdbqs001";
        }
    }
    else if(nItemCat == 15)//Ranged Weapon
    {
        nItemCat = Random(8)+1;
        if(nItemCat == 1) // Longbow
        {
            sResRef = "nw_wbwln001";
        }
        else if(nItemCat == 2) //Shortbow
        {
            sResRef = "nw_wbwsh001";
        }
        else if(nItemCat == 3) //Sling
        {
            sResRef = "nw_wbwsl001";
        }
        else if(nItemCat == 4) //Throwing Axe
        {
            sResRef = "nw_wthax001";
        }
        else if(nItemCat == 5) //Dart
        {
            sResRef = "nw_wthdt001";
        }
        else if(nItemCat == 6) //Crossbow, Light
        {
            sResRef = "nw_wbwxl001";
        }
        else if(nItemCat == 7) //Crossbow, Heavy
        {
            sResRef = "nw_wbwxh001";
        }
        else if(nItemCat == 8) //Shuriken
        {
            sResRef = "nw_wthsh001";
        }
    }




    return;
}
