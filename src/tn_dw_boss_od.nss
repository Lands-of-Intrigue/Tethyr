#include "loi_functions"
void main()
{
    ActionOpenDoor(GetObjectByTag("tn_dw_bossdoor", 1));
    CreateObject(OBJECT_TYPE_CREATURE,"tn_dw_miniboss",GetWaypointLocation("WP_DuskwoodMiniBoss"),TRUE);
    SpeakString("Noooo! Eliora!!!");
    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}

