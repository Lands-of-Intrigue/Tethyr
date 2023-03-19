int FeatCheck(string sFeat, object oPC)
{
int nFeat;
if (sFeat=="Runesmith") nFeat=1404;                             /*1404*/
if (sFeat=="Craft_Magic_Arms_And_Armor") nFeat=1405;            /*1405*/
if (sFeat=="Craft_Wonderous_Item") nFeat=1406;                  /*1406*/
if (sFeat=="History") nFeat=1426;                               /*1426*/
if (sFeat=="Astrology") nFeat=1427;                             /*1427*/
if (sFeat=="Decipher_Script") nFeat=1428;                       /*1428*/
if (sFeat=="Siege_Engineering") nFeat=1429;                     /*1429*/
if (sFeat=="Fire_Building") nFeat=1430;                         /*1430*/
if (sFeat=="Herbalism") nFeat=1431;                             /*1431*/
if (sFeat=="Armoring") nFeat=1432;                              /*1432*/
if (sFeat=="Carpentry") nFeat=1433;                             /*1433*/
if (sFeat=="Tailoring") nFeat=1434;                             /*1434*/
if (sFeat=="Masonry") nFeat=1435;                               /*1435*/
if (sFeat=="Mining") nFeat=1436;                                /*1436*/
if (sFeat=="Hunting") nFeat=1437;                               /*1437*/
if (sFeat=="Wood_Gathering") nFeat=1438;                        /*1438*/
if (sFeat=="Tracking") nFeat=1439;                              /*1439*/
if (sFeat=="Alchemy") nFeat=1481;
if (sFeat=="") return TRUE;
if (GetHasFeat(nFeat, oPC) == TRUE) return TRUE;
else return FALSE;
}

