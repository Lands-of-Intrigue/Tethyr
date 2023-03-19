void main()
{
    object oPlace = OBJECT_SELF;

    object oDoor = GetFirstObjectInShape(SHAPE_SPHERE,10.0f,GetLocation(oPlace),FALSE,OBJECT_TYPE_DOOR);

    while (oDoor != OBJECT_INVALID)
    {
        if(GetLocalInt(oDoor,"Drawbridge") == 1)
        {
            if(GetIsOpen(oDoor) == TRUE)
            {
                ActionOpenDoor(oDoor);
            }
            return;
        }

        oDoor = GetNextObjectInShape(SHAPE_SPHERE,10.0f,GetLocation(oPlace),FALSE,OBJECT_TYPE_DOOR);
    }
}
