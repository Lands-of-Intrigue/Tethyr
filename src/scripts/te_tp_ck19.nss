int StartingConditional()
{
if (GetLocalInt(GetItemPossessedBy(GetPCSpeaker(),"PC_Data_Object"),"BCTR7") > 5){return TRUE;} else {return FALSE;}
}
