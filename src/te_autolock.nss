#include "ipi_defaults"

void ActionAutoCloseAndLock(object theObject)
{
    if (GetIsOpen(theObject))
        { ActionCloseDoor(theObject); }
    ActionDoCommand (SetLocked (theObject, TRUE));
}

void main()
{
    DelayCommand(12.0, ActionAutoCloseAndLock(OBJECT_SELF));
}
