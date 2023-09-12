int StartingConditional()
{
if (GetLocalInt(GetItemPossessedBy(GetPCSpeaker(),"PC_Data_Object"),"BCWWG06") > 5){return TRUE;} else {return FALSE;}
}
