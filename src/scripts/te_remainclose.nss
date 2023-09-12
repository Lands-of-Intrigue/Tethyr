void main()
{
    object oPlace = OBJECT_SELF;
    object oPC = GetLastClosedBy();

    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");
    int nBlood   = GetLocalInt(oItem,"nBlood");
    int nSticky  = GetLocalInt(oItem,"nSticky");
    int nDust    = GetLocalInt(oItem,"nDust");
    int nPlan    = GetLocalInt(oItem,"nPlan");

    if(GetResRef(oPlace) == "te_remain_bone")
    {
        SetLocalInt(oItem,"nDust",nDust+1);
    }
    if(GetResRef(oPlace) == "te_remain_bug")
    {
        SetLocalInt(oItem,"nSticky",nSticky+1);
    }
    if(GetResRef(oPlace) == "te_remain_mam")
    {
        SetLocalInt(oItem,"nBlood",nBlood+1);
    }
    if(GetResRef(oPlace) == "te_remain")
    {
        SetLocalInt(oItem,"nBlood",nBlood+1);
    }
    if(GetResRef(oPlace) == "te_remain_nonc")
    {
        SetLocalInt(oItem,"nSticky",nSticky+1);
    }
    if(GetResRef(oPlace) == "te_remain_dust")
    {
        SetLocalInt(oItem,"nDust",nDust+1);
    }
    if(GetResRef(oPlace) == "te_remain_plan")
    {
        SetLocalInt(oItem,"nPlan",nPlan+1);
    }

    if(nBlood >= 100) {SetLocalInt(oItem,"nBlood",100);}
    if(nBlood <= 0)   {SetLocalInt(oItem,"nBlood",0);}
    if(nSticky >= 100) {SetLocalInt(oItem,"nSticky",100);}
    if(nSticky <= 0)   {SetLocalInt(oItem,"nSticky",0);}
    if(nDust >= 100) {SetLocalInt(oItem,"nDust",100);}
    if(nDust <= 0)   {SetLocalInt(oItem,"nDust",0);}
    if(nPlan >= 100) {SetLocalInt(oItem,"nPlan",100);}
    if(nPlan <= 0)   {SetLocalInt(oItem,"nPlan",0);}

    if(GetFirstItemInInventory(oPlace) == OBJECT_INVALID)
    {
        DestroyObject(oPlace,1.0f);
    }
}
