//::///////////////////////////////////////////////
//:: Functions for using variables on a skin object
//:: x3_inc_skin
//:://////////////////////////////////////////////
/*
    This is a collection of functions for using
    a PC's skin object (or another undroppable item)
    to hold local variables. This is useful for data
    that needs to be stored persistently over server
    resets.

    These local variables have the quirk that
    all underscores (_) are stripped from the
    variable names. Scripters using the underscore
    as a deliminator will need to find a
    different character to use.
*/
//:://////////////////////////////////////////////
//:: Created By: Deva B. Winblood
//:: Created On: Feb 3rd, 2008
//:://////////////////////////////////////////////
//:: Modified by: The Krit
//:: Modified on: May 27, 2008
//:://////////////////////////////////////////////


#include "x3_inc_string"
#include "x0_i0_match"


/* NOTES:
 *
 * When integrating skin systems, it may help if other systems call SkinGetSkin()
 * with the second paramter (bCreate) set to FALSE before creating a skin item.
 * If this function returns OBJECT_INVALID, then the system can proceed to
 * create a new skin item, and it should then call SkinSetSkin(). This will help
 * prevent the creation of multiple skin items for a PC.
 * NOTE: These functions are not part of the standard BioWare library. If you
 * need compatibility with the BioWare library, check / set the local object
 * called oX3_Skin that is set on the PC instead of using these functions.
 *
 * This modification to BioWare's skin library logically separates the skin's
 * roles as occupant of the CARMOUR slot and as bearer of persistent local
 * variables. Scripts that want to add or remove item properties (such as feats)
 * to/from a PC's skin should use SkinGetSkin to obtain the item. Scripts that
 * are interested in efficiently setting or retrieving a number of "skin
 * variables" should use GetSkinVarHolder() to retrieve the object on which
 * these variables are set. (Remember that skin variables have all underscores
 * stripped from their names to maintain compatibility with BioWare's
 * implementation.)
 *
 * Setting the local strings X3_SKINVAR_RESREF and/or X3_SKINVAR_TAG on a module
 * is one way to specify that an item other than the skin item should be used
 * for stoing "skin variables". If no current variable holder is set, the
 * scripts will look for an item with the tag X3_SKINVAR_TAG. If no such item is
 * found, an item will be created from the blueprint X3_SKINVAR_RESREF. This
 * item will be made undroppable (by both PCs and NPCs).
 * If only one of the ResRef and Tag is set, it will be assumed that they are
 * the same.
 *
 * Another way to specify the item that should be used to hold "skin variables"
 * is by explicitly setting the item via the function SetSkinVarHolder().
 *
 * The reason for splitting the functionality of the skin item is that servers
 * with ELC and/or ILR turned on may find that skin items are destroyed when PCs
 * log in.
 *
 * There are no functions provided for skin variables that hold objects because
 * such data would not be valid after a server reset.
 */


//////////////////////////////////////
// CONSTANTS
//////////////////////////////////////


// Default ResRefs:
const string SKIN_PCHide = "x3_it_pchide";      // For PCs.
const string SKIN_NPCHide = "x2_it_emptyskin";  // For NPCS.
// Two ResRefs allow some flexibility if these standard items are customized.
// By default, both "PC Properties" and "Empty Creature Skin" are empty skins.


// LOCAL VARIABLE NAMES:

// on a PC:
const string SKIN_SkinObject     = "oX3_Skin";          // The PC's skin item.
const string SKIN_VariableObject = "PC_Data_Object";// The item bearing the PC's "skin variables".
                                                        // (If not set, use the skin item.)
// on the module:
const string SKINVAR_ResRef = "X3_SKINVAR_RESREF";
const string SKINVAR_Tag    = "X3_SKINVAR_TAG";


//////////////////////////////////////
// PROTOTYPES
//////////////////////////////////////


// Set the "skin variable" named sVariable of type integer on oCreature to nValue.
// These variables are persistent and travel with exported characters.
//
// FILE: x3_inc_skin       FUNCTION: SetSkinInt()
void SetSkinInt(object oCreature, string sVariable, int nValue);

// Set the "skin variable" named sVariable of type string on oCreature to sValue.
// These variables are persistent and travel with exported characters.
//
// FILE: x3_inc_skin       FUNCTION: SetSkinString()
void SetSkinString(object oCreature, string sVariable, string sValue);

// Set the "skin variable" named sVariable of type float on oCreature to fValue.
// These variables are persistent and travel with exported characters.
//
// FILE: x3_inc_skin       FUNCTION: SetSkinFloat()
void SetSkinFloat(object oCreature, string sVariable, float fValue);

// Get the "skin variable" named sVariable of type integer on oCreature.
// These variables are persistent and travel with exported characters.
//
// FILE: x3_inc_skin       FUNCTION: GetSkinInt()
int GetSkinInt(object oCreature, string sVariable);

// Get the "skin variable" named sVariable of type string on oCreature.
// These variables are persistent and travel with exported characters.
//
// FILE: x3_inc_skin       FUNCTION: GetSkinString()
string GetSkinString(object oCreature, string sVariable);

// Get the "skin variable" named sVariable of type float on oCreature.
// These variables are persistent and travel with exported characters.
//
// FILE: x3_inc_skin       FUNCTION: GetSkinFloat()
float GetSkinFloat(object oCreature, string sVariable);

// Delete the "skin variable" named sVariable of type integer on oCreature.
// These variables are persistent and travel with exported characters.
//
// FILE: x3_inc_skin       FUNCTION: DeleteSkinInt()
void DeleteSkinInt(object oCreature, string sVariable);

// Delete the "skin variable" named sVariable of type string on oCreature.
// These variables are persistent and travel with exported characters.
//
// FILE: x3_inc_skin       FUNCTION: DeleteSkinString()
void DeleteSkinString(object oCreature, string sVariable);

// Delete the "skin variable" named sVariable of type float on oCreature.
// These variables are persistent and travel with exported characters.
//
// FILE: x3_inc_skin       FUNCTION: DeleteSkinFloat()
void DeleteSkinFloat(object oCreature, string sVariable);

// Returns the object that will hold "skin variables" for oCreature.
// If no such object exists and bCreate is TRUE, it will be created.
//
// FILE: x3_inc_skin
object GetSkinVarHolder(object oCreature, int bCreate = TRUE);

// Sets the object that will hold "skin variables" for oCreature.
// This is provided in case different PCs have objects with different tags or
// ResRefs for holding their variables (making the local strings on the module
// inadequate).
//
// FILE: x3_inc_skin
void SetSkinVarHolder(object oCreature, object oSkin);

// Returns the object that is oCreature's skin.
// If no such object exists and bCreate is TRUE, it will be created and
// equipped.
//
// FILE: x3_inc_skin
object SkinGetSkin(object oCreature, int bCreate = TRUE);

// Sets the object that is oCreature's skin.
// (Useful for integrating skin systems and for locating the "normal" skin item
// while polymorphed.)
//
// FILE: x3_inc_skin
void SkinSetSkin(object oCreature, object oSkin);


///////////////////////////////////////
// SUPPORT FUNCTIONS
///////////////////////////////////////


// Destroys oSkin if it is not possessed by a creature.
// Intended to be called on a delay after item creation as a backup.
//
void SKIN_SupportDestroyUnpossessed(object oSkin)
{
    if ( GetItemPossessor(oSkin) == OBJECT_INVALID )
        DestroyObject(oSkin);
}

// Forces the caller to equip oSkin in the creature armour slot.
// This will recurse itself up to ensure the item gets equipped.
// nCount is used to prevent infinite recursion; it should not be
// specified outside this function.
// Includes checks to avoid queueing up a lot of "equip" commands.
//
void SKIN_SupportEquipSkin(object oSkin, int nCount=0)
{
    // Preemptive abort.
    if ( !GetIsObjectValid(oSkin) )
        return;

    // We can't do anything while between areas, so wait for the area to become valid.
    if ( GetArea(OBJECT_SELF) == OBJECT_INVALID )
        // This can be a longer delay here since there is a minor disorientation
        // to players upon entering a new area -- especially if they are respawning.
        // Do not count this iteration.
        DelayCommand(1.0, SKIN_SupportEquipSkin(oSkin, nCount));

    // The following state will cause an equip command to be delayed, so wait
    // for this state to end if a command has already been issued.
    else if ( nCount > 0  &&  GetCurrentAction() == ACTION_REST )
        // Do not count this iteration.
        DelayCommand(0.2, SKIN_SupportEquipSkin(oSkin, nCount));

    // The following states will cause an equip command to be ignored, so wait
    // for these states to end.
    else if ( GetIsDead(OBJECT_SELF)  ||  !GetCommandable()  ||
              GetHasEffect(EFFECT_TYPE_POLYMORPH) )
        // Do not count this iteration.
        DelayCommand(0.2, SKIN_SupportEquipSkin(oSkin, nCount));

    // Final check: see if anything is already in the creature armour slot.
    // Must be done *after* the check for polymorph.
    else
    {
        object oCArmor = GetItemInSlot(INVENTORY_SLOT_CARMOUR, OBJECT_SELF);
        if ( !GetIsObjectValid(oCArmor) )
        {
            // No item in the slot.
            // Equip and recurse.
            ActionEquipItem(oSkin, INVENTORY_SLOT_CARMOUR);

            // Recurse this function to make sure the above action is not cancelled.
            // Uncomment the following line if this script goes out of control.
            //if ( nCount < 30 )
                DelayCommand(6.0, SKIN_SupportEquipSkin(oSkin, nCount+1));
        }
        else if ( oCArmor != oSkin )
            // A different item is in the slot.
            // Destroy oSkin.
            DestroyObject(oSkin);
    }
}//SKIN_SupportEquipSkin()


// Wrapper for SkinGetSkin(), for backwards compatibility.
//
object SKIN_SupportGetSkin(object oCreature, int bCreate = TRUE)
{
    return SkinGetSkin(oCreature, bCreate);
}


///////////////////////////////////////
// FUNCTIONS
///////////////////////////////////////


// Set the "skin variable" named sVariable of type integer on oCreature to nValue.
// These variables are persistent and travel with exported characters.
//
void SetSkinInt(object oCreature, string sVariable, int nValue)
{
    // Set the local on the variable object.
    SetLocalInt(GetSkinVarHolder(oCreature),
                StringReplace(sVariable, "_", ""), nValue);
}//SetSkinInt()


// Set the "skin variable" named sVariable of type string on oCreature to sValue.
// These variables are persistent and travel with exported characters.
//
void SetSkinString(object oCreature, string sVariable, string sValue)
{
    // Set the local on the variable object.
    SetLocalString(GetSkinVarHolder(oCreature),
                   StringReplace(sVariable, "_", ""), sValue);
}//SetSkinString()


// Set the "skin variable" named sVariable of type float on oCreature to fValue.
// These variables are persistent and travel with exported characters.
//
void SetSkinFloat(object oCreature, string sVariable, float fValue)
{
    // Set the local on the variable object.
    SetLocalFloat(GetSkinVarHolder(oCreature),
                  StringReplace(sVariable, "_", ""), fValue);
}//SetSkinFloat()


// Get the "skin variable" named sVariable of type integer on oCreature.
// These variables are persistent and travel with exported characters.
//
int GetSkinInt(object oCreature, string sVariable)
{
    // Get the local from the variable object.
    // (If the variable object is not valid, then there is nothing to retrieve,
    // and GetLocalInt() will correctly return 0.)
    return GetLocalInt(GetSkinVarHolder(oCreature, FALSE),
                       StringReplace(sVariable, "_", ""));
}//GetSkinInt()


// Get the "skin variable" named sVariable of type string on oCreature.
// These variables are persistent and travel with exported characters.
//
string GetSkinString(object oCreature, string sVariable)
{
    // Get the local from the variable object.
    // (If the variable object is not valid, then there is nothing to retrieve,
    // and GetLocalString() will correctly return "".)
    return GetLocalString(GetSkinVarHolder(oCreature, FALSE),
                          StringReplace(sVariable, "_", ""));
}//GetSkinString()


// Get the "skin variable" named sVariable of type float on oCreature.
// These variables are persistent and travel with exported characters.
//
float GetSkinFloat(object oCreature, string sVariable)
{
    // Get the local from the variable object.
    // (If the variable object is not valid, then there is nothing to retrieve,
    // and GetLocalFloat() will correctly return 0.0.)
    return GetLocalFloat(GetSkinVarHolder(oCreature, FALSE),
                         StringReplace(sVariable, "_", ""));
}//GetSkinFloat()


// Delete the "skin variable" named sVariable of type integer on oCreature.
// These variables are persistent and travel with exported characters.
//
void DeleteSkinInt(object oCreature, string sVariable)
{
    // Delete the local from the variable object.
    // (If the variable object is not valid, then there is nothing to delete,
    // and DeleteLocalInt() will correctly not do anything.)
    DeleteLocalInt(GetSkinVarHolder(oCreature, FALSE),
                   StringReplace(sVariable, "_", ""));
}//DeleteSkinInt()


// Delete the "skin variable" named sVariable of type string on oCreature.
// These variables are persistent and travel with exported characters.
//
void DeleteSkinString(object oCreature, string sVariable)
{
    // Delete the local from the variable object.
    // (If the variable object is not valid, then there is nothing to delete,
    // and DeleteLocalString() will correctly not do anything.)
    DeleteLocalString(GetSkinVarHolder(oCreature, FALSE),
                      StringReplace(sVariable, "_", ""));
}//DeleteSkinString()


// Delete the "skin variable" named sVariable of type float on oCreature.
// These variables are persistent and travel with exported characters.
//
void DeleteSkinFloat(object oCreature, string sVariable)
{
    // Delete the local from the variable object.
    // (If the variable object is not valid, then there is nothing to delete,
    // and DeleteLocalFloat() will correctly not do anything.)
    DeleteLocalFloat(GetSkinVarHolder(oCreature, FALSE),
                     StringReplace(sVariable, "_", ""));
}//DeleteSkinFloat()


// Returns the object that will hold "skin variables" for oCreature.
// If no such object exists and bCreate is TRUE, it will be created.
//
object GetSkinVarHolder(object oCreature, int bCreate = TRUE)
{
    // Start by checking the local object.
    object oSkin = GetLocalObject(oCreature, SKIN_VariableObject);
    // If we found a valid object, we are done.
    if ( GetIsObjectValid(oSkin) )
        return oSkin;

    object oModule = GetModule();

    // Get the tag of the variable holder.
    string sTag = GetLocalString(oModule, SKINVAR_Tag);
    if ( sTag == "" )
        // Tag defaults to ResRef.
        sTag = GetLocalString(oModule, SKINVAR_ResRef);

    if ( sTag == ""  ||  !GetIsPC(oCreature)  ||  GetIsDMPossessed(oCreature) )
        // No customization specified, so use the skin object.
        oSkin = SkinGetSkin(oCreature, bCreate);
    else
    {
        // Look for the variable holder in oCreature's inventory.
        oSkin = GetItemPossessedBy(oCreature, sTag);
        if ( oSkin == OBJECT_INVALID  &&  bCreate )
        {
            // Get the ResRef of the variable holder.
            string sResRef = GetLocalString(oModule, SKINVAR_ResRef);
            if ( sResRef == "" )
                // ResRef defaults to tag.
                sResRef = sTag;

            // Create a variable holder.
            oSkin = CreateItemOnObject(sResRef, oCreature, 1, sTag);
            SetItemCursedFlag(oSkin, TRUE); // Undroppable by PCs.

            // Safety precaution to avoid leaving items on the ground (if oSkin
            // was created, but not on oCreature for some reason).
            AssignCommand(oModule, DelayCommand(6.0, SKIN_SupportDestroyUnpossessed(oSkin)));
        }
    }

    // Avoid creating an unneeded local variable.
    if ( oSkin != OBJECT_INVALID )
        // Remember this object.
        SetLocalObject(oCreature, SKIN_VariableObject, oSkin);

    return oSkin;
}//GetSkinVarHolder()


// Sets the object that will hold "skin variables" for oCreature.
// This is provided in case different PCs have objects with different tags or
// ResRefs for holding their variables (making the local strings on the module
// inadequate).
//
void SetSkinVarHolder(object oCreature, object oSkin)
{
    SetLocalObject(oCreature, SKIN_VariableObject, oSkin);
}


// Returns the object that is oCreature's skin.
// If no such object exists and bCreate is TRUE, it will be created and
// equipped.
//
object SkinGetSkin(object oCreature, int bCreate = TRUE)
{
    // Start by checking the local object.
    object oSkin = GetLocalObject(oCreature, SKIN_SkinObject);
    // If we found a valid object, we are done.
    if ( GetIsObjectValid(oSkin) )
        return oSkin;

    // Check the creature armour slot.
    oSkin = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oCreature);
    // If there is no item in the slot, look for an unequipped skin item.
    if ( oSkin == OBJECT_INVALID  &&  GetObjectType(oCreature) == OBJECT_TYPE_CREATURE )
    {
        // ResRef and tag are the same for the two default hides.
        string sResRefTag = SKIN_NPCHide;
        if ( GetIsPC(oCreature) )
            sResRefTag = SKIN_PCHide;
        // sResRefTag functions as a tag here.
        oSkin = GetItemPossessedBy(oCreature, sResRefTag);

        // If there is no item found, create one.
        if ( oSkin == OBJECT_INVALID  &&  bCreate )
        {
            // sResRefTag functions as a ResRef here.
            oSkin = CreateItemOnObject(sResRefTag, oCreature);
            SetDroppableFlag(oSkin, FALSE);
            // Just in case...
            SetIdentified(oSkin, TRUE);
            // Safety precaution to avoid leaving skins on the ground (if oSkin
            // was created, but not on oCreature for some reason).
            AssignCommand(GetModule(), DelayCommand(6.0, SKIN_SupportDestroyUnpossessed(oSkin)));
        }

        // Equip the item.
        AssignCommand(oCreature, SKIN_SupportEquipSkin(oSkin));
    }

    // Avoid creating an unneeded local variable.
    if ( oSkin != OBJECT_INVALID )
        // Remember this object.
        SetLocalObject(oCreature, SKIN_SkinObject, oSkin);

    return oSkin;
}//SkinGetSkin()


// Sets the object that is oCreature's skin.
// (Useful for integrating skin systems and for locating the "normal" skin item
// while polymorphed.)
//
void SkinSetSkin(object oCreature, object oSkin)
{
    SetLocalObject(oCreature, SKIN_SkinObject, oSkin);
}
