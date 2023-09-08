// requires
#include "mk_inc_tools"

const int MK_CREATURE_PART_NEXT = 1;
const int MK_CREATURE_PART_PREV = 2;

const int MK_CRAFTBODY_ERROR = 0;
const int MK_CRAFTBODY_HEAD = 1;

const int MK_CRAFTBODY_TAIL = 3;
const int MK_CRAFTBODY_WINGS = 4;
const int MK_CRAFTBODY_PHENOTYPE = 5;

const int MK_CRAFTBODY_PORTRAIT = 7;
const int MK_CRAFTBODY_BODY = 8;
const int MK_CRAFTBODY_HORSE = 9;

const int MK_CRAFTBODY_COLOR = 10;

const int MK_CRAFTBODY_NUMBER_OF_BODYPARTS = 10;

const int MK_CRAFTBODY_SAVERESTORE = 21;

const int MK_CRAFTBODY_NUMBER_OF_SLOTS = 10;

const int MK_CRAFTBODY_NEXT = 1;
const int MK_CRAFTBODY_PREV = 2;

const int MK_PORTRAIT_ID_NEXT = 1;
const int MK_PORTRAIT_ID_PREV = 2;
const int MK_PORTRAIT_RESREF_NEXT = 3;
const int MK_PORTRAIT_RESREF_PREV = 4;

const string MK_CRAFTBODY_CURRENT = "MK_CRAFTBODY_CURRENT";
const string MK_CRAFTBODY_SUB = "MK_CRAFTBODY_SUB";
const string MK_CRAFTBODY_SAVE = "MK_CRAFTBODY_SAVE";

const int MK_CRAFTBODY_TOKEN_NAME = 14422;
const int MK_CRAFTBODY_TOKEN_NUMBER = 14423;

const string MK_2DA_RIDE_PHENO = "mk_ride_pheno";
const string MK_2DA_RIDE_HORSES = "mk_horses";

const string MK_VAR_CURRENT_HORSE = "MK_CurrentHorse";
const string MK_VAR_CURRENT_TAIL = "MK_CurrentTail";

const int MK_HORSE_1 = 16;
const int MK_HORSE_2 = 29;
const int MK_HORSE_3 = 42;
const int MK_HORSE_4 = 55;
const int MK_HORSE_5 = 68;


// ----------------------------------------------------------------------------
// Sets the part of the body to be modified
// - nBodyPart (MK_CRAFTBODY_*)
//      MK_CRAFTBODY_ERROR
//      MK_CRAFTBODY_HEAD
//      MK_CRAFTBODY_TAIL
//      MK_CRAFTBODY_WINGS
//      MK_CRAFTBODY_PHENOTYPE
//      MK_CRAFTBODY_PORTRAIT
//      MK_CRAFTBODY_BODY
// ----------------------------------------------------------------------------
void MK_SetBodyPartToBeModified(object oCreature, int nBodyPart);

// ----------------------------------------------------------------------------
// Returns the body part to be modified
// ----------------------------------------------------------------------------
int MK_GetBodyPartToBeModified(object oCreature);

// ----------------------------------------------------------------------------
// Changes the creature's portrait
// - nMode
//      MK_PORTRAITID_NEXT
//      MK_PORTRAITID_PREV
// ----------------------------------------------------------------------------
void MK_NewPortrait(object oCreature, int nMode);

// ----------------------------------------------------------------------------
// Tries to find the portrait ID by searching the portraits.2da
// for a matching resref.
// - bCustom: searches custom portrait list
// ----------------------------------------------------------------------------
int MK_GetPortraitIdFromResRef(string sResRef, int bCustom=FALSE);

// ----------------------------------------------------------------------------
// Get the PortraitId of oTarget
// - oTarget: the object for which you are getting the portrait Id.
//
// The function calls GetPortraitId() and if PORTRAIT_INVALID is returned
// it tries GetPortraitResRef() and searches the returned ResRef in
// Portraits.2da.
// - bCustom: searches custom portrait list
//
// ----------------------------------------------------------------------------
int MK_GetPortraitId(object oTarget=OBJECT_SELF);

// ----------------------------------------------------------------------------
// Get the custom PortraitId of oTarget
// - oTarget: the object for which you are getting the portrait Id.
//
// The function reads the portrait resref and searches MK_Portraits.2da
// for a matching portrait.
// Returns PORTRAIT_INVALID if no matching portrait is found. Otherwise
// it returns the line number.
// ----------------------------------------------------------------------------
int MK_GetCustomPortraitId(object oTarget=OBJECT_SELF);

// ----------------------------------------------------------------------------
// Returns the current body part number
// ----------------------------------------------------------------------------
int MK_GetBodyPart(object oCreature, int nBodyPartToBeModified, int nSubBodyPart=0);

// ----------------------------------------------------------------------------
// Sets the current body part number
// ----------------------------------------------------------------------------
void MK_SetBodyPart(int nBodyPart, object oCreature, int nBodyPartToBeModified, int nSubBodyPart=0);

// ----------------------------------------------------------------------------
// Calculates the save bodypart string
// ----------------------------------------------------------------------------
string MK_GetSaveBodyPartString(object oCreature, int nBodyPart);

// ----------------------------------------------------------------------------
// Restores appearance of bodypart nBodyPart from string sSaveString
// ----------------------------------------------------------------------------
void MK_RestoreBodyPartFromString(object oCreature, int nBodyPart, string sSaveString, float fDelay=0.0);

// ----------------------------------------------------------------------------
// Saves the current body appearance to slot nSlot
// ----------------------------------------------------------------------------
void MK_SaveBody(object oCreature, int nSlot);

// ----------------------------------------------------------------------------
// Compares the current body appearance with appearance in slot nSlot
// ----------------------------------------------------------------------------
int MK_CompareBody(object oCreature, int nSlot);

// ----------------------------------------------------------------------------
// Returns TRUE if slot nSlot stores a body appearance
// ----------------------------------------------------------------------------
int MK_GetIsUsedSaveBodySlot(object oCreature, int nSlot);

// ----------------------------------------------------------------------------
// Restores the body appearance from slot nSlot
// ----------------------------------------------------------------------------
void MK_RestoreBody(object oCreature, int nSlot);

// ----------------------------------------------------------------------------
// Saves the current body part so it can be restored
// ----------------------------------------------------------------------------
void MK_SaveBodyPart(object oCreature);

// ----------------------------------------------------------------------------
// Restores a previously saved body part
// ----------------------------------------------------------------------------
void MK_RestoreBodyPart(object oCreature);

// ----------------------------------------------------------------------------
// Finishes modifying of creature body
// ----------------------------------------------------------------------------
void MK_DoneBodyPart(object oCreature);

// ----------------------------------------------------------------------------
// Some clean up
// ----------------------------------------------------------------------------
void MK_CleanUpBodyPart(object oCreature);

// ----------------------------------------------------------------------------
// Returns TRUE if nBodyPart is valid
// ----------------------------------------------------------------------------
int MK_GetIsValidBodyPart(int nPartToBeModfied, int nBodyPart, string sUser2DA="", string sColumn="");

// ----------------------------------------------------------------------------
// Returns the name of nBodyPart
// ----------------------------------------------------------------------------
string MK_GetBodyPartName(int nPartToBeModified, int nBodyPart);

// ----------------------------------------------------------------------------
// Returns the name of the current horse
// ----------------------------------------------------------------------------
string MK_GetHorseName(int nHorse);

// ----------------------------------------------------------------------------
// Changes the body part
// - nMode
//      MK_CRAFTBODY_NEXT
//      MK_CRAFTBODY_PREV
//      MK_CRAFTBODY_TOGGLE
//
// ----------------------------------------------------------------------------
void MK_NewBodyPart(object oCreature, int nMode);


// ----------------------------------------------------------------------------
// Sets the tokens 14422/14423 to current body part name/number
// ----------------------------------------------------------------------------
void MK_SetBodyPartTokens(object oCreature);

// ----------------------------------------------------------------------------
// Sets the tokens 14422/14423
// ----------------------------------------------------------------------------
void MK_SetBodyPartTokens2(string sPartName, string sBodyPart);

// ----------------------------------------------------------------------------
int MK_GetMaxBodyPartID(int nCreaturePart);

// ----------------------------------------------------------------------------
// Initializes the horse selection for oCreature:
// - sets the phenotype to riding
// - sets the tail to the current horse or the starting horse of no
//   current horse exists.
// ----------------------------------------------------------------------------
int MK_InitializeHorseSelection(object oCreature);

// ----------------------------------------------------------------------------
int MK_GetIsRiding(object oCreature);

// ----------------------------------------------------------------------------
// implementation
// ----------------------------------------------------------------------------


void MK_SetBodyPartToBeModified(object oCreature, int nBodyPart)
{
    SetLocalInt(oCreature,MK_CRAFTBODY_CURRENT,nBodyPart);
}

void MK_SetSubPartToBeModified(object oCreature, int nSubPart)
{
    SetLocalInt(oCreature,MK_CRAFTBODY_SUB,nSubPart);
}

int MK_GetBodyPartToBeModified(object oCreature)
{
    return GetLocalInt(oCreature,MK_CRAFTBODY_CURRENT);
}

int MK_GetSubPartToBeModified(object oCreature)
{
    return GetLocalInt(oCreature,MK_CRAFTBODY_SUB);
}

int MK_GetBoneArmBodyPart(int iBoneArm)
{
    int nPart=0;
    switch (iBoneArm)
    {
    case 0:
        nPart = CREATURE_PART_LEFT_BICEP;
        break;
    case 1:
        nPart = CREATURE_PART_LEFT_FOREARM;
        break;
    case 2:
        nPart = CREATURE_PART_LEFT_HAND;
        break;
    }
    return nPart;
}

int MK_GetTattooBodyPart(int iTattoo)
{
    int nPart=0;
    switch (iTattoo)
    {
    case 0:
        nPart = CREATURE_PART_TORSO;
        break;
    case 1:
        nPart = CREATURE_PART_LEFT_BICEP;
        break;
    case 2:
        nPart = CREATURE_PART_RIGHT_BICEP;
        break;
    case 3:
        nPart = CREATURE_PART_LEFT_FOREARM;
        break;
    case 4:
        nPart = CREATURE_PART_RIGHT_FOREARM;
        break;
    case 5:
        nPart = CREATURE_PART_LEFT_THIGH;
        break;
    case 6:
        nPart = CREATURE_PART_RIGHT_THIGH;
        break;
    case 7:
        nPart = CREATURE_PART_LEFT_SHIN;
        break;
    case 8:
        nPart = CREATURE_PART_RIGHT_SHIN;
        break;
    }
    return nPart;
}

string MK_BodyPartToColumn(int nPart)
{
    return Get2DAString("capart", "MDLNAME", nPart);
}

int MK_BodyPart_ID2Model(int nPart, int nID)
{
    string sColumn = MK_BodyPartToColumn(nPart);
    string sModel = Get2DAString("mk_bodyparts", sColumn, nID);
    if (sModel=="") return -1;
    return StringToInt(sModel);
}

int MK_BodyPart_Model2ID(int nPart, int nModel)
{
    string sColumn = MK_BodyPartToColumn(nPart);

    int nMin = 0;
    int nMax = MK_GetMaxBodyPartID(nPart);

    int bFound=FALSE;
    string s2DA = "MK_BodyParts";

    int nId=nMin-1;
    while ((!bFound) && (nId<nMax))
    {
        int nModelQ = StringToInt(Get2DAString(s2DA, sColumn, ++nId));
        bFound = (nModel==nModelQ);
    }
    if (!bFound)
    {
        nId = -1;
    }
    return nId;
}

int MK_GetCreatureBodyPartID(int nPart, object oCreature)
{
    int nModel = GetCreatureBodyPart(nPart, oCreature);

    return MK_BodyPart_Model2ID(nPart, nModel);
}

int MK_GetBodyPart(object oCreature, int nBodyPartToBeModified, int nSubBodyPart=0)
{
    int nBodyPart = 0;
    switch (nBodyPartToBeModified)
    {
    case MK_CRAFTBODY_HEAD:
        nBodyPart = GetCreatureBodyPart(CREATURE_PART_HEAD, oCreature);
        break;
    case MK_CRAFTBODY_BODY:
        nBodyPart = MK_GetCreatureBodyPartID(
                        nSubBodyPart,
//                        GetLocalInt(OBJECT_SELF,"X2_TAILOR_CURRENT_PART"),
                        oCreature);
        break;
    case MK_CRAFTBODY_TAIL:
        nBodyPart = GetCreatureTailType(oCreature);
        break;
    case MK_CRAFTBODY_HORSE:
        nBodyPart = GetCreatureTailType(oCreature);
        break;
    case MK_CRAFTBODY_WINGS:
        nBodyPart = GetCreatureWingType(oCreature);
        break;
    case MK_CRAFTBODY_PHENOTYPE:
        nBodyPart = GetPhenoType(oCreature);
        break;
    case MK_CRAFTBODY_PORTRAIT:
        nBodyPart = MK_GetPortraitId(oCreature);
        break;
    case MK_CRAFTBODY_COLOR:
        nBodyPart = GetColor(oCreature, nSubBodyPart);
        break;
    }
    return nBodyPart;
}

void MK_SetCreatureBodyPartFromID(int nPart, int nID, object oCreature)
{
    int nModel = MK_BodyPart_ID2Model(nPart, nID);
    SetCreatureBodyPart(nPart, nModel, oCreature);
}

void MK_SetBodyPart(int nBodyPart, object oCreature, int nBodyPartToBeModified, int nSubBodyPart=0)
{
    switch (nBodyPartToBeModified)
    {
    case MK_CRAFTBODY_HEAD:
        SetCreatureBodyPart(CREATURE_PART_HEAD, nBodyPart, oCreature);
        break;
    case MK_CRAFTBODY_BODY:
        MK_SetCreatureBodyPartFromID(
            nSubBodyPart,
            nBodyPart,
            oCreature);
        break;
    case MK_CRAFTBODY_TAIL:
        SetCreatureTailType(nBodyPart, oCreature);
        break;
    case MK_CRAFTBODY_HORSE:
        SetCreatureTailType(nBodyPart, oCreature);
        break;
    case MK_CRAFTBODY_WINGS:
        SetCreatureWingType(nBodyPart, oCreature);
        break;
    case MK_CRAFTBODY_PHENOTYPE:
        SetPhenoType(nBodyPart, oCreature);
        break;
    case MK_CRAFTBODY_PORTRAIT:
        SetPortraitId(oCreature, nBodyPart);
        break;
    case MK_CRAFTBODY_COLOR:
        SetColor(oCreature, nSubBodyPart, nBodyPart);
        break;
    }
}

int MK_GetIsUsedSaveBodySlot(object oCreature, int nSlot)
{
    if (nSlot>=0)
    {
        string sPrefix = "MK_SaveSlot"+MK_IntToString(nSlot,2,"0")+"_";
        int nBodyPart;
        for (nBodyPart=1; nBodyPart<=MK_CRAFTBODY_NUMBER_OF_BODYPARTS; nBodyPart++)
        {
            string sVariable = sPrefix+"Part"+MK_IntToString(nBodyPart,2,"0");
            string sSaveString = GetLocalString(oCreature, sVariable);

            if (sSaveString!="") return TRUE;
        }
        return FALSE;
    }
    else
    {
        int nSlotQ;
        for (nSlotQ=1; nSlotQ<=MK_CRAFTBODY_NUMBER_OF_SLOTS; nSlotQ++)
        {
            if (MK_GetIsUsedSaveBodySlot(oCreature, nSlotQ))
            {
                return TRUE;
            }
        }
        return FALSE;
    }
}

void MK_SaveBody(object oCreature, int nSlot)
{
    string sPrefix = "MK_SaveSlot"+MK_IntToString(nSlot,2,"0")+"_";
    int nBodyPart;
    for (nBodyPart=1; nBodyPart<=MK_CRAFTBODY_NUMBER_OF_BODYPARTS; nBodyPart++)
    {
        string sSaveString = MK_GetSaveBodyPartString(oCreature, nBodyPart);
        string sVariable = sPrefix+"Part"+MK_IntToString(nBodyPart,2,"0");
//        SendMessageToPC(oCreature, "Variable: "+sVariable+", Wert: "+sSaveString);
        SetLocalString(oCreature, sVariable, sSaveString);
    }
}

void MK_RestoreBody(object oCreature, int nSlot)
{
    string sPrefix1 = "MK_SaveSlot"+MK_IntToString(nSlot,2,"0")+"_Part";
    string sVariable1;
    string sSaveString1, sSaveString0;

    float fDelay = GetLocalFloat(OBJECT_SELF, "MK_RESTOREBODY_DELAY");

    int nBodyPart;
    for (nBodyPart=1; nBodyPart<=MK_CRAFTBODY_NUMBER_OF_BODYPARTS; nBodyPart++)
    {
        sVariable1 = sPrefix1+MK_IntToString(nBodyPart,2,"0");

        sSaveString1 = GetLocalString(oCreature, sVariable1);
        sSaveString0 = MK_GetSaveBodyPartString(oCreature, nBodyPart);

//        SendMessageToPC(oCreature, "Variable: "+sVariable1+", Wert: "+sSaveString1+", Aktuell: "+sSaveString0);

        if (sSaveString1!=sSaveString0)
        {
            MK_RestoreBodyPartFromString(oCreature, nBodyPart, sSaveString1, fDelay);
            ActionPauseConversation();
            ActionWait(fDelay);
            ActionResumeConversation();
        }
    }
}

int MK_CompareBody(object oCreature, int nSlot)
{
    string sPrefix = "MK_SaveSlot"+MK_IntToString(nSlot,2,"0")+"_";
    int nBodyPart;
    for (nBodyPart=1; nBodyPart<=MK_CRAFTBODY_NUMBER_OF_BODYPARTS; nBodyPart++)
    {
        string sSaveString = MK_GetSaveBodyPartString(oCreature, nBodyPart);
        string sVariable = sPrefix+"Part"+MK_IntToString(nBodyPart,2,"0");
        if (GetLocalString(oCreature, sVariable)!=sSaveString)
        {
            return FALSE;
        }
    }
    return TRUE;
}

string MK_GetSaveBodyPartString(object oCreature, int nBodyPart)
{
    string sSave="";
    switch (nBodyPart)
//    switch (MK_GetBodyPartToBeModified(oCreature))
    {
    case MK_CRAFTBODY_HEAD:
        sSave = IntToString(GetCreatureBodyPart(CREATURE_PART_HEAD, oCreature));
        break;
    case MK_CRAFTBODY_BODY:
        {
            int i;
            for (i=0; i<=17; i++)
            {
                sSave+=MK_IntToString(GetCreatureBodyPart(i,oCreature),3);
            }
        }
        break;
    case MK_CRAFTBODY_COLOR:
        {
            int i;
            int nColorChannel;
            for (i=0; i<=3; i++)
            {
                sSave+=MK_IntToString(GetColor(oCreature, i),3);
            }
        }
        break;
    case MK_CRAFTBODY_TAIL:
        sSave = IntToString(GetCreatureTailType(oCreature));
        break;
    case MK_CRAFTBODY_WINGS:
        sSave = IntToString(GetCreatureWingType(oCreature));
        break;
    case MK_CRAFTBODY_PHENOTYPE:
        sSave = IntToString(GetPhenoType(oCreature));
        break;
    case MK_CRAFTBODY_HORSE:
        sSave = MK_IntToString(GetPhenoType(oCreature),3)
              + MK_IntToString(GetCreatureTailType(oCreature),3);
        break;
    case MK_CRAFTBODY_PORTRAIT:
        {
            int nId = GetPortraitId(oCreature);
            if (nId!=PORTRAIT_INVALID)
            {
                sSave="ID="+IntToString(nId);
            }
            else
            {
                sSave="ResRef="+GetPortraitResRef(oCreature);
            }
        }
        break;
    }
    return sSave;
}

void MK_SaveBodyPart(object oCreature)
{
    string sSave=MK_GetSaveBodyPartString(oCreature,
        MK_GetBodyPartToBeModified(oCreature));
    SetLocalString(oCreature, MK_CRAFTBODY_SAVE, sSave);
}

void MK_RestoreBodyPartFromString(object oCreature, int nBodyPart, string sSaveString, float fDelay)
{
    switch (nBodyPart)
    {
    case MK_CRAFTBODY_HEAD:
        SetCreatureBodyPart(CREATURE_PART_HEAD, StringToInt(sSaveString), oCreature);
        break;
    case MK_CRAFTBODY_BODY:
        {
            int i;
            int nNewBodyPart;
            int nCurrentBodyPart;
            for (i=0; i<=17; i++)
            {
                nNewBodyPart = StringToInt(GetSubString(sSaveString,i*3,3));
                nCurrentBodyPart = GetCreatureBodyPart(i, oCreature);

                if (nNewBodyPart!=nCurrentBodyPart)
                {
                    SetCreatureBodyPart(
                        i,
                        nNewBodyPart,
                        oCreature);
                    ActionPauseConversation();
                    ActionWait(fDelay);
                    ActionResumeConversation();
                }
            }
        }
        break;
    case MK_CRAFTBODY_COLOR:
        {
            int i, nNewColor, nCurrentColor;
            for (i=0; i<=3; i++)
            {
                nNewColor = StringToInt(GetSubString(sSaveString,i*3,3));
                nCurrentColor = GetColor(oCreature, i);

                if (nNewColor!=nCurrentColor)
                {
                    SetColor(oCreature, i, nNewColor);

                    ActionPauseConversation();
                    ActionWait(fDelay);
                    ActionResumeConversation();
                }
            }
        }
        break;
    case MK_CRAFTBODY_TAIL:
        SetCreatureTailType(StringToInt(sSaveString), oCreature);
        break;
    case MK_CRAFTBODY_WINGS:
        SetCreatureWingType(StringToInt(sSaveString), oCreature);
        break;
    case MK_CRAFTBODY_PHENOTYPE:
        SetPhenoType(StringToInt(sSaveString), oCreature);
        break;
    case MK_CRAFTBODY_HORSE:
        SetCreatureTailType(StringToInt(GetStringRight(sSaveString,3)), oCreature);
        SetPhenoType(StringToInt(GetStringLeft(sSaveString,3)), oCreature);
        break;
    case MK_CRAFTBODY_PORTRAIT:
        {
            if (GetStringLeft(sSaveString,3)=="ID=")
            {
                int nId = StringToInt(GetSubString(sSaveString,3,GetStringLength(sSaveString)-3));
                SetPortraitId(oCreature,nId);
            }
            else if (GetStringLeft(sSaveString,7)=="ResRef=")
            {
                string sResRef = GetSubString(sSaveString,7,GetStringLength(sSaveString)-7);
                SetPortraitResRef(oCreature, sResRef);
            }
        }
        break;
    }
}

void MK_RestoreBodyPart(object oCreature)
{
    string sSave=GetLocalString(oCreature, MK_CRAFTBODY_SAVE);
    int nBodyPart = MK_GetBodyPartToBeModified(oCreature);

    MK_RestoreBodyPartFromString(oCreature, nBodyPart, sSave);

//    MK_CleanUpBodyPart(oCreature);
}

int MK_GetIsBodyModified(object oCreature)
{
    int bModified=FALSE;

    int nBodyPart = MK_GetBodyPartToBeModified(oCreature);
    if (nBodyPart==MK_CRAFTBODY_SAVERESTORE)
    {
        bModified = !MK_CompareBody(oCreature, 0);
    }
    else
    {
        bModified =
            (MK_GetSaveBodyPartString(oCreature, nBodyPart) != GetLocalString(oCreature, MK_CRAFTBODY_SAVE));
    }
    return bModified;
}

void MK_CleanUpBodyPart(object oCreature)
{
    DeleteLocalString(oCreature, MK_CRAFTBODY_SAVE);
    DeleteLocalInt(oCreature, MK_CRAFTBODY_SUB);
    DeleteLocalInt(oCreature, MK_CRAFTBODY_CURRENT);
    DeleteLocalInt(OBJECT_SELF, "MK_PORTRAIT_MAX_ID");
    DeleteLocalInt(OBJECT_SELF, "MK_CUSTOM_MAX_ID");
    DeleteLocalInt(OBJECT_SELF, "MK_CURRENT_CUSTOM_PORTRAIT");

    int i;
    for (i=0; i<=17; i++)
    {
        string sColumn = Get2DAString("capart","MDLNAME",i);
        if (sColumn!="")
        {
            DeleteLocalInt(OBJECT_SELF, "MK_"+sColumn+"_MAX_ID");
        }
    }
    for (i=1; i<=MK_CRAFTBODY_NUMBER_OF_BODYPARTS; i++)
    {
        DeleteLocalInt(oCreature, "MK_SaveSlot00_Part"+MK_IntToString(i,2,"0"));
    }
}

void MK_DoneBodyPart(object oCreature)
{
    int nBodyPart = MK_GetBodyPartToBeModified(oCreature);
    switch (nBodyPart)
    {
    case MK_CRAFTBODY_HORSE:
        if (MK_GetIsRiding(oCreature))
        {
            SetLocalInt(oCreature,MK_VAR_CURRENT_HORSE,GetCreatureTailType(oCreature));
        }
        break;
    }
    MK_CleanUpBodyPart(oCreature);
}

string MK_GetBodyPartName(int nPartToBeModified, int nBodyPart)
{
    string s2DA = "";
    string sColumn = "";

    switch (nPartToBeModified)
    {
    case MK_CRAFTBODY_HEAD:
        break;
    case MK_CRAFTBODY_BODY:
        break;
    case MK_CRAFTBODY_TAIL:
        s2DA = "TailModel";
        sColumn = "Label";
        break;
    case MK_CRAFTBODY_HORSE:
        s2DA = "TailModel";
        sColumn = "Label";
        break;
    case MK_CRAFTBODY_WINGS:
        s2DA = "WingModel";
        sColumn = "Label";
        break;
    case MK_CRAFTBODY_PHENOTYPE:
        s2DA = "PhenoType";
        sColumn = "Label";
        break;
    case MK_CRAFTBODY_PORTRAIT:
        s2DA = "Portraits";
        sColumn = "BaseResRef";
        break;
    case MK_CRAFTBODY_COLOR:
        break;
    }

    string sPartName = "";

    if ((s2DA!="") && (sColumn!=""))
    {
        sPartName = Get2DAString(s2DA, sColumn, nBodyPart);
    }
    return sPartName;
}

string MK_GetHorseName(int nHorse)
{
    string sHorseName;
    string sUser2DA = GetLocalString(OBJECT_SELF, "MK_2DA_VALID_HORSES");
    string sColumn = "Default";

    if (MK_GetIsValidBodyPart(MK_CRAFTBODY_HORSE, nHorse, sUser2DA, sColumn))
    {
        sHorseName=MK_GetBodyPartName(MK_CRAFTBODY_HORSE, nHorse);
    }
    else
    {
        sHorseName="No Horse";
    }
    return sHorseName;
}

string MK_GetRacialTypeAsString(object oCreature)
{
    string sRacialType="";
    int nRacialType = GetRacialType(oCreature);
    switch (nRacialType)
    {
    case RACIAL_TYPE_DWARF:
        sRacialType = "Dwarf";
        break;
    case RACIAL_TYPE_ELF:
        sRacialType = "Elf";
        break;
    case RACIAL_TYPE_GNOME:
        sRacialType = "Gnome";
        break;
    case RACIAL_TYPE_HALFELF:
        sRacialType = "Halfelf";
        break;
    case RACIAL_TYPE_HALFLING:
        sRacialType = "Halfling";
        break;
    case RACIAL_TYPE_HALFORC:
        sRacialType = "Halforc";
        break;
    case RACIAL_TYPE_HUMAN:
        sRacialType = "Human";
        break;
    default:
        sRacialType = IntToString(nRacialType);
        break;
    }
    return sRacialType;
}

string MK_GetGenderAsString(object oCreature)
{
    string sGender="";
    int nGender = GetGender(oCreature);
    switch (nGender)
    {
    case GENDER_FEMALE:
        sGender = "Female";
        break;
    case GENDER_MALE:
        sGender = "Male";
        break;
    }
    return sGender;
}

int MK_GetIsValidBodyPart(int nPartToBeModified, int nBodyPart, string sUser2DA, string sColumn)
{
    string sPartName = MK_GetBodyPartName(nPartToBeModified, nBodyPart);

    int bOk = FALSE;
    switch (nPartToBeModified)
    {
    case MK_CRAFTBODY_HEAD:
        bOk = TRUE;
        break;
    case MK_CRAFTBODY_BODY:
        bOk = TRUE;
        break;
    case MK_CRAFTBODY_TAIL:
        bOk = (sPartName!="");
        break;
    case MK_CRAFTBODY_WINGS:
        bOk = (sPartName!="");
        break;
    case MK_CRAFTBODY_PHENOTYPE:
        bOk = (sPartName!="");
        break;
    case MK_CRAFTBODY_HORSE:
        bOk = TRUE;
        break;
    case MK_CRAFTBODY_PORTRAIT:
        bOk = TRUE;
        break;
    case MK_CRAFTBODY_COLOR:
        bOk = TRUE;
        break;
    }

    if ((bOk) && (sUser2DA!=""))
    {
        bOk = StringToInt(Get2DAString(sUser2DA, sColumn, nBodyPart))>0;
    }

    return bOk;
}

int MK_GetMaxBodyPart(int nBodyPart)
{
    switch (nBodyPart)
    {
    case MK_CRAFTBODY_HEAD:
        return 250;
    case MK_CRAFTBODY_PORTRAIT:
        return 0;
    case MK_CRAFTBODY_COLOR:
        return 175;
    }

    string sVarName = "MK_BODYPART_"+IntToString(nBodyPart)+"_MAX_ID";

    int nMax = GetLocalInt(OBJECT_SELF, sVarName);

    if (nMax==0)
    {
        string s2DA="";
        string sColumn="";

        switch (nBodyPart)
        {
        case MK_CRAFTBODY_TAIL:
            s2DA = "tailmodel";
            sColumn = "LABEL";
            break;
        case MK_CRAFTBODY_HORSE:
            s2DA = "mk_horses";
            sColumn = "Default";
            break;
        case MK_CRAFTBODY_WINGS:
            s2DA = "wingmodel";
            sColumn = "LABEL";
            break;
        case MK_CRAFTBODY_PHENOTYPE:
            s2DA = "phenotype";
            sColumn = "Label";
            break;
        case MK_CRAFTBODY_PORTRAIT:
            break;
        }
//        SendMessageToPC(GetPCSpeaker(),"2DA="+s2DA+", Column="+sColumn);

        if ((s2DA!="") && (sColumn!=""))
        {
            int bContinue=TRUE;
            int nEmpty=1;
            int nMaxEmpty = GetLocalInt(OBJECT_SELF, "MK_2DA_MAX_HOLE_SIZE");
            while (bContinue)
            {
                if (Get2DAString(s2DA, sColumn, nMax+nEmpty)!="")
                {
                    nMax+=nEmpty;
                    nEmpty=1;
                }
                else
                {
                    nEmpty++;
                }
                bContinue = (nEmpty<=nMaxEmpty);
            }
            SetLocalInt(OBJECT_SELF, sVarName, nMax);
        }
    }
    return nMax;
}

void MK_NewBodyPart(object oCreature, int nMode)
{
    int nBodyPartToBeModified = MK_GetBodyPartToBeModified(oCreature);
    int nSubPartToBeModified = MK_GetSubPartToBeModified(oCreature);

    int nMin = 0;
    int nMax = 0;

    switch (nBodyPartToBeModified)
    {
    case MK_CRAFTBODY_BODY:
        nMax = MK_GetMaxBodyPartID(
            nSubPartToBeModified);
//            GetLocalInt(OBJECT_SELF,"X2_TAILOR_CURRENT_PART"));
        break;
    default:
        nMax = MK_GetMaxBodyPart(nBodyPartToBeModified);
        break;
    }

    int nBodyPart = MK_GetBodyPart(oCreature, nBodyPartToBeModified, nSubPartToBeModified);

    string sUser2DA="";
    string sColumn="Default";

    switch (nBodyPartToBeModified)
    {
    case MK_CRAFTBODY_HEAD:
        sUser2DA = GetLocalString(oCreature, "MK_2DA_VALID_HEADS");
        sColumn = MK_GetRacialTypeAsString(oCreature)+"_"+MK_GetGenderAsString(oCreature);
        break;
    case MK_CRAFTBODY_TAIL:
        sUser2DA = GetLocalString(oCreature, "MK_2DA_VALID_TAILS");
        break;
    case MK_CRAFTBODY_WINGS:
        sUser2DA = GetLocalString(oCreature, "MK_2DA_VALID_WINGS");
        break;
    case MK_CRAFTBODY_PHENOTYPE:
        sUser2DA = GetLocalString(oCreature, "MK_2DA_VALID_PHENOTYPES");
        break;
    case MK_CRAFTBODY_HORSE:
        sUser2DA = GetLocalString(oCreature, "MK_2DA_VALID_HORSES");
        break;
    }

    do
    {
        switch (nMode)
        {
        case MK_CRAFTBODY_NEXT:
            if (++nBodyPart>nMax) nBodyPart=nMin;
            break;
        case MK_CRAFTBODY_PREV:
            if (--nBodyPart<nMin) nBodyPart=nMax;
            break;
        }
    }
    while (!MK_GetIsValidBodyPart(nBodyPartToBeModified, nBodyPart, sUser2DA, sColumn));

    MK_SetBodyPart(nBodyPart,oCreature,nBodyPartToBeModified,nSubPartToBeModified);

    return;
}

void MK_SetBodyPartTokens(object oCreature)
{
    int nToBeModified = MK_GetBodyPartToBeModified(oCreature);
    int nSubPartToBeModified = MK_GetSubPartToBeModified(oCreature);

    string sBodyPart="";
    string sPartName="";

    int nBodyPart = MK_GetBodyPart(oCreature, nToBeModified,
        nSubPartToBeModified);

    switch (nToBeModified)
    {
    case MK_CRAFTBODY_BODY:
        nBodyPart = MK_BodyPart_ID2Model(
            nSubPartToBeModified,
            nBodyPart);
        sBodyPart = IntToString(nBodyPart);
        break;
    case MK_CRAFTBODY_PORTRAIT:
        if (nBodyPart==PORTRAIT_INVALID)
        {
            nBodyPart=MK_GetCustomPortraitId(oCreature);
            sBodyPart=(nBodyPart==PORTRAIT_INVALID ? "-" : IntToString(nBodyPart)+"C");
            sPartName = GetPortraitResRef(oCreature);
        }
        else
        {
            sBodyPart=IntToString(nBodyPart);
            sPartName = MK_GetBodyPartName(nToBeModified,nBodyPart);
        }
        break;
    default:
        sPartName = MK_GetBodyPartName(nToBeModified,nBodyPart);
        sBodyPart = IntToString(nBodyPart);
    }
    MK_SetBodyPartTokens2(sPartName, sBodyPart);
//    SetCustomToken(MK_CRAFTBODY_TOKEN_NAME, sPartName);
//    SetCustomToken(MK_CRAFTBODY_TOKEN_NUMBER, sBodyPart);
}

void MK_SetBodyPartTokens2(string sPartName, string sBodyPart)
{
    SetCustomToken(MK_CRAFTBODY_TOKEN_NAME, sPartName);
    SetCustomToken(MK_CRAFTBODY_TOKEN_NUMBER, sBodyPart);
}

int MK_GetMaxPortraitId(int bCustom=FALSE)
{
    string sVarName = (bCustom ? "MK_CUSTOM_MAX_ID" : "MK_PORTRAIT_MAX_ID");

    int nMax = GetLocalInt(OBJECT_SELF, sVarName);
    if (nMax==0)
    {
        string s2DA = (bCustom ? "MK_Portraits" : "Portraits");
        int bContinue=TRUE;
        int nEmpty=1;
        int nMaxEmpty = GetLocalInt(OBJECT_SELF, "MK_2DA_MAX_HOLE_SIZE");
        while (bContinue)
        {
            if (Get2DAString(s2DA, "BaseResRef", nMax+nEmpty)!="")
            {
                nMax+=nEmpty;
                nEmpty=1;
            }
            else
            {
                nEmpty++;
            }
            bContinue = (nEmpty<=nMaxEmpty);
        }
        SetLocalInt(OBJECT_SELF, sVarName, nMax);
    }
    return nMax;
}

int MK_GetPortraitIdFromResRef(string sResRef, int bCustom=FALSE)
{
    int nMin = 1;
    int nMax = MK_GetMaxPortraitId(bCustom);

    int bFound=FALSE;
    string sResRef0=GetStringLowerCase(sResRef);
    string sResRef1;

    string s2DA = (bCustom ? "MK_Portraits" : "Portraits");

    int iId=nMin-1;
    while ((!bFound) && (iId<nMax))
    {
        sResRef1=GetStringLowerCase(
            Get2DAString(s2DA, "BaseResRef", ++iId));
        bFound = (sResRef0==sResRef1);
    }

    if (!bFound)
    {
        iId = PORTRAIT_INVALID;
    }
    return iId;
}

int MK_GetPortraitId(object oTarget=OBJECT_SELF)
{
    int nId = GetPortraitId(oTarget);

    if (nId==PORTRAIT_INVALID)
    {
        string sResRef = GetPortraitResRef(oTarget);

        if (sResRef!="")
        {
            if (GetStringLowerCase(GetStringLeft(sResRef,3))=="po_")
            {
                sResRef=GetSubString(sResRef,3,GetStringLength(sResRef)-3);
                nId = MK_GetPortraitIdFromResRef(sResRef);
            }
        }
    }
    return nId;
}

int MK_GetCustomPortraitId(object oTarget=OBJECT_SELF)
{
    int nId = PORTRAIT_INVALID;

    string sResRef = GetPortraitResRef(oTarget);
    if (sResRef!="")
    {
        nId = MK_GetPortraitIdFromResRef(sResRef, TRUE);
    }
    return nId;
}



void MK_NewPortrait(object oCreature, int nMode)
{
    int bCustom = (nMode==MK_PORTRAIT_RESREF_NEXT)||(nMode==MK_PORTRAIT_RESREF_PREV);
    int nMin = 1;
    int nMax = MK_GetMaxPortraitId(bCustom);

    string sRace = IntToString(GetRacialType(oCreature));
    string sGender = IntToString(GetGender(oCreature));

    int bIgnoreGender = GetLocalInt(OBJECT_SELF, "MK_PORTRAIT_IGNORE_GENDER");
    int bIgnoreRace =  GetLocalInt(OBJECT_SELF, "MK_PORTRAIT_IGNORE_RACE");

    int nCurrId;
    if (bCustom)
    {
        nCurrId = GetLocalInt(oCreature, "MK_CURRENT_CUSTOM_PORTRAIT");
        if ((nCurrId==PORTRAIT_INVALID) || (nCurrId==0))
        {
            nCurrId = MK_GetCustomPortraitId(oCreature);
        }
    }
    else
    {
        SetLocalInt(oCreature, "MK_CURRENT_CUSTOM_PORTRAIT", PORTRAIT_INVALID);
        nCurrId = MK_GetPortraitId(oCreature);
    }

    string s2DA = (bCustom ? "MK_Portraits" : "Portraits");
    string sColResRef = "BaseResRef";
    string sColGender = "Sex";
    string sColRace = "Race";

    int bPortraitIsValid=TRUE;

    string sResRef;

    do
    {
        switch (nMode)
        {
        case MK_PORTRAIT_ID_NEXT:
        case MK_PORTRAIT_RESREF_NEXT:
            if ((nCurrId==PORTRAIT_INVALID) || (++nCurrId > nMax))
            {
                nCurrId=nMin;
            }
            break;
        case MK_PORTRAIT_ID_PREV:
        case MK_PORTRAIT_RESREF_PREV:
            if ((nCurrId==PORTRAIT_INVALID) || (--nCurrId < nMin))
            {
                nCurrId=nMax;
            }
            break;
        }
        sResRef = Get2DAString(s2DA, sColResRef, nCurrId);
        bPortraitIsValid = (sResRef!="");

        bPortraitIsValid&=((bIgnoreGender)|(Get2DAString(s2DA, sColGender, nCurrId)==sGender));
        bPortraitIsValid&=((bIgnoreRace)|(Get2DAString(s2DA, sColRace, nCurrId)==sGender));
    }
    while (!bPortraitIsValid);

    if (bCustom)
    {
        SetPortraitResRef(oCreature, sResRef);
    }
    else
    {
        SetPortraitId(oCreature, nCurrId);
    }
}

int MK_GetMaxBodyPartID(int nCreaturePart)
{
    string sColumn = Get2DAString("capart","MDLNAME",nCreaturePart);
    if (sColumn=="") return -1;

    string sVarName = "MK_"+sColumn+"_MAX_ID";
    int nMax = GetLocalInt(OBJECT_SELF,sVarName);

    if (nMax==0)
    {
        string s2DA = "MK_BodyParts";
        int bContinue=TRUE;
        int nEmpty=1;
        int nMaxEmpty=1;
        while (bContinue)
        {
            if (Get2DAString(s2DA, sColumn, nMax+nEmpty)!="")
            {
                nMax+=nEmpty;
                nEmpty=1;
            }
            else
            {
                nEmpty++;
            }
            bContinue = (nEmpty<=nMaxEmpty);
        }
        SetLocalInt(OBJECT_SELF, sVarName, nMax);
    }
    return nMax;
}

int MK_PhenoTypeNormal2Ride(int nPhenoType)
{
    return StringToInt(Get2DAString(MK_2DA_RIDE_PHENO, "Ride", nPhenoType));
}

int MK_PhenoTypeRide2Normal(int nPhenoType)
{
    return StringToInt(Get2DAString(MK_2DA_RIDE_PHENO, "Normal", nPhenoType));
}

int MK_GetIsRiding(object oCreature)
{
    int nPhenoTypeNormal = GetPhenoType(oCreature);
    int nPhenoTypeRide = MK_PhenoTypeNormal2Ride(nPhenoTypeNormal);

    return (nPhenoTypeRide==0);
}

int MK_CreatureMountHorse(object oCreature, int nHorse)
{
    int nPhenoTypeNormal, nPhenoTypeRide, nTailType;
    if (nHorse==0)
    {
        nPhenoTypeRide = GetPhenoType(oCreature);
        nPhenoTypeNormal = MK_PhenoTypeRide2Normal(nPhenoTypeRide);

        nTailType = GetLocalInt(oCreature, MK_VAR_CURRENT_TAIL);

        SetPhenoType(nPhenoTypeNormal, oCreature);
        SetCreatureTailType(nTailType, oCreature);
    }
    else if (nHorse>0)
    {
        nPhenoTypeNormal = GetPhenoType(oCreature);
        nPhenoTypeRide = MK_PhenoTypeNormal2Ride(nPhenoTypeNormal);
        if (nPhenoTypeRide!=0)
        {
            nTailType = GetCreatureTailType(oCreature);

            SetLocalInt(oCreature, MK_VAR_CURRENT_TAIL, nTailType);
            SetPhenoType(nPhenoTypeRide, oCreature);
        }
        SetCreatureTailType(nHorse, oCreature);
    }
    return TRUE;
}

void MK_SetCustomTokenToHorseName(int nCustomTokenNumber, int nHorse)
{
    string sHorseName = MK_GetHorseName(nHorse);
    SetCustomToken(nCustomTokenNumber,
        sHorseName + "(" + IntToString(nHorse) + ")");
}

int MK_InitializeHorseSelection(object oCreature)
{
    int bIsRiding = MK_GetIsRiding(oCreature);
    int nCurrentHorse = GetLocalInt(oCreature, MK_VAR_CURRENT_HORSE);

    if (nCurrentHorse != 0)
    {
        MK_SetCustomTokenToHorseName(14440,nCurrentHorse);
    }
    MK_SetCustomTokenToHorseName(14441,MK_HORSE_1);
    MK_SetCustomTokenToHorseName(14442,MK_HORSE_2);
    MK_SetCustomTokenToHorseName(14443,MK_HORSE_3);
    MK_SetCustomTokenToHorseName(14444,MK_HORSE_4);
    MK_SetCustomTokenToHorseName(14445,MK_HORSE_5);

    return TRUE;
}



/*
void main()
{

}
/**/
