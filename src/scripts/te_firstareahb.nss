void main()
{
    object oUser = OBJECT_SELF;
    AssignCommand(oUser, JumpToLocation( GetLocation(GetObjectByTag("WP_Starting_Area") ) ));
}
