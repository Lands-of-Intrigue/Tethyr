//Hashtag(#) Chat System & Language Conversion (Assitance From Tsunami282 & DMFI Team)
//Author: Rob Steiner (robbythedude@hotmail.com)
//Date: 2/5/15
//Modified: 3/1/15

/******PURPOSE******
//An NWN Chat parser that will allow for execution of commands via a
//player sent chat message. Commands can allow for emotes, dice rolls, etc.
//
//An NWN chat parser that will determine the player's desired language and
//convert their message to the desired language
*/

/******HOW-TO******
This script is to be executed by event, OnPlayerChat().
Make sure NWNX2 with ODBC is installed properly and working!
Edit -> Module Properties -> Events -> OnPlayerChat
*/

//Initializing Functions
string parseArgs(string command, int argID);
void produceOutput(string output, string option, object oPlayer);
void handleLanguageOutput(string sMessage, object oPlayer, int nVolume);
string convertXanalress(string sLetter);
string convertInfernal(string sLetter);
string convertAbyssal(string sLetter);
string convertCelestial(string sLetter);
string convertUndercommon(string sLetter);
string convertDraconic(string sLetter);
string convertDwarf(string sLetter);
string convertElven(string sLetter);
string convertGnome(string sLetter);
string convertHalfling(string sLetter);
string convertOrc(string sLetter);
string convertAnimal(string sLetter);
string convertSylvan(string sLetter);
string convertRashemi(string sLetter);
string convertMulan(string sLetter);
string convertCant(string sLetter);

//Global Constants
const string tCurrLangToken = "TOKEN_CURR_LANG";
const string sAbyssalID = "abyssal";
const string sAnimalID = "animal";
const string sCelestialID = "celestial";
const string sDraconicID = "draconic";
const string sXanalressID = "xanalress";
const string sDwarvenID = "dwarven";
const string sElvenID = "elven";
const string sGnomeID = "gnome";
const string sUndercommonID = "undercommon";
const string sHalflingID = "halfling";
const string sInfernalID = "infernal";
const string sMulanID = "mulan";
const string sOrcID = "orc";
const string sRashemiID = "rashemi";
const string sSylvanID = "sylvan";
const string sCantID = "cant";

void main()
{
    //Storing the oPlayer who called the script
    object oPlayer = GetPCChatSpeaker();
    //Storing oPlayer's message in lowercase for easy parsing
    string sChatMessage = GetPCChatMessage();
    //Storing oPlayer's chat message volume
    int nChatMessageVolume = GetPCChatVolume();

    //Two checks must be made to determine if we go any further
    //1) Determine if 'oPlayer' is still  a valid object to call this script
    if(!GetIsPC(oPlayer))
    {
        return; //Leave execution, nothing to do
    }

    //2) Determine if 'sChatMessage' starts with a hashtag(!)
    if(GetStringLeft(sChatMessage, 1) != "!")
    {
        //produce desired output from user, consider language.
        handleLanguageOutput(sChatMessage, oPlayer, nChatMessageVolume);
        return;
    }

    //Remove the "#" from 'sChatMessage'
    sChatMessage = GetStringRight(sChatMessage, GetStringLength(sChatMessage)-1);
    //This will stop the player from speaking a command
    SetPCChatMessage("");
    //Will be used to hold the current command argument being interpreted
    string sCurrCommandArg;

    sCurrCommandArg = parseArgs(sChatMessage, 0);

    //This will be the first argument check. Below determines if the first
    //argument provided is valid and what to do with a valid argument
    if(sCurrCommandArg == "roll")  //This will handlie rolls for specific attributes/skills/etc.
    {
        sCurrCommandArg = parseArgs(sChatMessage, 1); //Parse next roll argument
        int nd20Roll = Random(20) + 1; //Rolling of the dice

        if(nd20Roll == 1) //You suck
            produceOutput("Critical Failure!", "", oPlayer);
        else if (nd20Roll == 20) //You win
            produceOutput("Critical Success!", "", oPlayer);
        else
        {
            if(sCurrCommandArg == "will" || sCurrCommandArg == "Will" || sCurrCommandArg == "WILL")
                produceOutput(GetPCPlayerName(oPlayer) + " rolled a " + IntToString(GetWillSavingThrow(oPlayer) + nd20Roll) + " on will save." , parseArgs(sChatMessage, 2), oPlayer);
            else if(sCurrCommandArg == "reflex" || sCurrCommandArg == "ref")
                produceOutput(GetPCPlayerName(oPlayer) + " rolled a " + IntToString(GetReflexSavingThrow(oPlayer) + nd20Roll) + " on reflex save." , parseArgs(sChatMessage, 2), oPlayer);
            else if(sCurrCommandArg == "fort" || sCurrCommandArg == "fortitude")
                produceOutput(GetPCPlayerName(oPlayer) + " rolled a " + IntToString(GetFortitudeSavingThrow(oPlayer) + nd20Roll) + " on fortitude save." , parseArgs(sChatMessage, 2), oPlayer);
            else if(sCurrCommandArg == "animal")
                produceOutput(GetPCPlayerName(oPlayer) + " rolled a " + IntToString(GetSkillRank(SKILL_ANIMAL_EMPATHY, oPlayer) + nd20Roll) + " on animal empathy save." , parseArgs(sChatMessage, 2), oPlayer);
            else if(sCurrCommandArg == "appraise")
                produceOutput(GetPCPlayerName(oPlayer) + " rolled a " + IntToString(GetSkillRank(SKILL_APPRAISE, oPlayer) + nd20Roll) + " on appraise save." , parseArgs(sChatMessage, 2), oPlayer);
            else if(sCurrCommandArg == "bluff")
                produceOutput(GetPCPlayerName(oPlayer) + " rolled a " + IntToString(GetSkillRank(SKILL_BLUFF, oPlayer) + nd20Roll) + " on bluff save." , parseArgs(sChatMessage, 2), oPlayer);
            else if(sCurrCommandArg == "concentration" || sCurrCommandArg == "conc")
                produceOutput(GetPCPlayerName(oPlayer) + " rolled a " + IntToString(GetSkillRank(SKILL_CONCENTRATION, oPlayer) + nd20Roll) + " on concentration save." , parseArgs(sChatMessage, 2), oPlayer);
            else if(sCurrCommandArg == "craft")
            {
                sCurrCommandArg =  parseArgs(sChatMessage, 2); //Parse what type of craft roll

                if(sCurrCommandArg == "armor")
                    produceOutput(GetPCPlayerName(oPlayer) + " rolled a " + IntToString(GetSkillRank(SKILL_CRAFT_ARMOR, oPlayer) + nd20Roll) + " on craft armor save." , parseArgs(sChatMessage, 3), oPlayer);
                else if(sCurrCommandArg == "trap")
                    produceOutput(GetPCPlayerName(oPlayer) + " rolled a " + IntToString(GetSkillRank(SKILL_CRAFT_TRAP, oPlayer) + nd20Roll) + " on craft trap save." , parseArgs(sChatMessage, 3), oPlayer);
                else if(sCurrCommandArg == "weapon")
                    produceOutput(GetPCPlayerName(oPlayer) + " rolled a " + IntToString(GetSkillRank(SKILL_CRAFT_WEAPON, oPlayer) + nd20Roll) + " on caft weapon save." , parseArgs(sChatMessage, 3), oPlayer);
                else
                    produceOutput("Error in command.", "quiet", oPlayer);
            }
            else if (sCurrCommandArg == "disable")
            {
                sCurrCommandArg = parseArgs(sChatMessage, 2); //Parse what type of craft roll

                if(sCurrCommandArg == "trap")
                    produceOutput(GetPCPlayerName(oPlayer) + " rolled a " + IntToString(GetSkillRank(SKILL_DISABLE_TRAP, oPlayer) + nd20Roll) + " on disable trap save." , parseArgs(sChatMessage, 2), oPlayer);
                else
                    produceOutput("Error in command.", "quiet", oPlayer);
            }
            else if(sCurrCommandArg == "discipline" || sCurrCommandArg == "disc")
                produceOutput(GetPCPlayerName(oPlayer) + " rolled a " + IntToString(GetSkillRank(SKILL_DISCIPLINE, oPlayer) + nd20Roll) + " on discipline save." , parseArgs(sChatMessage, 2), oPlayer);
            else if(sCurrCommandArg == "heal")
                produceOutput(GetPCPlayerName(oPlayer) + " rolled a " + IntToString(GetSkillRank(SKILL_HEAL, oPlayer) + nd20Roll) + " on heal save." , parseArgs(sChatMessage, 2), oPlayer);
            else if(sCurrCommandArg == "hide")
                produceOutput(GetPCPlayerName(oPlayer) + " rolled a " + IntToString(GetSkillRank(SKILL_HIDE, oPlayer) + nd20Roll) + " on hide save." , parseArgs(sChatMessage, 2), oPlayer);
            else if(sCurrCommandArg == "intimidate")
                produceOutput(GetPCPlayerName(oPlayer) + " rolled a " + IntToString(GetSkillRank(SKILL_INTIMIDATE, oPlayer) + nd20Roll) + " on intimidate save." , parseArgs(sChatMessage, 2), oPlayer);
            else if(sCurrCommandArg == "listen")
                produceOutput(GetPCPlayerName(oPlayer) + " rolled a " + IntToString(GetSkillRank(SKILL_LISTEN, oPlayer) + nd20Roll) + " on listen save." , parseArgs(sChatMessage, 2), oPlayer);
            else if(sCurrCommandArg == "lore")
                produceOutput(GetPCPlayerName(oPlayer) + " rolled a " + IntToString(GetSkillRank(SKILL_LORE, oPlayer) + nd20Roll) + " on lore save." , parseArgs(sChatMessage, 2), oPlayer);
            else if(sCurrCommandArg == "move")
            {
                sCurrCommandArg = parseArgs(sChatMessage, 2); //Parse out command

                if(sCurrCommandArg == "silently")
                    produceOutput(GetPCPlayerName(oPlayer) + " rolled a " + IntToString(GetSkillRank(SKILL_MOVE_SILENTLY, oPlayer) + nd20Roll) + " on move silently save." , parseArgs(sChatMessage, 3), oPlayer);
                else
                    produceOutput("Error in command.", "quiet", oPlayer);
            }
            else if(sCurrCommandArg == "open")
            {
                sCurrCommandArg = parseArgs(sChatMessage, 2); //Parse out command

                if(sCurrCommandArg == "lock")
                    produceOutput(GetPCPlayerName(oPlayer) + " rolled a " + IntToString(GetSkillRank(SKILL_OPEN_LOCK, oPlayer) + nd20Roll) + " on open lock save." , parseArgs(sChatMessage, 3), oPlayer);
                else
                    produceOutput("Error in command.", "quiet", oPlayer);
            }
            else if(sCurrCommandArg == "parry")
                produceOutput(GetPCPlayerName(oPlayer) + " rolled a " + IntToString(GetSkillRank(SKILL_PARRY, oPlayer) + nd20Roll) + " on parry save." , parseArgs(sChatMessage, 2), oPlayer);
            else if(sCurrCommandArg == "perform")
                produceOutput(GetPCPlayerName(oPlayer) + " rolled a " + IntToString(GetSkillRank(SKILL_PERFORM, oPlayer) + nd20Roll) + " on perform save." , parseArgs(sChatMessage, 2), oPlayer);
            else if(sCurrCommandArg == "persuade")
                produceOutput(GetPCPlayerName(oPlayer) + " rolled a " + IntToString(GetSkillRank(SKILL_PERSUADE, oPlayer) + nd20Roll) + " on persuade save." , parseArgs(sChatMessage, 2), oPlayer);
            else if(sCurrCommandArg == "pick")
            {
                sCurrCommandArg = parseArgs(sChatMessage, 2); //Parse out command

                if(sCurrCommandArg == "pocket")
                    produceOutput(GetPCPlayerName(oPlayer) + " rolled a " + IntToString(GetSkillRank(SKILL_PICK_POCKET, oPlayer) + nd20Roll) + " on pick pocket save." , parseArgs(sChatMessage, 3), oPlayer);
                else
                    produceOutput("Error in command.", "quiet", oPlayer);
            }
            else if(sCurrCommandArg == "ride")
                produceOutput(GetPCPlayerName(oPlayer) + " rolled a " + IntToString(GetSkillRank(SKILL_RIDE, oPlayer) + nd20Roll) + " on ride save." , parseArgs(sChatMessage, 2), oPlayer);
            else if(sCurrCommandArg == "search")
                produceOutput(GetPCPlayerName(oPlayer) + " rolled a " + IntToString(GetSkillRank(SKILL_SEARCH, oPlayer) + nd20Roll) + " on search save." , parseArgs(sChatMessage, 2), oPlayer);
            else if(sCurrCommandArg == "set")
            {
                sCurrCommandArg = parseArgs(sChatMessage, 2); //Parse out command

                if(sCurrCommandArg == "trap")
                    produceOutput(GetPCPlayerName(oPlayer) + " rolled a " + IntToString(GetSkillRank(SKILL_SET_TRAP, oPlayer) + nd20Roll) + " on set trap save." , parseArgs(sChatMessage, 3), oPlayer);
                else
                    produceOutput("Error in command.", "quiet", oPlayer);
            }
            else if(sCurrCommandArg == "spellcraft")
                produceOutput(GetPCPlayerName(oPlayer) + " rolled a " + IntToString(GetSkillRank(SKILL_SPELLCRAFT, oPlayer) + nd20Roll) + " on spellcraft save." , parseArgs(sChatMessage, 2), oPlayer);
            else if(sCurrCommandArg == "spot")
                produceOutput(GetPCPlayerName(oPlayer) + " rolled a " + IntToString(GetSkillRank(SKILL_SPOT, oPlayer) + nd20Roll) + " on spot save." , parseArgs(sChatMessage, 2), oPlayer);
            else if(sCurrCommandArg == "taunt")
                produceOutput(GetPCPlayerName(oPlayer) + " rolled a " + IntToString(GetSkillRank(SKILL_TAUNT, oPlayer) + nd20Roll) + " on taunt save." , parseArgs(sChatMessage, 2), oPlayer);
            else if(sCurrCommandArg == "tumble")
                produceOutput(GetPCPlayerName(oPlayer) + " rolled a " + IntToString(GetSkillRank(SKILL_TUMBLE, oPlayer) + nd20Roll) + " on tumble save." , parseArgs(sChatMessage, 2), oPlayer);
            else if(sCurrCommandArg == "umd")
                produceOutput(GetPCPlayerName(oPlayer) + " rolled a " + IntToString(GetSkillRank(SKILL_USE_MAGIC_DEVICE, oPlayer) + nd20Roll) + " on use magic device save." , parseArgs(sChatMessage, 2), oPlayer);
            else
                produceOutput("Error in command.", "quiet", oPlayer);
        }
    }  //End of rolling skill if
    else if (sCurrCommandArg == "emote") //This will handle any commands for emoting actions of a oPlayer
    {
        sCurrCommandArg = parseArgs(sChatMessage, 1); //Parse next roll argument

        if(sCurrCommandArg == "bow")
            AssignCommand(oPlayer, PlayAnimation(ANIMATION_FIREFORGET_BOW, 1.0));
        else if(sCurrCommandArg == "drink")
            AssignCommand(oPlayer, PlayAnimation(ANIMATION_FIREFORGET_DRINK, 1.0));
        else if(sCurrCommandArg == "greet")
            AssignCommand(oPlayer, PlayAnimation(ANIMATION_FIREFORGET_GREETING, 1.0));
        else if(sCurrCommandArg == "bored")
            AssignCommand(oPlayer, PlayAnimation(ANIMATION_FIREFORGET_PAUSE_BORED, 1.0));
        else if(sCurrCommandArg == "headscratch")
            AssignCommand(oPlayer, PlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD, 1.0));
        else if(sCurrCommandArg == "read")
            AssignCommand(oPlayer, PlayAnimation(ANIMATION_FIREFORGET_READ, 1.0));
        else if(sCurrCommandArg == "salute")
            AssignCommand(oPlayer, PlayAnimation(ANIMATION_FIREFORGET_SALUTE, 1.0));
        else if(sCurrCommandArg == "spasm")
            AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_SPASM, 1.0, 1000.0));
        else if(sCurrCommandArg == "taunt")
            AssignCommand(oPlayer, PlayAnimation(ANIMATION_FIREFORGET_TAUNT, 1.0));
        else if(sCurrCommandArg == "celebrate")
            AssignCommand(oPlayer, PlayAnimation(111-Random(3), 1.0));  //ANIMATION_FIREFORGET_VICTORY1(2)(3)
        else if(sCurrCommandArg == "fall")
        {
            sCurrCommandArg = parseArgs(sChatMessage, 2); //Get which way to fall

            if(sCurrCommandArg == "forward")
                AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_DEAD_FRONT, 1.0, 1000.0));
            else if(sCurrCommandArg == "backward")
                AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 1000.0));
            else
                produceOutput("Error in command.", "quiet", oPlayer);
        }
        else if(sCurrCommandArg == "pickup")
        {
            sCurrCommandArg = parseArgs(sChatMessage, 2); //Get where to pickup at

            if(sCurrCommandArg == "ground")
                AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 2.0));
            else if(sCurrCommandArg == "waist")
                AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 2.0));
            else
                produceOutput("Error in command.", "quiet", oPlayer);
        }
        else if(sCurrCommandArg == "listen")
            AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_LISTEN, 1.0, 1000.0));
        else if(sCurrCommandArg == "look")
            AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_LOOK_FAR, 1.0, 1000.0));
        else if(sCurrCommandArg == "meditate")
            AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_MEDITATE, 1.0, 1000.0));
        else if(sCurrCommandArg == "stop")
            AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_PAUSE, 1.0, 1000.0));
        else if(sCurrCommandArg == "drunk")
            AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK, 1.0, 1000.0));
        else if(sCurrCommandArg == "tired")
            AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED, 1.0, 1000.0));
        else if(sCurrCommandArg == "laugh")
            AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 1000.0));
        else if(sCurrCommandArg == "plead")
            AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0, 1000.0));
        else if(sCurrCommandArg == "worship")
            AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_WORSHIP, 1.0, 1000.0));
        else if(sCurrCommandArg == "sit")
            AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0, 1000.0));
        else
            produceOutput("Error in command.", "quiet", oPlayer);
    }  //End of emoting if
    else if (sCurrCommandArg == "dice")  //This will handle rolling random numbers with no attribute alteration
    {
        sCurrCommandArg = parseArgs(sChatMessage, 1); //Parse out the number to roll
        int dNumRoll = Random(StringToInt(sCurrCommandArg)) + 1; //Rolling of the dice

        if(TestStringAgainstPattern("*n", sCurrCommandArg))
            produceOutput(GetPCPlayerName(oPlayer) + " rolled a " + IntToString(dNumRoll) + " on their d" + sCurrCommandArg, parseArgs(sChatMessage, 2), oPlayer);
        else
            produceOutput("Error in command.", "quiet", oPlayer);
    }  //End of random dice if
    else if (sCurrCommandArg == "language")  //This will handle changing the player's set language
    {
        sCurrCommandArg = parseArgs(sChatMessage, 1); //Parse out the chosen language

        if(sCurrCommandArg == "aby" || sCurrCommandArg == sAbyssalID)
        {
            //Gotta implement security here to handle if the player even knows the language...
            SetLocalString(oPlayer, tCurrLangToken, sAbyssalID);
            produceOutput("Language set to Abyssal.", "quiet", oPlayer);
        }
        else if(sCurrCommandArg == "ani" || sCurrCommandArg == sAnimalID)
        {
            //Gotta implement security here to handle if the player even knows the language...
            SetLocalString(oPlayer, tCurrLangToken, sAnimalID);
            produceOutput("Language set to Animal.", "quiet", oPlayer);
        }
        else if(sCurrCommandArg == "cel" || sCurrCommandArg == sCelestialID)
        {
            //Gotta implement security here to handle if the player even knows the language...
            SetLocalString(oPlayer, tCurrLangToken, sCelestialID);
            produceOutput("Language set to Celestial.", "quiet", oPlayer);
        }
        else if(sCurrCommandArg == "dra" || sCurrCommandArg == sDraconicID)
        {
            //Gotta implement security here to handle if the player even knows the language...
            SetLocalString(oPlayer, tCurrLangToken, sDraconicID);
            produceOutput("Language set to Draconic.", "quiet", oPlayer);
        }
        else if(sCurrCommandArg == "xan" || sCurrCommandArg == sXanalressID)
        {
            //Gotta implement security here to handle if the player even knows the language...
            SetLocalString(oPlayer, tCurrLangToken, sXanalressID);
            produceOutput("Language set to Xanalress.", "quiet", oPlayer);
        }
        else if(sCurrCommandArg == "dwa" || sCurrCommandArg == sDwarvenID)
        {
            //Gotta implement security here to handle if the player even knows the language...
            SetLocalString(oPlayer, tCurrLangToken, sDwarvenID);
            produceOutput("Language set to Dwarven.", "quiet", oPlayer);
        }
        else if(sCurrCommandArg == "elv" || sCurrCommandArg == sElvenID)
        {
            //Gotta implement security here to handle if the player even knows the language...
            SetLocalString(oPlayer, tCurrLangToken, sElvenID);
            produceOutput("Language set to Elven.", "quiet", oPlayer);
        }
        else if(sCurrCommandArg == "gno" || sCurrCommandArg == sGnomeID)
        {
            //Gotta implement security here to handle if the player even knows the language...
            SetLocalString(oPlayer, tCurrLangToken, sGnomeID);
            produceOutput("Language set to Gnome.", "quiet", oPlayer);
        }
        else if(sCurrCommandArg == "und" || sCurrCommandArg == sUndercommonID)
        {
            //Gotta implement security here to handle if the player even knows the language...
            SetLocalString(oPlayer, tCurrLangToken, sUndercommonID);
            produceOutput("Language set to Undercommon.", "quiet", oPlayer);
        }
        else if(sCurrCommandArg == "hal" || sCurrCommandArg == sHalflingID)
        {
            //Gotta implement security here to handle if the player even knows the language...
            SetLocalString(oPlayer, tCurrLangToken, sHalflingID);
            produceOutput("Language set to Halfling.", "quiet", oPlayer);
        }
        else if(sCurrCommandArg == "inf" || sCurrCommandArg == sInfernalID)
        {
            //Gotta implement security here to handle if the player even knows the language...
            SetLocalString(oPlayer, tCurrLangToken, sInfernalID);
            produceOutput("Language set to Infernal.", "quiet", oPlayer);
        }
        else if(sCurrCommandArg == "mul" || sCurrCommandArg == sMulanID)
        {
            //Gotta implement security here to handle if the player even knows the language...
            SetLocalString(oPlayer, tCurrLangToken, sMulanID);
            produceOutput("Language set to Mulan.", "quiet", oPlayer);
        }
        else if(sCurrCommandArg == sOrcID)
        {
            //Gotta implement security here to handle if the player even knows the language...
            SetLocalString(oPlayer, tCurrLangToken, sOrcID);
            produceOutput("Language set to Orc.", "quiet", oPlayer);
        }
        else if(sCurrCommandArg == "ras" || sCurrCommandArg == sRashemiID)
        {
            //Gotta implement security here to handle if the player even knows the language...
            SetLocalString(oPlayer, tCurrLangToken, sRashemiID);
            produceOutput("Language set to Rashemi.", "quiet", oPlayer);
        }
        else if(sCurrCommandArg == "syl" || sCurrCommandArg == sSylvanID)
        {
            //Gotta implement security here to handle if the player even knows the language...
            SetLocalString(oPlayer, tCurrLangToken, sSylvanID);
            produceOutput("Language set to Sylvan.", "quiet", oPlayer);
        }
        else if(sCurrCommandArg == "can" || sCurrCommandArg == sCantID)
        {
            //Gotta implement security here to handle if the player even knows the language...
            SetLocalString(oPlayer, tCurrLangToken, sCantID);
            produceOutput("Language set to Thieves' Cant.", "quiet", oPlayer);
        }
        else if(sCurrCommandArg == "com" || sCurrCommandArg == "common")
        {
            //Gotta implement security here to handle if the player even knows the language...
            DeleteLocalString(oPlayer, tCurrLangToken);
            produceOutput("Language set to Common.", "quiet", oPlayer);
        }
        else
            produceOutput("Error in command.", "quiet", oPlayer);

    }//End of setting language if
    else if(sCurrCommandArg == "date") //Display current game date to user
    {
        produceOutput(IntToString(GetCalendarDay()) + " Day " + IntToString(GetCalendarMonth()) + " Month " + IntToString(GetCalendarYear()) + " Year", "quiet", oPlayer);
    }//End of date if
    // else if(sCurrCommandArg == "delete_character")
    // {
        // sCurrCommandArg = parseArgs(sChatMessage, 1); //Parse out the next delete check

        // if(sCurrCommandArg == "delete_character")
        // {
            // BootPC(oPlayer);
            //Determine a way to delete a character...
        // }
        // else
        // {
            // produceOutput("Error in command.", "quiet", oPlayer);
        // }
    // }
    // else if(sCurrCommandArg == "save")  //Force save character and date
    // {
        //Apart of persistent time system, remove if not using
        // SQLExecDirect("UPDATE currentDate SET year = " + IntToString(GetCalendarYear()) + ", month = " + IntToString(GetCalendarMonth()) + ", day = " + IntToString(GetCalendarDay()) + "WHERE id = 1");
    // }
    else
    {
        produceOutput("Command not found.", "quiet", oPlayer);
    }

}

/*
* This function will take a list of arguments and parse through them
* args -> The list of arguments separated by spaces
* argID -> This determines which argument to grab from the list
* Returns the desired argument cleansed of any spaces
*/
string parseArgs(string args, int argID)
{
    int loc = 0; //Location of space
    string arg; //Soon to be parsed argument
    int inc; //Incrementor

    //If no spaces found, means only a single argument was passed...
    //RETURN IT UNALTERED!
    if(FindSubString(args, " ", loc) == -1)
    {
        return args;
    }

    //Loop to parse out the desired argument from the spaces based on 'argID'
    for(inc = 0; inc <= argID; inc++)
    {
            arg = GetStringRight(args, GetStringLength(args) - loc);
            if(FindSubString(args, " ", loc) != -1)
                arg = GetStringLeft(arg, FindSubString(args, " ", loc)-loc);
            loc = FindSubString(args, " ", loc) + 1;
    }

    return arg;
}

/*
* This function is used to send output to the oPlayers.
* output -> The output to be sent to oPlayers
* option -> This can allow for custom output options to oPlayers
* oPlayer -> The original oPlayer to have executed a command
* Return nothing.
*/
void produceOutput(string output, string option, object oPlayer)
{
    //Determine if this should output to every oPlayer in the area, or silently
    //to the oPlayer
    if(option == "quiet")
        SendMessageToPC(oPlayer, output);
    else
    {
        object tempPlayer = GetFirstPC(); //Variable of oPlayers on the server
        while(GetIsObjectValid(tempPlayer)) //Ensure valid oPlayer every check
        {
            //A check to make sure only oPlayers in the area get the output
            if(GetArea(oPlayer) == GetArea(tempPlayer))
            {
                SendMessageToPC(tempPlayer,output);
                tempPlayer = GetNextPC();
            }
        }
    }
}

/*
* This function will be the beggining of parsing a player's chat message and local
* tokens to alter their chat message to a certain language.
* sMessage -> The message the player typed
* oPlayer -> The player being dealt with during this execution
*/
void handleLanguageOutput(string sMessage, object oPlayer, int nVolume)
{
    string sOutputBuffer = "";
    int nTempInc;
    int nMessageLength =  GetStringLength(sMessage);

    if(GetLocalString(oPlayer, tCurrLangToken) == "" || GetLocalString(oPlayer, tCurrLangToken) == "common")
    {
        return;
    }
    else if(GetLocalString(oPlayer, tCurrLangToken) == sAbyssalID)
    {
        for(nTempInc = 1; nTempInc < nMessageLength; nTempInc++)
        {
            sOutputBuffer = sOutputBuffer + convertAbyssal(GetStringLeft(GetStringRight(sMessage, nMessageLength - nTempInc), nTempInc));
        }
    }
    else if(GetLocalString(oPlayer, tCurrLangToken) == sAnimalID)
    {
        for(nTempInc = 1; nTempInc < nMessageLength; nTempInc++)
        {
            sOutputBuffer = sOutputBuffer + convertAnimal(GetStringLeft(GetStringRight(sMessage, nMessageLength - nTempInc), nTempInc));
        }
    }
    else if(GetLocalString(oPlayer, tCurrLangToken) == sCelestialID)
    {
        for(nTempInc = 1; nTempInc < nMessageLength; nTempInc++)
        {
            sOutputBuffer = sOutputBuffer + convertCelestial(GetStringLeft(GetStringRight(sMessage, nMessageLength - nTempInc), nTempInc));
        }
    }
    else if(GetLocalString(oPlayer, tCurrLangToken) == sDraconicID)
    {
        for(nTempInc = 1; nTempInc < nMessageLength; nTempInc++)
        {
            sOutputBuffer = sOutputBuffer + convertDraconic(GetStringLeft(GetStringRight(sMessage, nMessageLength - nTempInc), nTempInc));
        }
    }
    else if(GetLocalString(oPlayer, tCurrLangToken) == sXanalressID)
    {
        for(nTempInc = 1; nTempInc < nMessageLength; nTempInc++)
        {
            sOutputBuffer = sOutputBuffer + convertXanalress(GetStringLeft(GetStringRight(sMessage, nMessageLength - nTempInc), nTempInc));
        }
    }
    else if(GetLocalString(oPlayer, tCurrLangToken) == sDwarvenID)
    {
        for(nTempInc = 1; nTempInc < nMessageLength; nTempInc++)
        {
            sOutputBuffer = sOutputBuffer + convertDwarf(GetStringLeft(GetStringRight(sMessage, nMessageLength - nTempInc), nTempInc));
        }
    }
    else if(GetLocalString(oPlayer, tCurrLangToken) == sElvenID)
    {
        for(nTempInc = 1; nTempInc < nMessageLength; nTempInc++)
        {
            sOutputBuffer = sOutputBuffer + convertElven(GetStringLeft(GetStringRight(sMessage, nMessageLength - nTempInc), nTempInc));
        }
    }
    else if(GetLocalString(oPlayer, tCurrLangToken) == sGnomeID)
    {
        for(nTempInc = 1; nTempInc < nMessageLength; nTempInc++)
        {
            sOutputBuffer = sOutputBuffer + convertGnome(GetStringLeft(GetStringRight(sMessage, nMessageLength - nTempInc), nTempInc));
        }
    }
    else if(GetLocalString(oPlayer, tCurrLangToken) == sUndercommonID)
    {
        for(nTempInc = 1; nTempInc < nMessageLength; nTempInc++)
        {
            sOutputBuffer = sOutputBuffer + convertUndercommon(GetStringLeft(GetStringRight(sMessage, nMessageLength - nTempInc), nTempInc));
        }
    }
    else if(GetLocalString(oPlayer, tCurrLangToken) == sHalflingID)
    {
        for(nTempInc = 1; nTempInc < nMessageLength; nTempInc++)
        {
            sOutputBuffer = sOutputBuffer + convertHalfling(GetStringLeft(GetStringRight(sMessage, nMessageLength - nTempInc), nTempInc));
        }
    }
    else if(GetLocalString(oPlayer, tCurrLangToken) == sMulanID)
    {
        for(nTempInc = 1; nTempInc < nMessageLength; nTempInc++)
        {
            sOutputBuffer = sOutputBuffer + convertMulan(GetStringLeft(GetStringRight(sMessage, nMessageLength - nTempInc), nTempInc));
        }
    }
    else if(GetLocalString(oPlayer, tCurrLangToken) == sInfernalID)
    {
        for(nTempInc = 1; nTempInc < nMessageLength; nTempInc++)
        {
            sOutputBuffer = sOutputBuffer + convertInfernal(GetStringLeft(GetStringRight(sMessage, nMessageLength - nTempInc), nTempInc));
        }
    }
    else if(GetLocalString(oPlayer, tCurrLangToken) == sOrcID)
    {
        for(nTempInc = 1; nTempInc < nMessageLength; nTempInc++)
        {
            sOutputBuffer = sOutputBuffer + convertOrc(GetStringLeft(GetStringRight(sMessage, nMessageLength - nTempInc), nTempInc));
        }
    }
    else if(GetLocalString(oPlayer, tCurrLangToken) == sRashemiID)
    {
        for(nTempInc = 1; nTempInc < nMessageLength; nTempInc++)
        {
            sOutputBuffer = sOutputBuffer + convertRashemi(GetStringLeft(GetStringRight(sMessage, nMessageLength - nTempInc), nTempInc));
        }
    }
    else if(GetLocalString(oPlayer, tCurrLangToken) == sSylvanID)
    {
        for(nTempInc = 1; nTempInc < nMessageLength; nTempInc++)
        {
            sOutputBuffer = sOutputBuffer + convertSylvan(GetStringLeft(GetStringRight(sMessage, nMessageLength - nTempInc), nTempInc));
        }
    }
    else if(GetLocalString(oPlayer, tCurrLangToken) == sCantID)
    {
        for(nTempInc = 1; nTempInc < nMessageLength; nTempInc++)
        {
            sOutputBuffer = sOutputBuffer + convertCant(GetStringLeft(GetStringRight(sMessage, nMessageLength - nTempInc), nTempInc));
        }
    }

    //This needs to be altered to take into consideration the ability of other players around to understand.
    //Waiting for response to find out how to determinet this.
    SetPCChatMessage(sOutputBuffer);
}


////////////////////////
//BELOW ARE CONVERSION TABLES FOR SUPPORT LANGUAGES
//Thanks to Tsunami282
//
//Supported Languages
//-------------------
//Abyssal
//Animal
//Celestial
//Draconic
//Xanalress
//Dwarven
//Elven
//Gnome
//Undercommon
//Halfling
//Infernal
//Mulan
//Orc
//Rashemi
//Sylvan
//Thieves' Cant
////////////////////////

string convertXanalress(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    case 0: return "il";
    case 26: return "Il";
    case 1: return "f";
    case 27: return "F";
    case 2: return "st";
    case 28: return "St";
    case 3: return "w";
    case 4: return "a";
    case 5: return "o";
    case 6: return "v";
    case 7: return "ir";
    case 33: return "Ir";
    case 8: return "e";
    case 9: return "vi";
    case 35: return "Vi";
    case 10: return "go";
    case 11: return "c";
    case 12: return "li";
    case 13: return "l";
    case 14: return "e";
    case 15: return "ty";
    case 41: return "Ty";
    case 16: return "r";
    case 17: return "m";
    case 18: return "la";
    case 44: return "La";
    case 19: return "an";
    case 45: return "An";
    case 20: return "y";
    case 21: return "el";
    case 47: return "El";
    case 22: return "ky";
    case 48: return "Ky";
    case 23: return "'";
    case 24: return "a";
    case 25: return "p'";
    case 29: return "W";
    case 30: return "A";
    case 31: return "O";
    case 32: return "V";
    case 34: return "E";
    case 36: return "Go";
    case 37: return "C";
    case 38: return "Li";
    case 39: return "L";
    case 40: return "E";
    case 42: return "R";
    case 43: return "M";
    case 46: return "Y";
    case 49: return "'";
    case 50: return "A";
    case 51: return "P'";

    default: return sLetter;
    } return "";
}

string convertInfernal(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    case 0: return "o";
    case 1: return "c";
    case 2: return "r";
    case 3: return "j";
    case 4: return "a";
    case 5: return "v";
    case 6: return "k";
    case 7: return "r";
    case 8: return "y";
    case 9: return "z";
    case 10: return "g";
    case 11: return "m";
    case 12: return "z";
    case 13: return "r";
    case 14: return "y";
    case 15: return "k";
    case 16: return "r";
    case 17: return "n";
    case 18: return "k";
    case 19: return "d";
    case 20: return "'";
    case 21: return "r";
    case 22: return "'";
    case 23: return "k";
    case 24: return "i";
    case 25: return "g";
    case 26: return "O";
    case 27: return "C";
    case 28: return "R";
    case 29: return "J";
    case 30: return "A";
    case 31: return "V";
    case 32: return "K";
    case 33: return "R";
    case 34: return "Y";
    case 35: return "Z";
    case 36: return "G";
    case 37: return "M";
    case 38: return "Z";
    case 39: return "R";
    case 40: return "Y";
    case 41: return "K";
    case 42: return "R";
    case 43: return "N";
    case 44: return "K";
    case 45: return "D";
    case 46: return "'";
    case 47: return "R";
    case 48: return "'";
    case 49: return "K";
    case 50: return "I";
    case 51: return "G";
    default: return sLetter;
    }
    return "";
}//end ConvertInfernal

string convertAbyssal(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    case 27: return "N";
    case 28: return "M";
    case 29: return "G";
    case 30: return "A";
    case 31: return "K";
    case 32: return "S";
    case 33: return "D";
    case 35: return "H";
    case 36: return "B";
    case 37: return "L";
    case 38: return "P";
    case 39: return "T";
    case 40: return "E";
    case 41: return "B";
    case 43: return "N";
    case 44: return "M";
    case 45: return "G";
    case 48: return "B";
    case 51: return "T";
    case 0: return "oo";
    case 26: return "OO";
    case 1: return "n";
    case 2: return "m";
    case 3: return "g";
    case 4: return "a";
    case 5: return "k";
    case 6: return "s";
    case 7: return "d";
    case 8: return "oo";
    case 34: return "OO";
    case 9: return "h";
    case 10: return "b";
    case 11: return "l";
    case 12: return "p";
    case 13: return "t";
    case 14: return "e";
    case 15: return "b";
    case 16: return "ch";
    case 42: return "Ch";
    case 17: return "n";
    case 18: return "m";
    case 19: return "g";
    case 20: return  "ae";
    case 46: return  "Ae";
    case 21: return  "ts";
    case 47: return  "Ts";
    case 22: return "b";
    case 23: return  "bb";
    case 49: return  "Bb";
    case 24: return  "ee";
    case 50: return  "Ee";
    case 25: return "t";
    default: return sLetter;
    }
    return "";
}//end ConvertAbyssal

string convertCelestial(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    case 0: return "a";
    case 1: return "p";
    case 2: return "v";
    case 3: return "t";
    case 4: return "el";
    case 5: return "b";
    case 6: return "w";
    case 7: return "r";
    case 8: return "i";
    case 9: return "m";
    case 10: return "x";
    case 11: return "h";
    case 12: return "s";
    case 13: return "c";
    case 14: return "u";
    case 15: return "q";
    case 16: return "d";
    case 17: return "n";
    case 18: return "l";
    case 19: return "y";
    case 20: return "o";
    case 21: return "j";
    case 22: return "f";
    case 23: return "g";
    case 24: return "z";
    case 25: return "k";
    case 26: return "A";
    case 27: return "P";
    case 28: return "V";
    case 29: return "T";
    case 30: return "El";
    case 31: return "B";
    case 32: return "W";
    case 33: return "R";
    case 34: return "I";
    case 35: return "M";
    case 36: return "X";
    case 37: return "H";
    case 38: return "S";
    case 39: return "C";
    case 40: return "U";
    case 41: return "Q";
    case 42: return "D";
    case 43: return "N";
    case 44: return "L";
    case 45: return "Y";
    case 46: return "O";
    case 47: return "J";
    case 48: return "F";
    case 49: return "G";
    case 50: return "Z";
    case 51: return "K";
    default: return sLetter;
    }
    return "";
}//end ConvertCelestial

string convertUndercommon(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    case 0: return "u";
    case 1: return "p";
    case 2: return "";
    case 3: return "t";
    case 4: return "'";
    case 5: return "v";
    case 6: return "k";
    case 7: return "r";
    case 8: return "o";
    case 9: return "z";
    case 10: return "g";
    case 11: return "m";
    case 12: return "s";
    case 13: return "";
    case 14: return "u";
    case 15: return "b";
    case 16: return "";
    case 17: return "n";
    case 18: return "k";
    case 19: return "d";
    case 20: return "u";
    case 21: return "";
    case 22: return "'";
    case 23: return "";
    case 24: return "o";
    case 25: return "w";
    case 26: return "U";
    case 27: return "P";
    case 28: return "";
    case 29: return "T";
    case 30: return "'";
    case 31: return "V";
    case 32: return "K";
    case 33: return "R";
    case 34: return "O";
    case 35: return "Z";
    case 36: return "G";
    case 37: return "M";
    case 38: return "S";
    case 39: return "";
    case 40: return "U";
    case 41: return "B";
    case 42: return "";
    case 43: return "N";
    case 44: return "K";
    case 45: return "D";
    case 46: return "U";
    case 47: return "";
    case 48: return "'";
    case 49: return "";
    case 50: return "O";
    case 51: return "W";
    default: return sLetter;
    }
    return "";
}//end ConvertUndercommon

string convertDraconic(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    case 0: return "e";
    case 26: return "E";
    case 1: return "po";
    case 27: return "Po";
    case 2: return "st";
    case 28: return "St";
    case 3: return "ty";
    case 29: return "Ty";
    case 4: return "i";
    case 5: return "w";
    case 6: return "k";
    case 7: return "ni";
    case 33: return "Ni";
    case 8: return "un";
    case 34: return "Un";
    case 9: return "vi";
    case 35: return "Vi";
    case 10: return "go";
    case 36: return "Go";
    case 11: return "ch";
    case 37: return "Ch";
    case 12: return "li";
    case 38: return "Li";
    case 13: return "ra";
    case 39: return "Ra";
    case 14: return "y";
    case 15: return "ba";
    case 41: return "Ba";
    case 16: return "x";
    case 17: return "hu";
    case 43: return "Hu";
    case 18: return "my";
    case 44: return "My";
    case 19: return "dr";
    case 45: return "Dr";
    case 20: return "on";
    case 46: return "On";
    case 21: return "fi";
    case 47: return "Fi";
    case 22: return "zi";
    case 48: return "Zi";
    case 23: return "qu";
    case 49: return "Qu";
    case 24: return "an";
    case 50: return "An";
    case 25: return "ji";
    case 51: return "Ji";
    case 30: return "I";
    case 31: return "W";
    case 32: return "K";
    case 40: return "Y";
    case 42: return "X";
    default: return sLetter;
    }
    return "";
}//end ConvertDraconic

string convertDwarf(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    case 0: return "az";
    case 26: return "Az";
    case 1: return "po";
    case 27: return "Po";
    case 2: return "zi";
    case 28: return "Zi";
    case 3: return "t";
    case 4: return "a";
    case 5: return "wa";
    case 31: return "Wa";
    case 6: return "k";
    case 7: return "'";
    case 8: return "a";
    case 9: return "dr";
    case 35: return "Dr";
    case 10: return "g";
    case 11: return "n";
    case 12: return "l";
    case 13: return "r";
    case 14: return "ur";
    case 40: return "Ur";
    case 15: return "rh";
    case 41: return "Rh";
    case 16: return "k";
    case 17: return "h";
    case 18: return "th";
    case 44: return "Th";
    case 19: return "k";
    case 20: return "'";
    case 21: return "g";
    case 22: return "zh";
    case 48: return "Zh";
    case 23: return "q";
    case 24: return "o";
    case 25: return "j";
    case 29: return "T";
    case 30: return "A";
    case 32: return "K";
    case 33: return "'";
    case 34: return "A";
    case 36: return "G";
    case 37: return "N";
    case 38: return "L";
    case 39: return "R";
    case 42: return "K";
    case 43: return "H";
    case 45: return "K";
    case 46: return "'";
    case 47: return "G";
    case 49: return "Q";
    case 50: return "O";
    case 51: return "J";
    default: return sLetter;
    } return "";
}//end ConvertDwarf

string convertElven(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    case 0: return "il";
    case 26: return "Il";
    case 1: return "f";
    case 2: return "ny";
    case 28: return "Ny";
    case 3: return "w";
    case 4: return "a";
    case 5: return "o";
    case 6: return "v";
    case 7: return "ir";
    case 33: return "Ir";
    case 8: return "e";
    case 9: return "qu";
    case 35: return "Qu";
    case 10: return "n";
    case 11: return "c";
    case 12: return "s";
    case 13: return "l";
    case 14: return "e";
    case 15: return "ty";
    case 41: return "Ty";
    case 16: return "h";
    case 17: return "m";
    case 18: return "la";
    case 44: return "La";
    case 19: return "an";
    case 45: return "An";
    case 20: return "y";
    case 21: return "el";
    case 47: return "El";
    case 22: return "am";
    case 48: return "Am";
    case 23: return "'";
    case 24: return "a";
    case 25: return "j";

    case 27: return "F";
    case 29: return "W";
    case 30: return "A";
    case 31: return "O";
    case 32: return "V";
    case 34: return "E";
    case 36: return "N";
    case 37: return "C";
    case 38: return "S";
    case 39: return "L";
    case 40: return "E";
    case 42: return "H";
    case 43: return "M";
    case 46: return "Y";
    case 49: return "'";
    case 50: return "A";
    case 51: return "J";

    default: return sLetter;
    } return "";
}

string convertGnome(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
//cipher based on English -> Al Baed
    case 0: return "y";
    case 1: return "p";
    case 2: return "l";
    case 3: return "t";
    case 4: return "a";
    case 5: return "v";
    case 6: return "k";
    case 7: return "r";
    case 8: return "e";
    case 9: return "z";
    case 10: return "g";
    case 11: return "m";
    case 12: return "s";
    case 13: return "h";
    case 14: return "u";
    case 15: return "b";
    case 16: return "x";
    case 17: return "n";
    case 18: return "c";
    case 19: return "d";
    case 20: return "i";
    case 21: return "j";
    case 22: return "f";
    case 23: return "q";
    case 24: return "o";
    case 25: return "w";
    case 26: return "Y";
    case 27: return "P";
    case 28: return "L";
    case 29: return "T";
    case 30: return "A";
    case 31: return "V";
    case 32: return "K";
    case 33: return "R";
    case 34: return "E";
    case 35: return "Z";
    case 36: return "G";
    case 37: return "M";
    case 38: return "S";
    case 39: return "H";
    case 40: return "U";
    case 41: return "B";
    case 42: return "X";
    case 43: return "N";
    case 44: return "C";
    case 45: return "D";
    case 46: return "I";
    case 47: return "J";
    case 48: return "F";
    case 49: return "Q";
    case 50: return "O";
    case 51: return "W";
    default: return sLetter;
    } return "";
}

string convertHalfling(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
//cipher based on Al Baed -> English
    case 0: return "e";
    case 1: return "p";
    case 2: return "s";
    case 3: return "t";
    case 4: return "i";
    case 5: return "w";
    case 6: return "k";
    case 7: return "n";
    case 8: return "u";
    case 9: return "v";
    case 10: return "g";
    case 11: return "c";
    case 12: return "l";
    case 13: return "r";
    case 14: return "y";
    case 15: return "b";
    case 16: return "x";
    case 17: return "h";
    case 18: return "m";
    case 19: return "d";
    case 20: return "o";
    case 21: return "f";
    case 22: return "z";
    case 23: return "q";
    case 24: return "a";
    case 25: return "j";
    case 26: return "E";
    case 27: return "P";
    case 28: return "S";
    case 29: return "T";
    case 30: return "I";
    case 31: return "W";
    case 32: return "K";
    case 33: return "N";
    case 34: return "U";
    case 35: return "V";
    case 36: return "G";
    case 37: return "C";
    case 38: return "L";
    case 39: return "R";
    case 40: return "Y";
    case 41: return "B";
    case 42: return "X";
    case 43: return "H";
    case 44: return "M";
    case 45: return "D";
    case 46: return "O";
    case 47: return "F";
    case 48: return "Z";
    case 49: return "Q";
    case 50: return "A";
    case 51: return "J";
    default: return sLetter;
    } return "";
}

string convertOrc(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    case 0: return "ha";
    case 26: return "Ha";
    case 1: return "p";
    case 2: return "z";
    case 3: return "t";
    case 4: return "o";
    case 5: return "";
    case 6: return "k";
    case 7: return "r";
    case 8: return "a";
    case 9: return "m";
    case 10: return "g";
    case 11: return "h";
    case 12: return "r";
    case 13: return "k";
    case 14: return "u";
    case 15: return "b";
    case 16: return "k";
    case 17: return "h";
    case 18: return "g";
    case 19: return "n";
    case 20: return "";
    case 21: return "g";
    case 22: return "r";
    case 23: return "r";
    case 24: return "'";
    case 25: return "m";
    case 27: return "P";
    case 28: return "Z";
    case 29: return "T";
    case 30: return "O";
    case 31: return "";
    case 32: return "K";
    case 33: return "R";
    case 34: return "A";
    case 35: return "M";
    case 36: return "G";
    case 37: return "H";
    case 38: return "R";
    case 39: return "K";
    case 40: return "U";
    case 41: return "B";
    case 42: return "K";
    case 43: return "H";
    case 44: return "G";
    case 45: return "N";
    case 46: return "";
    case 47: return "G";
    case 48: return "R";
    case 49: return "R";
    case 50: return "'";
    case 51: return "M";
    default: return sLetter;
    } return "";
}

string convertAnimal(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    case 0: return "'";
    case 1: return "'";
    case 2: return "'";
    case 3: return "'";
    case 4: return "'";
    case 5: return "'";
    case 6: return "'";
    case 7: return "'";
    case 8: return "'";
    case 9: return "'";
    case 10: return "'";
    case 11: return "'";
    case 12: return "'";
    case 13: return "'";
    case 14: return "'";
    case 15: return "'";
    case 16: return "'";
    case 17: return "'";
    case 18: return "'";
    case 19: return "'";
    case 20: return "'";
    case 21: return "'";
    case 22: return "'";
    case 23: return "'";
    case 24: return "'";
    case 25: return "'";
    case 26: return "'";
    case 27: return "'";
    case 28: return "'";
    case 29: return "'";
    case 30: return "'";
    case 31: return "'";
    case 32: return "'";
    case 33: return "'";
    case 34: return "'";
    case 35: return "'";
    case 36: return "'";
    case 37: return "'";
    case 38: return "'";
    case 39: return "'";
    case 40: return "'";
    case 41: return "'";
    case 42: return "'";
    case 43: return "'";
    case 44: return "'";
    case 45: return "'";
    case 46: return "'";
    case 47: return "'";
    case 48: return "'";
    case 49: return "'";
    case 50: return "'";
    case 51: return "'";
    default: return sLetter;
    } return "";
}

string convertSylvan(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    case 0: return "i";
    case 1: return "ri";
    case 2: return "ba";
    case 3: return "ma";
    case 4: return "i";
    case 5: return "mo";
    case 6: return "yo";
    case 7: return "f";
    case 8: return "ya";
    case 9: return "ta";
    case 10: return "m";
    case 11: return "t";
    case 12: return "r";
    case 13: return "j";
    case 14: return "nu";
    case 15: return "wi";
    case 16: return "bo";
    case 17: return "w";
    case 18: return "ne";
    case 19: return "na";
    case 20: return "li";
    case 21: return "v";
    case 22: return "ni";
    case 23: return "ya";
    case 24: return "mi";
    case 25: return "og";
    case 26: return "I";
    case 27: return "Ri";
    case 28: return "Ba";
    case 29: return "Ma";
    case 30: return "I";
    case 31: return "Mo";
    case 32: return "Yo";
    case 33: return "F";
    case 34: return "Ya";
    case 35: return "Ta";
    case 36: return "M";
    case 37: return "T";
    case 38: return "R";
    case 39: return "J";
    case 40: return "Nu";
    case 41: return "Wi";
    case 42: return "Bo";
    case 43: return "W";
    case 44: return "Ne";
    case 45: return "Na";
    case 46: return "Li";
    case 47: return "V";
    case 48: return "Ni";
    case 49: return "Ya";
    case 50: return "Mi";
    case 51: return "Og";
    default: return sLetter;
    } return "";
}

string convertRashemi(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    case 0: return "a";
    case 1: return "s";
    case 2: return "n";
    case 3: return "y";
    case 4: return "ov";
    case 5: return "d";
    case 6: return "sk";
    case 7: return "fr";
    case 8: return "u";
    case 9: return "o";
    case 10: return "f";
    case 11: return "r";
    case 12: return "z";
    case 13: return "s";
    case 14: return "o";
    case 15: return "j";
    case 16: return "sk";
    case 17: return " ";
    case 18: return "or";
    case 19: return "ka";
    case 20: return "o";
    case 21: return "ka";
    case 22: return "ma";
    case 23: return "o";
    case 24: return "oj";
    case 25: return "y";
    case 26: return "A";
    case 27: return "S";
    case 28: return "N";
    case 29: return "Y";
    case 30: return "Ov";
    case 31: return "D";
    case 32: return "Sk";
    case 33: return "Fr";
    case 34: return "U";
    case 35: return "O";
    case 36: return "F";
    case 37: return "R";
    case 38: return "Z";
    case 39: return "S";
    case 40: return "O";
    case 41: return "J";
    case 42: return "Sk";
    case 43: return "M";
    case 44: return "Or";
    case 45: return "Ka";
    case 46: return "O";
    case 47: return "Ka";
    case 48: return "Ma";
    case 49: return "O";
    case 50: return "Oj";
    case 51: return "Y";
    default: return sLetter;
    } return "";
}

string convertMulan(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    case 0: return "ri";
    case 1: return "dj";
    case 2: return "p";
    case 3: return "al";
    case 4: return "a";
    case 5: return "j";
    case 6: return "y";
    case 7: return "u";
    case 8: return "o";
    case 9: return "f";
    case 10: return "ch";
    case 11: return "d";
    case 12: return "t";
    case 13: return "m";
    case 14: return "eh";
    case 15: return "k";
    case 16: return "ng";
    case 17: return "sh";
    case 18: return "th";
    case 19: return "s";
    case 20: return "e";
    case 21: return "z";
    case 22: return "p";
    case 23: return "qu";
    case 24: return "o";
    case 25: return "z";
    case 26: return "Ri";
    case 27: return "Dj";
    case 28: return "P";
    case 29: return "Al";
    case 30: return "A";
    case 31: return "J";
    case 32: return "Y";
    case 33: return "U";
    case 34: return "O";
    case 35: return "F";
    case 36: return "Ch";
    case 37: return "D";
    case 38: return "T";
    case 39: return "M";
    case 40: return "Eh";
    case 41: return "K";
    case 42: return "Ng";
    case 43: return "Sh";
    case 44: return "Th";
    case 45: return "S";
    case 46: return "E";
    case 47: return "Z";
    case 48: return "P";
    case 49: return "Qu";
    case 50: return "O";
    case 51: return "Z";
    default: return sLetter;
    } return "";
}

string convertCant(string sLetter)
{
    if (GetStringLength(sLetter) > 1)
        sLetter = GetStringLeft(sLetter, 1);

    if (sLetter == "a" || sLetter == "A") return "*Shields eyes.*";
    if (sLetter == "b" || sLetter == "B") return "*Blusters.*";
    if (sLetter == "c" || sLetter == "C") return "*Coughs.*";
    if (sLetter == "d" || sLetter == "D") return "*Furrows brow.*";
    if (sLetter == "e" || sLetter == "E") return "*Stares at the ground in thought.*";
    if (sLetter == "f" || sLetter == "F") return "*Frowns.*";
    if (sLetter == "g" || sLetter == "G") return "*Glances up.*";
    if (sLetter == "h" || sLetter == "H") return "*Looks thoughtful.*";
    if (sLetter == "i" || sLetter == "I") return "*Looks bored.*";
    if (sLetter == "j" || sLetter == "J") return "*Rubs chin thoughtfully.*";
    if (sLetter == "k" || sLetter == "K") return "*Scratches ear.*";
    if (sLetter == "l" || sLetter == "L") return "*Looks around.*";
    if (sLetter == "m" || sLetter == "M") return "Hmm.";
    if (sLetter == "n" || sLetter == "N") return "*Nods.*";
    if (sLetter == "o" || sLetter == "O") return "*Grins.*";
    if (sLetter == "p" || sLetter == "P") return "*Smiles widely.*";
    if (sLetter == "q" || sLetter == "Q") return "*Shivers slightly.*";
    if (sLetter == "r" || sLetter == "R") return "*Rolls eyes.*";
    if (sLetter == "s" || sLetter == "S") return "*Scratches nose.*";
    if (sLetter == "t" || sLetter == "T") return "*Turns slightly to the left and then the right.*";
    if (sLetter == "u" || sLetter == "U") return "*Glances idly about.*";
    if (sLetter == "v" || sLetter == "V") return "*Runs hand through hair.*";
    if (sLetter == "w" || sLetter == "W") return "*Waves.*";
    if (sLetter == "x" || sLetter == "X") return "*Stretches.*";
    if (sLetter == "y" || sLetter == "Y") return "*Yawns.*";
    if (sLetter == "z" || sLetter == "Z") return "*Shrugs.*";

    return "*nods*";
}
