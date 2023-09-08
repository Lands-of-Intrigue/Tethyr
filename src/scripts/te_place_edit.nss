void main()
{
    object oPC = GetPCSpeaker();
    object oPlace = OBJECT_SELF;

    SetLocalObject(oPC,"Placeable",oPlace);
}
