//:: [Shadow Fiend On Death]
//:: [tn_od_shad3.nss]
//:://////////////////////////////////////////////
//:: On Death If Shadow Fiend is in the EXACT AREA
//:: "Old Shanaar - Forgotten Temple: Interior"
//:: Set artifact to be damageable again
//:: Run the standard death script
//:://////////////////////////////////////////////
//:: Created By: Tsurani.Nevericy
//:: Created On: 1/31/2018
//:: Created For: Knights of Noromath
//:://////////////////////////////////////////////
void main()
{
    if (GetTag(GetArea(OBJECT_SELF)) == "te_temple_interior"){
    SetPlotFlag(GetObjectByTag("tn_artifact"), FALSE);}
    ExecuteScript("nw_ch_ac7", OBJECT_SELF);
}
