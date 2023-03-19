#include "so_inc_tradeskil"

void main()
{
    object oActivator=GetPCSpeaker();
    object oTarget=OBJECT_SELF;
    AssignCommand(oActivator,ActionPauseConversation());
    AssignCommand(oActivator,ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0,1.0));
    AssignCommand(oActivator,ActionDoCommand(AssignCommand(oTarget,FeedCampfire(oTarget))));
    AssignCommand(oActivator,ActionResumeConversation());
}
