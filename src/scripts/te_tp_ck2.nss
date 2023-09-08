int StartingConditional()
{
if (GetLocalInt(GetItemPossessedBy(GetPCSpeaker(),"PC_Data_Object"),"BCTPGLK") > 5){return TRUE;} else {return FALSE;}
}
