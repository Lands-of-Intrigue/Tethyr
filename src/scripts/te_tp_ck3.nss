int StartingConditional()
{
if (GetLocalInt(GetItemPossessedBy(GetPCSpeaker(),"PC_Data_Object"),"BCTPHR4_mcs001") > 5){return TRUE;} else {return FALSE;}
}
