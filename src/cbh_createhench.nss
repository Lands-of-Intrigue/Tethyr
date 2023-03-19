void main()
{
ExecuteScript("nw_c2_default4", OBJECT_SELF);
int nRace, nSex, nPackage, nStatus;
int nPtrn = GetListenPatternNumber();
object oPC;
object oContract;

//Listening Patterns
//   Race Listening Patterns
SetListenPattern(OBJECT_SELF, "Begin", 1);
SetListenPattern(OBJECT_SELF, "Human", 2);
SetListenPattern(OBJECT_SELF, "Dwarf", 3);
SetListenPattern(OBJECT_SELF, "Elf", 4);
SetListenPattern(OBJECT_SELF, "Halfling", 5);
SetListenPattern(OBJECT_SELF, "Half-Orc", 6);
SetListenPattern(OBJECT_SELF, "Gnome", 7);


//   Gender Listening Patterns
SetListenPattern(OBJECT_SELF, "Male", 8);
SetListenPattern(OBJECT_SELF, "Female", 9);


//   Class Listening Patterns
SetListenPattern(OBJECT_SELF, "Cleric", 11);
SetListenPattern(OBJECT_SELF, "Fighter", 12);
SetListenPattern(OBJECT_SELF, "Rogue", 13);
SetListenPattern(OBJECT_SELF, "Wizard", 14);
SetListenPattern(OBJECT_SELF, "Bard", 15);
SetListenPattern(OBJECT_SELF, "Druid", 16);
SetListenPattern(OBJECT_SELF, "Monk", 17);
SetListenPattern(OBJECT_SELF, "Paladin", 18);
SetListenPattern(OBJECT_SELF, "Ranger", 19);
SetListenPattern(OBJECT_SELF, "Barbarian", 1001);
SetListenPattern(OBJECT_SELF, "Sorcerer", 1002);


//   Cleric Packages
SetListenPattern(OBJECT_SELF, "General Cleric", 21);
SetListenPattern(OBJECT_SELF, "Shaman", 22);
SetListenPattern(OBJECT_SELF, "Battle Priest", 23);


//   Fighter Packages
SetListenPattern(OBJECT_SELF, "General Fighter", 31);
SetListenPattern(OBJECT_SELF, "Battle Commander", 32);
SetListenPattern(OBJECT_SELF, "Pirate", 33);
SetListenPattern(OBJECT_SELF, "Gladiator", 34);

//   Rogue Packages
SetListenPattern(OBJECT_SELF, "General Rogue", 41);
SetListenPattern(OBJECT_SELF, "Bandit", 42);
SetListenPattern(OBJECT_SELF, "Scout", 43);
SetListenPattern(OBJECT_SELF, "Swashbuckler", 44);

//   Bard Packages
SetListenPattern(OBJECT_SELF, "General Bard", 51);
SetListenPattern(OBJECT_SELF, "Blade", 52);
SetListenPattern(OBJECT_SELF, "Jester", 53);

//   Druid Packages
SetListenPattern(OBJECT_SELF, "General Druid", 61);
SetListenPattern(OBJECT_SELF, "Hawkmaster", 62);
SetListenPattern(OBJECT_SELF, "Interloper", 63);

//   Monk Packages
SetListenPattern(OBJECT_SELF, "General Monk", 71);
SetListenPattern(OBJECT_SELF, "Assassin", 72);
SetListenPattern(OBJECT_SELF, "Devout", 73);
SetListenPattern(OBJECT_SELF, "Spirit", 74);

//   Paladin Packages
SetListenPattern(OBJECT_SELF, "General Paladin", 81);
SetListenPattern(OBJECT_SELF, "Divine", 82);
SetListenPattern(OBJECT_SELF, "Inquisitor", 83);
SetListenPattern(OBJECT_SELF, "Undead Hunter", 84);

//   Ranger Packages
SetListenPattern(OBJECT_SELF, "General Ranger", 91);
SetListenPattern(OBJECT_SELF, "Marksman", 92);
SetListenPattern(OBJECT_SELF, "Stalker", 93);
SetListenPattern(OBJECT_SELF, "Warden", 94);

//   Barbarian Packages
SetListenPattern(OBJECT_SELF, "General Barbarian", 1011);
SetListenPattern(OBJECT_SELF, "Brute", 1012);
SetListenPattern(OBJECT_SELF, "Savage", 1013);
SetListenPattern(OBJECT_SELF, "Slayer", 1014);

//Finishing
SetListenPattern(OBJECT_SELF, "Yes", 100);

//Questions
string q1 = "First, you must choose a race.  Tell, me would you like a 'Human', 'Dwarf', 'Elf', 'Halfling', 'Half-Orc' or 'Gnome'.";
string q2 = "Would you prefer a 'Male' or a 'Female'?";
string q3 = "Now you must choose their skills.  Are you looking for a 'Barbarian', 'Bard', 'Cleric', 'Druid', 'Fighter', 'Monk', 'Paladin', 'Ranger', 'Rogue', 'Sorcerer' or 'Wizard'?";
string q4 = "We have several clerics, would you like a 'General Cleric', 'Shaman' or 'Battle Priest'?";
string q5 = "We have several fighters, would you like a 'General Fighter, 'Battle Commander', 'Pirate' or 'Gladiator'?";
string q6 = "We have several rogues, would you like a 'General Rogue', a 'Bandit', a 'Scout' or a 'Swashbuckler'?";
string q7 = "We have several bards, would you like a 'General Bard', a 'Blade' or a 'Jester'?";
string q8 = "We have sevaral druids, would you like a 'General Druid', 'Hawkmaster' or 'Interloper'?";
string q9 = "We have sevaral monks, would you like a 'General Monk', 'Assassin', 'Devout' or 'Spirit'?";
string q10 = "We have sevaral paladins, would you like a 'General Paladin', 'Divine', 'Inquisitor', or 'Undead Hunter'?";
string q11 = "We have several rangers, would you like a 'General Ranger', 'Marksman', 'Stalker', or 'Warden'?";
string q12 = "We have several barbarians, would you like a 'General Barbarian', 'Brute', 'Savage', or 'Slayer'?";


string q100 = "That seems to conclude all of the required information, for now.  Understand that for their protection, all of our mercenaries are protected through magic.  If harm should come to them, their bodies will be immediately returned here for healing, and you will need to return and pay for the healing if you would like them to return to duty.  Also, each of our mercenaries are given a course on basic combat as a fighter to ensure their flexibility and combat prowess. Do you understand? (Say 'Yes')";
string q101 = "Here is your contract";

if (nPtrn == 1)
  {
    AssignCommand(OBJECT_SELF, ActionSpeakString(q1, TALKVOLUME_TALK));
    object oDestroy = GetFirstItemInInventory(OBJECT_SELF);
    while (GetIsObjectValid(oDestroy))
    {
        if (GetTag(oDestroy)=="HenchmanContract") DestroyObject(oDestroy);
        oDestroy = GetNextItemInInventory(OBJECT_SELF);
    }
  }
else if (nPtrn == 2)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a human.", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Race", 1);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q2, TALKVOLUME_TALK));
  }
else if (nPtrn == 3)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a dwarf.", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Race", 2);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q2, TALKVOLUME_TALK));
  }
else if (nPtrn == 4)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen an elf.", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Race", 3);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q2, TALKVOLUME_TALK));
  }
else if (nPtrn == 5)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a Halfling.", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Race", 4);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q2, TALKVOLUME_TALK));
  }
else if (nPtrn == 6)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a Half-Orc. ", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Race", 5);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q2, TALKVOLUME_TALK));
  }
else if (nPtrn == 7)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a Gnome. ", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Race", 6);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q2, TALKVOLUME_TALK));
  }


//Set Gender
else if (nPtrn == 8)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a male. ", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Gender", 1);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q3, TALKVOLUME_TALK));
  }
else if (nPtrn == 9)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a female. ", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Gender", 2);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q3, TALKVOLUME_TALK));
  }


//Set Class
else if (nPtrn == 11)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a Cleric.", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Class", 1);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q4, TALKVOLUME_TALK));
  }
else if (nPtrn == 12)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a Fighter. ", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Class", 2);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q5, TALKVOLUME_TALK));
  }
  else if (nPtrn == 13)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a Rogue. ", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Class", 3);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q6, TALKVOLUME_TALK));
  }
  else if (nPtrn == 14)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a Wizard. ", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Class", 4);
  SetLocalInt(OBJECT_SELF, "Package", PACKAGE_WIZARDGENERALIST);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q100, TALKVOLUME_TALK));
  }
  else if (nPtrn == 15)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a Bard. ", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Class", 5);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q7, TALKVOLUME_TALK));
  }
  else if (nPtrn == 16)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a Druid. ", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Class", 6);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q8, TALKVOLUME_TALK));
  }
  else if (nPtrn == 17)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a Monk. ", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Class", 7);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q9, TALKVOLUME_TALK));
  }
  else if (nPtrn == 18)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a Paladin. ", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Class", 8);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q10, TALKVOLUME_TALK));
  }
  else if (nPtrn == 19)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a Ranger. ", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Class", 9);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q11, TALKVOLUME_TALK));
  }
  else if (nPtrn == 1001)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a Barbarian. ", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Class", 10);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q12, TALKVOLUME_TALK));
  }
  else if (nPtrn == 1002)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a Sorcerer. ", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Class", 11);
  SetLocalInt(OBJECT_SELF, "Package", PACKAGE_SORCERER);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q100, TALKVOLUME_TALK));
  }


//Cleric Packages
  else if (nPtrn == 21)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a General Cleric.", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Package", PACKAGE_CLERIC);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q100, TALKVOLUME_TALK));
  }
  else if (nPtrn == 22)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a Shaman.", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Package", PACKAGE_CLERIC_SHAMAN);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q100, TALKVOLUME_TALK));
  }
  else if (nPtrn == 23)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a Battle Priest.", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Package", PACKAGE_CLERIC_BATTLE_PRIEST);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q100, TALKVOLUME_TALK));
  }


//Fighter Packages
  else if (nPtrn == 31)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a General Fighter.", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Package", PACKAGE_FIGHTER);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q100, TALKVOLUME_TALK));
  }
  else if (nPtrn == 32)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a Commander.", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Package", PACKAGE_FIGHTER_COMMANDER);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q100, TALKVOLUME_TALK));
  }
  else if (nPtrn == 33)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a Pirate.", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Package", PACKAGE_FIGHTER_PIRATE);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q100, TALKVOLUME_TALK));
  }
  else if (nPtrn == 34)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a Gladiator.", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Package", PACKAGE_FIGHTER_GLADIATOR);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q100, TALKVOLUME_TALK));
  }

//Rogue Packages
  else if (nPtrn == 41)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a General Rogue.", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Package", PACKAGE_ROGUE);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q100, TALKVOLUME_TALK));
  }
  else if (nPtrn == 42)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a Bandit.", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Package", PACKAGE_ROGUE_BANDIT);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q100, TALKVOLUME_TALK));
  }
  else if (nPtrn == 43)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a Scout.", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Package", PACKAGE_ROGUE_SCOUT);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q100, TALKVOLUME_TALK));
  }
  else if (nPtrn == 44)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a Swashbuckler.", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Package", PACKAGE_ROGUE_SWASHBUCKLER);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q100, TALKVOLUME_TALK));
  }

//Bard Packages
  else if (nPtrn == 51)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a General Bard.", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Package", PACKAGE_BARD);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q100, TALKVOLUME_TALK));
  }
  else if (nPtrn == 52)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a Blade.", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Package", PACKAGE_BARD_BLADE);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q100, TALKVOLUME_TALK));
  }
  else if (nPtrn == 53)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a Jester.", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Package", PACKAGE_BARD_JESTER);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q100, TALKVOLUME_TALK));
  }

//Druid Packages
  else if (nPtrn == 61)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a General Druid.", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Package", PACKAGE_DRUID);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q100, TALKVOLUME_TALK));
  }
  else if (nPtrn == 62)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a Hawkmaster.", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Package", PACKAGE_DRUID_HAWKMASTER);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q100, TALKVOLUME_TALK));
  }
  else if (nPtrn == 63)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen an Interloper.", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Package", PACKAGE_DRUID_INTERLOPER);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q100, TALKVOLUME_TALK));
  }


//Monk Packages
  else if (nPtrn == 71)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a General Monk.", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Package", PACKAGE_MONK);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q100, TALKVOLUME_TALK));
  }
  else if (nPtrn == 72)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen an Assassin.", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Package", PACKAGE_MONK_ASSASSIN);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q100, TALKVOLUME_TALK));
  }
  else if (nPtrn == 73)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a Devout Monk.", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Package", PACKAGE_MONK_DEVOUT);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q100, TALKVOLUME_TALK));
  }
  else if (nPtrn == 74)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a Spirit Monk.", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Package", PACKAGE_MONK_SPIRIT);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q100, TALKVOLUME_TALK));
  }

//Paldin Packages
  else if (nPtrn == 81)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a General Paladin.", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Package", PACKAGE_PALADIN);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q100, TALKVOLUME_TALK));
  }
  else if (nPtrn == 82)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a Divine Paladin.", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Package", PACKAGE_PALADIN_DIVINE);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q100, TALKVOLUME_TALK));
  }
  else if (nPtrn == 83)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen an Inquisitor.", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Package", PACKAGE_PALADIN_INQUISITOR);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q100, TALKVOLUME_TALK));
  }
  else if (nPtrn == 84)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen an Undead Hunter.", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Package", PACKAGE_PALADIN_UNDEAD);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q100, TALKVOLUME_TALK));
  }

//Ranger Packages
  else if (nPtrn == 91)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a General Ranger.", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Package", PACKAGE_RANGER);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q100, TALKVOLUME_TALK));
  }
  else if (nPtrn == 92)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a Marksman.", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Package", PACKAGE_RANGER_MARKSMAN);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q100, TALKVOLUME_TALK));
  }
  else if (nPtrn == 93)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a Stalker.", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Package", PACKAGE_RANGER_STALKER);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q100, TALKVOLUME_TALK));
  }
  else if (nPtrn == 94)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a Warden.", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Package", PACKAGE_RANGER_WARDEN);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q100, TALKVOLUME_TALK));
  }


//Barbarian Packages
  else if (nPtrn == 1011)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a General Barbarian.", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Package", PACKAGE_BARBARIAN);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q100, TALKVOLUME_TALK));
  }
  else if (nPtrn == 1012)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a Brute.", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Package", PACKAGE_BARBARIAN_BRUTE);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q100, TALKVOLUME_TALK));
  }
  else if (nPtrn == 1013)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a Savage.", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Package", PACKAGE_BARBARIAN_SAVAGE);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q100, TALKVOLUME_TALK));
  }
  else if (nPtrn == 1014)
  {
  AssignCommand(OBJECT_SELF, ActionSpeakString("You have chosen a Slayer.", TALKVOLUME_TALK));
  SetLocalInt(OBJECT_SELF, "Package", PACKAGE_BARBARIAN_SLAYER);
  AssignCommand(OBJECT_SELF, ActionSpeakString(q100, TALKVOLUME_TALK));
  }

//Finishing Script
  else if (nPtrn == 100)
  {
  object oContract = CreateItemOnObject("cbh_contract", OBJECT_SELF);
  oPC = GetLastSpeaker();
  int nPCLvl = GetHitDice(oPC);
  int nCost = (nPCLvl * (nPCLvl -1 ) * 100);
  if (nPCLvl < 5) nCost = nCost / (5-nPCLvl);
  //SetName
  if(GetLocalInt(OBJECT_SELF, "Gender") == 1)    // Male
  {
    if(GetLocalInt(OBJECT_SELF, "Race") == 1) //Human
    {
    SetLocalString(oContract, "FirstName", RandomName(NAME_FIRST_HUMAN_MALE));
    SetLocalString(oContract, "LastName", RandomName(NAME_LAST_HUMAN));
    }
    else if(GetLocalInt(OBJECT_SELF, "Race") == 2) //Dwarf
    {
    SetLocalString(oContract, "FirstName", RandomName(NAME_FIRST_DWARF_MALE));
    SetLocalString(oContract, "LastName", RandomName(NAME_LAST_DWARF));
    }
    else if(GetLocalInt(OBJECT_SELF, "Race") == 3) //Elf
    {
    SetLocalString(oContract, "FirstName", RandomName(NAME_FIRST_ELF_MALE));
    SetLocalString(oContract, "LastName", RandomName(NAME_LAST_ELF));
    }
    else if(GetLocalInt(OBJECT_SELF, "Race") == 4) //Halfling
    {
    SetLocalString(oContract, "FirstName", RandomName(NAME_FIRST_HALFLING_MALE));
    SetLocalString(oContract, "LastName", RandomName(NAME_LAST_HALFLING));
    }
    else if(GetLocalInt(OBJECT_SELF, "Race") == 5) //Half-Orc
    {
    SetLocalString(oContract, "FirstName", RandomName(NAME_FIRST_HALFORC_MALE));
    SetLocalString(oContract, "LastName", RandomName(NAME_LAST_HALFORC));
    }
    else if(GetLocalInt(oContract, "Race") == 6) //Gnome
    {
    SetLocalString(oContract, "FirstName", RandomName(NAME_FIRST_GNOME_MALE));
    SetLocalString(oContract, "LastName", RandomName(NAME_LAST_GNOME));
    }
  }
  else if(GetLocalInt(OBJECT_SELF, "Gender") == 2)  // Female
  {
    if(GetLocalInt(OBJECT_SELF, "Race") == 1) //Human
    {
    SetLocalString(oContract, "FirstName", RandomName(NAME_FIRST_HUMAN_FEMALE));
    SetLocalString(oContract, "LastName", RandomName(NAME_LAST_HUMAN));
    }
    else if(GetLocalInt(oContract, "Race") == 2) //Dwarf
    {
    SetLocalString(oContract, "FirstName", RandomName(NAME_FIRST_DWARF_FEMALE));
    SetLocalString(oContract, "LastName", RandomName(NAME_LAST_DWARF));
    }
    else if(GetLocalInt(OBJECT_SELF, "Race") == 3) //Elf
    {
    SetLocalString(oContract, "FirstName", RandomName(NAME_FIRST_ELF_FEMALE));
    SetLocalString(oContract, "LastName", RandomName(NAME_LAST_ELF));
    }
    else if(GetLocalInt(OBJECT_SELF, "Race") == 4) //Halfling
    {
    SetLocalString(oContract, "FirstName", RandomName(NAME_FIRST_HALFLING_FEMALE));
    SetLocalString(oContract, "LastName", RandomName(NAME_LAST_HALFLING));
    }
    else if(GetLocalInt(OBJECT_SELF, "Race") == 5) //Half-Orc
    {
    SetLocalString(oContract, "FirstName", RandomName(NAME_FIRST_HALFORC_FEMALE));
    SetLocalString(oContract, "LastName", RandomName(NAME_LAST_HALFORC));
    }
    else if(GetLocalInt(OBJECT_SELF, "Race") == 6) //Half-Orc
    {
    SetLocalString(oContract, "FirstName", RandomName(NAME_FIRST_GNOME_FEMALE));
    SetLocalString(oContract, "LastName", RandomName(NAME_LAST_GNOME));
    }
  }
    if (d2()==2) {
    SetLocalInt(oContract, "Pheno", PHENOTYPE_BIG);
    } else {
    SetLocalInt(oContract, "Pheno", PHENOTYPE_NORMAL);
    }
    SetLocalInt(oContract, "Hair", d12(1));
    SetLocalInt(oContract, "Skin", d6(1));
    SetLocalInt(oContract, "Race", GetLocalInt(OBJECT_SELF, "Race"));
    SetLocalInt(oContract, "Gender", GetLocalInt(OBJECT_SELF, "Gender"));
    SetLocalInt(oContract, "Class", GetLocalInt(OBJECT_SELF, "Class"));
    SetLocalInt(oContract, "Package", GetLocalInt(OBJECT_SELF, "Package"));
    SetLocalInt(oContract, "Head", d12());
    SetLocalString(oContract, "RHand", "nw_wswss001");
    SetLocalString(oContract, "Armor", "nw_aarcl001");
    SetLocalInt(oContract, "Status", 1);
    oPC = GetLastSpeaker();
    SetLocalString(oContract, "Master", GetPCPlayerName(oPC) + GetPCPublicCDKey(oPC, TRUE) +"H");

//If Player has Contract, nothing.  Otherwise, take 20k gold and give contract.
if (GetItemPossessedBy(oPC, "cbh_Contract") == OBJECT_INVALID) {
    if (GetGold(oPC) >= nCost)
        {
        AssignCommand(OBJECT_SELF, ActionSpeakString("You have been assigned " + GetLocalString(oContract, "FirstName") + " " + GetLocalString(oContract, "LastName")));
        AssignCommand(OBJECT_SELF, ActionSpeakString(q101, TALKVOLUME_TALK));
        AssignCommand(oPC, TakeGoldFromCreature(nCost, oPC, TRUE));
        ActionGiveItem(oContract, oPC);
        } else { AssignCommand(OBJECT_SELF, ActionSpeakString("You cannot afford the contract, come back when you have " + IntToString(nCost) + " gold.", TALKVOLUME_TALK)); }
    } else {
    AssignCommand(OBJECT_SELF, ActionSpeakString("You already have an existing contract.", TALKVOLUME_TALK));
    DestroyObject(oContract);
    }
  }
}
