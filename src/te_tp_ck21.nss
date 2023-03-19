int StartingConditional()
{
if (GetLocalInt(GetItemPossessedBy(GetPCSpeaker(),"PC_Data_Object"),"BCESMPK2") > 5){return TRUE;} else {return FALSE;}
}
