#include "x0_i0_spawncond"
void main()
{
    object oCreature = OBJECT_SELF;
    SetListeningPatterns();

    int nVfxNum = GetLocalInt(oCreature, "VFX_NUM");
    if (nVfxNum) {
        effect eVfx = EffectVisualEffect(nVfxNum);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVfx, oCreature);
    }

    if (GetLocalInt(oCreature, "ANIMATE_IN")) {
        SetSpawnInCondition(NW_FLAG_APPEAR_SPAWN_IN_ANIMATION);
    }

    int nCreatureScale = GetLocalInt(oCreature, "SCALE");
    if (nCreatureScale) {
        SetObjectVisualTransform(oCreature, OBJECT_VISUAL_TRANSFORM_SCALE, nCreatureScale*0.01);
    }
}

