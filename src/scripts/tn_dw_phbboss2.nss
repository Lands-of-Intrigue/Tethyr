void FeastofDeath()
{
    object oBoss = OBJECT_SELF;
    effect eHeal1 = EffectTemporaryHitpoints(25);
    effect eHeal2 = EffectTemporaryHitpoints(5);
    effect eVis2 = EffectVisualEffect(VFX_IMP_HOLY_AID);
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 10.0f, GetLocation(OBJECT_SELF));
    effect eVis = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
    if (oBoss != OBJECT_INVALID || GetIsDead(oBoss) == FALSE)
    {
     while (GetIsObjectValid(oTarget))
        {
            if(GetIsPC(oTarget) == FALSE && GetTag(oTarget) != "te_npc_2001" && GetTag(oTarget) != "tn_dw_miniboss")
            {

                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                DelayCommand(1.0, DestroyObject(oTarget));
                if (GetLocalInt(OBJECT_SELF, "Weakened") == 1)
                {
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eHeal2, OBJECT_SELF);
                }
                else
                {
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eHeal1, OBJECT_SELF);
                }
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, OBJECT_SELF);
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, 10.0f, GetLocation(OBJECT_SELF));
        }
            DelayCommand(8.0+Random(3),FeastofDeath());

    }
    else{return;}
}
void main(){FeastofDeath();}
