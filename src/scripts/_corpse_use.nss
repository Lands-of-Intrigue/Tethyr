//::///////////////////////////////////////////////
//:: _corpse_use
//:://////////////////////////////////////////////
/*
    Use of corpse object .. adapted from CNR
*/
//:://////////////////////////////////////////////
//:: Created:  The Magus (2012 apr 7)
//:: Modified: The Magus (2012 nov 4) adjusted to work with lootable corpse system
//:: Modified: henesua (2016 jul 7) integration with PC corpse as well
//:://////////////////////////////////////////////

#include "te_functions"
#include "zdlg_include_i"

void main()
{
    object oUser        = GetLastUsedBy();
    if (!GetIsPC(oUser)) return;

    int corpse_type     = GetLocalInt(OBJECT_SELF,"CORPSE");


  if(GetLocalInt(OBJECT_SELF, "CONVERSATION_SUPRESSED"))
  {
        DeleteLocalInt(OBJECT_SELF, "CONVERSATION_SUPRESSED");
  }
  // SKINNABLE corpse --------------------------------------------------------
  else if(      corpse_type & CORPSE_TYPE_SKINNABLE
            &&  !GetLocalInt(OBJECT_SELF,"SKINNED")
            &&  GetIsWieldingKnife(oUser)
         )
  {
    // prevent rapid-clicks from getting multiple skins!
    SetLocalInt(OBJECT_SELF, "SKINNED", TRUE);

    object oHostCorpse  = GetLocalObject(OBJECT_SELF, "CORPSE_BODY");
    location lCorpse    = GetLocation(OBJECT_SELF);

    string skin_type    = GetLocalString(OBJECT_SELF,"SKIN_TYPE");
    string skin_name    = GetLocalString(OBJECT_SELF,"SKIN_NAME");
    string skin_tag     = GetLocalString(OBJECT_SELF,"SKIN_TAG");
    //int nSkinHP         = GetLocalInt   (OBJECT_SELF,"SKIN_MAXHP");
    //int nSkinDam        = GetLocalInt   (OBJECT_SELF,"SKIN_DAMAGE");
    int nMeat           = GetLocalInt   (OBJECT_SELF,"SKIN_MEAT");
    string sMeatTag     = GetLocalString(OBJECT_SELF,"SKIN_MEAT_TAG");
    string sMeatName    = GetLocalString(OBJECT_SELF,"SKIN_MEAT_NAME");

    float fDelay= 0.0;
    if(skin_type!="")
    {
        object oSkin    = CreateObject(OBJECT_TYPE_ITEM, skin_type, lCorpse,FALSE, skin_tag);
        SetName(oSkin, skin_name);
        AssignCommand(oUser, ActionPickUpItem(oSkin));
        FloatingTextStringOnCreature(LIME+GetName(oUser)+" skin's the corpse." , oUser, TRUE);
        fDelay = 6.0;
    }

    if(nMeat)
    {
        DelayCommand(fDelay,
            FloatingTextStringOnCreature(LIME+GetName(oUser)+" cuts the meat from the corpse's bones." , oUser, TRUE)
          );
        AssignCommand(oUser,
            ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, ((nMeat*0.2)+3.0))
          );
    }
    else if(fDelay==0.0)
    {
        FloatingTextStringOnCreature(LIME+GetName(oUser)+" skins and butchers the corpse but comes away with worthless skin and bones." , oUser, TRUE);
        AssignCommand(oUser, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 6.0) );
    }

    object oMeat;
    while(nMeat>0)
    {
        if(nMeat>10)
        {
            oMeat   = CreateItemOnObject("meat",oUser,10,sMeatTag);
            SetName(oMeat,sMeatName);
            nMeat-=10;
        }
        else
        {
            oMeat   = CreateItemOnObject("meat",oUser,nMeat,sMeatTag);
            SetName(oMeat,sMeatName);
            nMeat = 0;
        }
    }

    // create a mess to mark this corpse as skinned
    object oBlood   = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_bloodstain", GetLocation(OBJECT_SELF));
    SetLocalObject(OBJECT_SELF, "PAIRED", oBlood);
    // replace body with bones
    int nSize           = GetCreatureSize(oHostCorpse);
    string corpse_bones = "bones3";
    if(nSize==1)
    {
        int nRan    = d3();
        if(nRan==1)
            corpse_bones= "bones2";
        else
            corpse_bones= "bones1";
    }
    else if(nSize==2)
    {
        int nRan    = d3();
        if(nRan==1)
            corpse_bones= "bones2";
    }
    else if(nSize==4)
    {
        int nRan    = d3();
        if(nRan==1)
            corpse_bones= "bones4";
        else if(nRan==2)
            corpse_bones= "bones5";
    }
    else if(nSize>=5)
    {
        corpse_bones    = "bones6";
    }
    AssignCommand(oHostCorpse, SetIsDestroyable(TRUE,FALSE,FALSE));
    DestroyObject(oHostCorpse);

    object oBones   = CreateObject(OBJECT_TYPE_PLACEABLE, corpse_bones, GetLocation(OBJECT_SELF));
    SetLocalObject(OBJECT_SELF, "CORPSE_BODY", oBones);
    SetLocalObject(oBones, "CORPSE_NODE", OBJECT_SELF);
    SetLocalString(OBJECT_SELF, "CORPSE_BONES", corpse_bones);
  }
  else
  {
        // conversation dialog for corpse
        string sDialog  = GetLocalString(OBJECT_SELF, "dialog");
        int nGreet      = GetLocalInt(OBJECT_SELF, "dialog_greet");
        int nPublic     = GetLocalInt(OBJECT_SELF, "dialog_public");
        int nZoom       = GetLocalInt(OBJECT_SELF, "dialog_zoom");
        int nPrivate    = TRUE;
        if(nPublic)
            nPrivate    = FALSE;

        StartDlg( oUser, OBJECT_SELF, sDialog, nPrivate, nGreet, nZoom);
  }
}
