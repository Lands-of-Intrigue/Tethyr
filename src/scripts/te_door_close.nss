void main()
{
    DelayCommand(12.0f,ActionCloseDoor(OBJECT_SELF));

    if(GetLockLockDC(OBJECT_SELF) > 0)
    {
        SetLocked(OBJECT_SELF, TRUE);
    }
}
