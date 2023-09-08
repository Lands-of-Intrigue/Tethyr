void main()
{
    object oActivator=GetPCSpeaker();
    object oTarget=OBJECT_SELF;
    AssignCommand(oActivator,ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0,2.0));
    AssignCommand(oActivator,ActionDoCommand(DestroyObject(oTarget)));
}
