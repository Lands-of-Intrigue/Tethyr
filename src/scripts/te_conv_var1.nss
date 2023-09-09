int StartingConditional()
{

    object oPC = GetPCSpeaker();

    if(GetLocalString(OBJECT_SELF,"convar1") == "elf" && GetRacialType(oPC) == RACIAL_TYPE_ELF ) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "gnome" && GetRacialType(oPC) == RACIAL_TYPE_ELF ) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "half-elf" && GetRacialType(oPC) == RACIAL_TYPE_HALFELF )  {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "halfling" && GetRacialType(oPC) == RACIAL_TYPE_HALFLING ) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "half-orc" && GetRacialType(oPC) == RACIAL_TYPE_HALFORC )  {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "affluence" && GetHasFeat(1153,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "brawler" && GetHasFeat(1154,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "cosmopolitan" && GetHasFeat(1155,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "crusader" && GetHasFeat(1156,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "duelist" && GetHasFeat(1157,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "evangelist" && GetHasFeat(1158,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "forester" && GetHasFeat(1159,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "hard laborer" && GetHasFeat(1160,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "healer" && GetHasFeat(1161,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "knight" && GetHasFeat(1162,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "hedgemage" && GetHasFeat(1163,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "mendicant" && GetHasFeat(1164,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "merchant" && GetHasFeat(1165,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "minstrel" && GetHasFeat(1167,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "occultist" && GetHasFeat(1168,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "saboteur" && GetHasFeat(1169,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "scout" && GetHasFeat(1170,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "thief" && GetHasFeat(1171,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "soldier" && GetHasFeat(1172,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "traveler" && GetHasFeat(1173,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "spellfire" && GetHasFeat(1174,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "shadow weave" && GetHasFeat(1176,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "amnian trained" && GetHasFeat(1389,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "calishite trained" && GetHasFeat(1390,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "caravanner" && GetHasFeat(1391,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "chuch acolyte" && GetHasFeat(1392,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "circle born" && GetHasFeat(1393,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "enlightened student" && GetHasFeat(1394,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "harem trained" && GetHasFeat(1395,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "harper protege" && GetHasFeat(1396,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "knight squire" && GetHasFeat(1397,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "talfirian lineage" && GetHasFeat(1398,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "theocrat" && GetHasFeat(1399,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "ward of the triad" && GetHasFeat(1400,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "zhentarim informer" && GetHasFeat(1401,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "eldreth veluuthra" && GetHasFeat(1460,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "elmanesse tribe" && GetHasFeat(1461,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "suldusk tribe" && GetHasFeat(1462,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "dukes warband" && GetHasFeat(1463,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "calishite slave" && GetHasFeat(1464,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "seldarine priest" && GetHasFeat(1465,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "high mage" && GetHasFeat(1466,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "underdark exile" && GetHasFeat(1467,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "thunder twin" && GetHasFeat(1468,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "heir to the throne" && GetHasFeat(1469,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "mordinsamman priest" && GetHasFeat(1470,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "wary swordknight" && GetHasFeat(1471,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "copper elf" && GetHasFeat(1177,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "green elf" && GetHasFeat(1178,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "silver elf" && GetHasFeat(1179,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "gold elf" && GetHasFeat(1180,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "dark elf" && GetHasFeat(1181,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "gold dwarf" && GetHasFeat(1182,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "grey dwarf" && GetHasFeat(1183,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "shield dwarf" && GetHasFeat(1184,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "aasimar" && GetHasFeat(1186,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "tiefling" && GetHasFeat(1187,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "natural lycan" && GetHasFeat(1175,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "ffolk" && GetHasFeat(1445,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "chultan" && GetHasFeat(1446,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "imaskari" && GetHasFeat(1447,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "maztican" && GetHasFeat(1448,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "netherese" && GetHasFeat(1449,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "shaaran" && GetHasFeat(1450,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "shou" && GetHasFeat(1451,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "deep_gnome" && GetHasFeat(1452,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "forest_gnome" && GetHasFeat(1453,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "rock_gnome" && GetHasFeat(1454,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "ghostwise" && GetHasFeat(1455,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "lightfoot" && GetHasFeat(1456,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "strongheart" && GetHasFeat(1457,oPC)) {return TRUE;}
    else if(GetLocalString(OBJECT_SELF,"convar1") == "feyri" && GetHasFeat(1458,oPC)) {return TRUE;}
    else {return FALSE;}
}
