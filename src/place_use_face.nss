#include "gs_inc_fixture"
void main()
{
object oPC = GetPCSpeaker();
float fOrientation = GetFacing(oPC);
AssignCommand(OBJECT_SELF, ActionDoCommand(SetFacing(fOrientation)));
gsFXDeleteFixture(GetTag(GetArea(OBJECT_SELF)),OBJECT_SELF);
gsFXSaveFixture  (GetTag(GetArea(OBJECT_SELF)),OBJECT_SELF);
}
