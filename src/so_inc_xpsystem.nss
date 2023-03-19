//::///////////////////////////////////////////////
//:: Name
//:: FileName
//:: Copyright (c) 2005 The Ravenloft PW Project
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Soeren Peter Moeller/Zarathustra217
//:: Created On:
//:://////////////////////////////////////////////

#include "so_inc_general"
#include "so_inc_database"
#include "so_inc_death"
#include "so_inc_constants"

//The replacement for GiveXPToCreature. Adds nXP to the player oPC's XPbank instead of just handing out the XP.
void GiveToXPBank(object oPC, int nXP);

//Stores the player oPC's current XP bank into the running database.
void StoreXPBank(object oPC);

//Used on the OnDeath event of a monster. Gives XP awards to all nearby players.
void AwardKillers();

float sqrt_abs(float fN)
{
    return fN<0.0 ? -(sqrt(-fN)) : sqrt(fN);
}

int GetHasPermissionToClass(object oPC, int nClass)
{
    if(nClass<27||nClass==CLASS_TYPE_INVALID)
    {
        return TRUE;
    }
    else
    {
        object oSkin=GetSkin(oPC);
        return GetLocalInt(oSkin,DATABASE_PC_CLASS_PERMISSION+IntToString(nClass));
    }
}

void SetHasPermissionToClass(object oPC, int nClass)
{
    object oSkin=GetSkin(oPC);
    SetLocalInt(oSkin,DATABASE_PC_CLASS_PERMISSION+IntToString(nClass),TRUE);
}


int GetLevelCap(object oPC)
{
    object oSkin=GetSkin(oPC);
    int nReturn=20;
    if(GetLocalInt(oSkin,DATABASE_PC_MONSTROUS_RACE))
    {
        nReturn=20-GetLocalInt(oSkin,DATABASE_PC_ECL_ADJUSTMENT)/2;
        /*switch(GetLocalInt(oSkin,DATABASE_PC_MONSTROUS_RACE))
        {
            case DATABASE_PC_MONSTROUS_RACE_WIGHT:
            case DATABASE_PC_MONSTROUS_RACE_VAMPIRE_SPAWN:
                nReturn=16;
            break;
            case DATABASE_PC_MONSTROUS_RACE_WEREWOLF:
            case DATABASE_PC_MONSTROUS_RACE_WERERAT:
                nReturn=17;
            break;
        }*/
    }
    else
    {
        nReturn=20-GetLocalInt(oSkin,DATABASE_PC_ECL_ADJUSTMENT);
    }
    return nReturn;
}


//The replacement for GiveXPToCreature. Adds nXP to the player oPC's XPbank instead of just handing out the XP.
void GiveToXPBank(object oPC, int nXP)
{
    if(!GetIsDM(oPC))
    {
        object oSkin=GetSkin(oPC);
        SetLocalInt(oSkin,DATABASE_PC_XP,GetLocalInt(oSkin,DATABASE_PC_XP)+nXP);
        //SendMessageToPC(oPC,IntToString(nXP)+" xp gained.");
        SendMessageToPC(oPC,"Experience gained.");
    }
}

void GiveToRPXPBank(object oPC, int nXP)
{
    if(!GetIsDM(oPC))
    {
        object oSkin=GetSkin(oPC);
        //SetLocalInt(oPC,"RPXPBank",GetLocalInt(oPC,"RPXPBank")+nXP);
        SetLocalInt(oSkin,DATABASE_PC_RPXP,GetLocalInt(oSkin,DATABASE_PC_RPXP)+nXP);
        //SendMessageToPC(oPC,IntToString(nXP)+" xp gained.");
        SendMessageToPC(oPC,"Experience gained.");
    }
}

void SetECLAdjustment(object oPC, int nAdjustment)
{
    object oSkin=GetSkin(oPC);
    SetLocalInt(oSkin,DATABASE_PC_ECL_ADJUSTMENT, nAdjustment);
}

int GetECLAdjustment(object oPC)
{
    object oSkin=GetSkin(oPC);
    return GetLocalInt(oSkin,DATABASE_PC_ECL_ADJUSTMENT);
}

void ReduceXP(object oPC, int nXPLoss)
{
    object oSkin=GetSkin(oPC);
    //Deduct regular XP gain.
    int nXPGain=GetLocalInt(oSkin,DATABASE_PC_XP);
    if(nXPLoss<nXPGain)
    {
        nXPGain-=nXPLoss;
        SetLocalInt(oSkin,DATABASE_PC_XP,nXPGain);
        return;
    }
    nXPLoss-=nXPGain;
    SetLocalInt(oSkin,DATABASE_PC_XP,0);
    //Deduct roleplay XP gain.
    int nRPXPGain=GetLocalInt(oSkin,DATABASE_PC_RPXP);
    if(nXPLoss<nRPXPGain)
    {
        nRPXPGain-=nXPLoss;
        SetLocalInt(oSkin,DATABASE_PC_RPXP,nRPXPGain);
        return;
    }
    nXPLoss-=nRPXPGain;
    SetLocalInt(oSkin,DATABASE_PC_RPXP,0);
    //Deduct banked XP.
    int nXPBank=GetLocalInt(oSkin,DATABASE_PC_XP_BANK);
    if(nXPLoss<nXPBank)
    {
        nXPBank-=nXPLoss;
        SetLocalInt(oSkin,DATABASE_PC_XP_BANK,nXPBank);
        return;
    }
    nXPLoss-=nXPBank;
    SetLocalInt(oSkin,DATABASE_PC_XP_BANK,0);

    int nLevels=GetHitDice(oPC);
    if(nLevels<3)
    {
        return;
    }

    nXPBank=0;
    while(nXPLoss>nXPBank)
    {
        nLevels--;
        nXPBank+=1000*(nLevels);
    }
    nXPBank-=nXPLoss;
    SetLocalInt(oSkin,DATABASE_PC_XP_BANK,nXPBank);
    SetLocalInt(oSkin,DATABASE_PC_LEVEL,nLevels);
    SetXP(oPC,fac(nLevels-1)*1000);
    ExportSingleCharacter(oPC);
}

//Stores the player oPC's current XP bank into the running database.
void StoreXPBank(object oPC)
{
    object oSkin=GetSkin(oPC);
    int nXPGain=GetLocalInt(oSkin,DATABASE_PC_XP);
    if(nXPGain<0)
    {
        nXPGain=0;
    }
    int nRPXPGain=GetLocalInt(oSkin,DATABASE_PC_RPXP);
    if(nRPXPGain<0)
    {
        nRPXPGain=0;
    }
    int nXPBankLastUpdate=GetLocalInt(oSkin,DATABASE_PC_XP_BUFFER_UPDATE_TIME);
    int nXPBankBufferSize=GetLocalInt(oSkin,DATABASE_PC_XP_BUFFER);
    if(nXPBankBufferSize<0)
    {
        nXPBankBufferSize=0;
    }
    //SendMessageToPC(oPC,"XP Bank last update: "+IntToString(nXPBankLastUpdate));
    string sFeedback="";
    int nFeedbackState=0;
    int nXPBank=GetLocalInt(oSkin,DATABASE_PC_XP_BANK);
    if(nXPBank<0)
    {
        nXPBank=0;
    }
    int nCurrentTime=TimeStamp();
    int nLevels=GetHitDice(oPC);
    int nECL=GetECLAdjustment(oPC);
    int nHourlyGain=4-(nLevels+nECL)/5;
    if(nHourlyGain<1)
    {
        nHourlyGain=1;
    }
    int nBufferIncrease=(nCurrentTime-nXPBankLastUpdate)*nHourlyGain;
    nXPBankBufferSize+=nBufferIncrease;
    if(nXPBankBufferSize>XP_SYSTEM_MAX_BUFFER_SIZE)
    {
        nXPBankBufferSize=XP_SYSTEM_MAX_BUFFER_SIZE;
    }
    else if(nXPBankBufferSize<XP_SYSTEM_MIN_BUFFER_SIZE)
    {
        nXPBankBufferSize=XP_SYSTEM_MIN_BUFFER_SIZE;
    }
    SetLocalInt(oSkin,DATABASE_PC_XP,0);
    SetLocalInt(oSkin,DATABASE_PC_RPXP,0);
    //SendMessageToPC(oPC,IntToString(nXPBank)+" xp gained.");
    //SendMessageToPC(oPC,IntToString(nRPXPBank)+" roleplay xp gained.");
    nXPGain+=nRPXPGain;
    float fXPBankBufferSize=IntToFloat(nXPBankBufferSize);
    float fXPGain=IntToFloat(nXPGain);
    float fXPSystemMaxBufferSize=IntToFloat(XP_SYSTEM_MAX_BUFFER_SIZE);
    if(fXPGain>0.0)
    {
        fXPGain=(fXPGain*fXPBankBufferSize)/(fXPGain+fXPSystemMaxBufferSize);
        float fXPBankBufferSizeLoss=fXPGain; //*pow(fXPBankBufferSize/fXPSystemMaxBufferSize,0.25);
        nXPBankBufferSize-=FloatToInt(fXPBankBufferSizeLoss);
        nXPGain=FloatToInt(fXPGain);
    }
    else
    {
        nXPGain=0;
    }
    //SendMessageToPC(oPC,IntToString(nXPBankBufferSize)+" xp buffer.");'
    SetLocalInt(oSkin,DATABASE_PC_XP_BUFFER,nXPBankBufferSize);
    SetLocalInt(oSkin,DATABASE_PC_XP_BUFFER_UPDATE_TIME,nCurrentTime);
    //SendMessageToPC(oPC,IntToString(nXPBankData+nXPBank)+" xp in bank.");
    nXPBank=nXPBank+nXPGain;
    SetLocalInt(oSkin,DATABASE_PC_XP_BANK,nXPBank);
    //Check for level up
    int nLevelCap=GetLevelCap(oPC);
    if(nLevels>=nLevelCap)
    {
        SetLocalInt(oSkin,DATABASE_PC_XP_BANK,0);
        SetLocalInt(oSkin,DATABASE_PC_XP_BUFFER,0);
        ExportSingleCharacter(oPC);
    }
    else if(nXPBank>=(nLevels+nECL)*1000)
    {
        SetXP(oPC,fac(nLevels)*1000);
        SetLocalInt(oSkin,DATABASE_PC_XP_BANK,nXPBank-(nLevels+nECL)*1000);
        SetLocalInt(oSkin,DATABASE_PC_LEVEL,nLevels+1);
        ExportSingleCharacter(oPC);
    }


    //Feedback - Time
    if(nCurrentTime-nXPBankLastUpdate<=1)
    {
        sFeedback="It has only been a short while since you last had a rest, ";
        nFeedbackState=-1;
    }
    else if(nCurrentTime-nXPBankLastUpdate<=5)
    {
        sFeedback="Only a few hours have passed since your last rest, ";
        nFeedbackState=0;
    }
    else if(nCurrentTime-nXPBankLastUpdate<=11)
    {
        sFeedback="Nearly half a day has passed since your last rest, ";
        nFeedbackState=1;
    }
    else if(nCurrentTime-nXPBankLastUpdate<=24)
    {
        sFeedback="Nearly a day has passed since you last had a rest, ";
        nFeedbackState=1;
    }
    else
    {
        sFeedback="It's been days since your last proper rest, ";
        nFeedbackState=1;
    }
    //Feedback - XP bank increase
    if(nFeedbackState==1)
    {
        if(nXPGain>FloatToInt(XP_SYSTEM_MODIFIER)*50)
        {
            sFeedback=sFeedback+"and you're proud of what challenges you've overcome since then. ";
            nFeedbackState=1;
        }
        else if(nXPGain>FloatToInt(XP_SYSTEM_MODIFIER)*15)
        {
            sFeedback=sFeedback+"and you're satisfied of what challenges have been overcome since then. ";
            nFeedbackState=1;
        }
        else if(nXPGain>FloatToInt(XP_SYSTEM_MODIFIER)*5)
        {
            sFeedback=sFeedback+"but the time since then hasn't exactly been stressful. ";
            nFeedbackState=0;
        }
        else
        {
            sFeedback=sFeedback+"yet close to nothing has happened between now and then. ";
            nFeedbackState=-1;
        }
    }
    else if(nFeedbackState==0)
    {
        if(nXPGain>FloatToInt(XP_SYSTEM_MODIFIER)*25)
        {
            sFeedback=sFeedback+"and you feel proud about what you have managed to do since then. ";
            nFeedbackState=1;
        }
        else if(nXPGain>FloatToInt(XP_SYSTEM_MODIFIER)*5)
        {
            sFeedback=sFeedback+"and, while not overly exhausted, you are satisfied by what you have accomplished in the meantime. ";
            nFeedbackState=1;
        }
        else if(nXPGain>FloatToInt(XP_SYSTEM_MODIFIER)*1)
        {
            sFeedback=sFeedback+"and though the time since then hasn't exactly been stressful, you haven't been entirely idle either. ";
            nFeedbackState=0;
        }
        else
        {
            sFeedback=sFeedback+"but close to nothing has happened between now and then. ";
            nFeedbackState=-1;
        }
    }
    else
    {
        if(nXPGain>FloatToInt(XP_SYSTEM_MODIFIER)*15)
        {
            sFeedback=sFeedback+"but you feel proud thinking of the challenges you've managed to overcome since then. ";
            nFeedbackState=1;
        }
        else if(nXPGain>FloatToInt(XP_SYSTEM_MODIFIER)*5)
        {
            sFeedback=sFeedback+"but you are quite satisfied by what you've accomplished in this short time. ";
            nFeedbackState=0;
        }
        else if(nXPGain>FloatToInt(XP_SYSTEM_MODIFIER)*1)
        {
            sFeedback=sFeedback+"and though the time hasn't been terribly stressful, you haven't been idle either. ";
            nFeedbackState=0;
        }
        else
        {
            sFeedback=sFeedback+"and close to nothing has happened between now and then. ";
            nFeedbackState=-1;
        }
    }

    //Feedback - XP to next level
    float fXPToLevelFactor=IntToFloat(nXPBank)/IntToFloat((nLevels+nECL)*1000);
    if(nFeedbackState=1)
    {
        if(fXPToLevelFactor>1.0)
        {
            sFeedback=sFeedback+"The struggles have not been unrewarding either - you finally feel as if you're in full control of all your abilities and ready to learn more. ";
            nFeedbackState=1;
        }
        else if(fXPToLevelFactor>0.75)
        {
            sFeedback=sFeedback+"You also notice that your actions are starting to feel routine as you perform them - what was once a daring challenge now seems almost pedestrian to do. Perhaps soon new dawns of enlightenment will show themselves to you. ";
            nFeedbackState=1;
        }
        else if(fXPToLevelFactor>0.5)
        {
            sFeedback=sFeedback+"With each hindrance you've overcome, each puzzle you've solved, each foe you've defeated, you thrive more and more in the path you have chosen. ";
            nFeedbackState=0;
        }
        else if(fXPToLevelFactor>0.25)
        {
            sFeedback=sFeedback+"You've also noticed that you're beginning to feel more comfortable with your new abilities and skills. Each time you've used them, you've taken yet another step towards mastering them. ";
            nFeedbackState=0;
        }
        else
        {
            sFeedback=sFeedback+"However, it was not long ago that you attained new levels of power and discovered new abilities. It will take some more time yet to fully bring them under your control. ";
            nFeedbackState=-1;
        }
    }
    else if(nFeedbackState=0)
    {
        if(fXPToLevelFactor>1.0)
        {
            sFeedback=sFeedback+"To your satisfaction, your work and training is finally paying off - you feel as if you're in full control of all your abilities and ready to learn something new. ";
            nFeedbackState=1;
        }
        else if(fXPToLevelFactor>0.75)
        {
            sFeedback=sFeedback+"You also notice that your actions are starting to feel routine as you perform them - what was once a daring challenge now seems almost pedestrian to do. Perhaps soon new dawns of enlightenment will show themselves to you? ";
            nFeedbackState=1;
        }
        else if(fXPToLevelFactor>0.5)
        {
            sFeedback=sFeedback+"With each hindrance you've overcome, each puzzle you've solved, each foe you've defeated, you come ever closer to thriving in your chosen path. ";
            nFeedbackState=0;
        }
        else if(fXPToLevelFactor>0.25)
        {
            sFeedback=sFeedback+"You're feeling more and more comfortable with your new abilities and skills. Each time you've used them, you've taken yet another step towards mastering them. ";
            nFeedbackState=0;
        }
        else
        {
            sFeedback=sFeedback+"It was not long ago, however, that you attained new levels of power and discovered new abilities. It will take some more time to fully bring them under your control. ";
            nFeedbackState=-1;
        }
    }
    else if(nFeedbackState=-1)
    {
        if(fXPToLevelFactor>1.0)
        {
            sFeedback=sFeedback+"Somewhat to your surprise, it seems that your work and training is finally paying off - you feel as if you're in full control of all your abilities and ready to learn something new. ";
            nFeedbackState=1;
        }
        else if(fXPToLevelFactor>0.75)
        {
            sFeedback=sFeedback+"The small amount of activity, however, does not detract from your feeling that you've progressed far in your path and will soon be ready to learn even more.";
            nFeedbackState=1;
        }
        else if(fXPToLevelFactor>0.5)
        {
            sFeedback=sFeedback+"Nevertheless, you thrive on your chosen path and worry little about stagnation. ";
            nFeedbackState=0;
        }
        else if(fXPToLevelFactor>0.25)
        {
            sFeedback=sFeedback+"This is displeasing, since you've yet to master your newest powers and have quite a road ahead of you. ";
            nFeedbackState=0;
        }
        else
        {
            sFeedback=sFeedback+"This is hardly satisfying, since it was not long ago that you attained new levels of power and discovered new abilities. You will need to put them to the test to fully bring them under your control. Being idle will lead you nowhere. ";
            nFeedbackState=-1;
        }
    }

    //Feedback - XP buffer size
    if(nFeedbackState=1)
    {
        if(nXPBankBufferSize>9000)
        {
            sFeedback=sFeedback+"You regret that you haven't faced many true challenges lately and you feel as if you've been neglecting your path. You have a strong desire to seek new adventures and paths of enlightenment.";
        }
        else if(nXPBankBufferSize>5000)
        {
            sFeedback=sFeedback+"And you feel fresh enough in your mind to take in more. Whatever the Mist throws at you, you're certain you'll be able to use it to your advantage.";
        }
        else if(nXPBankBufferSize>2500)
        {
            sFeedback=sFeedback+"Regardless, you cannot help but think that it shouldn't have taken this long to absorb what you have from your experiences.  Something is holding you back and you get the sense it may be your own blind drive. Perhaps you need to slow down a bit and get a better perspective on your actions as you perform them.";
        }
        else
        {
            sFeedback=sFeedback+"Still, you cannot help but feel that you've been going in circles, futilely pushing yourself further before you've had sufficient time to consider what has passed.  Hitting the proverbial wall is a bitter tonic to swallow, but the mental and spiritual exhaustion you feel is clear evidence you need real rest from this routine, if you want to truly learn more.";
        }
    }
    else if(nFeedbackState=0)
    {
        if(nXPBankBufferSize>9000)
        {
            sFeedback=sFeedback+"You still feel the strong urge to learn more, to seek adventure … to accomplish something grander. And soon. Wherever your journey through the Mist should take you, you are certain that it is far from over and that there is much yet to be seen. You long to see it.";
        }
        else if(nXPBankBufferSize>5000)
        {
            sFeedback=sFeedback+"Your mind feels fresh enough to take in more. Your pursuit of knowledge and power seems to be steadily moving forward.  Whatever the Mist throws at you, you're certain you'll be able to use it to your advantage.";
        }
        else if(nXPBankBufferSize>2500)
        {
            sFeedback=sFeedback+"However, you get to ponder why your progress is starting to somewhat stall. It shouldn't have taken this long to absorb what you have from your experiences.  Something is holding you back and you get the sense it may be your own blind drive. Perhaps you need to slow down and get a better perspective on your actions as you perform them.";
        }
        else
        {
            sFeedback=sFeedback+"Still, on a personal level, you inevitably feel as though you're simply going in circles.  The mental and spiritual exhaustion you feel is clear evidence that you need real rest from this routine, if you want to truly learn more.";
        }
    }
    else
    {
        if(nXPBankBufferSize>9000)
        {
            sFeedback=sFeedback+"You cannot help being a bit dissatisfied with yourself, having recently discovered all these new talents you possess without truly exploring them. You know that there might be many dangers ahead, but deep within your heart, you actually long to face them.";
        }
        else if(nXPBankBufferSize>5000)
        {
            sFeedback=sFeedback+"You long to understand these newest revelations better -- the blood of an adventurer still flows steadily through your veins. Whatever the Mist throws at you, you're certain you'll be able to use it to your advantage.";
        }
        else if(nXPBankBufferSize>2500)
        {
            sFeedback=sFeedback+"Nevertheless, you feel as if you need to slow down a bit or you could easily end up pushing yourself too hard and to no avail.";
        }
        else
        {
            sFeedback=sFeedback+"Regardless, you feel as if you should suspend your adventuring for the time being or else you might endanger yourself due to mental and physical exhaustion.";
        }
    }
    SendMessageToPC(oPC,sFeedback);

}


//Restores the player oPC's current XP bank from the running database.  -obsolete
/*void RestoreXPBank(object oPC)
{
    SetLocalInt(oPC,"XPBank",PCDataReadInt(oPC,DATABASE_PC_XPBANK_START,DATABASE_PC_XPBANK_COUNT));
}*/

//Checks to see if the player oPC has enough XP in it's bank to level up, and gives the appropriate XP if so.
/*void CheckForLevelUp(object oPC)
{
    StoreXPBank(oPC);
    object oSkin=GetSkin(oPC);
    //int nXP=PCDataReadInt(oPC,DATABASE_PC_XPBANK_START,DATABASE_PC_XPBANK_COUNT);
    int nXP=GetLocalInt(oSkin,DATABASE_PC_XP_BANK);
    int nLevels=GetHitDice(oPC);
    if(nXP>=nLevels*1000)
    {
        //GiveXPToCreature(oPC,nLevels*1000);
        SetXP(oPC,fac(nLevels)*1000);
        ExportSingleCharacter(oPC);
        //PCDataWriteInt(oPC,nXP-nLevels*1000,DATABASE_PC_XPBANK_START,DATABASE_PC_XPBANK_COUNT);
        SetLocalInt(oSkin,DATABASE_PC_XP_BANK,nXP-nLevels*1000);
        SetLocalInt(oSkin,DATABASE_PC_LEVEL,nLevels+1);
    }
}*/

//Used on the OnDeath event of a monster. Gives XP awards to all nearby players.
void AwardKillers()
{
    object oKiller=GetLastKiller();
    if(GetObjectType(oKiller)==OBJECT_TYPE_TRIGGER)
    {
        oKiller=GetTrapCreator(oKiller);
    }
    object oMaster=GetMaster(oKiller);
    if((GetIsPC(oKiller)&&!GetIsDM(oKiller))||(GetIsPC(oMaster)&&!GetIsDM(oMaster)))
    {
        float fCR=GetChallengeRating(OBJECT_SELF);
        vector vSelf=GetPosition(OBJECT_SELF);
        vector vKiller=GetPosition(oKiller);
        vector vTarget=Vector((vSelf.x+vKiller.x)/2.0,(vSelf.y+vKiller.y)/2.0,0.0);
        location lTarget=Location(GetArea(OBJECT_SELF),vTarget,0.0);
        object oTemp=GetFirstObjectInShape(SHAPE_CUBE,XP_SYSTEM_RANGE,lTarget,FALSE,OBJECT_TYPE_CREATURE);
        int nPCLevelMax=GetHitDice(oKiller)+GetECLAdjustment(oKiller);
        int nCount=1;
        int nPCLevelTotal=GetHitDice(oKiller)+GetECLAdjustment(oKiller);
        int nTemp=nPCLevelTotal;
        //Make sure the killer is rewarded.
        if(GetIsPC(GetMaster(oKiller))&&(!GetIsEnemy(OBJECT_SELF,GetMaster(oKiller))||(!GetObjectSeen(OBJECT_SELF,GetMaster(oKiller))&&!GetObjectHeard(OBJECT_SELF,GetMaster(oKiller)))))
        {
            DelayCommand(0.0,GiveToXPBank(GetMaster(oKiller),FloatToInt(GetLocalFloat(OBJECT_SELF,"XPReward")*GetLocalFloat(OBJECT_SELF,"AverageLevel")/IntToFloat(nTemp))));
        }
        else
        {
            DelayCommand(0.0,GiveToXPBank(oKiller,FloatToInt(GetLocalFloat(OBJECT_SELF,"XPReward")*GetLocalFloat(OBJECT_SELF,"AverageLevel")/IntToFloat(nTemp))));
        }
        //Reward all nearby who've overseen the kill and who is hostile to the killed.
        while(oTemp!=OBJECT_INVALID)
        {
            if(((GetIsPC(oTemp)&&!GetIsDM(oTemp))
                ||(GetIsPC(GetMaster(oTemp))&&!GetIsDM(GetMaster(oTemp))))
                &&(GetObjectSeen(OBJECT_SELF,oTemp)||GetObjectHeard(OBJECT_SELF,oTemp))
                &&GetIsEnemy(OBJECT_SELF,oTemp)&&oTemp!=oKiller)
            {
                if(GetDeathState(oTemp)!=nSpirit)
                {
                    //Finds the highest level of the players in range.
                    nTemp=GetHitDice(oTemp)+GetECLAdjustment(oTemp);
                    if(nTemp>nPCLevelMax)
                    {
                        nPCLevelMax=nTemp;
                    }
                    nPCLevelTotal+=nTemp;
                    //Makes sure that each player will get the award when the script is done and the calculation is done.
                    if(GetIsPC(GetMaster(oTemp))&&GetMaster(oTemp)!=oKiller&&(!GetIsEnemy(OBJECT_SELF,GetMaster(oTemp))||(!GetObjectSeen(OBJECT_SELF,GetMaster(oTemp))&&!GetObjectHeard(OBJECT_SELF,GetMaster(oTemp)))))
                    {
                        DelayCommand(0.0,GiveToXPBank(GetMaster(oTemp),FloatToInt(GetLocalFloat(OBJECT_SELF,"XPReward")*GetLocalFloat(OBJECT_SELF,"AverageLevel")/IntToFloat(nTemp))));
                    }
                    else
                    {
                        DelayCommand(0.0,GiveToXPBank(oTemp,FloatToInt(GetLocalFloat(OBJECT_SELF,"XPReward")*GetLocalFloat(OBJECT_SELF,"AverageLevel")/IntToFloat(nTemp))));
                    }
                    //AssignCommand(oTemp,SpeakString("XP gained"));

                    nCount++;
                }
            }
            oTemp=GetNextObjectInShape(SHAPE_CUBE,XP_SYSTEM_RANGE,lTarget,FALSE,OBJECT_TYPE_CREATURE);
        }
        //If less than the party size minimum is present, then use that number instead when calculating.
        if(nCount<XP_SYSTEM_PARTYSIZE_MIN)
        {
            //nPCLevelTotal+=nPCLevelMax*(XP_SYSTEM_PARTYSIZE_MIN-nCount);
            nCount=XP_SYSTEM_PARTYSIZE_MIN;
        }
        //Find the challenge this creature should be to these opponents and calculate how much it should reward each.
        //float fStrength=IntToFloat(nPCLevelTotal)/IntToFloat(nCount);
        float fStrength=IntToFloat(nPCLevelMax);

        if(fStrength!=0.0)
        {
            float fRelativity=(fCR+XP_SYSTEM_CR_MODIFIER)/fStrength;
            float fDifference=(fCR+XP_SYSTEM_CR_MODIFIER)-fStrength;
            /*if(fDifference<0.0)
            {
                fDifference=-fDifference;
            }*/
            if(fDifference>XP_SYSTEM_MAX_CR_DIFFERENCE)
            {
                fDifference=XP_SYSTEM_MAX_CR_DIFFERENCE;
            }
            float fXPReward=0.5
                            +pow(fRelativity,XP_SYSTEM_EXPONENTIAL_MODIFIER)
                            *pow(XP_SYSTEM_EXPONENTIAL_MODIFIER,fDifference)
                            *XP_SYSTEM_MODIFIER*(IntToFloat(XP_SYSTEM_PARTYSIZE_MIN)/IntToFloat(nCount));
            //Sends out the result to be used by the commmand that was initialized earlier to run at end of script.
            SetLocalFloat(OBJECT_SELF,"XPReward",fXPReward);
            SetLocalFloat(OBJECT_SELF,"AverageLevel",fStrength);
            //SpeakString("XP given");
        }
    }
}

void AwardIfUnnoticed(object oTarget, object oObserver, int nXP)
{
    if(!GetObjectSeen(oTarget,oObserver)&&!GetObjectHeard(oTarget,oObserver)&&!GetIsDead(oObserver)&&GetIsObjectValid(oTarget)&&GetArea(oTarget)==GetArea(oObserver))
    {
        int nListenDifference=GetSkillRank(SKILL_LISTEN,oObserver)-GetSkillRank(SKILL_MOVE_SILENTLY,oTarget);
        if(nListenDifference<1)
        {
            nListenDifference=1;
        }
        int nSpotDifference=GetSkillRank(SKILL_SPOT,oObserver)-GetSkillRank(SKILL_HIDE,oTarget);
        if(nSpotDifference<1)
        {
            nSpotDifference=1;
        }
        float fCR=GetChallengeRating(oObserver);
        float fStrength=IntToFloat(GetHitDice(oTarget));
        if(fStrength!=0.0)
        {
            float fRelativity=(fCR+XP_SYSTEM_CR_MODIFIER)/fStrength;
            float fDifference=(fCR+XP_SYSTEM_CR_MODIFIER)-fStrength;
            /*if(fDifference<0.0)
            {
                fDifference=-fDifference;
            }*/
            if(fDifference>XP_SYSTEM_MAX_CR_DIFFERENCE)
            {
                fDifference=XP_SYSTEM_MAX_CR_DIFFERENCE;
            }
            int nXPReward=FloatToInt(0.5
                                    +pow(fRelativity,XP_SYSTEM_EXPONENTIAL_MODIFIER)
                                    *pow(XP_SYSTEM_EXPONENTIAL_MODIFIER,fDifference)
                                    *IntToFloat(nXP*((nListenDifference*nSpotDifference)))/40.0);
            if(nXPReward>0)
            {
                GiveToXPBank(oTarget,nXPReward);
            }
            //AssignCommand(oObserver,SpeakString(IntToString(nXPReward)+" xp given"));
        }
    }
}


