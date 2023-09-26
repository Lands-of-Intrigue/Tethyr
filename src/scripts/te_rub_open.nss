#include "nwnx_time"
#include "nwnx_creature"
#include "loi_mythicxp"

void DoRubbleLoot(object oPC);
void DoShanatarLoot(object oPC);
void DoBodyLoot(object oPC,int nType);
void DoDragonLoot(object oPC);
void DoScrollLoot(object oPC);
void DoIntMythic(object oPC);

void main()
{
    object oPC = GetLastUsedBy();
    object oTarget = oPC;
    int nMinutes = 60;
    int nType = GetLocalInt(OBJECT_SELF,"LootType");
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");
    int nDust = GetLocalInt(oItem,"nDust");
    int nBlood = GetLocalInt(oItem,"nBlood");
    int nLastUsed = NWNX_Time_GetTimeStamp();
    //32 Character Limit
    int nNextLoot = NWNX_Time_GetTimeStamp() + (nMinutes*60);

    string sPCStamp = GetPCPublicCDKey(oPC);

    if(GetLocalInt(OBJECT_SELF,sPCStamp) > nLastUsed)
    {
        SendMessageToPC(oPC,"You have searched for treasure too recently in this location.");
    }
    else
    {
        if(GetIsInCombat(oPC) == TRUE)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneImmobilize(),oPC,6.0f);
            AssignCommand(oPC, PlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 6.0));
            SendMessageToPC(oPC,"You automatically fail to find loot when trying to search in the middle of battle.");
            SetLocalInt(OBJECT_SELF,sPCStamp,nNextLoot);
            return;
        }
        else
        {
            SendMessageToPC(oPC,"You begin searching for treasure...");
            SetLocalInt(OBJECT_SELF,sPCStamp,nNextLoot);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneImmobilize(),oPC,6.0f);
            AssignCommand(oPC, PlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 6.0));
            if(nType == 0)
            {
                SetLocalInt(oItem,"nDust",nDust+5);
                if(nDust >= 100){SetLocalInt(oItem,"nDust",100);}
                if(nDust <= 0){SetLocalInt(oItem,"nDust",0);}
                DelayCommand(6.0f,DoRubbleLoot(oPC));
            }
            else if(nType == 1)
            {
                SetLocalInt(oItem,"nDust",nDust+5);
                if(nDust >= 100){SetLocalInt(oItem,"nDust",100);}
                if(nDust <= 0){SetLocalInt(oItem,"nDust",0);}
                DelayCommand(6.0f,DoShanatarLoot(oPC));
            }
            else if(nType == 2)
            {
                SetLocalInt(oItem,"nBlood",nBlood+5);
                if(nBlood >= 100){SetLocalInt(oItem,"nBlood",100);}
                if(nBlood <= 0){SetLocalInt(oItem,"nBlood",0);}
                DelayCommand(6.0f,DoBodyLoot(oPC,nType));
            }
            else if(nType == 3)
            {
                SetLocalInt(oItem,"nDust",nDust+5);
                if(nDust >= 100){SetLocalInt(oItem,"nDust",100);}
                if(nDust <= 0){SetLocalInt(oItem,"nDust",0);}
                DelayCommand(6.0f,DoDragonLoot(oPC));
            }
            else if(nType == 4)
            {
                SetLocalInt(oItem,"nDust",nDust+5);
                if(nDust >= 100){SetLocalInt(oItem,"nDust",100);}
                if(nDust <= 0){SetLocalInt(oItem,"nDust",0);}
                DelayCommand(6.0f,DoScrollLoot(oPC));
            }
        }
    }
}

void DoScrollLoot(object oPC)
{
    int nD20 = d20(1);
    int nSkill = GetSkillRank(SKILL_SEARCH,oPC,FALSE);
    int nRoll = nD20+nSkill;
    object oItem;
    object oArtifact;
    object oMagic;

    int nHistThreshold = 20;
    int nScrollThreshold = 25;
    int nTomeThreshold = 25;

    //History
    if(GetHasFeat(1426,oPC) == TRUE)                   {nHistThreshold = nHistThreshold-5;}

    //Decipher Script
    if(GetHasFeat(1428,oPC) == TRUE)                   {nTomeThreshold = nTomeThreshold-5;}

    //Spellcraft
    if(GetSkillRank(SKILL_SPELLCRAFT,oPC,FALSE) >= 10) {nScrollThreshold = nScrollThreshold-5;}


    if(nD20 == 1 || (nHistThreshold > nRoll && nTomeThreshold >nRoll && nScrollThreshold >nRoll ))
    {
         SendMessageToPC(oPC,"You find nothing...");
         //Critical Failure.
         //You find nothing.
         if(nD20 ==1)
         {
            int nMonster = d6(1);
            if(nMonster == 1) {CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2130",GetLocation(oPC),TRUE);}
            if(nMonster == 2) {CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2130a",GetLocation(oPC),TRUE);}
            if(nMonster == 3) {CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2130b",GetLocation(oPC),TRUE);}
            if(nMonster == 4) {CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2130c",GetLocation(oPC),TRUE);}
            if(nMonster == 5) {CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2130d",GetLocation(oPC),TRUE);}
            if(nMonster == 6) {CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2130e",GetLocation(oPC),TRUE);}
         }
    }
    else
    {
        DoIntMythic(oPC);
        if(nRoll >= nHistThreshold)
        {
            int nHistRoll = d10(1);
            if(nHistRoll == 1)         {CreateItemOnObject("te_item_0018",oPC,1);}
            else if(nHistRoll == 2)    {CreateItemOnObject("te_item_8211",oPC,1);}
            else if(nHistRoll == 3)    {CreateItemOnObject("te_item_8212",oPC,1);}
            else if(nHistRoll == 4)    {CreateItemOnObject("te_item_8213",oPC,1);}
            else if(nHistRoll == 5)    {CreateItemOnObject("te_item_8214",oPC,1);}
            else if(nHistRoll == 6)    {CreateItemOnObject("te_item_8215",oPC,1);}
            else if(nHistRoll == 7)    {CreateItemOnObject("te_item_8216",oPC,1);}
            else if(nHistRoll == 8)    {CreateItemOnObject("te_item_0013",oPC,1);}
            else if(nHistRoll == 9)    {CreateItemOnObject("te_item_0014",oPC,1);}
            else if(nHistRoll == 10)   {CreateItemOnObject("te_item_0005",oPC,1);}
        }

        if(nRoll >= nScrollThreshold)
        {
            int nScrollRoll = Random(49)+1;
            if(nScrollRoll == 1)         {CreateItemOnObject("nw_it_sparscr101",oPC,1);}
            else if(nScrollRoll == 2)    {CreateItemOnObject("nw_it_sparscr102",oPC,1);}
            else if(nScrollRoll == 3)    {CreateItemOnObject("x1_it_sparscr103",oPC,1);}
            else if(nScrollRoll == 4)    {CreateItemOnObject("nw_it_sparscr218",oPC,1);}
            else if(nScrollRoll == 5)    {CreateItemOnObject("nw_it_sparscr201",oPC,1);}
            else if(nScrollRoll == 6)    {CreateItemOnObject("nw_it_sparscr103",oPC,1);}
            else if(nScrollRoll == 7)    {CreateItemOnObject("nw_it_sparscr104",oPC,1);}
            else if(nScrollRoll == 8)    {CreateItemOnObject("nw_it_sparscr105",oPC,1);}
            else if(nScrollRoll == 9)    {CreateItemOnObject("nw_it_sparscr203",oPC,1);}
            else if(nScrollRoll == 10)   {CreateItemOnObject("nw_it_sparscr304",oPC,1);}
            else if(nScrollRoll == 11)   {CreateItemOnObject("nw_it_sparscr106",oPC,1);}
            else if(nScrollRoll == 12)   {CreateItemOnObject("nw_it_sparscr205",oPC,1);}
            else if(nScrollRoll == 13)   {CreateItemOnObject("nw_it_sparscr307",oPC,1);}
            else if(nScrollRoll == 14)   {CreateItemOnObject("nw_it_sparscr107",oPC,1);}
            else if(nScrollRoll == 15)   {CreateItemOnObject("nw_it_sparscr108",oPC,1);}
            else if(nScrollRoll == 16)   {CreateItemOnObject("nw_it_sparscr211",oPC,1);}
            else if(nScrollRoll == 17)   {CreateItemOnObject("nw_it_sparscr308",oPC,1);}
            else if(nScrollRoll == 18)   {CreateItemOnObject("nw_it_sparscr406",oPC,1);}
            else if(nScrollRoll == 19)   {CreateItemOnObject("x2_it_sparscr104",oPC,1);}
            else if(nScrollRoll == 20)   {CreateItemOnObject("nw_it_sparscr109",oPC,1);}
            else if(nScrollRoll == 21)   {CreateItemOnObject("x2_it_sparscr201",oPC,1);}
            else if(nScrollRoll == 22)   {CreateItemOnObject("x2_it_sparscr205",oPC,1);}
            else if(nScrollRoll == 23)   {CreateItemOnObject("nw_it_sparscr309",oPC,1);}
            else if(nScrollRoll == 24)   {CreateItemOnObject("x1_it_sparscr303",oPC,1);}
            else if(nScrollRoll == 25)   {CreateItemOnObject("nw_it_sparscr310",oPC,1);}
            else if(nScrollRoll == 26)   {CreateItemOnObject("x2_it_sparscr302",oPC,1);}
            else if(nScrollRoll == 27)   {CreateItemOnObject("x2_it_sparscr401",oPC,1);}
            else if(nScrollRoll == 28)   {CreateItemOnObject("nw_it_sparscr407",oPC,1);}
            else if(nScrollRoll == 29)   {CreateItemOnObject("nw_it_sparscr110",oPC,1);}
            else if(nScrollRoll == 30)   {CreateItemOnObject("nw_it_sparscr207",oPC,1);}
            else if(nScrollRoll == 31)   {CreateItemOnObject("x1_it_sparscr301",oPC,1);}
            else if(nScrollRoll == 32)   {CreateItemOnObject("nw_it_sparscr314",oPC,1);}
            else if(nScrollRoll == 33)   {CreateItemOnObject("nw_it_sparscr408",oPC,1);}
            else if(nScrollRoll == 34)   {CreateItemOnObject("nw_it_sparscr113",oPC,1);}
            else if(nScrollRoll == 35)   {CreateItemOnObject("nw_it_sparscr111",oPC,1);}
            else if(nScrollRoll == 36)   {CreateItemOnObject("x2_it_sparscr202",oPC,1);}
            else if(nScrollRoll == 37)   {CreateItemOnObject("nw_it_sparscr315",oPC,1);}
            else if(nScrollRoll == 38)   {CreateItemOnObject("nw_it_sparscr311",oPC,1);}
            else if(nScrollRoll == 39)   {CreateItemOnObject("nw_it_sparscr412",oPC,1);}
            else if(nScrollRoll == 40)   {CreateItemOnObject("nw_it_sparscr413",oPC,1);}
            else if(nScrollRoll == 41)   {CreateItemOnObject("nw_it_sparscr112",oPC,1);}
            else if(nScrollRoll == 42)   {CreateItemOnObject("x1_it_sparscr101",oPC,1);}
            else if(nScrollRoll == 43)   {CreateItemOnObject("nw_it_sparscr212",oPC,1);}
            else if(nScrollRoll == 44)   {CreateItemOnObject("x2_it_sparscr207",oPC,1);}
            else if(nScrollRoll == 45)   {CreateItemOnObject("nw_it_sparscr219",oPC,1);}
            else if(nScrollRoll == 46)   {CreateItemOnObject("nw_it_sparscr215",oPC,1);}
            else if(nScrollRoll == 47)   {CreateItemOnObject("nw_it_sparscr220",oPC,1);}
            else if(nScrollRoll == 48)   {CreateItemOnObject("nw_it_sparscr216",oPC,1);}
            else if(nScrollRoll == 49)   {CreateItemOnObject("nw_it_sparscr221",oPC,1);}
        }

        if(nRoll >= nTomeThreshold)
        {
            int nTomeRoll = d8(1);
            if(nTomeRoll == 1)         {CreateItemOnObject("mal_sm_abju1",oPC,1);}
            else if(nTomeRoll == 2)    {CreateItemOnObject("mal_sm_conj1",oPC,1);}
            else if(nTomeRoll == 3)    {CreateItemOnObject("mal_sm_divi2",oPC,1);}
            else if(nTomeRoll == 4)    {CreateItemOnObject("mal_sm_ench1",oPC,1);}
            else if(nTomeRoll == 5)    {CreateItemOnObject("mal_sm_evoc1",oPC,1);}
            else if(nTomeRoll == 6)    {CreateItemOnObject("mal_sm_illus1",oPC,1);}
            else if(nTomeRoll == 7)    {CreateItemOnObject("mal_sm_necro1",oPC,1);}
            else if(nTomeRoll == 8)    {CreateItemOnObject("mal_sm_transm1",oPC,1);}
        }
    }
}

void DoBodyLoot(object oPC, int nType)
{
    int nD20 = d20(1);
    int nSkill = GetSkillRank(SKILL_SEARCH,oPC,FALSE);
    int nRoll = nD20+nSkill;
    int nSlot = d10(1);

    int nGoldThreshold = 15;
    int nItemThreshold = 20;

    if(nD20 == 1 || (nGoldThreshold > nRoll && nItemThreshold >nRoll))
    {
         //Critical Failure.
         //You find nothing.
         SendMessageToPC(oPC,"You find nothing...");
         return;
    }
    else
    {
        DoIntMythic(oPC);
        //Dead Adventurer
        if(nType == 2)
        {
            if(nGoldThreshold <= nRoll)
            {
                GiveGoldToCreature(oPC,d12(5));
            }

            if(nItemThreshold <= nRoll)
            {
                //Ammo
                if(nSlot == 1)      {}

                //Gloves/Bracers
                else if(nSlot == 2) {}

                //Belt
                else if(nSlot == 3) {}

                //Boots
                else if(nSlot == 4) {}

                //Armor
                else if(nSlot == 5) {}

                //Shield
                else if(nSlot == 6) {}

                //Ring
                else if(nSlot == 7) {}

                //Necklace
                else if(nSlot == 8) {}

                //Cloak
                else if(nSlot == 9) {}

                //Weapon
                else if(nSlot == 10){}
            }
        }
    }
}

void DoShanatarLoot(object oPC)
{
    int nD20 = d20(1);
    int nSkill = GetSkillRank(SKILL_SEARCH,oPC,FALSE);
    int nRoll = nD20+nSkill;
    object oItem;
    object oArtifact;
    object oMagic;

    int nGoldThreshold = 25;
    int nItemThreshold = 30;
    int nMagiThreshold = 35;

    //Survival
    if(GetHasFeat(1430,oPC) == TRUE)                   {nGoldThreshold = nGoldThreshold-2;}
    //Masonry
    if(GetHasFeat(1435,oPC) == TRUE)                   {nItemThreshold = nItemThreshold-2;}
    //Mining
    if(GetHasFeat(1436,oPC) == TRUE)                   {nItemThreshold = nItemThreshold-2;}

    if(GetSkillRank(SKILL_SPELLCRAFT,oPC,FALSE) >= 10) {nMagiThreshold = 30;}

    if(nD20 == 1 || (nGoldThreshold > nRoll && nItemThreshold >nRoll && nMagiThreshold >nRoll ))
    {
         //Critical Failure.
         //You find nothing.
         SendMessageToPC(oPC,"You find nothing...");
    }
    else
    {
        DoIntMythic(oPC);
        if(nD20 == 20)
        {
            if(Random(10) == 10)
            {
                int nD3 = d3(1);
                if(nD3 == 1) {oArtifact = CreateItemOnObject("te_item_8495",oPC,1);}
                else if(nD3 == 2) {oArtifact = CreateItemOnObject("te_hammerow",oPC,1);}
                else if(nD3 == 3) {oArtifact = CreateItemOnObject("te_item_01005",oPC,1);}
                if(GetIsObjectValid(oArtifact) == TRUE){SetIdentified(oArtifact, FALSE);}
            }
        }

        if(nRoll >= nGoldThreshold)
        {
            GiveGoldToCreature(oPC,d12(5));
        }

        if(nRoll >= nItemThreshold)
        {
            int nItemRoll = Random(27)+1;
            if (nItemRoll == 1){oItem = CreateItemOnObject("te_item_5002",oPC,1);}
            else if (nItemRoll == 2) {oItem = CreateItemOnObject("te_item_5005",oPC,1);}
            else if (nItemRoll == 3) {oItem = CreateItemOnObject("te_item_5006",oPC,1);}
            else if (nItemRoll == 4) {oItem = CreateItemOnObject("te_item_5009",oPC,1);}
            else if (nItemRoll == 5) {oItem = CreateItemOnObject("te_item_5010",oPC,1);}
            else if (nItemRoll == 6) {oItem = CreateItemOnObject("te_item_5012",oPC,1);}
            else if (nItemRoll == 7) {oItem = CreateItemOnObject("te_item_5013",oPC,1);}
            else if (nItemRoll == 8) {oItem = CreateItemOnObject("te_item_5017",oPC,1);}
            else if (nItemRoll == 9) {oItem = CreateItemOnObject("te_item_5018",oPC,1);}
            else if (nItemRoll == 10) {oItem = CreateItemOnObject("te_item_8569",oPC,1);}
            else if (nItemRoll == 11) {oItem = CreateItemOnObject("te_item_8570",oPC,1);}
            else if (nItemRoll == 12) {oItem = CreateItemOnObject("te_item_0006",oPC,1);}
            else if (nItemRoll == 13) {oItem = CreateItemOnObject("te_item_0008",oPC,1);}
            else if (nItemRoll == 14) {oItem = CreateItemOnObject("te_item_2002",oPC,1);}
            else if (nItemRoll == 15) {oItem = CreateItemOnObject("te_item_2003",oPC,1);}
            else if (nItemRoll == 16) {oItem = CreateItemOnObject("te_item_2007",oPC,1);}
            else if (nItemRoll == 17) {oItem = CreateItemOnObject("te_item_2008",oPC,1);}
            else if (nItemRoll == 18) {oItem = CreateItemOnObject("te_item_2009",oPC,1);}
            else if (nItemRoll == 19) {oItem = CreateItemOnObject("te_item_3003",oPC,1);}
            else if (nItemRoll == 20) {oItem = CreateItemOnObject("te_item_3004",oPC,1);}
            else if (nItemRoll == 21) {oItem = CreateItemOnObject("te_item_3005",oPC,1);}
            else if (nItemRoll == 22) {oItem = CreateItemOnObject("te_item_3006",oPC,1);}
            else if (nItemRoll == 23) {oItem = CreateItemOnObject("te_item_3008",oPC,1);}
            else if (nItemRoll == 24) {oItem = CreateItemOnObject("te_item_3016",oPC,1);}
            else if (nItemRoll == 25) {oItem = CreateItemOnObject("te_item_4003",oPC,1);}
            else if (nItemRoll == 26) {oItem = CreateItemOnObject("te_item_7006",oPC,1);}
            else if (nItemRoll == 27) {oItem = CreateItemOnObject("te_item_7007",oPC,1);}

            if(GetIsObjectValid(oItem) == TRUE) {SetIdentified(oItem, FALSE);}
        }
        if(nRoll >= nMagiThreshold)
        {
            int nMagicRoll = Random(30)+1;
            if (nMagicRoll == 1) {oMagic = CreateItemOnObject("x2_it_spdvscr201",oPC,1);}
            else if (nMagicRoll == 2) {oMagic = CreateItemOnObject("x2_it_spdvscr103",oPC,1);}
            else if (nMagicRoll == 3) {oMagic = CreateItemOnObject("nw_it_sparscr212",oPC,1);}
            else if (nMagicRoll == 4) {oMagic = CreateItemOnObject("nw_it_sparscr213",oPC,1);}
            else if (nMagicRoll == 5) {oMagic = CreateItemOnObject("x2_it_spdvscr104",oPC,1);}
            else if (nMagicRoll == 6) {oMagic = CreateItemOnObject("x2_it_spdvscr203",oPC,1);}
            else if (nMagicRoll == 7) {oMagic = CreateItemOnObject("x2_it_spdvscr305",oPC,1);}
            else if (nMagicRoll == 8) {oMagic = CreateItemOnObject("x1_it_spdvscr102",oPC,1);}
            else if (nMagicRoll == 9) {oMagic = CreateItemOnObject("x1_it_spdvscr103",oPC,1);}
            else if (nMagicRoll == 10) {oMagic = CreateItemOnObject("x2_it_spdvscr304",oPC,1);}
            else if (nMagicRoll == 11) {oMagic = CreateItemOnObject("x2_it_sparscr305",oPC,1);}
            else if (nMagicRoll == 12) {oMagic = CreateItemOnObject("x2_it_spdvscr312",oPC,1);}
            else if (nMagicRoll == 13) {oMagic = CreateItemOnObject("x1_it_spdvscr105",oPC,1);}
            else if (nMagicRoll == 14) {oMagic = CreateItemOnObject("it_comp_colsand",oPC,1);}
            else if (nMagicRoll == 15) {oMagic = CreateItemOnObject("it_comp_crbead",oPC,1);}
            else if (nMagicRoll == 16) {oMagic = CreateItemOnObject("it_comp_dust",oPC,1);}
            else if (nMagicRoll == 17) {oMagic = CreateItemOnObject("it_comp_earth",oPC,1);}
            else if (nMagicRoll == 18) {oMagic = CreateItemOnObject("it_comp_granite",oPC,1);}
            else if (nMagicRoll == 19) {oMagic = CreateItemOnObject("it_comp_holyparc",oPC,1);}
            else if (nMagicRoll == 20) {oMagic = CreateItemOnObject("it_comp_holyrel",oPC,1);}
            else if (nMagicRoll == 21) {oMagic = CreateItemOnObject("it_comp_incense",oPC,1);}
            else if (nMagicRoll == 22) {oMagic = CreateItemOnObject("it_comp_lumpcoal",oPC,1);}
            else if (nMagicRoll == 23) {oMagic = CreateItemOnObject("it_comp_metalbar",oPC,1);}
            else if (nMagicRoll == 24) {oMagic = CreateItemOnObject("it_comp_minsphe",oPC,1);}
            else if (nMagicRoll == 25) {oMagic = CreateItemOnObject("it_comp_oilyfli",oPC,1);}
            else if (nMagicRoll == 26) {oMagic = CreateItemOnObject("it_comp_phospho",oPC,1);}
            else if (nMagicRoll == 27) {oMagic = CreateItemOnObject("it_comp_pwdcrys",oPC,1);}
            else if (nMagicRoll == 28) {oMagic = CreateItemOnObject("it_comp_pwdsilv",oPC,1);}
            else if (nMagicRoll == 29) {oMagic = CreateItemOnObject("it_comp_sulfur",oPC,1);}
            else if (nMagicRoll == 30) {oMagic = CreateItemOnObject("it_comp_slvrholy",oPC,1);}

            if(GetIsObjectValid(oMagic) == TRUE){SetIdentified(oMagic, FALSE);}
        }
    }
}

void DoRubbleLoot(object oPC)
{
    int nD20 = d20(1);
    int nSkill = GetSkillRank(SKILL_SEARCH,oPC,FALSE);
    int nRoll = nD20+nSkill;

    int nGoldThreshold = 15;
    int nHistThreshold = 20;
    int nMagiThreshold = 25;

    if(GetHasFeat(1430,oPC) == TRUE)                   {nGoldThreshold = 13;}
    if(GetHasFeat(1426,oPC) == TRUE)                   {nHistThreshold = 16;}
    if(GetSkillRank(SKILL_SPELLCRAFT,oPC,FALSE) >= 10) {nMagiThreshold = 20;}

    SendMessageToPC(oPC,"Search Roll: "+IntToString(nD20)+" + Modifier: "+IntToString(nSkill));

    if(nD20 == 1 || (nGoldThreshold > nRoll && nHistThreshold >nRoll && nMagiThreshold >nRoll ))
    {
         SendMessageToPC(oPC,"You find nothing...");
         //Critical Failure.
         //You find nothing.
    }
    else
    {
        DoIntMythic(oPC);
        if(nRoll >= nGoldThreshold)
        {
            GiveGoldToCreature(oPC,d10(2));
        }

        if(nRoll >= nHistThreshold)
        {
            int nHistRoll = d10(1);
            if(nHistRoll == 1)         {CreateItemOnObject("te_item_0018",oPC,1);}
            else if(nHistRoll == 2)    {CreateItemOnObject("te_item_8211",oPC,1);}
            else if(nHistRoll == 3)    {CreateItemOnObject("te_item_8212",oPC,1);}
            else if(nHistRoll == 4)    {CreateItemOnObject("te_item_8213",oPC,1);}
            else if(nHistRoll == 5)    {CreateItemOnObject("te_item_8214",oPC,1);}
            else if(nHistRoll == 6)    {CreateItemOnObject("te_item_8215",oPC,1);}
            else if(nHistRoll == 7)    {CreateItemOnObject("te_item_8216",oPC,1);}
            else if(nHistRoll == 8)    {CreateItemOnObject("te_item_0013",oPC,1);}
            else if(nHistRoll == 9)    {CreateItemOnObject("te_item_0014",oPC,1);}
            else if(nHistRoll == 10)   {CreateItemOnObject("te_item_0005",oPC,1);}
        }

        if(nRoll >= nMagiThreshold)
        {
            int nMagiRoll = Random(5);
            if(nMagiRoll == 4)
            {
                int nItem = Random(59);
                object oItem;
                if(nItem == 0) { oItem = CreateItemOnObject("te_potion027",oPC,1);}
                else if(nItem == 1) { oItem = CreateItemOnObject("te_potion044",oPC,1);}
                else if(nItem == 2) { oItem = CreateItemOnObject("te_potion029",oPC,1);}
                else if(nItem == 3) { oItem = CreateItemOnObject("te_potion039",oPC,1);}
                else if(nItem == 4) { oItem = CreateItemOnObject("te_potion040",oPC,1);}
                else if(nItem == 5) { oItem = CreateItemOnObject("te_potion026",oPC,1);}
                else if(nItem == 6) { oItem = CreateItemOnObject("te_potion038",oPC,1);}
                else if(nItem == 7) { oItem = CreateItemOnObject("te_potion025",oPC,1);}
                else if(nItem == 8) { oItem = CreateItemOnObject("te_potion032",oPC,1);}
                else if(nItem == 9) { oItem = CreateItemOnObject("te_potion002",oPC,1);}
                else if(nItem == 10) { oItem = CreateItemOnObject("te_potion001",oPC,1);}
                else if(nItem == 11) { oItem = CreateItemOnObject("te_potion004",oPC,1);}
                else if(nItem == 12) { oItem = CreateItemOnObject("te_potion005",oPC,1);}
                else if(nItem == 13) { oItem = CreateItemOnObject("te_potion006",oPC,1);}
                else if(nItem == 14) { oItem = CreateItemOnObject("te_potion009",oPC,1);}
                else if(nItem == 15) { oItem = CreateItemOnObject("te_potion010",oPC,1);}
                else if(nItem == 16) { oItem = CreateItemOnObject("te_potion012",oPC,1);}
                else if(nItem == 17) { oItem = CreateItemOnObject("te_potion013",oPC,1);}
                else if(nItem == 18) { oItem = CreateItemOnObject("te_potion014",oPC,1);}
                else if(nItem == 19) { oItem = CreateItemOnObject("te_potion015",oPC,1);}
                else if(nItem == 20) { oItem = CreateItemOnObject("te_potion016",oPC,1);}
                else if(nItem == 21) { oItem = CreateItemOnObject("te_potion017",oPC,1);}
                else if(nItem == 22) { oItem = CreateItemOnObject("te_potion018",oPC,1);}
                else if(nItem == 23) { oItem = CreateItemOnObject("te_potion020",oPC,1);}
                else if(nItem == 24) { oItem = CreateItemOnObject("te_scr_su1",oPC,1);}
                else if(nItem == 25) { oItem = CreateItemOnObject("te_scr_su2",oPC,1);}
                else if(nItem == 26) { oItem = CreateItemOnObject("te_scr_smou",oPC,1);}
                else if(nItem == 27) { oItem = CreateItemOnObject("te_scr_scor",oPC,1);}
                else if(nItem == 28) { oItem = CreateItemOnObject("te_scr_blur",oPC,1);}
                else if(nItem == 29) { oItem = CreateItemOnObject("te_scr_shcr",oPC,1);}
                else if(nItem == 30) { oItem = CreateItemOnObject("te_scr_proa",oPC,1);}
                else if(nItem == 31) { oItem = CreateItemOnObject("te_scr_chto",oPC,1);}
                else if(nItem == 32) { oItem = CreateItemOnObject("te_scr_cund",oPC,1);}
                else if(nItem == 33) { oItem = CreateItemOnObject("te_scr_fwav",oPC,1);}
                else if(nItem == 34) { oItem = CreateItemOnObject("te_scr_flife",oPC,1);}
                else if(nItem == 35) { oItem = CreateItemOnObject("te_scr_halt",oPC,1);}
                else if(nItem == 36) { oItem = CreateItemOnObject("te_scr_spra",oPC,1);}
                else if(nItem == 37) { oItem = CreateItemOnObject("te_scr_dsund",oPC,1);}
                else if(nItem == 38) { oItem = CreateItemOnObject("nw_it_sparscr414",oPC,1);}
                else if(nItem == 39) { oItem = CreateItemOnObject("nw_it_sparscr211",oPC,1);}
                else if(nItem == 40) { oItem = CreateItemOnObject("nw_it_sparscr112",oPC,1);}
                else if(nItem == 41) { oItem = CreateItemOnObject("x2_it_sparscr201",oPC,1);}
                else if(nItem == 42) { oItem = CreateItemOnObject("x2_it_sparscr202",oPC,1);}
                else if(nItem == 43) { oItem = CreateItemOnObject("nw_it_sparscr309",oPC,1);}
                else if(nItem == 44) { oItem = CreateItemOnObject("nw_it_sparscr304",oPC,1);}
                else if(nItem == 45) { oItem = CreateItemOnObject("x2_it_sparscr205",oPC,1);}
                else if(nItem == 46) { oItem = CreateItemOnObject("x2_it_sparscr203",oPC,1);}
                else if(nItem == 47) { oItem = CreateItemOnObject("nw_it_sparscr209",oPC,1);}
                else if(nItem == 48) { oItem = CreateItemOnObject("x1_it_sparscr303",oPC,1);}
                else if(nItem == 49) { oItem = CreateItemOnObject("x2_it_sparscr104",oPC,1);}
                else if(nItem == 50) { oItem = CreateItemOnObject("nw_it_sparscr207",oPC,1);}
                else if(nItem == 51) { oItem = CreateItemOnObject("nw_it_sparscr218",oPC,1);}
                else if(nItem == 52) { oItem = CreateItemOnObject("nw_it_sparscr310",oPC,1);}
                else if(nItem == 53) { oItem = CreateItemOnObject("nw_it_sparscr315",oPC,1);}
                else if(nItem == 54) { oItem = CreateItemOnObject("nw_it_sparscr113",oPC,1);}
                else if(nItem == 55) { oItem = CreateItemOnObject("nw_it_sparscr111",oPC,1);}
                else if(nItem == 56) { oItem = CreateItemOnObject("nw_it_sparscr201",oPC,1);}
                else if(nItem == 57) { oItem = CreateItemOnObject("x2_it_sparscr204",oPC,1);}
                else if(nItem == 58) { oItem = CreateItemOnObject("nw_it_sparscr311",oPC,1);}

                SetIdentified(oItem,FALSE);
            }
        }
    }
    //Gold
    //Calishite Items
    //Scrolls
    //Magic Item Roll
    //History Items
}

void DoDragonLoot(object oPC)
{
    int nD20 = d20(1);
    int nSkill = GetSkillRank(SKILL_SEARCH,oPC,FALSE);
    int nRoll = nD20+nSkill;
    object oItem;
    object oArtifact;
    object oMagic;

    int nGoldThreshold = 25;
    int nItemThreshold = 30;
    int nMagiThreshold = 35;

    //Survival
    if(GetHasFeat(1430,oPC) == TRUE)                   {nGoldThreshold = 20;}
    //History
    if(GetHasFeat(1426,oPC) == TRUE)                   {nItemThreshold = 25;}
    //Magic
    if(GetSkillRank(SKILL_SPELLCRAFT,oPC,FALSE) >= 10) {nMagiThreshold = 30;}

    if(nD20 == 1 || (nGoldThreshold > nRoll && nItemThreshold >nRoll && nMagiThreshold >nRoll ))
    {
         //Critical Failure.
         //You find nothing.
         SendMessageToPC(oPC,"You find nothing...");
    }
    else
    {
        DoIntMythic(oPC);
        /*
        if(nD20 == 20)
        {
            if(Random(10) == 10)
            {
                int nD3 = d3(1);
                if(nD3 == 1) {oArtifact = CreateItemOnObject("te_item_8495",oPC,1);}
                else if(nD3 == 2) {oArtifact = CreateItemOnObject("te_hammerow",oPC,1);}
                else if(nD3 == 3) {oArtifact = CreateItemOnObject("te_item_01005",oPC,1);}
                if(GetIsObjectValid(oArtifact) == TRUE){SetIdentified(oArtifact, FALSE);}
            }
        }
        */

        if(nRoll >= nGoldThreshold)
        {
            GiveGoldToCreature(oPC,d20(5));
        }

        if(nRoll >= nItemThreshold)
        {
            int nItemRoll = Random(10);
            if (nItemRoll == 1){oItem = CreateItemOnObject("te_item_0018",oPC,1);}
            else if (nItemRoll == 2) {oItem = CreateItemOnObject("te_item_8211",oPC,1);}
            else if (nItemRoll == 3) {oItem = CreateItemOnObject("te_item_8212",oPC,1);}
            else if (nItemRoll == 4) {oItem = CreateItemOnObject("te_item_8213",oPC,1);}
            else if (nItemRoll == 5) {oItem = CreateItemOnObject("te_item_8214",oPC,1);}
            else if (nItemRoll == 6) {oItem = CreateItemOnObject("te_item_8215",oPC,1);}
            else if (nItemRoll == 7) {oItem = CreateItemOnObject("te_item_8216",oPC,1);}
            else if (nItemRoll == 8) {oItem = CreateItemOnObject("te_item_0013",oPC,1);}
            else if (nItemRoll == 9) {oItem = CreateItemOnObject("te_item_0014",oPC,1);}
            else if (nItemRoll == 10) {oItem = CreateItemOnObject("te_item_0005",oPC,1);}

            if(GetIsObjectValid(oItem) == TRUE) {SetIdentified(oItem, FALSE);}
        }
        if(nRoll >= nMagiThreshold)
        {
            int nMagicRoll = Random(28);
            if(nMagicRoll == 0) { oMagic = CreateItemOnObject("te_item_3015",oPC,1);}
            else if(nMagicRoll == 1) { oMagic = CreateItemOnObject("te_item_4002",oPC,1);}
            else if(nMagicRoll == 2) { oMagic = CreateItemOnObject("te_item_4008",oPC,1);}
            else if(nMagicRoll == 3) { oMagic = CreateItemOnObject("te_item_4009",oPC,1);}
            else if(nMagicRoll == 4) { oMagic = CreateItemOnObject("te_item_6016",oPC,1);}
            else if(nMagicRoll == 5) { oMagic = CreateItemOnObject("te_item_6018",oPC,1);}
            else if(nMagicRoll == 6) { oMagic = CreateItemOnObject("te_item_6019",oPC,1);}
            else if(nMagicRoll == 7) { oMagic = CreateItemOnObject("nw_it_sparscr112",oPC,1);}
            else if(nMagicRoll == 8) { oMagic = CreateItemOnObject("x2_it_sparscr201",oPC,1);}
            else if(nMagicRoll == 9) { oMagic = CreateItemOnObject("nw_it_sparscr704",oPC,1);}
            else if(nMagicRoll == 10) { oMagic = CreateItemOnObject("nw_it_sparscr416",oPC,1);}
            else if(nMagicRoll == 11) { oMagic = CreateItemOnObject("x2_it_spdvscr901",oPC,1);}
            else if(nMagicRoll == 12) { oMagic = CreateItemOnObject("nw_it_sparscr101",oPC,1);}
            else if(nMagicRoll == 13) { oMagic = CreateItemOnObject("x1_it_spdvscr704",oPC,1);}
            else if(nMagicRoll == 14) { oMagic = CreateItemOnObject("nw_it_sparscr309",oPC,1);}
            else if(nMagicRoll == 15) { oMagic = CreateItemOnObject("x1_it_sparscr501",oPC,1);}
            else if(nMagicRoll == 16) { oMagic = CreateItemOnObject("nw_it_sparscr304",oPC,1);}
            else if(nMagicRoll == 17) { oMagic = CreateItemOnObject("x1_it_spdvscr205",oPC,1);}
            else if(nMagicRoll == 18) { oMagic = CreateItemOnObject("x1_it_spdvscr403",oPC,1);}
            else if(nMagicRoll == 19) { oMagic = CreateItemOnObject("x2_it_sparscr205",oPC,1);}
            else if(nMagicRoll == 20) { oMagic = CreateItemOnObject("nw_it_sparscr804",oPC,1);}
            else if(nMagicRoll == 21) { oMagic = CreateItemOnObject("x1_it_spdvscr501",oPC,1);}
            else if(nMagicRoll == 22) { oMagic = CreateItemOnObject("nw_it_sparscr906",oPC,1);}
            else if(nMagicRoll == 23) { oMagic = CreateItemOnObject("nw_it_sparscr303",oPC,1);}
            else if(nMagicRoll == 24) { oMagic = CreateItemOnObject("nw_it_sparscr201",oPC,1);}
            else if(nMagicRoll == 25) { oMagic = CreateItemOnObject("nw_it_sparscr407",oPC,1);}
            else if(nMagicRoll == 26) { oMagic = CreateItemOnObject("te_scr_smou",oPC,1);}
            else if(nMagicRoll == 27) { oMagic = CreateItemOnObject("te_scr_scor",oPC,1);}

            if(GetIsObjectValid(oMagic) == TRUE){SetIdentified(oMagic, FALSE);}
        }
    }
}

void DoIntMythic(object oPC)
{
    TickMythicXp(oPC, ABILITY_INTELLIGENCE);
}
