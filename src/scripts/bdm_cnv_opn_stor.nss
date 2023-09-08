//::///////////////////////////////////////////////
//:: Name:      Bedlamson's Dynamic Merchant System
//::            Conversation 'Actions Taken'
//:: FileName:  bdm_cnv_opn_stor
//:: Copyright (c) 2003 Stephen Spann
//::///////////////////////////////////////////////
//:: Created By: Bedlamson
//:: Created On: 1/23/2003
//::///////////////////////////////////////////////

#include "bdm_include"

void main()
{
// Get local variables.
object oStoreToOpen = GetLocalObject(OBJECT_SELF, "STORE");
string sParams = GetLocalString(OBJECT_SELF, "PARAMS");
object oPC = GetPCSpeaker();

// Set who opened the store for other scripts
SetLocalObject(oStoreToOpen, "LAST_OPENED_BY", oPC);

// Get variables from the parameters.
int nHaggleDC = GetValue(oStoreToOpen, "DC", sParams);

int nFavorsRace = GetValue(oStoreToOpen, "FR", sParams);
int nFavorsClass = GetValue(oStoreToOpen, "FC", sParams);
int nFavorsAlignment = GetValue(oStoreToOpen, "FA", sParams);
int nFavorsGender = GetValue(oStoreToOpen, "FG", sParams);
int nFavorsSubrace = GetValue(oStoreToOpen, "FS", sParams);
int nFavorsPercent = GetValue(oStoreToOpen, "FP", sParams);
int nFavorsLinked = GetValue(oStoreToOpen, "FL", sParams);
int nFavorsBuy = GetValue(oStoreToOpen, "FB", sParams);
int nFavorsSell = GetValue(oStoreToOpen, "FE", sParams);
int nFavorsUnlimited = GetValue(oStoreToOpen, "FU", sParams);

int nDislikesRace = GetValue(oStoreToOpen, "PR", sParams);
int nDislikesClass = GetValue(oStoreToOpen, "PC", sParams);
int nDislikesAlignment = GetValue(oStoreToOpen, "PA", sParams);
int nDislikesGender = GetValue(oStoreToOpen, "PG", sParams);
int nDislikesSubrace = GetValue(oStoreToOpen, "PS", sParams);
int nDislikesPercent = GetValue(oStoreToOpen, "PP", sParams);
int nDislikesLinked = GetValue(oStoreToOpen, "PL", sParams);
int nDislikesBuy = GetValue(oStoreToOpen, "PB", sParams);
int nDislikesSell = GetValue(oStoreToOpen, "PE", sParams);
int nDislikesUnlimited = GetValue(oStoreToOpen, "PU", sParams);

if (nDebug) SendMessageToPC(oPC, "Favors Gender: " + IntToString(nFavorsGender) + " Dislikes Gender " + IntToString(nDislikesGender));

int nMarkUp;
int nMarkDown;

int nAlignBonus;
int nAlignPenalty;
int nClassBonus;
int nClassPenalty;
int nRaceBonus;
int nRacePenalty;
int nGenderBonus;
int nGenderPenalty;
int nSubraceBonus;
int nSubracePenalty;

if (nHaggleDC)
    {
    int nHaggleAll = GetValue(oStoreToOpen, "HA", sParams);
    int nHaggleUp = GetValue(oStoreToOpen, "HU", sParams);
    int nHaggleDown = GetValue(oStoreToOpen, "HD", sParams);
    int nHaggleBuy = GetValue(oStoreToOpen, "HB", sParams);
    int nHaggleSell = GetValue(oStoreToOpen, "HS", sParams);
    int nHagglePercent = GetValue(oStoreToOpen, "HP", sParams);
    int nHaggleCumulative = GetValue(oStoreToOpen, "HC", sParams);
    int nHaggleScore = GetSkillRank(SKILL_PERSUADE, oPC) + GetAbilityModifier(ABILITY_CHARISMA, oPC);

    int nFinalPercent;
    int nResult = nHaggleScore - nHaggleDC;
    if (nHaggleCumulative) nFinalPercent = abs(nResult * nHagglePercent);
    if (!nHaggleCumulative) nFinalPercent = nHagglePercent;

    int nHaggleModifier = GetValue(oStoreToOpen, "HM", sParams);
    int nPassModifier = GetValue(oStoreToOpen, "PM", sParams);
    int nFailModifier = GetValue(oStoreToOpen, "FM", sParams);

    // Good for PC, items sold by store
    if (nResult > (0 + nPassModifier + nHaggleModifier) && (nHaggleAll || nHaggleDown && !nHaggleSell || nHaggleBuy && !nHaggleUp || (nHaggleDown && nHaggleBuy))) nMarkUp = nFinalPercent * -1;
    // Good for PC, items bought by store
    if (nResult > (0 + nPassModifier + nHaggleModifier) && (nHaggleAll || nHaggleDown && !nHaggleBuy || nHaggleSell && !nHaggleUp || (nHaggleDown && nHaggleSell))) nMarkDown = nFinalPercent;
    // Bad for PC, items sold by store
    if (nResult < (0 - nFailModifier - nHaggleModifier) && (nHaggleAll || nHaggleUp && !nHaggleSell || nHaggleBuy && !nHaggleDown || (nHaggleUp && nHaggleBuy))) nMarkUp = nFinalPercent;
    // Bad for PC, items bought by store
    if (nResult < (0 - nFailModifier - nHaggleModifier) && (nHaggleAll || nHaggleUp && !nHaggleBuy || nHaggleSell && !nHaggleDown || (nHaggleUp && nHaggleSell))) nMarkDown = nFinalPercent * -1;

    if (nDebug) SendMessageToPC(oPC, "DC: " + IntToString(nHaggleDC) + "Score: " + IntToString(nHaggleScore) + "Result: " + IntToString(nResult) + "Haggle Percent: " + IntToString(nHagglePercent) + "Final Percent: " + IntToString(nFinalPercent));
    if (nDebug) SendMessageToPC(oPC, "Haggle Modifier: " + IntToString(nHaggleModifier));
    }

if (nFavorsAlignment)
    {
    int iNumberPos = FindSubString(sParams, "FA");
    int nParamPos = iNumberPos + 2;
    string sAlign = GetSubString(sParams, (nParamPos), 2);
    while (sAlign != "")
        {
        if (CheckAlignment(sAlign, oPC))
            {
            nAlignBonus = nFavorsPercent;
            break;
            }

        if (GetSubString(sParams, (nParamPos + 2), 1) != "_" &&
            GetSubString(sParams, (nParamPos + 2), 1) == "A")
            {
            nParamPos = nParamPos + 3;
            sAlign = GetSubString(sParams, (nParamPos), 2);
            }
        else
            {
            sAlign = "";
            }
        }
    }

if (nDislikesAlignment)
    {
    int iNumberPos = FindSubString(sParams, "PA");
    int nParamPos = iNumberPos + 2;
    string sAlign = GetSubString(sParams, (nParamPos), 2);
    while (sAlign != "")
        {
        if (CheckAlignment(sAlign, oPC))
            {
            nAlignPenalty = nDislikesPercent;
            break;
            }

        if (GetSubString(sParams, (nParamPos + 2), 1) == "A")
            {
            nParamPos = nParamPos + 3;
            sAlign = GetSubString(sParams, (nParamPos), 2);
            }
        else
            {
            sAlign = "";
            }
        }
    }

if (nFavorsClass)
    {
    int iNumberPos = FindSubString(sParams, "FC");
    int nParamPos = iNumberPos + 2;
    string sClass = GetSubString(sParams, nParamPos, 2);
    while (sClass != "")
        {
        if (CheckClass(sClass, oPC))
            {
            nClassBonus = nFavorsPercent;
            break;
            }

        if (GetSubString(sParams, (nParamPos + 2), 1) == "A")
            {
            nParamPos = nParamPos + 3;
            sClass = GetSubString(sParams, (nParamPos), 2);
            }
        else
            {
            sClass = "";
            }
        }
    }

if (nDislikesClass)
    {
    int iNumberPos = FindSubString(sParams, "PC");
    int nParamPos = iNumberPos + 2;
    string sClass = GetSubString(sParams, nParamPos, 2);
    while (sClass != "")
        {
        if (CheckClass(sClass, oPC))
            {
            nClassPenalty = nDislikesPercent;
            break;
            }

        if (GetSubString(sParams, (nParamPos + 2), 1) == "A")
            {
            nParamPos = nParamPos + 3;
            sClass = GetSubString(sParams, (nParamPos), 2);
            }
        else
            {
            sClass = "";
            }
        }
    }

if (nFavorsRace)
    {
    int iNumberPos = FindSubString(sParams, "FR");
    int nParamPos = iNumberPos + 2;
    string sRace = GetSubString(sParams, nParamPos, 2);
    while (sRace != "")
        {
        if (CheckRace(sRace, oPC))
            {
            nRaceBonus = nFavorsPercent;
            break;
            }
        if (GetSubString(sParams, (nParamPos + 2), 1) != "_" &&
            GetSubString(sParams, (nParamPos + 2), 1) == "A")
            {
            nParamPos = nParamPos + 3;
            sRace = GetSubString(sParams, (nParamPos), 2);
            }
        else
            {
            sRace = "";
            }
        }
    }

if (nDislikesRace)
    {
    int iNumberPos = FindSubString(sParams, "PR");
    int nParamPos = iNumberPos + 2;
    string sRace = GetSubString(sParams, nParamPos, 2);
    while (sRace != "")
        {
        if (CheckRace(sRace, oPC))
            {
            nRacePenalty = nDislikesPercent;
            break;
            }
        if (GetSubString(sParams, (nParamPos + 2), 1) != "_" &&
            GetSubString(sParams, (nParamPos + 2), 1) == "A")
            {
            nParamPos = nParamPos + 3;
            sRace = GetSubString(sParams, (nParamPos), 2);
            }
        else
            {
            sRace = "";
            }
        }
    }

if (nFavorsSubrace)
    {
    int iNumberPos = FindSubString(sParams, "FS");
    int nParamPos = iNumberPos + 2;
    string sRace = GetSubString(sParams, nParamPos, 2);
    while (sRace != "")
        {
        if (CheckSubrace(sRace, oPC))
            {
            nRaceBonus = nFavorsPercent;
            break;
            }
        if (GetSubString(sParams, (nParamPos + 2), 1) != "_" &&
            GetSubString(sParams, (nParamPos + 2), 1) == "A")
            {
            nParamPos = nParamPos + 3;
            sRace = GetSubString(sParams, (nParamPos), 2);
            }
        else
            {
            sRace = "";
            }
        }
    }

if (nDislikesSubrace)
    {
    int iNumberPos = FindSubString(sParams, "PS");
    int nParamPos = iNumberPos + 2;
    string sRace = GetSubString(sParams, nParamPos, 2);
    while (sRace != "")
        {
        if (CheckSubrace(sRace, oPC))
            {
            nRacePenalty = nDislikesPercent;
            break;
            }
        if (GetSubString(sParams, (nParamPos + 2), 1) != "_" &&
            GetSubString(sParams, (nParamPos + 2), 1) == "A")
            {
            nParamPos = nParamPos + 3;
            sRace = GetSubString(sParams, (nParamPos), 2);
            }
        else
            {
            sRace = "";
            }
        }
    }

if (nDebug) SendMessageToPC(oPC, "Favors Gender: " + IntToString(nFavorsGender) + " Dislikes Gender " + IntToString(nDislikesGender));

if (nFavorsGender)
    {
    int iNumberPos = FindSubString(sParams, "FG");
    string sGender = GetSubString(sParams, (iNumberPos + 2), 1);
    if (CheckGender(sGender, oPC)) nGenderBonus = nFavorsPercent;
    if (nDebug) SendMessageToPC(oPC, "Check Gender: " + IntToString(CheckGender(sGender, oPC)));
    }

if (nDislikesGender)
    {
    int iNumberPos = FindSubString(sParams, "PG");
    string sGender = GetSubString(sParams, (iNumberPos + 2), 1);
    if (CheckGender(sGender, oPC)) nGenderPenalty = nDislikesPercent;
    if (nDebug) SendMessageToPC(oPC, "Check Gender: " + IntToString(CheckGender(sGender, oPC)));
    }
if (nDebug) SendMessageToPC(oPC, "Gender Bonus: " + IntToString(nGenderBonus) + " Gender Penalty: " + IntToString(nGenderPenalty));

while (nFavorsLinked)
    {
    if (nFavorsAlignment && !nAlignBonus) break;
    if (nFavorsClass && !nClassBonus) break;
    if (nFavorsRace && !nRaceBonus) break;
    if (nFavorsGender && !nGenderBonus) break;
    if (nFavorsSubrace && !nSubraceBonus) break;
    if (!nFavorsBuy && nFavorsUnlimited) nMarkUp = nMarkUp - nAlignBonus - nClassBonus - nRaceBonus - nGenderBonus - nSubraceBonus;
    if (!nFavorsSell && nFavorsUnlimited) nMarkDown = nMarkDown + nAlignBonus + nClassBonus + nRaceBonus + nGenderBonus + nSubraceBonus;
    if (!nFavorsBuy && !nFavorsUnlimited && (nAlignBonus || nClassBonus || nRaceBonus || nGenderBonus || nSubraceBonus)) nMarkUp = nMarkUp - nFavorsPercent;
    if (!nFavorsSell && !nFavorsUnlimited && (nAlignBonus || nClassBonus || nRaceBonus || nGenderBonus || nSubraceBonus)) nMarkDown = nMarkDown + nFavorsPercent;
    if (nDebug) SendMessageToPC(oPC, "Favors linked.");
    break;
    }

while (nDislikesLinked)
    {
    if (nDislikesAlignment && !nAlignPenalty) break;
    if (nDislikesClass && !nClassPenalty) break;
    if (nDislikesRace && !nRacePenalty) break;
    if (nDislikesGender && !nGenderPenalty) break;
    if (nDislikesSubrace && !nSubracePenalty) break;
    if (!nDislikesBuy && nDislikesUnlimited) nMarkUp = nMarkUp + nAlignPenalty + nClassPenalty + nRacePenalty + nGenderPenalty + nSubracePenalty;
    if (!nDislikesSell && nDislikesUnlimited) nMarkDown = nMarkDown - nAlignPenalty - nClassPenalty - nRacePenalty - nGenderPenalty - nSubracePenalty;
    if (!nDislikesBuy && !nDislikesUnlimited && (nAlignPenalty || nClassPenalty || nRacePenalty || nGenderPenalty || nSubracePenalty)) nMarkUp = nMarkUp + nDislikesPercent;
    if (!nDislikesSell && !nDislikesUnlimited && (nAlignPenalty || nClassPenalty || nRacePenalty || nGenderPenalty || nSubracePenalty)) nMarkDown = nMarkDown - nDislikesPercent;
    if (nDebug) SendMessageToPC(oPC, "Prejudice linked.");
    break;
    }

if (!nFavorsLinked)
    {
    if (!nFavorsBuy && nFavorsUnlimited) nMarkUp = nMarkUp - nAlignBonus - nClassBonus - nRaceBonus - nGenderBonus - nSubraceBonus;
    if (!nFavorsSell && nFavorsUnlimited) nMarkDown = nMarkDown + nAlignBonus + nClassBonus + nRaceBonus + nGenderBonus + nSubraceBonus;
    if (!nFavorsBuy && !nFavorsUnlimited && (nAlignBonus || nClassBonus || nRaceBonus || nGenderBonus || nSubraceBonus)) nMarkUp = nMarkUp - nFavorsPercent;
    if (!nFavorsSell && !nFavorsUnlimited && (nAlignBonus || nClassBonus || nRaceBonus || nGenderBonus || nSubraceBonus)) nMarkDown = nMarkDown + nFavorsPercent;
    if (nDebug) SendMessageToPC(oPC, "Favors not linked.");
    }

if (!nDislikesLinked)
    {
    if (nDebug) SendMessageToPC(oPC, "Dislikes Buy : " + IntToString(nDislikesBuy) + " Dislikes Sell: " + IntToString(nDislikesSell));
    if (nDebug) SendMessageToPC(oPC, "Mark Up Before: " + IntToString(nMarkUp) + " Mark Down: " + IntToString(nMarkDown));
    if (!nDislikesBuy && nDislikesUnlimited) nMarkUp = nMarkUp + nAlignPenalty + nClassPenalty + nRacePenalty + nGenderPenalty + nSubracePenalty;
    if (!nDislikesSell && nDislikesUnlimited) nMarkDown = nMarkDown - nAlignPenalty - nClassPenalty - nRacePenalty - nGenderPenalty - nSubracePenalty;
    if (!nDislikesBuy && !nDislikesUnlimited && (nAlignPenalty || nClassPenalty || nRacePenalty || nGenderPenalty || nSubracePenalty)) nMarkUp = nMarkUp + nDislikesPercent;
    if (!nDislikesSell && !nDislikesUnlimited && (nAlignPenalty || nClassPenalty || nRacePenalty || nGenderPenalty || nSubracePenalty)) nMarkDown = nMarkDown - nDislikesPercent;
    if (nDebug) SendMessageToPC(oPC, "Prejudice not linked.");
    }

if (nDebug) SendMessageToPC(oPC, "Favors Percent: " + IntToString(nFavorsPercent) + " Prejudice Percent: " + IntToString(nDislikesPercent));

if (nMarkUp > 100) nMarkUp = 100;
if (nMarkUp < -100) nMarkUp = -100;
if (nMarkDown > 100) nMarkDown = 100;
if (nMarkDown < -100) nMarkDown = -100;

if (nDebug) SendMessageToPC(oPC, "Mark Up After: " + IntToString(nMarkUp) + " Mark Down: " + IntToString(nMarkDown));

OpenStore(oStoreToOpen, oPC, nMarkUp, nMarkDown);
}
