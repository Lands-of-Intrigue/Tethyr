#include "nw_i0_2q4luskan"
void CallOfTheDead()
{
    object oBoss = GetObjectByTag("te_npc_2001");
    effect eDirt = EffectVisualEffect(137);
    if (oBoss != OBJECT_INVALID)
    {
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDirt, GetLocation(GetNearestObjectByTag("tn_dw_boss_sp", OBJECT_SELF, 1)));
        DelayCommand(2.5, CreateObjectVoid(OBJECT_TYPE_CREATURE, "tn_boss_zombie", GetLocation(GetNearestObjectByTag("tn_dw_boss_sp", OBJECT_SELF, 1)), FALSE));
        if (GetLocalInt(OBJECT_SELF, "Burned") == 0)
        {
            DelayCommand(30.0+Random(61),CallOfTheDead());
        }
        else
        {
            DelayCommand(60.0+Random(61),CallOfTheDead());
        }
    }
    else{return;}
}
void main(){CallOfTheDead();}
