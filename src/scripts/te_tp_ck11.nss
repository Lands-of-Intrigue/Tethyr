int StartingConditional()
{
if (GetLocalInt(GetItemPossessedBy(GetPCSpeaker(),"PC_Data_Object"),"BCBSW") > 5){return TRUE;} else {return FALSE;}
}
