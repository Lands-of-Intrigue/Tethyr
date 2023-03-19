#include "so_inc_flags"
#include "so_inc_general"
#include "so_inc_death"
#include "x0_i0_behavior"
#include "x0_i0_assoc"

location GetRandomFlankLocation(object oTarget, float fDist)
{
    vector vSelf=GetPosition(OBJECT_SELF);
    vector vFleeFrom=GetPosition(oTarget);
    float fAngle=VectorToAngle(vSelf-vFleeFrom);
    if(d2()==2)
    {
        fAngle=fAngle-135.0;
    }
    else
    {
        fAngle=fAngle+135.0;
    }
    vector vTargeter=AngleToVector(fAngle);
    vTargeter=VectorNormalize(vTargeter);
    vTargeter=fDist*vTargeter;
    vector vTarget=vSelf+vTargeter;
    return Location(GetArea(OBJECT_SELF),vTarget,GetFacing(OBJECT_SELF));
}

void ActionFlankIfStuck(object oTarget, vector vOld)
{
    vector vSelf=GetPosition(OBJECT_SELF);
    vector vDiff=vSelf-vOld;
    if(VectorMagnitude(vDiff)<2.0)
    {
        ClearAllActions();
        //SpeakString("Flanking");
        ActionMoveToLocation(GetRandomFlankLocation(oTarget,30.0),TRUE);
        ActionMoveAwayFromObject(oTarget,TRUE,40.0);
    }
}

location GetRandomFleeLocation(object oTarget, float fDist)
{
    vector vSelf=GetPosition(OBJECT_SELF);
    vector vFleeFrom=GetPosition(oTarget);
    float fAngle=VectorToAngle(vSelf-vFleeFrom);
    fAngle=fAngle-60.0+IntToFloat(Random(121));
    vector vTargeter=AngleToVector(fAngle);
    vTargeter=VectorNormalize(vTargeter);
    vTargeter=fDist*vTargeter;
    vector vTarget=vSelf+vTargeter;
    return Location(GetArea(OBJECT_SELF),vTarget,GetFacing(OBJECT_SELF));
}

void ActionPanic(object oTarget)
{
    if(GetActionMode(OBJECT_SELF,ACTION_MODE_DETECT))
    {
        SetActionMode(OBJECT_SELF,ACTION_MODE_DETECT,FALSE);
    }
    if(GetLocalInt(OBJECT_SELF,"ALERT_STATE")<10||GetCurrentAction()!=ACTION_MOVETOPOINT)
    {
        ClearAllActions();
    }
    SetLocalInt(OBJECT_SELF,"ALERT_STATE",10);
    //SpeakString("Fleeing");
    ActionMoveToLocation(GetRandomFleeLocation(oTarget,20.0),TRUE);
    ActionMoveAwayFromObject(oTarget,TRUE,40.0);
    vector vPos=GetPosition(OBJECT_SELF);
    DelayCommand(3.0,ActionFlankIfStuck(oTarget,vPos));
}


int GetAlertState(object oCreature)
{
    if(GetLocalInt(oCreature,AI_ALWAYS_ALERT))
    {
        return 10;
    }
    return GetLocalInt(oCreature, AI_ALERT_STATE);
}

void SetAIType(object oCreature,int nAIType)
{
    SetLocalInt(oCreature,AI_TYPE,nAIType);
}

int GetAIType(object oCreature)
{
    return GetLocalInt(oCreature,AI_TYPE);
}


void SummonGuardReinforcements()
{

    if(GetIsDay())
    {
        object oTemp;
        int nCount=1;
        object oEntry;
        while(nCount>0)
        {
            oTemp=GetNearestObject(OBJECT_TYPE_DOOR|OBJECT_TYPE_TRIGGER,OBJECT_SELF,nCount);
            if(oTemp==OBJECT_INVALID)
            {
                return;
            }
            object oTarget=GetTransitionTarget(oTemp);
            if(oTarget!=OBJECT_INVALID&&!GetIsAreaInterior(GetArea(oTarget)))
            {
                nCount=-1;
            }
            else
            {
                nCount++;
            }
        }
        nCount=d4();
        object oReinforcement;
        while(nCount>0)
        {
            oReinforcement=CreateObject(OBJECT_TYPE_CREATURE,GetResRef(OBJECT_SELF),GetLocationBehind(oTemp));
            SetLocalInt(oReinforcement,"GUARD_REINFORCEMENT",1);
            nCount--;
        }
    }
}

void SummonGuards(object oTarget)
{
    object oSelf=OBJECT_SELF;
    object oTemp=GetLocalObject(GetArea(OBJECT_SELF),"GUARD_1");
    int nCount=1;
    while(oTemp!=OBJECT_INVALID)
    {
        if(!GetIsInCombat(oTemp)&&!GetIsObjectValid(GetAttackTarget(oTemp))&&oTemp!=oSelf)
        {
            if(GetArea(oTemp)==GetArea(OBJECT_SELF))
            {
                AssignCommand(oTemp,ClearAllActions());
                AssignCommand(oTemp,ActionMoveToLocation(GetLocation(oTarget),TRUE));
                SetIsTemporaryEnemy(oTarget,oTemp,TRUE);
            }
        }
        nCount++;
        oTemp=GetLocalObject(GetArea(OBJECT_SELF),"GUARD_"+IntToString(nCount));
    }
}

int GetIsBusy(object oCreature=OBJECT_SELF)
{
    object oAttackTarget = GetAttackTarget(oCreature);
    if(GetIsObjectValid(oAttackTarget))
    {
        return TRUE;
    }
    int nAction=GetCurrentAction(oCreature);
    switch(nAction)
    {
        case ACTION_ATTACKOBJECT:
        case ACTION_CASTSPELL:
        case ACTION_COUNTERSPELL:
        case ACTION_HEAL:
        case ACTION_ITEMCASTSPELL:
        case ACTION_KIDAMAGE:
        case ACTION_SMITEGOOD:
        case ACTION_TAUNT:
        case ACTION_USEOBJECT:
        case ACTION_SETTRAP:
        case ACTION_PICKUPITEM:
        case ACTION_PICKPOCKET:
        case ACTION_OPENLOCK:
        case ACTION_OPENDOOR:
        case ACTION_LOCK:
        case ACTION_DROPITEM:
        {
            return TRUE;
        }
        break;
    }
    return FALSE;
}

void ClearActionsIfNotBusy(object oCreature=OBJECT_SELF)
{
    if(!GetIsBusy(oCreature)&&GetCurrentAction(oCreature)!=ACTION_INVALID)
    {
        AssignCommand(oCreature,ClearAllActions());
    }
}

int GetIsTargetRelevant(object oTarget)
{
    if(GetIsObjectValid(oTarget) && GetArea(oTarget) == GetArea(OBJECT_SELF) && GetDeathState(oTarget)== nWell
        && !GetAssociateState(NW_ASC_MODE_DYING, oTarget) && !GetIsDead(oTarget))
    {
        return TRUE;
    }
    return FALSE;
}


