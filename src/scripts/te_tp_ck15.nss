int StartingConditional()
{
if (GetLocalInt(GetItemPossessedBy(GetPCSpeaker(),"PC_Data_Object"),"BCTR2") > 5){return TRUE;} else {return FALSE;}
}
