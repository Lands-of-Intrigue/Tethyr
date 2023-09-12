//Teleport spell...
//Location 1:14
void JumpAssociate(object i_oPC, int i_type, location lDest);


void main()
{
    object oPC = OBJECT_SELF;
    object oTrav = GetFirstFactionMember(oPC,FALSE);
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");
    int nConfidence = GetLocalInt(oItem,"BCNTRST1");

    location lLoc = GetLocation(GetObjectByTag("WP_TP12"));

    // Make the player say something on his departure (so others will now that he teleported but crashed):
    string sGoodbye = "*Fades Out*";
    // Enter the message being send to the player when teleport starts:
    string sTeleportmessage = "Your surroundings begin to fade...";

    object oArea = GetAreaFromLocation(lLoc);
    vector vLoc = GetPositionFromLocation(lLoc);
    vector vMod;
    float fAng = GetFacingFromLocation(lLoc);

    float fRan1 = IntToFloat(Random(25));
    float fRan2 = IntToFloat(Random(25));

    if (d2(1) == 2)
    {
        fRan1 = (fRan1*-1);
    }
    if (d2(1) == 2)
    {
        fRan2 = (fRan2*-1);
    }

    location lDest;

    if(nConfidence >= 50)
    {
        lDest = lLoc;
    }
    else if((nConfidence < 20)&&(nConfidence >= 10))
    {
        vMod = Vector(vLoc.x+(fRan1/2),vLoc.y+(fRan2/2),1.0f);
        lDest = Location(oArea,vMod,fAng);
    }
    else if(nConfidence < 10)
    {
        vMod = Vector(vLoc.x+fRan1,vLoc.y+fRan2,1.0f);
        lDest = Location(oArea,vMod,fAng);
    }

    
    // Don't start Teleport at all if activator isn't a player or DM
    if(!GetIsPC(oPC))
        return;

        object oFM = GetFirstFactionMember(oPC);
        // Step through the party members.
        while(GetIsObjectValid(oFM))
            {
            AssignCommand(oFM, ActionSpeakString(sGoodbye));
            SendMessageToPC(oFM, sTeleportmessage);
            AssignCommand(oFM,  DelayCommand(2.0, JumpToLocation(lDest)));
            effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oFM);
            
            if(nConfidence < 20)
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d10(1),DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_NORMAL),oTrav);
            }            
            
            // now send the players companions over as well:
            DelayCommand(2.0, JumpAssociate(oFM, ASSOCIATE_TYPE_ANIMALCOMPANION, lDest));
            DelayCommand(2.0, JumpAssociate(oFM, ASSOCIATE_TYPE_DOMINATED, lDest));
            DelayCommand(2.0, JumpAssociate(oFM, ASSOCIATE_TYPE_FAMILIAR, lDest));
            DelayCommand(2.0, JumpAssociate(oFM, ASSOCIATE_TYPE_HENCHMAN, lDest));
            DelayCommand(2.0, JumpAssociate(oFM, ASSOCIATE_TYPE_SUMMONED, lDest));
            // Select the next member of the faction and loop.
            oFM = GetNextFactionMember(oFM);
            }
}

void JumpAssociate(object i_oPC, int i_type, location lDest)
{
    object oAssociate = GetAssociate(i_type, i_oPC);
    if(GetIsObjectValid(oAssociate))
        AssignCommand(oAssociate, JumpToLocation(lDest));
}

// "Teleport_Party"
// this teleport script is pre-set to teleport the whole party
// edit the "INSERT TAG HERE" below to set a new destination
// then "Save As" a different script name. Place the script where needed.