//::///////////////////////////////////////////////
//:: Garbage collection PC Objects
//:: mil_g_pcobjects.nss
//:: Copyright (c) 2003 Jake E. Fitch
//:://////////////////////////////////////////////
/*
    Removes the PC objects from the speaker.
*/
//:://////////////////////////////////////////////
//:: Created By: Jake E. Fitch (Milambus Mandragon)
//:: Created On: Nov. 27, 2003
//:://////////////////////////////////////////////

void main()
{
    DeleteLocalObject(GetLastSpeaker(), "mil_PC9010");
    DeleteLocalObject(GetLastSpeaker(), "mil_PC9011");
    DeleteLocalObject(GetLastSpeaker(), "mil_PC9012");
    DeleteLocalObject(GetLastSpeaker(), "mil_PC9013");
    DeleteLocalObject(GetLastSpeaker(), "mil_PC9014");
}
