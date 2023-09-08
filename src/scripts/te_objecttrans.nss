void main()
{
    object oDoor = OBJECT_SELF;
    string sDes = GetLocalString(oDoor, "DESTINATION");
    object oUser = GetLastUsedBy();
    object oDes = GetObjectByTag(sDes);
    if(GetIsObjectValid(oDes)) // the door is there
    {
        AssignCommand(oUser, JumpToObject(oDes));
    }
}
