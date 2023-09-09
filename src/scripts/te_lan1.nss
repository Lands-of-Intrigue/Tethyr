void main()
{
    object oTarget;
    int iLang = 1;
    string sLang = "Elven";

    iLang = 2;
    sLang = "Gnome";

    iLang = 3;
    sLang = "Halfling";

    iLang = 4;
    sLang = "Dwarven";

    iLang = 5;
    sLang = "Orc";

    iLang = 6;
    sLang = "Goblin";

    iLang = 7;
    sLang = "Draconic";

    iLang = 8;
    sLang = "Animal";

    iLang = 9;
    sLang = "Thieves' Cant";

    iLang = 10;
    sLang = "Celestial";

    iLang = 11;
    sLang = "Abyssal";

    iLang = 12;
    sLang = "Infernal";

    iLang = 13;
    sLang = "Drow";

    iLang = 14;
    sLang = "Sylvan";

    iLang = 15;
    sLang = "Rashemi";

    iLang = 16;
    sLang = "Mulhorandi";

    SetLocalInt(oTarget, "hls_MyLanguage", iLang);
    SetLocalString(oTarget, "hls_MyLanguageName", sLang);
}
