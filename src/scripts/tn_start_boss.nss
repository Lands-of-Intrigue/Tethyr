void main()
{
    if (GetLocalInt(OBJECT_SELF, "Active") == 1 && GetObjectByTag("te_npc_2001", 1) != OBJECT_INVALID)
    {
        DelayCommand(12.0, ActionCloseDoor(GetNearestObjectByTag("tn_dw_bossdoor")));
        ExecuteScript("tn_phb_boss", GetNearestObjectByTag("tn_corpsepile", OBJECT_SELF, 1));
        ExecuteScript("tn_phb_boss", GetNearestObjectByTag("tn_corpsepile", OBJECT_SELF, 2));
        ExecuteScript("tn_phb_boss", GetNearestObjectByTag("tn_corpsepile", OBJECT_SELF, 3));
        ExecuteScript("tn_phb_boss", GetNearestObjectByTag("tn_corpsepile", OBJECT_SELF, 4));
        ExecuteScript("tn_phb_boss", GetNearestObjectByTag("tn_corpsepile", OBJECT_SELF, 5));
        ExecuteScript("tn_phb_boss", GetNearestObjectByTag("tn_corpsepile", OBJECT_SELF, 6));
        ExecuteScript("tn_phb_boss", GetNearestObjectByTag("tn_corpsepile", OBJECT_SELF, 7));
        ExecuteScript("tn_phb_boss", GetNearestObjectByTag("tn_corpsepile", OBJECT_SELF, 8));
        ExecuteScript("tn_phb_boss", GetNearestObjectByTag("tn_corpsepile", OBJECT_SELF, 9));
        ExecuteScript("tn_phb_boss", GetNearestObjectByTag("tn_corpsepile", OBJECT_SELF, 10));
        ExecuteScript("tn_phb_boss", GetNearestObjectByTag("tn_corpsepile", OBJECT_SELF, 11));
        SetLocalInt(OBJECT_SELF, "Active", 0);
    }
    else{return;}
}
