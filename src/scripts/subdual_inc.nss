//::///////////////////////////////////////////////
//:: Subdual Damage 1.6
//:: subdual_clenter
//:: Copyright (c) 2018 CarfaxAbbey.net
//:://////////////////////////////////////////////
/*
    Allows for PC subdual in PvP combat.
    Non-Lethal Damage
*/
//:://////////////////////////////////////////////
//:: Revised By: Diavlen (hatter@carfaxabbey.net)
//:: Created On: August 11, 2006
//:: Revised: March 30, 2018
//:://////////////////////////////////////////////

//::///////////////////////////////////////////////
//:: Configuration
//::///////////////////////////////////////////////
int DEBUG       =   TRUE;
int DEBUG_LEVEL =   1;  // 0=Minimum, 1=Verbose, 2=DMs

// Change these constants to set the maximum of 'knockout hits' that a PC can
// receive before moving to the next stage of unconsciousness.
// For example, if SUBDUE_WINDED = 3, a PC can receive 3 hits in a short period
// of time and remain winded. 4 hits will cause him to black out.
int SUBDUE_WINDED               = 7;
int SUBDUE_BLACKOUT             = 12;
int SUBDUE_KNOCKOUT             = 18;

int SUBDUAL_MODE_FULL_DAMAGE    = 0;
int SUBDUAL_MODE_SUBDUAL        = 1;



//::///////////////////////////////////////////////
//:: Declaration
//::///////////////////////////////////////////////

// For DEBUG Purposes
void subDEBUG(string sMessage);

// Main subdual check funciton. Call only in OnPlayerDeath and OnPlayerDying.
// Will return the degree of damage the player has incurred, or 0 if it was
// not subdual damage.
int CheckSubdual(object oPC);

// Only CheckSubdual is meant to be called, and then only from
// OnPlayerDeath and OnPlayerDying. The rest are internal functions.

void SetSubdualHealth(object oPC);
void SetSubdued(object oPC, int i);
void SubdualDrop(object oPC, int type=1);
void SubdualDecrease(object oPC, int lastValue);
int GetSubdual(object oPC);

//::///////////////////////////////////////////////
//:: Implementation
//::///////////////////////////////////////////////

// For debugging use
void subDEBUG(string sMessage) {
    WriteTimestampedLogEntry(sMessage);
    if(DEBUG_LEVEL==1)  {
        SendMessageToAllDMs(sMessage);
        object oPC = GetFirstPC();
        while (GetIsPC(oPC))    {
            SendMessageToPC(oPC, sMessage);
            oPC = GetNextPC();
        }
    }
    if(DEBUG_LEVEL==2)  {
        SendMessageToAllDMs(sMessage);
    }
}

// Main subdual check funciton. Call only in OnPlayerDeath and OnPlayerDying.
// Will return the degree of damage the player has incurred, or 0 if it was
// not subdual damage.
int CheckSubdual(object oPC)    {
    int j   =   GetSubdual(oPC);
    if(j) {
        if(GetLocalInt(oPC,"BEATEN_TO_DEATH")) return FALSE;    // Added this as a quick out in case the person was beaten to death THROUGH Subdual damage
        int i=GetLocalInt(oPC,"nSubdued");
        i++;
        SetLocalInt(oPC,"nSubdued",i);
        SetSubdualHealth(oPC);
        SetSubdued(oPC,i);
        return i;
    }
    return FALSE;
}

void SetSubdualHealth(object oPC) {
    if ((GetCurrentHitPoints(oPC))<-9)
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPC);
    else if ((GetCurrentHitPoints(oPC))<1)
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(abs(GetCurrentHitPoints(oPC))+1),oPC);
}

void SetSubdued(object oPC,int i) {
    string sMes;
    float timeUnc;      // Time unconscious
    float timeDazed;    // Time Dazed
    int dropType;       // What equipment should be dropped
    int moveDec;        // Movement decrease
    int acDec;          // AC Decrease
    if (i<=SUBDUE_WINDED) {
        sMes="**Winded**";
        timeUnc=15.0;
        timeDazed=30.0;
        dropType=0;
        moveDec=20;
        acDec=2;
    } else if (i<=SUBDUE_BLACKOUT) {
        sMes="**Black out**";
        timeUnc=30.0;
        timeDazed=60.0;
        dropType=1;
        moveDec=35;
        acDec=5;
    } else if(i<=SUBDUE_KNOCKOUT) {
        sMes="**Knock out**";
        timeUnc=45.0;
        timeDazed=120.0;
        dropType=2;
        moveDec=50;
        acDec=7;
    } else {
        sMes="**Concussion**";
        timeUnc=60.0;
        timeDazed=240.0;
        dropType=3;     // Death is a possibility now.  Fortitude Saves Begin
        moveDec=75;
        acDec=10;
    }
    // Apply the subdual effects
    AssignCommand(oPC,ClearAllActions());
    AssignCommand(oPC,ActionSpeakString(sMes));
    AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT,1.0,timeUnc));
    AssignCommand(oPC,ActionDoCommand(ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectMovementSpeedDecrease(moveDec),oPC,timeDazed)));
    AssignCommand(oPC,ActionDoCommand(ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectACDecrease(acDec),oPC,timeDazed)));
    AssignCommand(oPC,ActionDoCommand(SetCommandable(TRUE,oPC)));
    AssignCommand(oPC,SetCommandable(FALSE,oPC));
    DelayCommand(timeUnc+timeDazed,SubdualDecrease(oPC,i));
    if(dropType>0)  {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectBlindness(),oPC,timeUnc);
        //DelayCommand(3.0,FadeToBlack(oPC));
        //DelayCommand(timeUnc,FadeFromBlack(oPC));
        SubdualDrop(oPC,dropType);
    }
}

// Returns type of subdual.
// GetLastAttacker, GetGoingToBeAttackedBy, GetLastHostileActor
// seem to work correctly in an ondeath script for a PC.
// To be safe, check everything for a possible subdual attack.
// If there is an incorrect positive, the attacker can always hit
// the PC again.
int GetSubdual(object oPC) {
    int i   = 0;
    object oKiller = GetLastAttacker(oPC);
    if(GetIsObjectValid(oKiller))
        if((GetLocalInt(oKiller,"SUBDUAL"))&&(oKiller!=oPC))
            i=GetLocalInt(oKiller,"SUBDUAL");
    oKiller=GetGoingToBeAttackedBy(oPC);
    if(GetIsObjectValid(oKiller))
        if((GetLocalInt(oKiller,"SUBDUAL"))&&(oKiller!=oPC))
            i=GetLocalInt(oKiller,"SUBDUAL");
    oKiller=GetLastDamager();
    if(GetIsObjectValid(oKiller))
        if((GetLocalInt(oKiller,"SUBDUAL"))&&(oKiller!=oPC))
            i=GetLocalInt(oKiller,"SUBDUAL");
    oKiller=GetLastKiller();
    if(GetIsObjectValid(oKiller))
        if((GetLocalInt(oKiller,"SUBDUAL"))&&(oKiller!=oPC))
            i=GetLocalInt(oKiller,"SUBDUAL");
    oKiller=GetLastHostileActor(oPC);
    if(GetIsObjectValid(oKiller))
        if((GetLocalInt(oKiller,"SUBDUAL"))&&(oKiller!=oPC))
            i=GetLocalInt(oKiller,"SUBDUAL");
    oKiller=GetLastSpellCaster();
    if(GetIsObjectValid(oKiller))
        if((GetLocalInt(oKiller,"SUBDUAL"))&&(oKiller!=oPC))
            i=GetLocalInt(oKiller,"SUBDUAL");
    return i;
}

void SubdualDecrease(object oPC, int lastValue) {
  if (GetLocalInt(oPC,"nSubdued")==lastValue)
    SetLocalInt(oPC,"nSubdued",0);
}

void strip_equip(object oTarget, object oPC, int inventory_slot)    {
    object oInv = GetItemInSlot(inventory_slot,oPC);
    CopyObject(oInv,GetLocation(oTarget),oTarget);
    DestroyObject(oInv);
}

void SubdualDrop(object oPC, int type=1) {
    if (type==0) return;        // Winded and no item loss

    // Creates a gear bag to the player's side
    vector vVec =   GetPositionFromLocation(GetLocation(oPC));
    vVec.x+=0.6;
    location lLoc   =   Location(GetArea(oPC),vVec,0.0);
    object oItemBag =   GetLocalObject(oPC,"SUBDUALBAG");
    if((!GetIsObjectValid(oItemBag))||(GetDistanceBetween(oPC,oItemBag)>10.0)) {
        oItemBag    =   CreateObject(OBJECT_TYPE_PLACEABLE, "subdualbag", lLoc);
        SetLocalObject(oPC,"SUBDUALBAG",oItemBag);
    }
    string sID  =   GetName(oPC)+GetPCPublicCDKey(oPC);
    SetLocalString(oItemBag,"Name",GetName(oPC));

    // Blackout - Transfer the gold to the bag
    if(type>=1) {
        int nAmtGold=GetGold(oPC);
        AssignCommand(oItemBag,TakeGoldFromCreature(nAmtGold,oPC, TRUE));
        while(nAmtGold > 0) {
            if(nAmtGold > 50000)    {
                CreateItemOnObject("nw_it_gold001", oItemBag, 50000);
                nAmtGold -= 50000;
            } else {
                CreateItemOnObject("nw_it_gold001", oItemBag, nAmtGold);
                nAmtGold=0;
            }
        }
    }
    // Knockout - Transfer Readily grabbed equipped items and weapon
    if (type>=2) {
        strip_equip(oItemBag,oPC,INVENTORY_SLOT_RIGHTHAND);
        strip_equip(oItemBag,oPC,INVENTORY_SLOT_LEFTHAND);
        strip_equip(oItemBag,oPC,INVENTORY_SLOT_LEFTRING);
        strip_equip(oItemBag,oPC,INVENTORY_SLOT_RIGHTRING);
        strip_equip(oItemBag,oPC,INVENTORY_SLOT_HEAD);
        strip_equip(oItemBag,oPC,INVENTORY_SLOT_NECK);
        strip_equip(oItemBag,oPC,INVENTORY_SLOT_ARROWS);
        strip_equip(oItemBag,oPC,INVENTORY_SLOT_BELT);
        strip_equip(oItemBag,oPC,INVENTORY_SLOT_BOOTS);
        strip_equip(oItemBag,oPC,INVENTORY_SLOT_BULLETS);
        strip_equip(oItemBag,oPC,INVENTORY_SLOT_CLOAK);
        strip_equip(oItemBag,oPC,INVENTORY_SLOT_BOLTS);
        //strip_equip(oItemBag,oPC,INVENTORY_SLOT_ARMS);
        //strip_equip(oItemBag,oPC,INVENTORY_SLOT_CHEST);
    }
    // Concussion - Fortitude Save vs Death
    if(type>=3) {
        int nDC   =   GetLocalInt(oPC,"SUBDUAL_SAVE");
        // If not initialized, set the base save at 10
        if(!nDC)  nDC = 10;
        if(FortitudeSave(oPC,nDC,SAVING_THROW_TYPE_DEATH))  {
            nDC++;  // Save gets harder for next round
            SetLocalInt(oPC,"SUBDUAL_SAVE",nDC);
        } else {
            DelayCommand(10.0,DeleteLocalInt(oPC,"SUBDUAL_SAVE"));
            SetLocalInt(oPC,"BEATEN_TO_DEATH",TRUE);
            subDEBUG(GetName(GetLastDamager(oPC)) + " beat " + GetName(oPC) + " to death!!");
        }
    }
}
