int StartingConditional()
{
if (GetLocalInt(GetItemPossessedBy(GetPCSpeaker(),"PC_Data_Object"),"BCTR4") > 5){return TRUE;} else {return FALSE;}
}
