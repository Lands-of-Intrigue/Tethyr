//::///////////////////////////////////////////////
//:: campfire_dlg
//:://////////////////////////////////////////////
/*
    MAGUS CAMPFIRE SYSTEM

    Z-Dialog Script for the Campfire

*/
//:://////////////////////////////////////////////
//:: Created By: The Magus (2013 july 13)
//:: Modified:
//:://////////////////////////////////////////////

#include "zdlg_include_i"
#include "te_functions"
#include "camp_include"

// Constants
const string PAGE_START         = "start";
const string PAGE_COOK_MEAT     = "cooking";
const string PAGE_FUEL_FIRE     = "fuel";
const string PAGE_ELSE          = "else";

// Globals (fake constants)

// DECLARATIONS
// custom

void SelectItemsForTheFire(string sAction, string sTag, string sPage, object oHolder);

// Zdlg
void Init();
void PageInit();
void CleanUp();
void HandleSelection();

// IMPLEMENTATION
// custom ----------------------------------------------------------------------

void SelectItemsForTheFire(string sAction, string sTag, string sPage, object oPC)
{
    object oItem    = GetFirstItemInInventory(oPC);
    string sFullTag     = GetTag(oItem);
    string sIdentifier  = sFullTag+GetResRef(oItem);
    int nIndex;

    while(GetIsObjectValid(oItem))
    {
      if(!GetLocalInt(oItem,"FIRE_ITEM_USED")) // skip items marked for use
      {
        sFullTag     = GetTag(oItem);
        sIdentifier  = sFullTag+GetResRef(oItem);
        if(     sFullTag==sTag
            ||  GetTagPrefix(sFullTag)==sTag
          )
        {
            int bNew    = TRUE;
            int i;
            for (i = 0; i <= nIndex; i++)
            {
                object oSelect  = GetLocalObject(oPC, "FIRE_ITEM_"+IntToString(i));
                if( (GetTag(oSelect)+GetResRef(oSelect))==sIdentifier )
                {
                    bNew=FALSE;
                    break;
                }
            }

            if(bNew)
            {
                nIndex  = AddStringElement( "["+sAction+" "+GetName(oItem)+"]", sPage, oPC )-1;
                SetLocalObject(oPC, "FIRE_ITEM_"+IntToString(nIndex),oItem);
                SetLocalInt(oPC, "FIRE_ITEM_COUNT",nIndex);
            }
        }
      }
        oItem    = GetNextItemInInventory(oPC);
    }
}

// ZDLG ------------------------------------------------------------------------
void Init()
{
    object oPC          = GetPcDlgSpeaker();

    SetLocalString(oPC, "ZDLG_END", "[Nothing. Let it be.]");
    SetShowEndSelection( TRUE );

    // General List
    string sUser    = GetLocalString(OBJECT_SELF, "IN_USE_BY");
    if(sUser=="")
    {
        SetLocalString(OBJECT_SELF, "IN_USE_BY", GetName(oPC));
        if(!GetLocalInt(oPC, "IN_CONV"))
        {
            SetDlgPageString(PAGE_START);
            SetLocalInt(oPC, "IN_CONV", TRUE);
        }
    }
    else
        SendMessageToPC(oPC, RED+"The campfire is currently tended to by "+PINK+sUser+RED+".");
}

void PageInit()
{
    string sPage    = GetDlgPageString();

    object oPC      = GetPcDlgSpeaker();
    object oHolder  = oPC;

    string sPrompt;

    // Generate fresh response list
    DeleteList( sPage, oHolder );

    // Initialize prompt and responses
    if( sPage==PAGE_START || sPage==PAGE_ELSE )
    {
      if(sPage==PAGE_START)
        sPrompt =
             "What would you like to do with the campsite?"
            ;
      else
        sPrompt =
             "Done."
             +BR+BR
             +"What else would you like to do?"
            ;

        int bHasWood    = GetIsObjectValid(
                                GetFirewoodInInventory(oPC, 1)
                            );
        int bHasMeat    = GetIsObjectValid(
                                GetRawMeatInInventory(TAG_MEAT, oPC)
                            );


        object oPot     = GetItemPossessedBy(oPC, TAG_COOKPOT);
        int bHasPot     = (GetIsObjectValid(oPot)&&!GetLocalInt(oPot,"FIRE_ITEM_USED"));

        object oPaired  = GetLocalObject(OBJECT_SELF, "PAIRED");
        int nVersion    = GetLocalInt(oPaired, "CAMPFIRE_STATE");

        // Is the fire lit?
        if(!GetLocalInt(OBJECT_SELF, LIGHT_VALUE))
        {// Fire is NOT lit
            AddStringElement( "[Light a fire.]", sPage, oHolder );
            if(nVersion==2)             // tripod
                AddStringElement( "[Dismantle the tripod.]", sPage, oHolder );
            if(nVersion!=3)             // no pot over fire
            {
                if(bHasPot)
                    AddStringElement( "[Hang a pot.]", sPage, oHolder );
            }
            else if(nVersion==3)        // suspended pot
            {
                AddStringElement( "[Retrieve the pot.]", sPage, oHolder );
                AddStringElement( "[Open the pot.]", sPage, oHolder );
            }

            if( bHasWood )
                AddStringElement( "[Add more fuel to the fire.]", sPage, oHolder );
            AddStringElement( "[Pack up the campsite.]", sPage, oHolder );
        }
        else
        {// Fire is lit
            AddStringElement( "[Extinguish the fire.]", sPage, oHolder );
            AddStringElement( "[Rest by the fire.]", sPage, oHolder );
            if(nVersion!=3) // no pot
            {
                if( bHasMeat )
                    AddStringElement( "[Cook meat over the fire.]", sPage, oHolder );
                if( bHasPot )
                    AddStringElement( "[Hang a pot over the fire.]", sPage, oHolder );
            }
            else    // suspended pot
                AddStringElement( "[Open the pot.]", sPage, oHolder );

            if( bHasWood )
                AddStringElement( "[Add more fuel to the fire.]", sPage, oHolder );
        }
    }
    else if( sPage==PAGE_COOK_MEAT )
    {
        sPrompt =
             "What meat will you cook over the fire?"
            ;

        AddStringElement( "[Stop Cooking.]", sPage, oHolder );
        SelectItemsForTheFire("Cook", TAG_MEAT, sPage, oHolder);
    }
    else if( sPage==PAGE_FUEL_FIRE )
    {
        sPrompt =
             "With what will you fuel the fire?"
            ;

        AddStringElement( "[Stop stoking the flames.]", sPage, oHolder );
        SelectItemsForTheFire("Burn", TAG_FIREWOOD, sPage, oHolder);
    }

    // Set Prompt and Response List ............................................
    SetDlgPrompt( sPrompt );
    SetDlgResponseList( sPage, oHolder );
}

void CleanUp()
{
    object oPC = GetPcDlgSpeaker();
    DeleteLocalInt(oPC, "IN_CONV");
    DeleteLocalString(OBJECT_SELF, "IN_USE_BY");

}

void HandleSelection()
{
  object oPC    = GetPcDlgSpeaker();
  object oHolder= oPC;
  object oFire  = OBJECT_SELF;
  string sPage  = GetDlgPageString();
  int nSelect   = GetDlgSelection();
  string sSelect= GetStringElement( nSelect, sPage, oPC);

  // Generate fresh response list
  DeleteList( sPage, oHolder );

  if(sPage==PAGE_COOK_MEAT)
  {
    if(nSelect==0)
    {
        SetDlgPageString(PAGE_ELSE);
    }
    else
    {
        object oMeat    = GetLocalObject(oPC, "FIRE_ITEM_"+IntToString(nSelect));

        int cook_result = CamperCooksAtCampfire(oFire,oMeat,oPC);

        if(cook_result&2)
        {
            if(!GetIsObjectValid( GetRawMeatInInventory(TAG_MEAT, oPC) ))
                SetDlgPageString(PAGE_ELSE);

            SetLocalInt(oMeat,"FIRE_ITEM_USED",TRUE);

            // garbage collection
            int i; int nCount = GetLocalInt(oPC,"FIRE_ITEM_COUNT");
            for (i = 0; i < nCount; i++)
                DeleteLocalObject(oPC, "FIRE_ITEM_"+IntToString(i));
        }
    }
  }
  else if(sPage==PAGE_FUEL_FIRE)
  {
    if(nSelect==0)
    {
        SetDlgPageString(PAGE_ELSE);
    }
    else
    {
        object oFuel    = GetLocalObject(oPC, "FIRE_ITEM_"+IntToString(nSelect));
        SetLocalInt(oFuel,"FIRE_ITEM_USED",TRUE);
        AssignCommand(oPC, CamperFuelsCampfire(oFire,oFuel));
        if(!GetIsObjectValid( GetFirewoodInInventory(oPC, 1) ))
            SetDlgPageString(PAGE_ELSE);

        // garbage collection
        int i; int nCount = GetLocalInt(oPC,"FIRE_ITEM_COUNT");
        for (i = 0; i < nCount; i++)
            DeleteLocalObject(oPC, "FIRE_ITEM_"+IntToString(i));
    }
  }
  else
  {
    if(sSelect=="[Add more fuel to the fire.]")
    {
        SetDlgPageString(PAGE_FUEL_FIRE);
        return;
    }
    else if(sSelect=="[Light a fire.]")
    {
        AssignCommand(oPC, PlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0,3.0) );
        CampfireLight();
    }
    else if(sSelect=="[Extinguish the fire.]")
    {
        AssignCommand(oPC, PlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,3.0) );
        CampfireExtinguish();
    }
    else if(sSelect=="[Pack up the campsite.]")
    {
        AssignCommand(oPC, CamperPacksCampfire(oFire));
        EndDlg();
    }
    else if(sSelect=="[Rest by the fire.]")
    {
        AssignCommand(oPC,ActionRest());
        EndDlg();
    }
    else if(sSelect=="[Dismantle the tripod.]")
    {
        CampfireState(oPC, 1);
    }
    else if(FindSubString(sSelect, "[Cook meat")!=-1)
    {
        SetDlgPageString(PAGE_COOK_MEAT);
        return;
    }
    else if(FindSubString(sSelect, "[Hang a pot")!=-1)
    {
        object oPot = GetItemPossessedBy(oPC, TAG_COOKPOT);
        SetLocalInt(oPot,"FIRE_ITEM_USED",TRUE);
        CamperHangsPot(oFire, oPot, oPC);
    }
    else if(sSelect=="[Retrieve the pot.]")
    {
        CamperRetrievesPot(oFire,oPC);
    }
    else if(sSelect=="[Open the pot.]")
    {
        object oPaired  = GetLocalObject(OBJECT_SELF, "PAIRED");
        SetLocalInt(oPaired, "CONVERSATION_SUPRESSED", TRUE);

        AssignCommand(oPC, ActionInteractObject(oPaired));
        EndDlg();
    }

    SetDlgPageString(PAGE_ELSE);
  }

}

// MAIN ------------------------------------------------------------------------
void main()
{
    //object oSelf    = OBJECT_SELF;

    int iEvent = GetDlgEventType();

    switch( iEvent )
    {
        case DLG_INIT:
            Init();
        break;
        case DLG_PAGE_INIT:
            PageInit();
        break;
        case DLG_SELECTION:
            HandleSelection();
        break;
        case DLG_ABORT:
        case DLG_END:
            // We do the same thing on abort or end
            CleanUp();
        break;
    }
}
