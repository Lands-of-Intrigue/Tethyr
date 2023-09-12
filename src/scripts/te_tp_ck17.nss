int StartingConditional()
{
if (GetLocalInt(GetItemPossessedBy(GetPCSpeaker(),"PC_Data_Object"),"BCTR10") > 5){return TRUE;} else {return FALSE;}
}
