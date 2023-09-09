void main()
{

    /*
    object oMod = GetModule();
    int nMonth = GetCalendarMonth(); //1-12
    int nD20 = d20(1);

        switch (nMonth)
        {
            case 1|2:
            {
                if (GetIsNight())
                {
                    switch (nD20)
                    {   case 1|2|3|4: //Clear - 20%
                            {   SetLocalInt(oMod, "iWeather", WEATHER_CLEAR);
                                break;}
                        case 6|7|8|9|10|11|12|13: //Rain - 40%
                            {   SetLocalInt(oMod, "iWeather", WEATHER_RAIN);
                                break;}
                        case 14|15|16|17|18|19|20: //Snow - 40%
                            {   SetLocalInt(oMod, "iWeather", WEATHER_SNOW);
                                break;}
                    }
                    break;
                }
                else if (!GetIsNight())
                {
                    switch (nD20)
                    {
                        case 1|2|3|4|5|6|7|8: //Clear -40%
                            {   SetLocalInt(oMod, "iWeather", WEATHER_CLEAR);
                                break;}
                        case 9|10|11|12|13|14|15|16: //Rain - 40%
                            {   SetLocalInt(oMod, "iWeather", WEATHER_RAIN);
                                break;}
                        case 17|18|19|20: //Snow - 20%
                            {   SetLocalInt(oMod, "iWeather", WEATHER_SNOW);
                                break;}
                    }
                    break;
                }
            }
            case 3|4|5:
            {
                if (GetIsNight())
                {
                    switch (nD20)
                    {
                        case 1|2|3|4|5|6: //Clear - 35%
                        {   SetLocalInt(oMod, "iWeather", WEATHER_CLEAR);
                            break;}

                        case 7|8|9|10|11|12|13: //Rain - 30%
                        {   SetLocalInt(oMod, "iWeather", WEATHER_RAIN);
                            break;}
                        case 14|15|16|17|18|19|20: //Snow - 35%
                        {   SetLocalInt(oMod, "iWeather", WEATHER_SNOW);
                            break;}
                    }
                    break;
                }
                else if (!GetIsNight())
                {
                    switch (nD20)
                    {
                        case 1|2|3|4|5|6|7|8|9|10: //Clear - 50%
                        {   SetLocalInt(oMod, "iWeather", WEATHER_CLEAR);
                            break;}

                        case 11|12|13|14|15|16|17|18: //Rain - 40%
                        {    SetLocalInt(oMod, "iWeather", WEATHER_RAIN);
                            break;}

                        case 19|20: //Snow - 10%
                        {   SetLocalInt(oMod, "iWeather", WEATHER_SNOW);
                            break;}
                    }
                    break;
                }
            }
            case 6|7|8|9:
            {
                if (GetIsNight())
                {
                    switch (nD20)
                    {
                        case 1|2|3|4|5|6|7|8|9|10|11: //Clear - 50%
                        {   SetLocalInt(oMod, "iWeather", WEATHER_CLEAR);
                            break;}
                        case 12|13|14|15|16|17|18|19|20: //Rain - 50%
                        {    SetLocalInt(oMod, "iWeather", WEATHER_RAIN);
                            break;}
                    }
                    break;
                }
                else if (!GetIsNight())
                {
                    switch (nD20)
                    {
                        case 1|2|3|4|5|6|7|8|9|10|11|12|13|14: //Clear - 70%
                        {   SetLocalInt(oMod, "iWeather", WEATHER_CLEAR);
                            break;}

                        case 15|16|17|18|19|20: //Rain - 30%
                        {    SetLocalInt(oMod, "iWeather", WEATHER_RAIN);
                            break;}
                    }
                    break;
                }
            }
            case 10|11|12:
            {
                if (GetIsNight())
                {
                    switch (nD20)
                    {
                        case 1|2|3|4|5: //Clear - 40%
                        {   SetLocalInt(oMod, "iWeather", WEATHER_CLEAR);
                            break;}

                        case 6|7|8|9|10|11|12|13|14|15|16|17: //Rain - 50%
                        {   SetLocalInt(oMod, "iWeather", WEATHER_RAIN);
                            break;}

                        case 18|19|20://Snow - 10%
                        {   SetLocalInt(oMod, "iWeather", WEATHER_SNOW);
                            break;}
                    }
                    break;
                }
                else if (!GetIsNight())
                {
                    switch (nD20)
                    {
                        case 1|2|3|4|5|6|7: //Clear - 60%
                        {   SetLocalInt(oMod, "iWeather", WEATHER_CLEAR);
                            break;}

                        case 8|9|10|11|12|13|14|15|16|17|18: //Rain - 35%
                        {   SetLocalInt(oMod, "iWeather", WEATHER_RAIN);
                            break;}
                        case 19|20: //Snow - 5%
                        {   SetLocalInt(oMod, "iWeather", WEATHER_SNOW);
                            break;}
                    }
                    break;
                }
            }
        }
    DelayCommand(HoursToSeconds(1),ExecuteScript("te_weather", oMod));
    */
}
