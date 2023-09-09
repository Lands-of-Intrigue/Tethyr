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
    if(GetTag(OBJECT_SELF) == "te_npc_2207")
    {
        SpeakString("Looks like meat's back on the menu, boys!",TALKVOLUME_TALK);
    }

    ExecuteScript("nw_c2_default2", OBJECT_SELF);
}
