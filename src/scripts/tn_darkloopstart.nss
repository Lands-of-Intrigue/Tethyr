//:: [Start Dark Loop]
//:: [tn_darkloopstart.nss]
//:://////////////////////////////////////////////
//:: If the trigger is active set it inactive
//:: (THIS IS TO STOP MULTIPLE HEARTBEATS)
//:: Start Heartbeat on Artifact
//:://////////////////////////////////////////////
//:: Created By: Tsurani.Nevericy
//:: Created On: 1/30/2018
//:: Created For: Knights of Noromath
//:://////////////////////////////////////////////

void main(){

    object oArtifact = GetNearestObjectByTag("tn_artifact", OBJECT_SELF);
    //ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectImmunity(IMMUNITY_TYPE_CRITICAL_HIT), oArtifact); - Didn't work, but I tried xD
    if (oArtifact != OBJECT_INVALID || GetIsDead(OBJECT_SELF))
    {
        if (GetLocalInt(OBJECT_SELF, "Active") ==  1)
        {
            ExecuteScript("tn_darkloop", oArtifact);
            SetLocalInt(OBJECT_SELF, "Active", 0);
        }
        else {return;}
    }
}
