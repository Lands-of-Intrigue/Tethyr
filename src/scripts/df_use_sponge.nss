#include "df_handler"
void main()
{
    object oTarget = GetLastUsedBy();
    DF_RestoreOxygen(oTarget, 10);
    DestroyObject(OBJECT_SELF, 0.0);
}
