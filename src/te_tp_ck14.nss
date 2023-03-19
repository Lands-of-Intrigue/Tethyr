int StartingConditional()
{
if (GetLocalInt(GetItemPossessedBy(GetPCSpeaker(),"PC_Data_Object"),"BCTT002") > 5){return TRUE;} else {return FALSE;}
}
