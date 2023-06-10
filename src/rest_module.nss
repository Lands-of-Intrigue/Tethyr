//::///////////////////////////////////////////////
//:: rest_module
//:://////////////////////////////////////////////
/*
    MAGUS REST SYSTEM - MODULE EVENT

    Player Rests

*/
//:://////////////////////////////////////////////
//:: Creator   : The Magus (2013 july 13)
//:: Modified  :
//:://////////////////////////////////////////////

// INCLUDES
#include "rest_include"
#include "food_include"

// MAIN ------------------------------------------------------------------------

void main()
{
    switch(GetLastRestEventType())
    {
        case REST_EVENTTYPE_REST_STARTED:
            AssignCommand(GetLastPCRested(), RestStarted());
        break;
        case REST_EVENTTYPE_REST_CANCELLED:
            AssignCommand(GetLastPCRested(), RestCanceled());
        break;
        case REST_EVENTTYPE_REST_FINISHED:
           AssignCommand(GetLastPCRested(), RestFinished());
        break;
        case REST_EVENTTYPE_REST_INVALID:
            AssignCommand(GetLastPCRested(), RestCanceled());
        break;
    }
}
