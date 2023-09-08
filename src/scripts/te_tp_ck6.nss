int StartingConditional()
{
if (GetLocalInt(GetItemPossessedBy(GetPCSpeaker(),"PC_Data_Object"),"BCSTF6") > 5){return TRUE;} else {return FALSE;}
}
