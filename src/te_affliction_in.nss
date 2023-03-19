//:://////////////////////////////////////////////
//:: Affliction_Initialization
//:: TE_Afflict_init
//:: Function(D20) 2016
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: David Novotny
//:: Created On: March 22, 2016
//:://////////////////////////////////////////////

void main()
{
    object oPC = GetEnteringObject();
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");

    //Look for whether the PC has their Affliction Skin. If they do not, give it to them. If they do, unequip and reequipe to restore bonuses.
    /*
    Integer meanings for Afflictions:
    Werewolf = 1
    Vampire Thrall = 2
    Vampire = 3
    Vampire Drider = 4
    Revenant = 5
    Drider = 6
    Lich = 7
    */


    switch (GetLocalInt(oItem, "iPCAffliction"))

    {
        //Werewolf
        case 1:
            if (GetItemPossessedBy(oPC, "TE_SKIN_WEREWOLF") == OBJECT_INVALID)
            {
                CreateItemOnObject("TE_SKIN_WEREWOLF", oPC, 1);
                DelayCommand(0.5,ActionEquipItem(GetItemPossessedBy(oPC,"TE_SKIN_WEREWOLF"), INVENTORY_SLOT_CARMOUR));
                break;
            }
            else
            {
                ActionUnequipItem(GetItemPossessedBy(oPC,"TE_SKIN_WEREWOLF"));
                DelayCommand(0.5,ActionEquipItem(GetItemPossessedBy(oPC,"TE_SKIN_WEREWOLF"), INVENTORY_SLOT_CARMOUR));
                break;
            }
        //Vampire Thrall
        case 2:
            if (GetItemPossessedBy(oPC, "TE_SKIN_VAMPIRET") == OBJECT_INVALID)
            {
                CreateItemOnObject("TE_SKIN_VAMPIRET", oPC, 1);
                DelayCommand(0.5,ActionEquipItem(GetItemPossessedBy(oPC,"TE_SKIN_VAMPIRET"), INVENTORY_SLOT_CARMOUR));
                break;
            }
            else
            {
                ActionUnequipItem(GetItemPossessedBy(oPC,"TE_SKIN_WEREWOLF"));
                DelayCommand(0.5,ActionEquipItem(GetItemPossessedBy(oPC,"TE_SKIN_VAMPIRET"), INVENTORY_SLOT_CARMOUR));
                break;
            }
        //Vampire
        case 3:
                    if (GetItemPossessedBy(oPC, "TE_SKIN_VAMPIRE") == OBJECT_INVALID)
            {
                CreateItemOnObject("TE_SKIN_VAMPIRE", oPC, 1);
                DelayCommand(0.5,ActionEquipItem(GetItemPossessedBy(oPC,"TE_SKIN_VAMPIRE"), INVENTORY_SLOT_CARMOUR));
                break;
            }
            else
            {
                ActionUnequipItem(GetItemPossessedBy(oPC,"TE_SKIN_VAMPIRE"));
                DelayCommand(0.5,ActionEquipItem(GetItemPossessedBy(oPC,"TE_SKIN_VAMPIRET"), INVENTORY_SLOT_CARMOUR));
                break;
            }
        //Vampire Drider
        case 4:
                    if (GetItemPossessedBy(oPC, "TE_SKIN_VAMPIRED") == OBJECT_INVALID)
            {
                CreateItemOnObject("TE_SKIN_VAMPIRED", oPC, 1);
                DelayCommand(0.5,ActionEquipItem(GetItemPossessedBy(oPC,"TE_SKIN_VAMPIRED"), INVENTORY_SLOT_CARMOUR));
                break;
            }
            else
            {
                ActionUnequipItem(GetItemPossessedBy(oPC,"TE_SKIN_VAMPIRED"));
                DelayCommand(0.5,ActionEquipItem(GetItemPossessedBy(oPC,"TE_SKIN_VAMPIRED"), INVENTORY_SLOT_CARMOUR));
                break;
            }
        //Revenant
        case 5:
                    if (GetItemPossessedBy(oPC, "TE_SKIN_Werewolf") == OBJECT_INVALID)
            {
                CreateItemOnObject("TE_SKIN_WEREWOLF", oPC, 1);
                DelayCommand(0.5,ActionEquipItem(GetItemPossessedBy(oPC,"TE_SKIN_Werewolf"), INVENTORY_SLOT_CARMOUR));
                break;
            }
            else
            {
                ActionUnequipItem(GetItemPossessedBy(oPC,"TE_SKIN_WEREWOLF"));
                DelayCommand(0.5,ActionEquipItem(GetItemPossessedBy(oPC,"TE_SKIN_Werewolf"), INVENTORY_SLOT_CARMOUR));
                break;
            }
        //Drider
        case 6:
            if (GetItemPossessedBy(oPC, "TE_SKIN_Werewolf") == OBJECT_INVALID)
            {
                CreateItemOnObject("TE_SKIN_WEREWOLF", oPC, 1);
                DelayCommand(0.5,ActionEquipItem(GetItemPossessedBy(oPC,"TE_SKIN_Werewolf"), INVENTORY_SLOT_CARMOUR));
                break;
            }
            else
            {
                ActionUnequipItem(GetItemPossessedBy(oPC,"TE_SKIN_WEREWOLF"));
                DelayCommand(0.5,ActionEquipItem(GetItemPossessedBy(oPC,"TE_SKIN_Werewolf"), INVENTORY_SLOT_CARMOUR));
                break;
            }
        //Lich
        case 7:
            if (GetItemPossessedBy(oPC, "TE_SKIN_Werewolf") == OBJECT_INVALID)
            {
                CreateItemOnObject("TE_SKIN_WEREWOLF", oPC, 1);
                DelayCommand(0.5,ActionEquipItem(GetItemPossessedBy(oPC,"TE_SKIN_Werewolf"), INVENTORY_SLOT_CARMOUR));
                break;
            }
            else
            {
                ActionUnequipItem(GetItemPossessedBy(oPC,"TE_SKIN_WEREWOLF"));
                DelayCommand(0.5,ActionEquipItem(GetItemPossessedBy(oPC,"TE_SKIN_Werewolf"), INVENTORY_SLOT_CARMOUR));
                break;
            }
    }
}
