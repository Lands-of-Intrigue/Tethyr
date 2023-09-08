int StartingConditional()
{
if (GetLocalInt(GetItemPossessedBy(GetPCSpeaker(),"PC_Data_Object"),"BCNTRO") > 5){return TRUE;} else {return FALSE;}
}
