////////////////////////////
// Seige Scripts
// Scripted by Urthen
////////////////////////////
// siege_load:
// Called by the conversation, allows the user to view the inventory.
////////////////////////////

void main()
{
SetLocalInt(OBJECT_SELF, "in_use", TRUE);
SetLocalInt(OBJECT_SELF, "loading", TRUE);
DelayCommand(0.1, AssignCommand(GetPCSpeaker(), ActionInteractObject(OBJECT_SELF))); //Attempt to automatically open inventory

//To prevent someone from being able to "jam" the weapon:
DelayCommand(12.0, SetLocalInt(OBJECT_SELF, "in_use", FALSE));
DelayCommand(7.0, SetLocalInt(OBJECT_SELF, "loading", FALSE));
}
