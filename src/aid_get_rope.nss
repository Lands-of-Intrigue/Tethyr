//::///////////////////////////////////////////////
//:: aid_get_rope
//:://////////////////////////////////////////////
/*
    script for taking rope in aid system
*/
//:://////////////////////////////////////////////
//:: Created By: The Magus (2012 mar 30)
//:: Modified:
//:://////////////////////////////////////////////

#include "aid_inc_fcns"

void main()
{
    object oPC      = GetLocalObject(OBJECT_SELF, AID_TRIGGERING_OBJECT);
    DeleteLocalObject(OBJECT_SELF, AID_TRIGGERING_OBJECT); // Garbage collection
    string sRopeRef = GetLocalString(OBJECT_SELF, "ROPE_ITEM");
    int nRopeMagic  = GetLocalInt(OBJECT_SELF, "ROPE_MAGIC");
    object oMover   = GetLocalObject(OBJECT_SELF, "MOVE_OBJECT");
    object oRope    = GetLocalObject(OBJECT_SELF, "PAIRED");
    int bTop        = GetLocalInt(OBJECT_SELF, "MOVE_TOP");
    if(!bTop)
    {
        if(nRopeMagic)
        {
            oRope   = GetLocalObject(OBJECT_SELF, "ROPE_TOP");
            oMover  = GetLocalObject(oRope, "MOVE_OBJECT");
        }
        else
        {
            DoManipulate(oPC, OBJECT_SELF, ANIMATION_LOOPING_GET_LOW, 1.0);
            SendMessageToPC(oPC, RED+"FAILED: The rope is tied at the top. You are unable to retrieve it from your current location.");
            DelayCommand(0.5,
                    FloatingTextStringOnCreature(LIME+GetName(oPC)+RED+" fails"+LIME+" to shake the "+GREEN+GetName(OBJECT_SELF)+LIME+" loose.", oPC)
                );
            return;
        }
    }

    DeleteLocalInt(oMover, "ROPED"); // remove rope flag from "move skill" placeable
    DeleteLocalInt(oMover, "ROPE_MAGIC");
    int nRopeLength = GetLocalInt(oMover, "ROPE_LENGTH");
    DeleteLocalInt(oMover, "ROPE_LENGTH");
    DoManipulate(oPC, OBJECT_SELF, ANIMATION_LOOPING_GET_LOW, 1.0);
    string sVerb    = "retrieves";
    if(!GetIsPossessedFamiliar(oPC))
        CreateItemOnObject(sRopeRef, oPC);
    else
    {
        object oItem;
        if(bTop)
        {
            oItem   = CreateObject(OBJECT_TYPE_ITEM, sRopeRef, GetLocation(oRope), TRUE);
            sVerb   = "detaches";
        }
        else
        {
            oItem   = CreateObject(OBJECT_TYPE_ITEM, sRopeRef, GetLocation(oPC), TRUE);
            sVerb   = "shakes loose";
        }
        AssignCommand(oItem, PlaySound("bf_med_flesh"));

        int nMaxLength  = GetLocalInt(oItem, "ROPE_LENGTH");
        if(nMaxLength>nRopeLength)
        {
            int nMaxWeight  = GetWeight(oItem);
            int nFinalWeight= nMaxWeight*(nMaxLength/nRopeLength);
            if(nFinalWeight<1){nFinalWeight=1;}
            // strip weight item properties, prior to setting item weight
            int nType;
            itemproperty ip = GetFirstItemProperty(oItem);
            while(GetIsItemPropertyValid(ip))
            {
                if(GetItemPropertyType(ip)==ITEM_PROPERTY_WEIGHT_INCREASE)
                    RemoveItemProperty(oItem,ip);
                ip = GetNextItemProperty(oItem);
            }
            //set new item weight appropriate to length
            //NWNXFuncs_SetItemWeight(oItem,nFinalWeight);
            SetIdentified(oItem,TRUE);
        }
        SetLocalInt(oItem, "ROPE_LENGTH", nRopeLength);
        SetLocalInt(oItem, "ROPE_MAGIC", nRopeMagic);

        SetName(oItem, GetName(oItem)+" ("+IntToString(nRopeLength)+"m)");

    }
    FloatingTextStringOnCreature(LIME+GetName(oPC)+" "+sVerb+" the "+GREEN+GetName(OBJECT_SELF)+LIME+".", oPC);
    DestroyObject(oRope, 0.1);
    DestroyObject(OBJECT_SELF, 0.2);
}
