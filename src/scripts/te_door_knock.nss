void main()
{
    object oDoor = OBJECT_SELF;
    object oOther = GetTransitionTarget(oDoor);

    if(oOther == OBJECT_INVALID)
    {
        SpeakString("KNOCK KNOCK!",TALKVOLUME_TALK);
    }
    else
    {
        AssignCommand(oOther,ClearAllActions());
        AssignCommand(oOther,SpeakString("KNOCK KNOCK!",TALKVOLUME_TALK));
    }
}
