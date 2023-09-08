void main()
{
object oTarget = GetExitingObject();
effect eSearch = GetFirstEffect(oTarget);
while ( GetIsEffectValid(eSearch) )
{
    if (GetName(GetEffectCreator(eSearch)) == "ceb_shrinetemple")
    {
        if (GetEffectType(eSearch) != EFFECT_TYPE_TURNED)
        {
            if (GetEffectType(eSearch) != EFFECT_TYPE_VISUALEFFECT)
            {
                RemoveEffect(oTarget, eSearch);
            }
        }
     }
    eSearch = GetNextEffect(oTarget);
}
}
