int StartingConditional()
{
if (GetLocalInt(GetItemPossessedBy(GetPCSpeaker(),"PC_Data_Object"),"BCESM3") > 5){return TRUE;} else {return FALSE;}
}
