
void add_vfx(object oSelf, int iResult, object oPC);
//void create_item2(object oSelf, object source_1, object oCoal, string result, object oPC);

void add_vfx(object oSelf, int iResult,object oPC)
{
    SendMessageToPC(oPC, "VFX Script");
    int nBurnTime = 15;
    effect eWorking = EffectVisualEffect(VFX_DUR_INFERNO);
    effect eCritFail = EffectVisualEffect(VFX_DUR_INFERNO_CHEST);

    if (iResult == 1)
    {
        // sucess case
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, IntToFloat(nBurnTime));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eWorking, oSelf, IntToFloat(nBurnTime));
    }

    if (iResult == 0)
    {
        // critical fail case
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, IntToFloat(nBurnTime));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eWorking, oSelf, IntToFloat(nBurnTime));
        int nDamage = d12(1);
        effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
        eDam = EffectLinkEffects(eCritFail,eDam); // flare up
        ApplyEffectToObject (DURATION_TYPE_TEMPORARY, eDam, oPC, 6.0);
    }
}


/*void create_item2(object oSelf, object source_1, object oCoal, string result, object oPC)
{
    SendMessageToPC(oPC, "create item script beginning");
    int nMod = GetHitDice(oPC) + GetAbilityModifier(ABILITY_INTELLIGENCE, oPC);
    int nRoll = d20(1);
    int nDC = 0;
    string sResult == "";

    if     (source_1 == "te_item_8468"){nDC = 15; sResult = "te_item_8464"}     //Iron Ingot
    else if(source_1 == "te_item_8464"){nDC = 15; sResult = "te_item_0007"}     //Bar of Iron
    else if(source_1 == "te_item_0007"){nDC = 17; sResult = "te_item_0009"}     //Bar of Steel
    else if(source_1 == "te_item_8469"){nDC = 19; sResult = "te_item_8466"}     //Mithril Ingot
    else if(source_1 == "te_item_8466"){nDC = 19; sResult = "te_item_0008"}     //Bar Mithril
    else if(source_1 == "te_item_8470"){nDC = 21; sResult = "te_item_8467"}     //Adamantine Ingot
    else if(source_1 == "te_item_8467"){nDC = 21; sResult = "te_item_0006"}     //Bar of Adamantine
    // checks roll results and returns apropriate responses
    if (nRoll == 1)
    {
        SendMessageToPC(oPC, "crif fail");
        add_vfx(oSelf, 1,oPC);
        SendMessageToPC(oPC, "You critically Fail!");
    }

    if (nRoll + nMod >= nDC)
    {
       SendMessageToPC(oPC, "sucess");
       CreateItemOnObject(sResult, oSelf, 1);
       DestroyObject(source_1);
       DestroyObject(oCoal);
       add_vfx(oSelf, 0,oPC);
       SendMessageToPC(oPC, "You sucessfully produce an metal bar!");
    }

    if (nRoll + nMod <= nDC)
    {
        SendMessageToPC(oPC, "failiure");
        add_vfx(oSelf, 0,oPC);
        SendMessageToPC(oPC, "You you fail getting the furnace hot enugh and waste coal in the process!");
    }
}
*/

void main()
{

    object oSelf = OBJECT_SELF;
    object oPC = GetLastUsedBy();

    //SendMessageToPC(oPC, "Hello Script");
    int nItemCount = 0;
    object oItem;

    int nSmelt = 0;     //This value if smelting ore to ingot or ingot to bar
    int nFail = 0;      //Failure case for items with no metal material value
    int nBreak = 0;     //This value used if breaking down material.
    //int nMetalBar = 0;

    //list of all metal bars in the game
    string sIron       = "te_item_8468";     //Iron Ore
    string sAdam       = "te_item_8470";     //Adamant Ore
    string sMithr      = "te_item_8469";     //Mithral Ore
    string sIronIngot  = "te_item_8464";     //Iron Ingot
    string sIronBar    = "te_item_0007";     //Bar of Iron
    string sSteel      = "te_item_0009";     //Bar of Steel
    string sMithIngot  = "te_item_8466";     //Mithril Ingot
    string sMithBar    = "te_item_0008";     //Bar Mithril
    string sAdamIngot  = "te_item_8467";     //Adamantine Ingot
    string sAdamBar    = "te_item_0006";     //Bar of Adamantine
    int nIronCounter = 0;
    int nSteelCounter = 0;
    int nAdamCounter = 0;
    int nMithrCounter = 0;

    object oBreak = OBJECT_INVALID;
    object oSmelt = OBJECT_INVALID;

    // coal
    string sCoal = "cnrLumpOfCoal";
    //string sCoal = "x2_it_cfm_bscr";
    int nCoalCounter = 0;

    // tongs
    string sTong = "te_item_8463";

    // check if tongs are in the inventory
    object oTong = GetItemPossessedBy(oPC, sTong);

    if (oTong == OBJECT_INVALID)
    {
        SendMessageToPC(oPC, "You need tongs to work the furnace!");
        return;
    }

    //Roll Stuff
    int nRoll = d20(1);
    int nMod = 0;

    if(GetHasFeat(1485,oPC) == TRUE)
    {
        nMod = GetHitDice(oPC) + GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);
    }
    else
    {
        nMod = GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);
    }

    nRoll += nMod;

    //SendMessageToPC(oPC, "before first get item");
    oItem = GetFirstItemInInventory(oSelf);
    /*count the items in the Furnace*/
    //SendMessageToPC(oPC, "before while loop");
    while (GetIsObjectValid(oItem))
    {
        //SendMessageToPC(oPC, "in while loop");
        // check for metal in the furnace

        int nMaterial = GetLocalInt(oItem, "Material");

        if(GetResRef(oItem) == sIron     ||
           GetResRef(oItem) == sAdam     ||
           GetResRef(oItem) == sMithr    ||
           GetResRef(oItem) == sIronIngot||
           GetResRef(oItem) == sIronBar  ||
           GetResRef(oItem) == sMithIngot||
           GetResRef(oItem) == sMithBar  ||
           GetResRef(oItem) == sAdamIngot||
           GetResRef(oItem) == sSteel    ||
           GetResRef(oItem) == sAdamBar)
        {
            nSmelt = 1;
            oSmelt = oItem;
        }
        else if(GetTag(oItem) == sCoal)
        {
            nCoalCounter += 1;
        }
        else
        {
            if (nMaterial ==  1 )   {nIronCounter = nIronCounter + 1;}
            else if (nMaterial ==  2 )   {nSteelCounter = nSteelCounter + 1;}
            else if (nMaterial ==  3 )   {nMithrCounter = nMithrCounter + 1;}
            else if (nMaterial ==  4 )   {nAdamCounter = nAdamCounter + 1;}
            else {nFail = 1;}
            oBreak = oItem;
            nBreak = 1;
        }

        nItemCount = nItemCount+1;
        oItem = GetNextItemInInventory(oSelf);
    }

    if(nItemCount > 2)
    {
        SendMessageToPC(oPC,"You have too many items in the smelter.");
        return;
    }

    if(nItemCount < 2)
    {
        SendMessageToPC(oPC,"You do not have enough items in the smelter.");
        return;
    }

    if(nCoalCounter <= 0)
    {
        SendMessageToPC(oPC,"You must have coal to use the smelter.");
        return;
    }

    object oCoal = GetItemPossessedBy(oSelf, sCoal);

    if(nFail == 1)
    {
        SendMessageToPC(oPC,"You may not smelt non-metal items down into their base components.");
    }
    else if(nBreak == 1 && oBreak != OBJECT_INVALID)
    {
        //+1 DC for every 500.
        int nDCMod = GetLocalInt(oBreak, "Value")/500;
        if(nRoll == 1)
        {
            SendMessageToPC(oPC, "Critical Failure! You ruin the item you are attempting to break down.");
            add_vfx(oSelf,0,oPC);
        }
        else if(nRoll > 20+nDCMod)
        {
            SendMessageToPC(oPC,"Success! You break down the item into its base material.");
            if      (GetLocalInt(oBreak,"Material") ==  1 )   {CreateItemOnObject(sIronIngot,oSelf,1);}
            else if (GetLocalInt(oBreak,"Material") ==  2 )   {CreateItemOnObject(sIronIngot,oSelf,1);}
            else if (GetLocalInt(oBreak,"Material") ==  3 )   {CreateItemOnObject(sMithIngot,oSelf,1);}
            else if (GetLocalInt(oBreak,"Material") ==  4 )   {CreateItemOnObject(sAdamIngot,oSelf,1);}
            else   {SendMessageToPC(oPC,"Incorrect item loaded in Smelter."); return;}
            add_vfx(oSelf,1,oPC);
        }
        else
        {
            SendMessageToPC(oPC,"Failure! You ruin the item you are attempting to break down.");
            add_vfx(oSelf,0,oPC);
        }
        DestroyObject(oCoal,0.1f);
        DestroyObject(oBreak,0.1f);
    }
    else if(nSmelt == 1 && oSmelt != OBJECT_INVALID)
    {
        int nDC = 0;
        string sResult = "";
        if     (GetResRef(oSmelt) == "te_item_8468"){nDC = 15; sResult = "te_item_8464";}     //Iron Ingot
        else if(GetResRef(oSmelt) == "te_item_8464"){nDC = 15; sResult = "te_item_0007";}     //Bar of Iron
        else if(GetResRef(oSmelt) == "te_item_0007"){nDC = 17; sResult = "te_item_0009";}     //Bar of Steel
        else if(GetResRef(oSmelt) == "te_item_8469"){nDC = 19; sResult = "te_item_8466";}     //Mithril Ingot
        else if(GetResRef(oSmelt) == "te_item_8466"){nDC = 19; sResult = "te_item_0008";}     //Bar Mithril
        else if(GetResRef(oSmelt) == "te_item_8470"){nDC = 21; sResult = "te_item_8467";}     //Adamantine Ingot
        else if(GetResRef(oSmelt) == "te_item_8467"){nDC = 21; sResult = "te_item_0006";}     //Bar of Adamantine
        else   {SendMessageToPC(oPC,"Incorrect item loaded in Smelter."); return;}

        if(nRoll == 1)
        {
            SendMessageToPC(oPC,"Critical Failure! You ruin the item you are attempting to refine.");
            add_vfx(oSelf,0,oPC);
        }
        else if(nRoll > nDC)
        {
            SendMessageToPC(oPC,"Success! You smelt this item into a more refined form.");
            CreateItemOnObject(sResult,oSelf,1);
            add_vfx(oSelf,1,oPC);
        }
        else
        {
            add_vfx(oSelf,0,oPC);
        }
        DestroyObject(oCoal,0.1f);
        DestroyObject(oSmelt,0.1f);
    }
}
        /*ALL OF THIS IS MAL'S CRAP.
        if( (nMaterial ==  1 && GetResRef(oItem) == sIron) || //iron
            (nMaterial ==  2 && GetResRef(oItem) == sSteel) || //steel
            (nMaterial ==  3 && GetResRef(oItem) == sMithr) || //mithrl
            (nMaterial ==  4 && GetResRef(oItem) == sAdam))    //adam
        {
           SendMessageToPC(oPC, "This shuld print for a metal bar");
           nMetal = 1;
           nMetalBar
        }
        if( nMaterial ==  1 || //iron
            nMaterial ==  2 || //steel
            nMaterial ==  3 || //mithrl
            nMaterial ==  4)    //adam
        {
           nMetal = 1;
        }

        //counting instances of materials
        if (GetTag(oItem) == sCoal)                         {nCoalCounter = nCoalCounter + 1;}
        if (nMaterial ==  1 || GetResRef(oItem) == sIron)   {nIronCounter = nIronCounter + 1;}
        if (nMaterial ==  2 || GetResRef(oItem)  == sSteel) {nSteelCounter = nSteelCounter + 1;}
        if (nMaterial ==  3 || GetResRef(oItem) == sMithr)  {nMithrCounter = nMithrCounter + 1;}
        if (nMaterial ==  4 || GetResRef(oItem) == sAdam)   {nAdamCounter = nAdamCounter + 1;}

        SendMessageToPC(oPC, "Item count " + IntToString(nItemCount));
        SendMessageToPC(oPC, "coal count " + IntToString(nCoalCounter));
        SendMessageToPC(oPC, "Iron count " + IntToString(nIronCounter));
        SendMessageToPC(oPC, "Steel count " + IntToString(nSteelCounter));
        SendMessageToPC(oPC, "Mithrl count " + IntToString(nMithrCounter));
        SendMessageToPC(oPC, "Adamantine count " + IntToString(nAdamCounter));


    if(nMetal >= 1 && nMetalBar == 0 && nCoalCounter >= 1)  //if we dont have a metal bar in the smelter we are re processing material
    {
        SendMessageToPC(oPC, "Smelting Reprocessing");

        if (nItemCount - nCoalCounter > nCoalCounter)
        {
            SendMessageToPC(oPC, "not enugh coal to start the furnace you have more items in the smelter than you have coal  ");
            return;
        }
        else
        {
          SendMessageToPC(oPC, "all is well so far");
            if(((nIronCounter > 0) && (nSteelCounter > 0)) ||
                ((nIronCounter > 0) && (nMithrCounter > 0)) ||
                ((nIronCounter > 0) && (nAdamCounter > 0))  ||
                ((nSteelCounter > 0) && (nMithrCounter > 0)) ||
                ((nSteelCounter > 0) && (nAdamCounter > 0))  ||
                ((nMithrCounter > 0) && (nAdamCounter > 0))  ||
                (nIronCounter > 1)  ||
                (nSteelCounter > 1)  ||
                (nMithrCounter > 1)  ||
                (nAdamCounter > 1))
            {
                SendMessageToPC(oPC, "creating slag");
                return;
            }
            oItem = GetFirstItemInInventory(oSelf);

            if (GetResRef(oItem) == sCoal)
            {
                oItem = GetNextItemInInventory(oSelf);
            }

            int nMaterial = GetLocalInt(oItem, "Material");

            if (nMaterial ==  1)//Iron
            {
                 SendMessageToPC(oPC, "we have coal and we have iron");
                 object oCoal = GetItemPossessedBy(oSelf, sCoal);
                 //start of a recepy makes an asertion about what is needed
                 create_item2(oSelf, oItem, oCoal, sIron, oPC);
                 nCoalCounter = nCoalCounter - 1;
                 nIronCounter = nIronCounter - 1;
            }//iron ends

            if (nMaterial ==   2)//Steel
            {
                 SendMessageToPC(oPC, "we have coal and we have steel");
                 object oCoal = GetItemPossessedBy(oSelf, sCoal);
                 //start of a recepy makes an asertion about what is needed
                 create_item2(oSelf, oItem, oCoal, sSteel, oPC);
                 nCoalCounter = nCoalCounter - 1;
                 nSteelCounter = nSteelCounter - 1;
            }// Steel ends

            if (nMaterial ==   3)// Mithril
            {
                 SendMessageToPC(oPC, "we have coal and we have mithral");
                 object oCoal = GetItemPossessedBy(oSelf, sCoal);
                 //start of a recepy makes an asertion about what is needed
                 create_item2(oSelf, oItem, oCoal, sMithr, oPC);
                 nCoalCounter = nCoalCounter - 1;
                 nMithrCounter = nMithrCounter - 1;
            }// Mithril ends
            if (nMaterial ==   4)// Adamantine
            {
                 SendMessageToPC(oPC, "we have coal and we have adamantine");
                 object oCoal = GetItemPossessedBy(oSelf, sCoal);
                 //start of a recepy makes an asertion about what is needed
                 create_item2(oSelf, oItem, oCoal, sAdam, oPC);
                 nCoalCounter = nCoalCounter - 1;
                 nAdamCounter = nAdamCounter - 1;
            }// Adamantine ends
            return;
        }
    }

    if (nItemCount == 0){return;}
    if (nItemCount == 1)// 1 items in the furnace
    {
        return;
    }
    if (nItemCount == 2)// 2 items in the furnace
    {
        SendMessageToPC(oPC, "two items in the furnace");
        SendMessageToPC(oPC, IntToString(nMetal));
        SendMessageToPC(oPC, IntToString(nMetalBar));
        //first sheck if we are dealing with metal or not
        if (nMetal == 1 && nMetalBar == 1)  //if we have a metal bar in the smelter we are making an alloy.
        {
            SendMessageToPC(oPC, "Starting Steel");

            if (nCoalCounter == 1 && nIronCounter ==1)   // verifies assertion
            {
                SendMessageToPC(oPC, "we have coal and we have iron");
                object oCoal = GetItemPossessedBy(oSelf, sCoal);
                //start of a recepy makes an asertion about what is needed
                object oIron = GetItemPossessedBy(oSelf, sIron);
                create_item2(oSelf, oIron, oCoal, sSteel, oPC);
                return;
            } // end of recepy
        }
        //if assertion verification fails we can make a new one and test for that recepy
    }
    if (nItemCount == 3)// 3 items in the furnace
    {return;}
    if (nItemCount == 4)// 4 items in the furnace
    {return;}
    if (nItemCount >= 5)// 5 or more items in the furnace end case this many items will burn everything and return slag if metal was present
    {return;}
}
*/
