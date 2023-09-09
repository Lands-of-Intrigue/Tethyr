int StartingConditional()
{
if (GetLocalInt(GetItemPossessedBy(GetPCSpeaker(),"PC_Data_Object"),"BCNTRST1") > 5){return TRUE;} else {return FALSE;}
}
