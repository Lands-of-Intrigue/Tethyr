//::///////////////////////////////////////////////
//:: Name x2_def_percept
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default On Perception script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

void main()
{
    object oPercep = GetLastPerceived();

    if(GetIsPC(oPercep) && GetHitDice(oPercep) < 4)
    {
        string QuestSpeak = GetLocalString(OBJECT_SELF,"QuestSpeak");
        SpeakString(QuestSpeak,TALKVOLUME_TALK);
    }

    ExecuteScript("nw_c2_default2", OBJECT_SELF);

}
