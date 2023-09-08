#include "nw_i0_plot"
void main()
{
    object oPC = GetPCSpeaker();
    object oHarp = GetNearestObjectByTag("tn_harpplc");
    object oSky = GetNearestObjectByTag("tn_sky_hand");
    object oWaypoint = GetNearestObjectByTag("tn_elioraspot");
    if (GetPLocalInt(oPC, "Tuned") == 0)
    {
        FloatingTextStringOnCreature("Playing the harp out of tune causes the house to snatch you up!", oPC, TRUE);
        ExecuteScript("tn_bad_harp", oPC);
    }
    else
    {   if (GetObjectByTag("tn_elioraghost") != OBJECT_INVALID)
        {
            FloatingTextStringOnCreature("Playing the harp further has no effect!", oPC, TRUE);
        }
        else
        {
            FloatingTextStringOnCreature("The Ghost of Eliora has appeared nearby!", oPC, TRUE);
            CreateObject(OBJECT_TYPE_CREATURE, "tn_elioraghost", GetLocation(oWaypoint));
        }
    }
}
