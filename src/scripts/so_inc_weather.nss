#include "te_afflic_func"
#include "nwnx_area"
#include "x3_inc_horse"
#include "nwnx_time"

const float WEATHER_TEMPERATURE_MIN=-50.0;
const float WEATHER_TEMPERATURE_MAX=50.0;
const float WEATHER_SUN_COLOUR_BASE=180.0;
const float WEATHER_SUN_COLOUR_TEMPERATURE_MID=15.0;
const float WEATHER_BACKGROUND_FOG_DAY_RED=140.0;
const float WEATHER_BACKGROUND_FOG_DAY_GREEN=140.0;
const float WEATHER_BACKGROUND_FOG_DAY_BLUE=140.0;
const float WEATHER_SATURATION_MODIFIER=1.0;
const float WEATHER_FOGGINESS_MODIFIER=1.0;
//Changed from 50 to 25 12/14/18
const float WEATHER_FOGGINESS_START=25.0;

const float WEATHER_SUN_REDSHIFT_MODIFIER=1.0;
const float WEATHER_WIND_MODIFIER=0.025;

const float WEATHER_MOON_COLOUR_BASE_RED=6.0;
const float WEATHER_MOON_COLOUR_BASE_GREEN=6.0;
const float WEATHER_MOON_COLOUR_BASE_BLUE=24.0;

const float WEATHER_SUN_HEAT_MODIFIER=0.625;
const float WEATHER_GROUND_DAMPNING_MODIFIER=2.0;
const float WEATHER_ATMOSPHERIC_DAMPNING_MODIFIER=0.25;

const float WEATHER_SUN_HEAT_VAPORING_MODIFIER=0.5;
const float WEATHER_RAIN_CONDENSING_MODIFIER=0.1;

const float WEATHER_MAX_VARIATION=20.0;
const float WEATHER_DAILY_VARIATION=10.0;

const float WEATHER_WIND_TO_METERS_PER_SECOND=100.0;
const float WEATHER_WIND_MAX_ACCELERATION=0.02;

const string WEATHER_LOCAL_GROUND_TEMPERATURE="Weather_Local_Ground_Temperature";
const string WEATHER_LOCAL_SKY_TEMPERATURE="Weather_Local_Sky_Temperature";
const string WEATHER_LOCAL_GROUND_HUMIDITY="Weather_Local_Ground_Humidity";
const string WEATHER_LOCAL_SKY_HUMIDITY="Weather_Local_Sky_Humidity";
const string WEATHER_LOCAL_CLOUDINESS="Weather_Local_Cloudiness";
const string WEATHER_LOCAL_RAIN="Weather_Local_Rain";

const string WEATHER_BEYOND_GROUND_TEMPERATURE="Weather_Beyond_Ground_Temperature";
const string WEATHER_BEYOND_SKY_TEMPERATURE="Weather_Beyond_Sky_Temperature";
const string WEATHER_BEYOND_GROUND_HUMIDITY="Weather_Beyond_Ground_Humidity";
const string WEATHER_BEYOND_SKY_HUMIDITY="Weather_Beyond_Sky_Humidity";

const string WEATHER_GLOBAL_SUN_INFLUX="Weather_Global_Sun_Influx";
const string WEATHER_GLOBAL_MOONLIGHT="Weather_Global_Moonlight";
const string WEATHER_GLOBAL_WIND="Weather_Global_Wind";
const string WEATHER_GLOBAL_SUN_REDSHIFT="Weather_Global_Sun_Redshift";

const string WEATHER_AREA_NO_WEATHER="NoWeather";
const string WEATHER_AREA_NO_WEATHER_SOUND="NoWeatherSound";
const string WEATHER_AREA_RAIN="Rain";
const string WEATHER_AREA_TEMPERATURE="Temperature";
const string WEATHER_AREA_LIGHT="Light";
//const string WEATHER_AREA_FOG="Fog";
const string WEATHER_AREA_HUMIDITY="Humidity";
const string WEATHER_AREA_WIND_MODIFIER="Wind";

void UpdateAreaWeather(object oArea, int nInstant=FALSE);
void UpdateGlobalWeather(int bFeedback=FALSE);
int WeatherToColour(float fTemperature, float fSunshine, float fMoonlight, float fFoggyness, float fHumidity);

void FadeFog(object oArea, int nColour, int nAmount, int nInstant=FALSE, int nSafe=120)
{
    if(nSafe<=0)
    {
        nInstant=TRUE;
    }
    if(nInstant)
    {
        SetFogAmount(FOG_TYPE_SUN,nAmount,oArea);
        SetFogAmount(FOG_TYPE_MOON,nAmount,oArea);
        SetFogColor(FOG_TYPE_MOON,nColour,oArea);
        SetFogColor(FOG_TYPE_SUN,nColour,oArea);
        return;
    }

    int nCurrentAmount=GetFogAmount(FOG_TYPE_SUN,oArea);
    int nRerun=FALSE;
    if(nAmount>nCurrentAmount)
    {
        SetFogAmount(FOG_TYPE_SUN,nCurrentAmount+1,oArea);
        SetFogAmount(FOG_TYPE_MOON,nCurrentAmount+1,oArea);
        nRerun=TRUE;
    }
    else if(nAmount<nCurrentAmount)
    {
        SetFogAmount(FOG_TYPE_SUN,nCurrentAmount-1,oArea);
        SetFogAmount(FOG_TYPE_MOON,nCurrentAmount-1,oArea);
        nRerun=TRUE;
    }
    int nColourCurrent=GetFogColor(FOG_TYPE_SUN,oArea);
    int nRedCurrent=nColourCurrent/(16*16*16*16);
    int nGreenCurrent=(nColourCurrent-nRedCurrent*16*16*16*16)/(16*16);
    int nBlueCurrent=nColourCurrent-nRedCurrent*16*16*16*16-nGreenCurrent*16*16;
    int nRed=nColour/(16*16*16*16);
    int nGreen=(nColour-nRed*16*16*16*16)/(16*16);
    int nBlue=nColour-nRed*16*16*16*16-nGreen*16*16;
    int nRedDifference=abs(nRedCurrent-nRed);
    int nGreenDifference=abs(nGreenCurrent-nGreen);
    int nBlueDifference=abs(nBlueCurrent-nBlue);
    int nRedChange=0;
    int nGreenChange=0;
    int nBlueChange=0;
    if(nRedDifference!=0)
    {
        if((nGreenDifference/nRedDifference)<2&&(nBlueDifference/nRedDifference)<2)
        {
            if(nRedCurrent>nRed)
            {
                nRedChange=-1;
            }
            else
            {
                nRedChange=1;
            }
        }
        nRerun=TRUE;
    }
    if(nGreenDifference!=0)
    {
        if((nRedDifference/nGreenDifference)<2&&(nBlueDifference/nGreenDifference)<2)
        {
            if(nGreenCurrent>nGreen)
            {
                nGreenChange=-1;
            }
            else
            {
                nGreenChange=1;
            }
        }
        nRerun=TRUE;
    }
    if(nBlueDifference!=0)
    {
        if((nGreenDifference/nBlueDifference)<2&&(nRedDifference/nBlueDifference)<2)
        {
            if(nBlueCurrent>nBlue)
            {
                nBlueChange=-1;
            }
            else
            {
                nBlueChange=1;
            }
        }
        nRerun=TRUE;
    }
    int nNewFogColour=(nRedCurrent+nRedChange)*16*16*16*16+(nGreenCurrent+nGreenChange)*16*16+(nBlueCurrent+nBlueChange);
    SetFogColor(FOG_TYPE_MOON,nNewFogColour,oArea);
    SetFogColor(FOG_TYPE_SUN,nNewFogColour,oArea);
    if(nRerun)
    {
        float fDelay=0.1;
        nSafe--;
        DelayCommand(fDelay,FadeFog(oArea,nColour,nAmount,FALSE,nSafe));
    }
}

string GetWeatherFeedback(object oPC)
{
    object oModule=GetModule();
    object oArea=GetArea(oPC);
    object oWeatherCache=GetModule();
    float fHumidity=GetLocalFloat(oWeatherCache,WEATHER_LOCAL_SKY_HUMIDITY)+IntToFloat(GetLocalInt(oArea,WEATHER_AREA_HUMIDITY));
    float fTemperature=GetLocalFloat(oWeatherCache,WEATHER_LOCAL_GROUND_TEMPERATURE)+IntToFloat(GetLocalInt(oArea,WEATHER_AREA_TEMPERATURE));
    float fWind=GetLocalFloat(oWeatherCache,WEATHER_GLOBAL_WIND)*(100.0+IntToFloat(GetLocalInt(oArea,WEATHER_AREA_WIND_MODIFIER)))/100.0;
    float fRain =  GetLocalFloat(oWeatherCache,WEATHER_LOCAL_RAIN);
    if(!GetIsAreaAboveGround(oArea)||GetIsAreaInterior(oArea))
    {
        fHumidity=20.0;
        fTemperature=IntToFloat(GetLocalInt(oArea,WEATHER_AREA_TEMPERATURE));
        float fTempOut = GetLocalFloat(oWeatherCache,WEATHER_LOCAL_GROUND_TEMPERATURE)+IntToFloat(GetLocalInt(oArea,WEATHER_AREA_TEMPERATURE));
        if(fTemperature==0.0)
        {
            if(!GetIsAreaAboveGround(oArea))
            {
                fTemperature = IntToFloat(GetLocalInt(oArea,WEATHER_AREA_TEMPERATURE));
            }
            else
            {
                if(fTempOut >= 30.0)
                {
                    fTemperature = 30.0;
                }
                else if(fTempOut <= 30.0 && fTempOut > 25.0)
                {
                    fTemperature = 25.0;
                }
                else if(fTempOut <= 25.0 && fTempOut > 15.0)
                {
                    fTemperature = 20.0;
                }
                else
                {
                    fTemperature = 23.0;
                }
            }
        }
        fWind=0.0;
    }
    float fWind2 = (WEATHER_WIND_TO_METERS_PER_SECOND*fWind);
    string sFeedback= "<cððð>Location:</c><czzþ> "+GetName(oArea);
    if(FloatToInt(fTemperature) >= 30)
    {
        sFeedback+=    "\n</c><cððð>Temperature:</c><cþ  >    "+IntToString(FloatToInt(fTemperature*(9.0/5.0)+32.0))+"°F ("+IntToString(FloatToInt(fTemperature))+"°C)";
    }
    else if (FloatToInt(fTemperature) >= 25 && FloatToInt(fTemperature) < 30)
    {
        sFeedback+=    "\n</c><cððð>Temperature:</c><cþ} >    "+IntToString(FloatToInt(fTemperature*(9.0/5.0)+32.0))+"°F ("+IntToString(FloatToInt(fTemperature))+"°C)";
    }
    else if (FloatToInt(fTemperature) >= 15 && FloatToInt(fTemperature) < 25)
    {
        sFeedback+=    "\n</c><cððð>Temperature:</c><cþ× >    "+IntToString(FloatToInt(fTemperature*(9.0/5.0)+32.0))+"°F ("+IntToString(FloatToInt(fTemperature))+"°C)";
    }
    else if (FloatToInt(fTemperature) >= 10 && FloatToInt(fTemperature) < 15)
    {
        sFeedback+=    "\n</c><cððð>Temperature:</c><c0¡0>    "+IntToString(FloatToInt(fTemperature*(9.0/5.0)+32.0))+"°F ("+IntToString(FloatToInt(fTemperature))+"°C)";
    }
    else if (FloatToInt(fTemperature) <= 10)
    {
        sFeedback+=    "\n</c><cððð>Temperature:</c><c zþ>    "+IntToString(FloatToInt(fTemperature*(9.0/5.0)+32.0))+"°F ("+IntToString(FloatToInt(fTemperature))+"°C)";
    }

    sFeedback+=    "\n</c><cððð>Humidity:</c><czzþ>           "+IntToString(FloatToInt(fHumidity))+"%";
    sFeedback+=    "\n</c><cððð>Wind:</c><czzþ>                 "+IntToString(FloatToInt(WEATHER_WIND_TO_METERS_PER_SECOND*fWind*2.23693629))+"mph ("+IntToString(FloatToInt(WEATHER_WIND_TO_METERS_PER_SECOND*fWind))+" m/s)";

    int nHour=GetTimeHour();
    int nMinute=GetTimeMinute();
    int nDay = GetCalendarDay();
    int nMonth = GetCalendarMonth();
    int nYear = GetCalendarYear();
    sFeedback+="\n</c><cððð>Date:</c><czzþ> "+IntToString(nDay)+" ";
    switch(nMonth)
    {
        case 1:
        sFeedback+="Hammer (Deepwinter) ";
        break;
        case 2:
        sFeedback+="Alturiak (Claw of Winter) ";
        break;
        case 3:
        sFeedback+="Ches (Claw of Sunsets) ";
        break;
        case 4:
        sFeedback+="Tarasakh (Claw of Storms) ";
        break;
        case 5:
        sFeedback+="Mirtul (The Melting) ";
        break;
        case 6:
        sFeedback+="Kythorn (The Time of Flowers) ";
        break;
        case 7:
        sFeedback+="Flamerule (Summertide) ";
        break;
        case 8:
        sFeedback+="Eleasias (Highsun) ";
        break;
        case 9:
        sFeedback+="Eleint (The Fading) ";
        break;
        case 10:
        sFeedback+="Marpenoth (Leafall)";
        break;
        case 11:
        sFeedback+="Uktar (The Rotting) ";
        break;
        case 12:
        sFeedback+="Nightal (The Drawing Down) ";
        break;
    }
    sFeedback+=(IntToString(nYear));

    if(((nMonth == 12)&&(nDay == 28))||((nMonth == 1)&&(nDay == 1)))
    {
        sFeedback+="\n</c><cððð>Holiday:</c> Midwinter (Deadwinter Day)";
    }
    ////////////
    //Waukeen
    ////////////
    if((nMonth == 1)&&(nDay == 15))
    {
        sFeedback+="\n</c><cððð>Holiday:</c> Cold Counting Comfort (Waukeen)";
    }
    if((nMonth == 3)&&(nDay == 28))
    {
        sFeedback+="\n</c><cððð>Holiday:</c> High Coin (Waukeen)";
    }
    if((nMonth == 2)&&(nDay == 20))
    {
        sFeedback+="\n</c><cððð>Holiday:</c> Great Weave (Waukeen)";
    }
    if((nMonth == 4)&&(nDay == 10))
    {
        sFeedback+="\n</c><cððð>Holiday:</c> Spheres (Waukeen)";
    }
    if((nMonth == 5)&&(nDay == 12))
    {
        sFeedback+="\n</c><cððð>Holiday:</c> Sammardach (Waukeen)";
    }
    if((nMonth == 8)&&(nDay == 17))
    {
        sFeedback+="\n</c><cððð>Holiday:</c> Huldark (Waukeen)";
    }
    if((nMonth == 9)&&(nDay == 7))
    {
        sFeedback+="\n</c><cððð>Holiday:</c> Spryndalstar (Waukeen)";
    }
    if((nMonth == 10)&&(nDay == 1))
    {
        sFeedback+="\n</c><cððð>Holiday:</c> Marthoon (Waukeen)";
    }
    if((nMonth == 11)&&(nDay == 10))
    {
        sFeedback+="\n</c><cððð>Holiday:</c> Tehenneahan (Waukeen)";
    }
    if((nMonth == 12)&&(nDay == 25))
    {
        sFeedback+="\n</c><cððð>Holiday:</c> Orbar (Waukeen)";
    }
    if(((nMonth == 7)&&(nDay == 3))||((nMonth == 7)&&(nDay == 4))||((nMonth == 7)&&(nDay == 5)))
    {
        sFeedback+="\n</c><cððð>Holiday:</c> Sornyn (Waukeen)";
    }
    if((nMonth == 4)&&(nDay == 15))
    {
        sFeedback+="\n</c><cððð>Holiday:</c> Windride (Shaundakul)";
    }
    if((nMonth == 4)&&(nDay == 1))
    {
        sFeedback+="\n</c><cððð>Holiday:</c> Queen's Gambit (Red Knight)";
    }

    if((nMonth == 8)&&(nDay == 13))
    {
        sFeedback+="\n</c><cððð>Holiday:</c> Divine Death (Torm)";
    }
    if((nMonth == 8)&&(nDay == 11))
    {
        sFeedback+="\n</c><cððð>Holiday:</c> Penultimate Thunder (Hoar)";
    }

    if((nMonth == 10)&&(nDay == 15))
    {
        sFeedback+="\n</c><cððð>Holiday:</c> Ascension (Mystra)";
        sFeedback+="\n</c><cððð>Holiday:</c> True Resurrection (Torm)";
    }
    if((nMonth == 10)&&(nDay == 23))
    {
        sFeedback+="\n</c><cððð>Holiday:</c> Starfall (Tymora)";
    }
    ////////////
    if(nMonth == 9 & nDay == 12)
    {
        sFeedback+="\n</c><cððð>Holiday:</c> Eve of the Black Days (Tethyr)";
    }
    ////////////
    if(nMonth == 9 && ( nDay == 13||
                        nDay == 14||
                        nDay == 15||
                        nDay == 16||
                        nDay == 17||
                        nDay == 18||
                        nDay == 19||
                        nDay == 20||
                        nDay == 21||
                        nDay == 22)
    )
    {
        sFeedback+="\n</c><cððð>Holiday:</c> Black Days (Tethyr)";
    }

    if((nMonth == 3)&&(nDay == 19))
    {
        sFeedback+="\n</c><cððð>Holiday:</c> Spring Equinox";
    }
    if(((nMonth == 4)&&(nDay == 28))||((nMonth == 5)&&(nDay == 1)))
    {
        sFeedback+="\n</c><cððð>Holiday:</c> Greengrass";
    }
    if((nMonth == 6)&&(nDay == 20))
    {
        sFeedback+="\n</c><cððð>Holiday:</c> Summer Solstice";
    }
    if(((nMonth == 7)&&(nDay == 28))||((nMonth == 8)&&(nDay == 1)))
    {
        sFeedback+="\n</c><cððð>Holiday:</c> Midsummer";
    }
    if((nMonth == 8)&&(nDay == 1)&&(nYear == 1372|1376|1380|1384|1388))
    {
        sFeedback+="\n</c><cððð>Holiday:</c> Shieldmeet";
    }
    if((nMonth == 9)&&(nDay == 21))
    {
        sFeedback+="\n</c><cððð>Holiday:</c> Autumn Equinox";
    }
    if(((nMonth == 9)&&(nDay == 28))||((nMonth == 10)&&(nDay == 1)))
    {
        sFeedback+="\n</c><cððð>Holiday:</c> Highharvestide";
    }
    if(((nMonth == 11)&&(nDay == 28))||((nMonth == 12)&&(nDay == 1)))
    {
        sFeedback+="\n</c><cððð>Holiday:</c> Feast of the Moon";
    }
    if((nMonth == 12)&&(nDay == 20))
    {
        sFeedback+="\n</c><cððð>Holiday:</c> Winter Solstice";
    }

    if((nHour<=5||nHour>=18)||(nHour==17&&nMinute==5)||(nHour==6&&nMinute==0))
    {
        if(GetIsAreaAboveGround(oArea)&&!GetIsAreaInterior(oArea))
        {
            sFeedback+="\n</c><cððð>Moon Phase:</c><czzþ> ";
            switch(nDay)
            {
                case 27:
                case 28:
                case 1:
                case 2:
                case 3:
                    sFeedback+="Full Moon";
                    break;
                case 4:
                case 5:
                case 6:
                    sFeedback+="Waning Gibbous Moon";
                    break;
                case 7:
                case 8:
                case 9:
                    sFeedback+="Waning Half Moon";
                    break;
                case 10:
                case 11:
                case 12:
                case 13:
                    sFeedback+="Waning Crescent Moon";
                    break;
                case 14:
                case 15:
                case 16:
                    sFeedback+="New Moon";
                    break;
                case 17:
                case 18:
                case 19:
                case 20:
                    sFeedback+="Waxing Crescent Moon";
                    break;
                case 21:
                case 22:
                case 23:
                    sFeedback+="Waxing Half Moon";
                    break;
                case 24:
                case 25:
                case 26:
                    sFeedback+="Waxing Gibbous Moon";
                    break;
            }
        }
    }
    if(!GetIsAreaInterior(oArea))
    {
        sFeedback+="\n</c><cððð>Atmospheric:<czzþ> ";
        if(fTemperature > 35.0)
        {
            sFeedback+="The hot air is miserable and stifling, causing you to sweat excessively. ";
            if(fWind2 < 5.0)
            {
                sFeedback+="Short breezes of hot air blow across the County.";
            }
            else if ((fWind2 >=5.0)&&(fWind2 <9.0))
            {
                sFeedback+="A steady breeze of hot air blows across the County.";
            }
            else if ((fWind2 >=9.0)&&(fWind2 <13.0))
            {
                sFeedback+="A strong wind blows across the County.";
            }
            else if ((fWind2 >=13.0)&&(fWind2 <22.0))
            {
                sFeedback+="A severe wind is blowing across the County, making it difficult to venture outside.";
            }
            else if ((fWind2 >=22.0)&&(fWind2 <33.0))
            {
                sFeedback+="A powerful wind is blowing across the County, making it almost impossible to venture outside!";
            }
             else if (fWind2 >=33.0)
            {
                sFeedback+="An extreme storm is blowing across the County, seek shelter immediately!";
            }

            if(fRain >= 1.00)
            {
                sFeedback+=" A deluge of rain falls around you.";
            }
            else if((fRain < 1.0)&&(fRain >=0.5))
            {
                sFeedback+=" A heavy rain falls around you.";
            }
            else if((fRain < 0.5)&&(fRain >=0.25))
            {
                sFeedback+=" A steady rain falls around you.";
            }
            else if ((fRain > 0.0)&&(fRain < 0.25))
            {
                sFeedback+=" A sprinkle of rain falls around you.";
            }
            else
            {
            }

        }
        else if((fTemperature <= 35.0)&&(fTemperature >32.0))
        {
            sFeedback+="The hot air is miserable, causing you to sweat excessively. ";
            if(fWind2 < 5.0)
            {
                sFeedback+="Short breezes of warm air blow across the County.";
            }
            else if ((fWind2 >=5.0)&&(fWind2 <9.0))
            {
                sFeedback+="A steady breeze of warm air blows across the County.";
            }
            else if ((fWind2 >=9.0)&&(fWind2 <13.0))
            {
                sFeedback+="A strong wind blows across the County.";
            }
            else if ((fWind2 >=13.0)&&(fWind2 <22.0))
            {
                sFeedback+="A severe wind is blowing across the County, making it difficult to venture outside.";
            }
            else if ((fWind2 >=22.0)&&(fWind2 <33.0))
            {
                sFeedback+="A powerful wind is blowing across the County, making it almost impossible to venture outside!";
            }
             else if (fWind2 >=33.0)
            {
                sFeedback+="An extreme storm is blowing across the County, seek shelter immediately!";
            }

            if(fRain >= 1.00)
            {
                sFeedback+=" A deluge of rain falls around you.";
            }
            else if((fRain < 1.0)&&(fRain >=0.5))
            {
                sFeedback+=" A heavy rain falls around you.";
            }
            else if((fRain < 0.5)&&(fRain >=0.25))
            {
                sFeedback+=" A steady rain falls around you.";
            }
            else if ((fRain > 0.0)&&(fRain < 0.25))
            {
                sFeedback+=" A sprinkle of rain falls around you.";
            }
            else
            {
            }

        }
        else if((fTemperature <= 32.0)&&(fTemperature >29.0))
        {
            sFeedback+="The warm air is uncomfortable, causing you to sweat. ";
            if(fWind2 < 5.0)
            {
                sFeedback+="Short breezes of mild air blow across the County.";
            }
            else if ((fWind2 >=5.0)&&(fWind2 <9.0))
            {
                sFeedback+="A steady breeze of mild air blows across the County.";
            }
            else if ((fWind2 >=9.0)&&(fWind2 <13.0))
            {
                sFeedback+="A strong wind blows across the County.";
            }
            else if ((fWind2 >=13.0)&&(fWind2 <22.0))
            {
                sFeedback+="A severe wind is blowing across the County, making it difficult to venture outside.";
            }
            else if ((fWind2 >=22.0)&&(fWind2 <33.0))
            {
                sFeedback+="A powerful wind is blowing across the County, making it almost impossible to venture outside!";
            }
             else if (fWind2 >=33.0)
            {
                sFeedback+="An extreme storm is blowing across the County, seek shelter immediately!";
            }

            if(fRain >= 1.00)
            {
                sFeedback+=" A deluge of rain falls around you.";
            }
            else if((fRain < 1.0)&&(fRain >=0.5) )
            {
                sFeedback+=" A heavy rain falls around you.";
            }
            else if((fRain < 0.5)&&(fRain >=0.25))
            {
                sFeedback+=" A steady rain falls around you.";
            }
            else if ((fRain > 0.0)&&(fRain < 0.25))
            {
                sFeedback+=" A sprinkle of rain falls around you.";
            }
            else
            {
            }

        }
        else if((fTemperature <= 29.0)&&(fTemperature >24.0))
        {
            sFeedback+="The warm air is pleasant. ";
            if(fWind2 < 5.0)
            {
                sFeedback+="Short breezes of cool air blow across the County.";
            }
            else if ((fWind2 >=5.0)&&(fWind2 <9.0))
            {
                sFeedback+="A steady breeze of cool air blows across the County.";
            }
            else if ((fWind2 >=9.0)&&(fWind2 <13.0))
            {
                sFeedback+="A strong wind blows across the County.";
            }
            else if ((fWind2 >=13.0)&&(fWind2 <22.0))
            {
                sFeedback+="A severe wind is blowing across the County, making it difficult to venture outside.";
            }
            else if ((fWind2 >=22.0)&&(fWind2 <33.0))
            {
                sFeedback+="A powerful wind is blowing across the County, making it almost impossible to venture outside!";
            }
             else if (fWind2 >=33.0)
            {
                sFeedback+="An extreme storm is blowing across the County, seek shelter immediately!";
            }

            if(fRain >= 1.00)
            {
                sFeedback+=" A deluge of rain falls around you.";
            }
            else if((fRain < 1.0)&&(fRain >=0.5))
            {
                sFeedback+=" A heavy rain falls around you.";
            }
            else if((fRain < 0.5)&&(fRain >=0.25))
            {
                sFeedback+=" A steady rain falls around you.";
            }
            else if ((fRain > 0.0)&&(fRain < 0.25))
            {
                sFeedback+=" A sprinkle of rain falls around you.";
            }
            else
            {
            }

        }
        else if((fTemperature <= 24.0)&&(fTemperature >15.0))
        {
            sFeedback+="The cool air is pleasant. ";
            if(fWind2 < 5.0)
            {
                sFeedback+="Short breezes of brisk air blow across the County.";
            }
            else if ((fWind2 >=5.0)&&(fWind2 <9.0))
            {
                sFeedback+="A steady breeze of brisk air blows across the County.";
            }
            else if ((fWind2 >=9.0)&&(fWind2 <13.0))
            {
                sFeedback+="A strong wind blows across the County.";
            }
            else if ((fWind2 >=13.0)&&(fWind2 <22.0))
            {
                sFeedback+="A severe wind is blowing across the County, making it difficult to venture outside.";
            }
            else if ((fWind2 >=22.0)&&(fWind2 <33.0))
            {
                sFeedback+="A powerful wind is blowing across the County, making it almost impossible to venture outside!";
            }
             else if (fWind2 >=33.0)
            {
                sFeedback+="An extreme storm is blowing across the County, seek shelter immediately!";
            }

            if(fRain >= 1.00)
            {
                sFeedback+=" A deluge of rain falls around you.";
            }
            else if((fRain < 1.0)&&(fRain >=0.5)   )
            {
                sFeedback+=" A heavy rain falls around you.";
            }
            else if((fRain < 0.5)&&(fRain >=0.25))
            {
                sFeedback+=" A steady rain falls around you.";
            }
            else if ((fRain > 0.0)&&(fRain < 0.25))
            {
                sFeedback+=" A sprinkle of rain falls around you.";
            }
            else
            {
            }

        }
        else if((fTemperature <= 15.0)&&(fTemperature >7.0))
        {
            sFeedback+="The brisk air causes your breath to fog in front of you. ";
            if(fWind2 < 5.0)
            {
                sFeedback+="Short breezes of cold air blow across the County.";
            }
            else if ((fWind2 >=5.0)&&(fWind2 <9.0))
            {
                sFeedback+="A steady breeze of cold air blows across the County.";
            }
            else if ((fWind2 >=9.0)&&(fWind2 <13.0))
            {
                sFeedback+="A strong wind blows across the County.";
            }
            else if ((fWind2 >=13.0)&&(fWind2 <22.0))
            {
                sFeedback+="A severe wind is blowing across the County, making it difficult to venture outside.";
            }
            else if ((fWind2 >=22.0)&&(fWind2 <33.0))
            {
                sFeedback+="A powerful wind is blowing across the County, making it almost impossible to venture outside!";
            }
             else if (fWind2 >=33.0)
            {
                sFeedback+="An extreme storm is blowing across the County, seek shelter immediately!";
            }

            if(fRain >= 1.00)
            {
                sFeedback+=" A deluge of rain falls around you.";
            }
            else if((fRain < 1.0)&&(fRain >=0.5)  )
            {
                sFeedback+=" A heavy rain falls around you.";
            }
            else if((fRain < 0.5)&&(fRain >=0.25))
            {
                sFeedback+=" A steady rain falls around you.";
            }
            else if ((fRain > 0.0)&&(fRain < 0.25))
            {
                sFeedback+=" A sprinkle of rain falls around you.";
            }
            else
            {
            }

        }
        else if ((fTemperature <= 7.0) && (fTemperature > 0.0))
        {
            sFeedback+="The cold air causes your breath to fog in front of you and nips at your face and ears. ";
            if(fWind2 < 5.0)
            {
                sFeedback+="Short breezes of frigid air blow across the County.";
            }
            else if ((fWind2 >=5.0)&&(fWind2 <9.0))
            {
                sFeedback+="A steady breeze of frigid air blows across the County.";
            }
            else if ((fWind2 >=9.0)&&(fWind2 <13.0))
            {
                sFeedback+="A strong wind blows across the County.";
            }
            else if ((fWind2 >=13.0)&&(fWind2 <22.0))
            {
                sFeedback+="A severe wind is blowing across the County, making it difficult to venture outside.";
            }
            else if ((fWind2 >=22.0)&&(fWind2 <33.0))
            {
                sFeedback+="A powerful wind is blowing across the County, making it almost impossible to venture outside!";
            }
             else if (fWind2 >=33.0)
            {
                sFeedback+="An extreme storm is blowing across the County, seek shelter immediately!";
            }

            if(fRain >= 1.00)
            {
                sFeedback+=" A deluge of rain falls around you.";
            }
            else if((fRain < 1.0)&&(fRain >=0.5)    )
            {
                sFeedback+=" A heavy rain falls around you.";
            }
            else if((fRain < 0.5)&&(fRain >=0.25))
            {
                sFeedback+=" A steady rain falls around you.";
            }
            else if ((fRain > 0.0)&&(fRain < 0.25))
            {
                sFeedback+=" A sprinkle of rain falls around you.";
            }
            else
            {
            }

        }
        else if (fTemperature < 0.0)
        {
            if(fWind2 < 5.0)
            {
                sFeedback+="Short breezes of freezing air blow across the County.";
            }
            else if ((fWind2 >=5.0)&&(fWind2 <9.0))
            {
                sFeedback+="A steady breeze of freezing air blows across the County.";
            }
            else if ((fWind2 >=9.0)&&(fWind2 <13.0))
            {
                sFeedback+="A strong wind blows across the County.";
            }
            else if ((fWind2 >=13.0)&&(fWind2 <22.0))
            {
                sFeedback+="A severe wind is blowing across the County, making it difficult to venture outside.";
            }
            else if ((fWind2 >=22.0)&&(fWind2 <33.0))
            {
                sFeedback+="A powerful wind is blowing across the County, making it almost impossible to venture outside!";
            }
             else if (fWind2 >=33.0)
            {
                sFeedback+="An extreme storm is blowing across the County, seek shelter immediately!";
            }

            if(fRain >= 1.00)
            {
                sFeedback+=" A sprinkle of snow drifts down around you.";
            }
            else if((fRain < 1.0)&&(fRain >=0.5) )
            {
                sFeedback+=" A light dusting of snow falls around you.";
            }
            else if((fRain < 0.5)&&(fRain >=0.25))
            {
                sFeedback+=" A steady snowfall clouds the sky and area around you.";
            }
            else if ((fRain > 0.0)&&(fRain < 0.25))
            {
                sFeedback+=" A steady snowfall clouds the sky and limits your ability to see anything around you.";
            }
            else
            {
            }
        }
    }
    sFeedback+="</c>";
    return sFeedback;
}

void UpdateAreaWeather(object oArea, int nInstant=FALSE)
{
    object oWeatherCache=GetModule();
    if(!GetLocalInt(oArea,"WeatherUpdate"))
    {
        return;
    }
    DeleteLocalInt(oArea,"WeatherUpdate");
    if(!GetIsAreaAboveGround(oArea)||GetIsAreaInterior(oArea))
    {
        return;
    }
    if(GetLocalInt(oArea,WEATHER_AREA_NO_WEATHER)||!GetIsObjectValid(oArea))
    {
        return;
    }
    int nMonth=GetCalendarMonth();
    object oModule=GetModule();
    float fHumidity=GetLocalFloat(oWeatherCache,WEATHER_LOCAL_GROUND_HUMIDITY)+IntToFloat(GetLocalInt(oArea,WEATHER_AREA_HUMIDITY));
    float fTemperature=GetLocalFloat(oWeatherCache,WEATHER_LOCAL_GROUND_TEMPERATURE)+IntToFloat(GetLocalInt(oArea,WEATHER_AREA_TEMPERATURE));
    float fSkyHumidity=GetLocalFloat(oWeatherCache,WEATHER_LOCAL_SKY_HUMIDITY)+IntToFloat(GetLocalInt(oArea,WEATHER_AREA_RAIN));
    float fSkyTemperature=GetLocalFloat(oWeatherCache,WEATHER_LOCAL_SKY_TEMPERATURE)+IntToFloat(GetLocalInt(oArea,WEATHER_AREA_TEMPERATURE));
    float fSunInflux=GetLocalFloat(oWeatherCache,WEATHER_GLOBAL_SUN_INFLUX)*(100.0+IntToFloat(GetLocalInt(oArea,WEATHER_AREA_LIGHT)))/100.0;
    if(fSunInflux<0.0)
    {
        fSunInflux=0.0;
    }
    float fMoonlight=GetLocalFloat(oWeatherCache,WEATHER_GLOBAL_MOONLIGHT)*(100.0+IntToFloat(GetLocalInt(oArea,WEATHER_AREA_LIGHT)))/100.0;
    if(fMoonlight<0.0)
    {
        fMoonlight=0.0;
    }
    //float fRain=GetLocalFloat(oModule,WEATHER_LOCAL_RAIN)+IntToFloat(GetLocalInt(oArea,"Rain");
    float fWind=GetLocalFloat(oWeatherCache,WEATHER_GLOBAL_WIND)*(100.0+IntToFloat(GetLocalInt(oArea,WEATHER_AREA_WIND_MODIFIER)))/100.0;
    //New weather calculations
    float fRain=0.0;
    if(fSkyHumidity-(fSkyTemperature-WEATHER_TEMPERATURE_MIN)-10.0>0.0)
    {
        fRain=fSkyHumidity-(10.0+fSkyTemperature-WEATHER_TEMPERATURE_MIN);
        fRain=fRain*fSkyHumidity/100.0;
    }

    float fFoggyness=(fHumidity*2.0-(fabs(fTemperature)-WEATHER_TEMPERATURE_MIN))*WEATHER_FOGGINESS_MODIFIER;//fHumidity/(1.0+pow(fTemperature,2.0));
    if(fFoggyness>100.0)
    {
        fFoggyness=100.0;
    }
    if(fFoggyness<0.0)
    {
        fFoggyness=0.0;
    }

    //float fCloudyness=GetLocalFloat(oModule,WEATHER_LOCAL_CLOUDINESS)+IntToFloat(;
    float fCloudyness=(fSkyHumidity-(fSkyTemperature-WEATHER_TEMPERATURE_MIN)+10.0)/100.0;
    if(fCloudyness>0.75)
    {
        fCloudyness=0.75;
    }
    if(fCloudyness<0.0)
    {
        fCloudyness=0.0;
    }

    if(fFoggyness<20.0)
    {
        if(fCloudyness>0.1)
        {
            if(GetSkyBox(oArea)!=SKYBOX_GRASS_STORM)
            {
                SetSkyBox(SKYBOX_GRASS_STORM,oArea);
            }
        }
        else
        {
            if(GetSkyBox(oArea)!=SKYBOX_GRASS_CLEAR)
            {
                SetSkyBox(SKYBOX_GRASS_CLEAR,oArea);
            }
        }
    }
    else
    {
        if(fCloudyness>0.0)
        {
            if(GetSkyBox(oArea)!=SKYBOX_GRASS_STORM)
            {
                SetSkyBox(SKYBOX_GRASS_STORM,oArea);
            }
        }
        else
        {
            if(GetSkyBox(oArea)!=SKYBOX_DESERT_CLEAR)
            {
                SetSkyBox(SKYBOX_DESERT_CLEAR,oArea);
            }
        }
    }
    float fSunshine=fSunInflux*(1.0-fCloudyness);
    fMoonlight=fMoonlight*(1.0-fCloudyness);
    int nSound=-1;
    int nSoundNight=-1;
    if(fRain>0.0)
    {
        if(fTemperature<0.0)
        {
            //if(GetWeather
            if(GetWeather(oArea)!=WEATHER_SNOW)
            {
                SetWeather(oArea,WEATHER_SNOW);

            }
            if(fWind<0.1)
            {
                nSound=0;
                nSoundNight=0;
            }
            else
            {
                nSound=90;
                nSoundNight=91;
            }
        }
        else
        {
            if(GetWeather(oArea)!=WEATHER_RAIN)
            {
                SetWeather(oArea,WEATHER_RAIN);
            }
            if(fWind<0.1)
            {
                if(fRain<0.1)
                {
                    nSound=38;
                    nSoundNight=38;
                }
                else
                {
                    nSound=39;
                    nSoundNight=39;
                }
            }
            else
            {
                if(fRain<0.1)
                {
                    nSound=40;
                    nSoundNight=40;
                }
                else
                {
                    nSound=41;
                    nSoundNight=41;
                }
            }

        }
    }
    else
    {
        if(fWind<0.02)
        {
            nSound=0;
            nSoundNight=0;
        }
        else if(fWind<0.05)
        {
            nSound=30;
            nSoundNight=30;
        }
        else if(fWind<0.1)
        {
            nSound=31;
            nSoundNight=31;
        }
        else
        {
            nSound=32;
            nSoundNight=32;
        }
        if(GetWeather(oArea)!=WEATHER_CLEAR)
        {
            SetWeather(oArea,WEATHER_CLEAR);
        }
    }
    if(nSound==0)
    {
        if(GetIsAreaNatural(oArea)==AREA_NATURAL)
        {
            if(fTemperature>15.0)
            {
                nSound=49;
                nSoundNight=53;
            }
            else if(fTemperature>0.0)
            {
                nSound=50;
                nSoundNight=54;
            }
            else
            {
                nSound=0;
                nSoundNight=0;
            }
            /*switch(nMonth)
            {
                case 11:
                case 12:
                case 1:
                case 2:
                    nSound=0;
                    nSoundNight=0;
                    break;
                case 3:
                case 4:
                case 9:
                case 10:
                    nSound=50;
                    nSoundNight=54;
                    break;
                case 5:
                case 6:
                case 7:
                case 8:
                    nSound=49;
                    nSoundNight=53;
                    break;
            }*/
        }
    }
    if(!GetLocalInt(oArea,WEATHER_AREA_NO_WEATHER_SOUND))
    {
        /*if(nSound==0)
        {
            AmbientSoundStop(oArea);
        }
        else
        {*/
            AmbientSoundChangeDay(oArea,nSound);
            AmbientSoundChangeNight(oArea,nSoundNight);
        //}
    }


    //Rain: -4 Spot, -4 Search, -4 Listen.
    //Fog: 20% miss chance.
    //Moderate: (5-9)
    //Strong Wind: -2 Ranged Attack, -2 Listen. (9-13)
    //Severe Wind: -4 Ranged, -4 Listen. (13-22)
    //Wind Storm: No Ranged Attacks, -8 Listen. (23-33)
    //Hurricane: No Ranged Attacks, -30 Listen. (33-77)
    float fWind2 = (WEATHER_WIND_TO_METERS_PER_SECOND*fWind);

    int nSpotPenalty = 0;
    int nListPenalty = 0;
    int nFogClip = 90;
    int nWindPower = 0;

    if(fFoggyness>20.0)
    {
        nFogClip -= 30;
    }

    if(fRain > 0.1)
    {
        nSpotPenalty -= 4;
        nListPenalty -= 4;
        nFogClip -= 30;
    }

    if ((fWind2 >=9.0)&&(fWind2 <13.0))
    {
        nListPenalty -=2;
        nWindPower = 1;
        if(fRain > 0.1)
        {NWNX_Area_SetWeatherChance(oArea,NWNX_AREA_WEATHER_CHANCE_LIGHTNING,50);}
    }
    else if ((fWind2 >=13.0)&&(fWind2 <22.0))
    {
        nListPenalty -=4;
        nWindPower = 2;
        if(fRain > 0.1)
        {NWNX_Area_SetWeatherChance(oArea,NWNX_AREA_WEATHER_CHANCE_LIGHTNING,75);}
    }
    else if ((fWind2 >=22.0)&&(fWind2 <33.0))
    {
        nListPenalty -=8;
        nWindPower = 2;
        if(fRain > 0.1)
        {NWNX_Area_SetWeatherChance(oArea,NWNX_AREA_WEATHER_CHANCE_LIGHTNING,90);}
    }
     else if (fWind2 >=33.0)
    {
        nListPenalty -=30;
        nWindPower = 2;
        if(fRain > 0.1)
        {NWNX_Area_SetWeatherChance(oArea,NWNX_AREA_WEATHER_CHANCE_LIGHTNING,100);}
    }
    else
    {
        nWindPower = 0;
        NWNX_Area_SetWeatherChance(oArea,NWNX_AREA_WEATHER_CHANCE_LIGHTNING,0);
    }


    NWNX_Area_SetFogClipDistance(oArea,IntToFloat(nFogClip));
    NWNX_Area_SetAreaSpotModifier(oArea,nSpotPenalty);
    NWNX_Area_SetAreaListenModifier(oArea,nListPenalty);
    NWNX_Area_SetWindPower(oArea,nWindPower);

    int nFogColour=WeatherToColour(fTemperature,fSunshine,fMoonlight,fFoggyness,fHumidity);
    FadeFog(oArea,nFogColour,FloatToInt(fFoggyness),nInstant);
}

int WeatherToColour(float fTemperature, float fSunshine, float fMoonlight, float fFoggyness, float fHumidity)
{
    object oWeatherCache=GetModule();
    float fRedShift=GetLocalFloat(oWeatherCache,WEATHER_GLOBAL_SUN_REDSHIFT);
    float fGreenShift=sqrt(fRedShift+1.0)-1.0;
    int nGreenBit=16*16;
    int nRedBit=16*16*16*16;
    int nBlueBit=1;
    /*if(fHumidity<20.0)
    {
        fHumidity=20.0;
    }*/
    //float fColouringModifierHue=(fTemperature-WEATHER_SUN_COLOUR_TEMPERATURE_MID)/(WEATHER_TEMPERATURE_MAX-WEATHER_TEMPERATURE_MIN);
    //float fColouringModifierSaturation=(WEATHER_SATURATION_MODIFIER/(1.0+pow(fFoggyness,2.0)));//(50.0/fHumidity)*(2.0-fSunshine)*1.0;
    float fColouringModifierHue=(40.0-fHumidity)/100.0;
    float fColouringModifierSaturation=((WEATHER_TEMPERATURE_MAX+fTemperature)/(WEATHER_TEMPERATURE_MAX-WEATHER_TEMPERATURE_MIN))*(WEATHER_SATURATION_MODIFIER/(1.0+pow(fFoggyness,2.0)));//(50.0/fHumidity)*(2.0-fSunshine)*1.0;
    int nGreen=nGreenBit*
                FloatToInt(WEATHER_SUN_COLOUR_BASE*pow(fSunshine,0.5)//brightness
                //*fColouringModifierHue*0.0//hue
                //*fColouringModifierSaturation//saturation
                +WEATHER_SUN_COLOUR_BASE*fGreenShift*pow(fSunshine,0.5)*WEATHER_SUN_REDSHIFT_MODIFIER*fColouringModifierSaturation
                +fFoggyness*sqrt(fSunshine)//backgroundfog
                );
    int nRed=nRedBit*
                FloatToInt(WEATHER_SUN_COLOUR_BASE*pow(fSunshine,0.5)//brightness
                *(1.0+fColouringModifierHue//hue
                *fColouringModifierSaturation)//saturation
                +WEATHER_SUN_COLOUR_BASE*fRedShift*pow(fSunshine,0.5)*WEATHER_SUN_REDSHIFT_MODIFIER*fColouringModifierSaturation
                +fFoggyness*sqrt(fSunshine)//backgroundfog
                );
    int nBlue=nBlueBit*
                FloatToInt(WEATHER_SUN_COLOUR_BASE*pow(fSunshine,0.5)//brightness
                *(1.0-fColouringModifierHue//hue
                *fColouringModifierSaturation)//saturation
                +fFoggyness*sqrt(fSunshine)//backgroundfog
                );
    nGreen+=nGreenBit*
                FloatToInt((WEATHER_MOON_COLOUR_BASE_GREEN+fFoggyness)
                *fMoonlight
                );
    nRed+=nRedBit*
                FloatToInt((WEATHER_MOON_COLOUR_BASE_RED+fFoggyness)
                *fMoonlight
                );
    nBlue+=nBlueBit*
                FloatToInt((WEATHER_MOON_COLOUR_BASE_BLUE+fFoggyness)
                *fMoonlight
                );

    if(nRed>255*16*16*16*16)
    {
        nRed=16*16*16*16*255;
    }
    else if(nRed<16*16*16*16&&nRed!=0)
    {
        nRed=0;
    }
    if(nGreen>255*16*16)
    {
        nGreen=16*16*255;
    }
    else if(nGreen<16*16&&nGreen!=0)
    {
        nGreen=0;
    }
    if(nBlue>255)
    {
        nBlue=255;
    }
    else if(nBlue<0)
    {
        nBlue=0;
    }
    /*PrintString("Fog Colour:"
        +"\nFogColourRed: "+IntToString(nRed/(16*16*16*16))
        +"\nFogColourGreen: "+IntToString(nGreen/(16*16))
        +"\nFogColourBlue: "+IntToString(nBlue));*/
    return (nGreen+nRed+nBlue);
}

float VaryingRandom(float fRange)
{
    float fRandom=((IntToFloat(Random(21))/10.0-1.0)
                    +(IntToFloat(Random(21))/10.0-1.0)
                    +(IntToFloat(Random(21))/10.0-1.0)
                    +(IntToFloat(Random(21))/10.0-1.0)
                    +(IntToFloat(Random(21))/10.0-1.0)
                    +(IntToFloat(Random(21))/10.0-1.0)
                    +(IntToFloat(Random(21))/10.0-1.0)
                    /*+(IntToFloat(Random(21))/10.0-1.0)
                    +(IntToFloat(Random(21))/10.0-1.0)
                    +(IntToFloat(Random(21))/10.0-1.0)
                    +(IntToFloat(Random(21))/10.0-1.0)
                    +(IntToFloat(Random(21))/10.0-1.0)
                    +(IntToFloat(Random(21))/10.0-1.0)
                    +(IntToFloat(Random(21))/10.0-1.0)
                    +(IntToFloat(Random(21))/10.0-1.0)
                    +(IntToFloat(Random(21))/10.0-1.0)
                    +(IntToFloat(Random(21))/10.0-1.0)
                    +(IntToFloat(Random(21))/10.0-1.0)
                    +(IntToFloat(Random(21))/10.0-1.0)
                    +(IntToFloat(Random(21))/10.0-1.0)
                    +(IntToFloat(Random(21))/10.0-1.0)
                    +(IntToFloat(Random(21))/10.0-1.0)
                    +(IntToFloat(Random(21))/10.0-1.0)
                    +(IntToFloat(Random(21))/10.0-1.0)
                    +(IntToFloat(Random(21))/10.0-1.0)
                    +(IntToFloat(Random(21))/10.0-1.0)
                    +(IntToFloat(Random(21))/10.0-1.0)
                    +(IntToFloat(Random(21))/10.0-1.0)
                    +(IntToFloat(Random(21))/10.0-1.0)
                    +(IntToFloat(Random(21))/10.0-1.0)
                    +(IntToFloat(Random(21))/10.0-1.0)
                    +(IntToFloat(Random(21))/10.0-1.0)
                    +(IntToFloat(Random(21))/10.0-1.0)
                    +(IntToFloat(Random(21))/10.0-1.0)
                    +(IntToFloat(Random(21))/10.0-1.0)
                    +(IntToFloat(Random(21))/10.0-1.0)
                    +(IntToFloat(Random(21))/10.0-1.0)
                    +(IntToFloat(Random(21))/10.0-1.0)
                    +(IntToFloat(Random(21))/10.0-1.0)*/
                    +(IntToFloat(Random(21))/10.0-1.0))/8.0;
    fRandom=pow(fRandom*10.0,3.0);
    return fRandom*fRange/1000.0;
}

void UpdateGlobalWeather(int bFeedback=FALSE)
{
    object oModule=GetModule();
    object oWeatherCache=GetModule();

    //Global Variables
    int nHour=GetTimeHour();
    int nMonth=GetCalendarMonth();
    int nDay=GetCalendarDay();
    float fDay=IntToFloat((nMonth-1)*28+(nDay-1));
    int nMinute=GetTimeMinute();

    //Local weather state
    float fTemperature=GetLocalFloat(oWeatherCache,WEATHER_LOCAL_GROUND_TEMPERATURE);
    float fHumidity=GetLocalFloat(oWeatherCache,WEATHER_LOCAL_GROUND_HUMIDITY);
    float fOldSkyTemperature=GetLocalFloat(oWeatherCache,WEATHER_LOCAL_SKY_TEMPERATURE);
    float fOldSkyHumidity=GetLocalFloat(oWeatherCache,WEATHER_LOCAL_SKY_HUMIDITY);

    //Beyond weather state
    float fBeyondTemperature=GetLocalFloat(oWeatherCache,WEATHER_BEYOND_GROUND_TEMPERATURE);
    float fBeyondHumidity=GetLocalFloat(oWeatherCache,WEATHER_BEYOND_GROUND_HUMIDITY);
    float fBeyondOldSkyTemperature=GetLocalFloat(oWeatherCache,WEATHER_BEYOND_SKY_TEMPERATURE);
    float fBeyondOldSkyHumidity=GetLocalFloat(oWeatherCache,WEATHER_BEYOND_SKY_HUMIDITY);

    //Template Weather
    float fTemperatureAimHourlyVariation=(cos((IntToFloat(nHour)-15.0)*360.0/24.0)*5.0-5.0);
    float fTemperatureAim=GetLocalFloat(oWeatherCache,"Weather_Temperature_Month_"+IntToString(nMonth))+fTemperatureAimHourlyVariation;
    float fHumidityAim=GetLocalFloat(oWeatherCache,"Weather_Humidity_Month_"+IntToString(nMonth));

    //Ramdomize beyond weather.
    float fRandomizeTemperature=VaryingRandom(WEATHER_MAX_VARIATION);
    float fTemperatureVariation=fBeyondOldSkyTemperature-fTemperatureAim;
    float fRandomTemperatureModifier=fabs(fTemperatureVariation+fRandomizeTemperature);
    fRandomizeTemperature=pow(0.98,fRandomTemperatureModifier)*fRandomizeTemperature;
    fBeyondOldSkyTemperature+=fRandomizeTemperature;

    //Calculate Wind
    float fTemperatureDifference=fBeyondOldSkyTemperature-fOldSkyTemperature;

    fTemperatureDifference=fTemperatureDifference*(WEATHER_TEMPERATURE_MAX-WEATHER_TEMPERATURE_MIN)/(fabs(fTemperatureDifference)+(WEATHER_TEMPERATURE_MAX-WEATHER_TEMPERATURE_MIN));
    float fPriorWind=GetLocalFloat(oWeatherCache,WEATHER_GLOBAL_WIND);
    float fWind=fabs(fTemperatureDifference/(WEATHER_TEMPERATURE_MAX-WEATHER_TEMPERATURE_MIN));
    if(fWind-WEATHER_WIND_MAX_ACCELERATION>fPriorWind)
    {
        fWind=fPriorWind+WEATHER_WIND_MAX_ACCELERATION;
    }
    else if(fWind+WEATHER_WIND_MAX_ACCELERATION<fPriorWind)
    {
        fWind=fPriorWind-WEATHER_WIND_MAX_ACCELERATION;
    }

    //fWind=fWind/2.0;
    float fWindModified=WEATHER_WIND_MODIFIER*fWind/2.0;
    float fNewSkyTemperature=fOldSkyTemperature*(1.0-fWindModified)+fBeyondOldSkyTemperature*(fWindModified);
    float fBeyondNewSkyTemperature=fBeyondOldSkyTemperature*(1.0-fWindModified)+fOldSkyTemperature*(fWindModified);
    float fNewSkyHumidity=fOldSkyHumidity*(1.0-fWindModified)+fBeyondOldSkyHumidity*(fWindModified);
    float fBeyondNewSkyHumidity=fBeyondOldSkyHumidity*(1.0-fWindModified)+fOldSkyHumidity*(fWindModified);

    //Light
    float fRedShift=0.0;
    float fSunInflux=0.0;
    float fMoonlight=0.0;
    if((nHour>5&&nHour<18)&&!(nHour==17&&nMinute==5)&&!(nHour==6&&nMinute==0))
    {
        fSunInflux=sin(90.0*((IntToFloat(nHour-6)+IntToFloat(nMinute)/6.0)/6.0))*(1.0-0.5*fabs(cos(fDay*180.0/336.0)));
        //fSunInflux=sin(90.0*((IntToFloat(nHour-6)+3.0/6.0)/6.5))*(1.0-0.75*fabs(cos(fDay*180.0/336.0)));
        fRedShift=(1.0/(pow(fSunInflux,3.0)+0.01))/100.0;
    }
    else
    {
        int nDay=GetCalendarDay();
        fMoonlight=-sin(IntToFloat(nDay)*180.0/28.0)+1;
        //fMoonlight=1.0;
    }


    //New weather calculations

    float fRain=0.0;
    if(fNewSkyHumidity-(fNewSkyTemperature-WEATHER_TEMPERATURE_MIN)-10.0>0.0)
    {
        fRain=fNewSkyHumidity-(fNewSkyTemperature-WEATHER_TEMPERATURE_MIN)-10.0;
        fRain=fRain*fNewSkyHumidity/100.0;
    }
    float fCloudyness=((fNewSkyHumidity-(fNewSkyTemperature-WEATHER_TEMPERATURE_MIN)+10.0)/100.0);
    if(fCloudyness>0.75)
    {
        fCloudyness=0.75;
    }
    if(fCloudyness<0.0)
    {
        fCloudyness=0.0;
    }

    float fSunshine=fSunInflux*(1.0-fCloudyness);
    //fMoonlight=fMoonlight*(1.0-fCloudyness);
    float fSunHeating=fSunshine*WEATHER_SUN_HEAT_MODIFIER;
    float fGroundDampning=pow(((fTemperature-fNewSkyTemperature)/(WEATHER_TEMPERATURE_MAX-WEATHER_TEMPERATURE_MIN)),1.0)*WEATHER_GROUND_DAMPNING_MODIFIER*(1.0-0.1*fCloudyness);
    float fAtmosphericDampning=pow(((fNewSkyTemperature-WEATHER_TEMPERATURE_MIN)/(WEATHER_TEMPERATURE_MAX-WEATHER_TEMPERATURE_MIN)),1.0)*WEATHER_ATMOSPHERIC_DAMPNING_MODIFIER*1.0;

    float fVaporising=fSunshine*fHumidity/100.0;

    //Sun heating:
    fTemperature+=fSunHeating;
    //Atmospheric damping:
    fTemperature-=fGroundDampning;
    fNewSkyTemperature+=fGroundDampning;
    fNewSkyTemperature-=fAtmosphericDampning;
    //Set weather changes:
    fNewSkyHumidity+=fVaporising*WEATHER_SUN_HEAT_VAPORING_MODIFIER;
    fNewSkyHumidity-=fRain*WEATHER_RAIN_CONDENSING_MODIFIER;
    fHumidity+=fRain*WEATHER_RAIN_CONDENSING_MODIFIER;
    fHumidity-=fVaporising*WEATHER_SUN_HEAT_VAPORING_MODIFIER;


    //New beyond weather calculations

    float fBeyondRain=0.0;
    if(fBeyondNewSkyHumidity-(fBeyondNewSkyTemperature-WEATHER_TEMPERATURE_MIN)-10.0>0.0)
    {
        fBeyondRain=fBeyondNewSkyHumidity-(fBeyondNewSkyTemperature-WEATHER_TEMPERATURE_MIN)-10.0;
        fBeyondRain=fBeyondRain*fBeyondNewSkyHumidity/100.0;
    }

    float fBeyondCloudyness=((fBeyondNewSkyHumidity-(fBeyondNewSkyTemperature-WEATHER_TEMPERATURE_MIN)+10.0)/100.0);
    if(fBeyondCloudyness>0.75)
    {
        fBeyondCloudyness=0.75;
    }
    if(fBeyondCloudyness<0.0)
    {
        fBeyondCloudyness=0.0;
    }

    float fBeyondSunshine=fSunInflux*(1.0-fBeyondCloudyness);
    //fMoonlight=fMoonlight*(1.0-fCloudyness);
    float fBeyondSunHeating=fBeyondSunshine*WEATHER_SUN_HEAT_MODIFIER;
    float fBeyondGroundDampning=pow(((fBeyondTemperature-fBeyondNewSkyTemperature)/(WEATHER_TEMPERATURE_MAX-WEATHER_TEMPERATURE_MIN)),1.0)*WEATHER_GROUND_DAMPNING_MODIFIER*(1.0-0.1*fBeyondCloudyness);
    float fBeyondAtmosphericDampning=pow(((fNewSkyTemperature-WEATHER_TEMPERATURE_MIN)/(WEATHER_TEMPERATURE_MAX-WEATHER_TEMPERATURE_MIN)),1.0)*WEATHER_ATMOSPHERIC_DAMPNING_MODIFIER*1.0;
    float fBeyondVaporising=fBeyondSunshine*fBeyondHumidity/100.0;
    //Sun heating:
    fBeyondTemperature+=fBeyondSunHeating;
    //Atmospheric damping:
    fBeyondTemperature-=fBeyondGroundDampning;
    fBeyondNewSkyTemperature+=fBeyondGroundDampning;
    fBeyondNewSkyTemperature-=fBeyondAtmosphericDampning;
    //Set weather changes:
    fBeyondNewSkyHumidity+=fBeyondVaporising*WEATHER_SUN_HEAT_VAPORING_MODIFIER;
    fBeyondNewSkyHumidity-=fBeyondRain*WEATHER_RAIN_CONDENSING_MODIFIER;
    fBeyondHumidity+=fBeyondRain*WEATHER_RAIN_CONDENSING_MODIFIER;
    fBeyondHumidity-=fBeyondVaporising*WEATHER_SUN_HEAT_VAPORING_MODIFIER;

    /*
    if(fTemperature >= fTemperatureAim + 10)
    {
        fTemperature = fTemperatureAim+10;
    }
    else if(fTemperature <= fTemperatureAim-10)
    {
        fTemperature = fTemperatureAim-10;
        fBeyondTemperature = fTemperature+2;
    }

    if(fBeyondTemperature >= fTemperatureAim + 10)
    {
        fBeyondTemperature = fBeyondTemperature+10;
    }
    else if(fBeyondTemperature <= fTemperatureAim-10)
    {
        fBeyondTemperature = fTemperatureAim-10;
    }
    */

    SetLocalFloat(oWeatherCache,WEATHER_GLOBAL_SUN_REDSHIFT,fRedShift);
    SetLocalFloat(oWeatherCache,WEATHER_LOCAL_GROUND_HUMIDITY,fHumidity);
    SetLocalFloat(oWeatherCache,WEATHER_LOCAL_GROUND_TEMPERATURE,fTemperature);
    SetLocalFloat(oWeatherCache,WEATHER_LOCAL_SKY_TEMPERATURE,fNewSkyTemperature);
    SetLocalFloat(oWeatherCache,WEATHER_LOCAL_SKY_HUMIDITY,fNewSkyHumidity);
    SetLocalFloat(oWeatherCache,WEATHER_LOCAL_CLOUDINESS,fCloudyness);
    SetLocalFloat(oWeatherCache,WEATHER_LOCAL_RAIN,fRain);
    SetLocalFloat(oWeatherCache,WEATHER_GLOBAL_SUN_INFLUX,fSunInflux);
    SetLocalFloat(oWeatherCache,WEATHER_GLOBAL_MOONLIGHT,fMoonlight);
    SetLocalFloat(oWeatherCache,WEATHER_BEYOND_GROUND_TEMPERATURE,fBeyondTemperature);
    SetLocalFloat(oWeatherCache,WEATHER_BEYOND_GROUND_HUMIDITY,fBeyondHumidity);
    SetLocalFloat(oWeatherCache,WEATHER_BEYOND_SKY_TEMPERATURE,fBeyondNewSkyTemperature);
    SetLocalFloat(oWeatherCache,WEATHER_BEYOND_SKY_HUMIDITY,fBeyondNewSkyHumidity);
    //SetLocalFloat(oWeatherCache,"BeyondCloudyness",fBeyondCloudyness);
    SetLocalFloat(oWeatherCache,WEATHER_GLOBAL_WIND,fWind);
    if(bFeedback)
    {
        AssignCommand(GetModule(),SpeakString(
                                             "**** DAY "+IntToString(FloatToInt(fDay))
                                            +" HOUR "+IntToString(nHour)
                                            +" MINUTE "+IntToString(nMinute)
                                            +" ****"
                                            +"\nSunshine: "+FloatToString(fSunshine)
                                            //+"\nTemperature: "+FloatToString(fTemperature)
                                            //+"\nFoggyness: "+FloatToString(fFoggyness)
                                            //+"\nFogColourRed: "+IntToString(nFogColour/(16*16*16*16))
                                            //+"\nFogColourGreen: "+IntToString((nFogColour-(nFogColour/(16*16*16*16))*16*16*16*16)/(16*16))
                                            //+"\nFogColourBlue: "+IntToString(nFogColour-16*16*(nFogColour/(16*16)))
                                            +"\nTemperature: "+FloatToString(fTemperature)
                                            +"\nHumidity "+FloatToString(fHumidity)
                                            +"\nSkyTemperature: "+FloatToString(fNewSkyTemperature)
                                            +"\nSkyHumidity "+FloatToString(fNewSkyHumidity)
                                            +"\nRain: "+FloatToString(fRain)
                                            +"\nCloudyness: "+FloatToString(fCloudyness)
                                            +"\nBeyond Temperature: "+FloatToString(fBeyondTemperature)
                                            +"\nBeyond Humidity: "+FloatToString(fBeyondHumidity)
                                            +"\nBeyond Sky Temperature: "+FloatToString(fBeyondNewSkyTemperature)
                                            +"\nBeyond Sky Humidity: "+FloatToString(fBeyondNewSkyHumidity)
                                            +"\nBeyondRain: "+FloatToString(fBeyondRain)
                                            +"\nBeyondCloudyness: "+FloatToString(fBeyondCloudyness)
                                            +"\nWind: "+FloatToString(fWind)
                                            +"\nRandomize Temperature: "+FloatToString(fRandomizeTemperature)
                                            //+"\nRandomize Humidity: "+FloatToString(fRandomizeHumidity)
                                            ,TALKVOLUME_SHOUT));
        PrintString(
                                             "**** DAY "+IntToString(FloatToInt(fDay))
                                            +" HOUR "+IntToString(nHour)
                                            +" MINUTE "+IntToString(nMinute)
                                            +" ****"
                                            +"\nSunshine: "+FloatToString(fSunshine)
                                            //+"\nTemperature: "+FloatToString(fTemperature)
                                            //+"\nFoggyness: "+FloatToString(fFoggyness)
                                            //+"\nFogColourRed: "+IntToString(nFogColour/(16*16*16*16))
                                            //+"\nFogColourGreen: "+IntToString((nFogColour-(nFogColour/(16*16*16*16))*16*16*16*16)/(16*16))
                                            //+"\nFogColourBlue: "+IntToString(nFogColour-16*16*(nFogColour/(16*16)))
                                            +"\nTemperature: "+FloatToString(fTemperature)
                                            +"\nHumidity "+FloatToString(fHumidity)
                                            +"\nSkyTemperature: "+FloatToString(fNewSkyTemperature)
                                            +"\nSkyHumidity "+FloatToString(fNewSkyHumidity)
                                            +"\nRain: "+FloatToString(fRain)
                                            +"\nCloudyness: "+FloatToString(fCloudyness)
                                            +"\nBeyond Temperature: "+FloatToString(fBeyondTemperature)
                                            +"\nBeyond Humidity: "+FloatToString(fBeyondHumidity)
                                            +"\nBeyond Sky Temperature: "+FloatToString(fBeyondNewSkyTemperature)
                                            +"\nBeyond Sky Humidity: "+FloatToString(fBeyondNewSkyHumidity)
                                            +"\nBeyondRain: "+FloatToString(fBeyondRain)
                                            +"\nBeyondCloudyness: "+FloatToString(fBeyondCloudyness)
                                            +"\nWind: "+FloatToString(fWind)
                                            +"\nRandomize Temperature: "+FloatToString(fRandomizeTemperature)
                                            //+"\nRandomize Humidity: "+FloatToString(fRandomizeHumidity)
                                            );
    }
    WriteTimestampedLogEntry(
                                            "**** DAY "+IntToString(FloatToInt(fDay))
                                            +" HOUR "+IntToString(nHour)
                                            +" MINUTE "+IntToString(nMinute)
                                            +" ****"
                                            +"\nSunshine: "+FloatToString(fSunshine)
                                            //+"\nTemperature: "+FloatToString(fTemperature)
                                            //+"\nFoggyness: "+FloatToString(fFoggyness)
                                            //+"\nFogColourRed: "+IntToString(nFogColour/(16*16*16*16))
                                            //+"\nFogColourGreen: "+IntToString((nFogColour-(nFogColour/(16*16*16*16))*16*16*16*16)/(16*16))
                                            //+"\nFogColourBlue: "+IntToString(nFogColour-16*16*(nFogColour/(16*16)))
                                            +"\nTemperature: "+FloatToString(fTemperature)
                                            +"\nHumidity "+FloatToString(fHumidity)
                                            +"\nSkyTemperature: "+FloatToString(fNewSkyTemperature)
                                            +"\nSkyHumidity "+FloatToString(fNewSkyHumidity)
                                            +"\nRain: "+FloatToString(fRain)
                                            +"\nCloudyness: "+FloatToString(fCloudyness)
                                            +"\nBeyond Temperature: "+FloatToString(fBeyondTemperature)
                                            +"\nBeyond Humidity: "+FloatToString(fBeyondHumidity)
                                            +"\nBeyond Sky Temperature: "+FloatToString(fBeyondNewSkyTemperature)
                                            +"\nBeyond Sky Humidity: "+FloatToString(fBeyondNewSkyHumidity)
                                            +"\nBeyondRain: "+FloatToString(fBeyondRain)
                                            +"\nBeyondCloudyness: "+FloatToString(fBeyondCloudyness)
                                            +"\nWind: "+FloatToString(fWind)
                                            +"\nRandomize Temperature: "+FloatToString(fRandomizeTemperature)
                                            //+"\nRandomize Humidity: "+FloatToString(fRandomizeHumidity)
                                            );
    if(GetLocalInt(GetModule(),"nFlood") == 1)
    {
        if(fRain >= 1.00)
        {
            SetLocalInt(GetModule(),"nFlood",2);
        }
    }
    else if(GetLocalInt(GetModule(),"nFlood") < 1)
    {
        if(fRain >= 1.00)
        {
            SetLocalInt(GetModule(),"nFlood",2);
        }
        else if((fRain < 1.0)&&(fRain >=0.5))
        {
            SetLocalInt(GetModule(),"nFlood",1);
        }
    }
    else
    {

    }
}

void WeatherApplyFrostDamage(object oPC)
{
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");
    int nBlood   = GetLocalInt(oItem,"nBlood");
    int nSticky  = GetLocalInt(oItem,"nSticky");
    int nDust    = GetLocalInt(oItem,"nDust");
    int nPlan    = GetLocalInt(oItem,"nPlan");
    int nWet     = GetLocalInt(oItem,"nWet");
    int nSweat   = GetLocalInt(oItem,"nSweat");
    int nMud     = GetLocalInt(oItem,"nMud");

    object oModule=GetModule();
    object oArea=GetArea(oPC);
    object oWeatherCache=GetModule();
    int nDaywalk = 0;

    if(GetLocalInt(oArea,WEATHER_AREA_NO_WEATHER)||!GetIsObjectValid(oArea))
    {
        return;
    }

    if(GetItemInSlot(INVENTORY_SLOT_CLOAK,oPC) != OBJECT_INVALID || GetItemInSlot(INVENTORY_SLOT_HEAD,oPC) != OBJECT_INVALID)
    {
        if(GetLocalInt(GetItemInSlot(INVENTORY_SLOT_CLOAK,oPC),"Daywalk") == 1 || GetLocalInt(GetItemInSlot(INVENTORY_SLOT_HEAD,oPC),"Daywalk") == 1)
        {
            nDaywalk = 1;
        }
    }

    int nMinute=GetTimeMinute()+1;
    float fHumidity=GetLocalFloat(oWeatherCache,WEATHER_LOCAL_GROUND_HUMIDITY)+IntToFloat(GetLocalInt(oArea,WEATHER_AREA_HUMIDITY));
    float fTemperature=GetLocalFloat(oWeatherCache,WEATHER_LOCAL_GROUND_TEMPERATURE)+IntToFloat(GetLocalInt(oArea,WEATHER_AREA_TEMPERATURE));
    float fWind=WEATHER_WIND_TO_METERS_PER_SECOND*GetLocalFloat(oWeatherCache,WEATHER_GLOBAL_WIND)*(100.0+IntToFloat(GetLocalInt(oArea,WEATHER_AREA_WIND_MODIFIER)))/100.0;
    float fSunInflux;
    float fRain =  GetLocalFloat(oWeatherCache,WEATHER_LOCAL_RAIN);

    if(!GetIsAreaAboveGround(oArea)||GetIsAreaInterior(oArea))
    {
        fHumidity=20.0;
        fWind=0.0;
        fTemperature=IntToFloat(GetLocalInt(oArea,WEATHER_AREA_TEMPERATURE));
        fRain = 0.0;
        float fTempOut = GetLocalFloat(oWeatherCache,WEATHER_LOCAL_GROUND_TEMPERATURE)+IntToFloat(GetLocalInt(oArea,WEATHER_AREA_TEMPERATURE));
        if(fTemperature==0.0)
        {
            if(!GetIsAreaAboveGround(oArea))
            {
                fTemperature = IntToFloat(GetLocalInt(oArea,WEATHER_AREA_TEMPERATURE));
            }
            else
            {
                if(fTempOut >= 30.0)
                {
                    fTemperature = 30.0;
                }
                else if(fTempOut <= 30.0 && fTempOut > 25.0)
                {
                    fTemperature = 25.0;
                }
                else if(fTempOut <= 25.0 && fTempOut > 15.0)
                {
                    fTemperature = 20.0;
                }
                else
                {
                    fTemperature = 23.0;
                }
            }
        }
    }

    if(GetIsAreaInterior(oArea) == FALSE && GetIsAreaAboveGround(oArea) == TRUE)
    {
        if(GetIsUndead(oPC) == TRUE && nDaywalk == 0)
        {
            if(GetPCAffliction(oPC) == 3)
            {
                fSunInflux=GetLocalFloat(oWeatherCache,WEATHER_GLOBAL_SUN_INFLUX)*(100.0+IntToFloat(GetLocalInt(oArea,WEATHER_AREA_LIGHT)))/100.0;
                if(fSunInflux>0.0)
                {
                    int nSunDamage=d8(FloatToInt(fSunInflux*20.0));
                    effect eSunDamage=SupernaturalEffect(EffectDamage(nSunDamage,DAMAGE_TYPE_DIVINE));
                    effect eSlow = EffectSlow();
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,eSunDamage,oPC);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSlow,oPC,60.0f);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_FLAME_M),oPC,12.0f);
                    SendMessageToPC(oPC,"Lathander's Light burns your skin.");
                }
            }
            else if (GetPCAffliction(oPC) == 8)
            {
                fSunInflux=GetLocalFloat(oWeatherCache,WEATHER_GLOBAL_SUN_INFLUX)*(100.0+IntToFloat(GetLocalInt(oArea,WEATHER_AREA_LIGHT)))/100.0;
                if(fSunInflux>0.0)
                {
                    effect eSkill1 = EffectSkillDecrease(SKILL_HIDE,15);
                    effect eSkill2 = EffectSkillDecrease(SKILL_MOVE_SILENTLY,15);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSkill1,oPC,6.0f);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSkill2,oPC,6.0f);
                    SendMessageToPC(oPC,"Lathander's Light afflicts your ability to sneak about.");
                }
            }

        }

        if ((GetHasFeat(BACKGROUND_DARK_ELF,oPC)||GetHasFeat(BACKGROUND_GREY_DWARF,oPC))&&(!GetHasFeat(1407,oPC)) && nDaywalk == 0)
        {
            fSunInflux=GetLocalFloat(oWeatherCache,WEATHER_GLOBAL_SUN_INFLUX)*(100.0+IntToFloat(GetLocalInt(oArea,WEATHER_AREA_LIGHT)))/100.0;
            if(fSunInflux>0.0)
            {
                effect eSkill3 = EffectSkillDecrease(SKILL_SEARCH,1);
                effect eSkill4 = EffectSkillDecrease(SKILL_SPOT,1);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAttackDecrease(1,ATTACK_BONUS_MISC),oPC, 6.0);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSkill3,oPC,6.0f);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSkill4,oPC,6.0f);
                SendMessageToPC(oPC,"The Hellish Orb's bright light burns and assaults your eyes.");
            }
        }
    }

    int nRainClean = GetLocalInt(oItem,"nRainClean");
    int nTimeNow = NWNX_Time_GetTimeStamp();

    if(nRainClean+360 < nTimeNow)
    {
        SetLocalInt(oItem,"nRainClean",nTimeNow);
        if(fRain >= 1.00)
        {
            SetLocalInt(oItem,"nBlood",nBlood - 15);
            SetLocalInt(oItem,"nSticky",nSticky - 15);
            SetLocalInt(oItem,"nDust",nDust - 15);
            SetLocalInt(oItem,"nPlan",nPlan - 15);
            SetLocalInt(oItem,"nMud",nMud + 25);
            SetLocalInt(oItem,"nWet",nWet + 25);
            SendMessageToPC(oPC,"Precipitation has cleaned some of the grime from you.");
        }
        else if((fRain < 1.0)&&(fRain >=0.5)    )
        {
            SetLocalInt(oItem,"nBlood",nBlood - 11);
            SetLocalInt(oItem,"nSticky",nSticky - 11);
            SetLocalInt(oItem,"nDust",nDust - 11);
            SetLocalInt(oItem,"nPlan",nPlan - 11);
            SetLocalInt(oItem,"nMud",nMud + 20);
            SetLocalInt(oItem,"nWet",nWet + 20);
            SendMessageToPC(oPC,"Precipitation has cleaned some of the grime from you.");
        }
        else if((fRain < 0.5)&&(fRain >=0.25))
        {
            SetLocalInt(oItem,"nBlood",nBlood - 8);
            SetLocalInt(oItem,"nSticky",nSticky - 8);
            SetLocalInt(oItem,"nDust",nDust - 8);
            SetLocalInt(oItem,"nPlan",nPlan - 8);
            SetLocalInt(oItem,"nMud",nMud + 10);
            SetLocalInt(oItem,"nWet",nWet + 10);
            SendMessageToPC(oPC,"Precipitation has cleaned some of the grime from you.");
        }
        else if ((fRain > 0.0)&&(fRain < 0.25))
        {
            SetLocalInt(oItem,"nBlood",nBlood - 5);
            SetLocalInt(oItem,"nSticky",nSticky - 5);
            SetLocalInt(oItem,"nDust",nDust - 5);
            SetLocalInt(oItem,"nPlan",nPlan - 5);
            SetLocalInt(oItem,"nMud",nMud + 5);
            SetLocalInt(oItem,"nWet",nWet + 5);
            SendMessageToPC(oPC,"Precipitation has cleaned some of the grime from you.");
        }
    }

    if(nBlood >= 100) {SetLocalInt(oItem,"nBlood",100);}
    if(nBlood <= 0)   {SetLocalInt(oItem,"nBlood",0);}
    if(nSticky >= 100) {SetLocalInt(oItem,"nSticky",100);}
    if(nSticky <= 0)   {SetLocalInt(oItem,"nSticky",0);}
    if(nDust >= 100) {SetLocalInt(oItem,"nDust",100);}
    if(nDust <= 0)   {SetLocalInt(oItem,"nDust",0);}
    if(nPlan >= 100) {SetLocalInt(oItem,"nPlan",100);}
    if(nPlan <= 0)   {SetLocalInt(oItem,"nPlan",0);}
    if(nMud >= 100) {SetLocalInt(oItem,"nMud",100);}
    if(nMud <= 0)   {SetLocalInt(oItem,"nMud",0);}
    if(nWet >= 100) {SetLocalInt(oItem,"nWet",100);}
    if(nWet <= 0)   {SetLocalInt(oItem,"nWet",0);}


    ////////////////////////////////////////////////////////////////////////////
    //////// ENVIRONMENTAL STUFF / STORMS
    ////////////////////////////////////////////////////////////////////////////

    int nLastCheck = GetLocalInt(oItem,"TempCheck");
    int nDCCheck = GetLocalInt(oItem,"nDCCheck");
    int nEndureElements = 0;
    int nDC = 15+nDCCheck;
    string sFeedback = "Debug: ";

    if(GetLocalInt(oItem,"nEndure") <= nTimeNow)
    {
        nEndureElements = 0;
    }
    else
    {
        nEndureElements = 1;
        sFeedback += " Endure Elements Active";
    }

    //Wetness factor
    if(nWet >= 25 && nWet < 50)
    {
        if(fTemperature <= 4.4f)
        {
            nDC = nDC + 2;
            sFeedback += " +2 DC for Slightly Wet";
        }
        else if(fTemperature >= 32.2f)
        {
            nDC = nDC - 2;
            sFeedback += " -2 DC for Slightly Wet";
        }
    }
    else if(nWet >= 50)
    {
        if(fTemperature <= 4.4f)
        {
            nDC = nDC + 4;
            sFeedback += " +4 DC for Very Wet";
        }
        else if(fTemperature >= 32.2f)
        {
            nDC = nDC - 4;
            sFeedback += " -4 DC for Very Wet";
        }
    }

    if ((fWind >=9.0)&&(fWind <13.0))
    {
        nDC = nDC + 1;
        sFeedback += " +1 DC for Light Wind";
    }
    else if ((fWind >=13.0)&&(fWind <22.0))
    {
        nDC = nDC + 2;
        sFeedback += " +2 DC for Steady Wind";
    }
    else if ((fWind >=22.0)&&(fWind <33.0))
    {
        nDC = nDC + 3;
        sFeedback += " +3 DC for Heavy Wind";
    }
    else if (fWind >=33.0)
    {
        nDC = nDC + 4;
        sFeedback += " +4 DC for Hurricane Wind";
    }

    if(GetHasFeat(1411,oPC) == TRUE)
    {
        nDC = nDC - 4;
        sFeedback += " -4 DC for Endurance Feat";
    }

    if(GetHasFeat(1430,oPC) == TRUE)
    {
        nDC = nDC - 4;
        sFeedback += " -4 DC for Survival Proficiency";
    }

    if(GetIsUndead(oPC) == TRUE || GetLocalInt(GetItemInSlot(INVENTORY_SLOT_NECK,oPC),"Adaptation") == 5 || nEndureElements == 1)
    {
        if(nLastCheck+60 <= nTimeNow)
        {
            SetLocalInt(oItem,"TempCheck",nTimeNow);
            SetLocalInt(oItem,"nDCCheck",nDCCheck-1);
            //Debug
            //SendMessageToPC(oPC,sFeedback);
            if(GetLocalInt(oItem,"nDCCheck") < 0) {SetLocalInt(oItem,"nDCCheck",0);}
            else
            {SendMessageToPC(oPC,"You are recovering from your exposure to the elements.");}
        }
    }
    else
    {
        //Temperature Check: 1d6 Nonlethal every hour, DC 15 growing
        if(fTemperature <= 4.4f && fTemperature > -17.7f)
        {
            if(nLastCheck+1800 <= nTimeNow)
            {
                SetLocalInt(oItem,"TempCheck",nTimeNow);
                SetLocalInt(oItem,"nDCCheck",nDCCheck+1);
                //Debug
                //SendMessageToPC(oPC,sFeedback);
                if(FortitudeSave(oPC,nDC+nDCCheck,SAVING_THROW_TYPE_COLD,OBJECT_SELF) == 0)
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d6(1),DAMAGE_TYPE_COLD,DAMAGE_POWER_NORMAL),oPC);
                    SendMessageToPC(oPC,"The cold chills you to the bone.");
                    if(GetLocalInt(oItem,"nFatigue") == TRUE)
                    {
                        SetLocalInt(oItem,"nExhaust",TRUE);
                        SendMessageToPC(oPC,"You are exhausted.");
                    }
                    else
                    {
                        SetLocalInt(oItem,"nFatigue",TRUE);
                        SendMessageToPC(oPC,"You are fatigued.");
                    }
                }
            }
        }
        //Temperature Check: 1d6 Nonlethal every 6 Minutes
        else if(fTemperature <= -17.7f && fTemperature > -28.8f)
        {
            if(nLastCheck+360 <= nTimeNow)
            {
                 SetLocalInt(oItem,"TempCheck",nTimeNow);
                 SetLocalInt(oItem,"nDCCheck",nDCCheck+1);
                 //Debug
                 //SendMessageToPC(oPC,sFeedback);
                if(FortitudeSave(oPC,nDC+nDCCheck,SAVING_THROW_TYPE_COLD,OBJECT_SELF) == 0)
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d6(1),DAMAGE_TYPE_COLD,DAMAGE_POWER_NORMAL),oPC);
                    SendMessageToPC(oPC,"The cold chills you to the bone.");
                    if(GetLocalInt(oItem,"nFatigue") == TRUE)
                    {
                        SetLocalInt(oItem,"nExhaust",TRUE);
                        SendMessageToPC(oPC,"You are exhausted.");
                    }
                    else
                    {
                        SetLocalInt(oItem,"nFatigue",TRUE);
                        SendMessageToPC(oPC,"You are fatigued.");
                    }
                }
            }
        }
        //Temperature Check: 1d6 Nonlethal every 1 Minutes
        else if(fTemperature <= -28.8f)
        {
            if(nLastCheck+60 <= nTimeNow)
            {
                SetLocalInt(oItem,"TempCheck",nTimeNow);
                SetLocalInt(oItem,"nDCCheck",nDCCheck+1);
                //Debug
                //SendMessageToPC(oPC,sFeedback);
                if(FortitudeSave(oPC,nDC+nDCCheck,SAVING_THROW_TYPE_COLD,OBJECT_SELF) == 0)
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d6(1),DAMAGE_TYPE_COLD,DAMAGE_POWER_NORMAL),oPC);
                    SendMessageToPC(oPC,"The cold chills you to the bone.");
                    if(GetLocalInt(oItem,"nFatigue") == TRUE)
                    {
                        SetLocalInt(oItem,"nExhaust",TRUE);
                        SendMessageToPC(oPC,"You are exhausted.");
                    }
                    else
                    {
                        SetLocalInt(oItem,"nFatigue",TRUE);
                        SendMessageToPC(oPC,"You are fatigued.");
                    }
                }
            }
        }
        //Normal Conditions/Recovery
        else if(fTemperature > 4.4f  && fTemperature < 32.2f)
        {
            if(nLastCheck+60 <= nTimeNow)
            {
                SetLocalInt(oItem,"TempCheck",nTimeNow);
                SetLocalInt(oItem,"nDCCheck",nDCCheck-1);
                //Debug
                //SendMessageToPC(oPC,sFeedback);
                if(GetLocalInt(oItem,"nDCCheck") < 0) {SetLocalInt(oItem,"nDCCheck",0);}
                else
                {SendMessageToPC(oPC,"You are recovering from your exposure to the elements.");}
            }
        }
        //Temperature Check 1d4 every Hour
        else if(fTemperature <= 43.333f && fTemperature > 32.2f)
        {
            SetLocalInt(oItem,"nWet",nWet-1);
            if(nLastCheck+1800 <= nTimeNow)
            {
                SetLocalInt(oItem,"TempCheck",nTimeNow);
                SetLocalInt(oItem,"nDCCheck",nDCCheck+1);
                //Debug
                //SendMessageToPC(oPC,sFeedback);
                if(FortitudeSave(oPC,nDC+nDCCheck,SAVING_THROW_TYPE_FIRE,OBJECT_SELF) == 0)
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d4(1),DAMAGE_TYPE_FIRE,DAMAGE_POWER_NORMAL),oPC);
                    SendMessageToPC(oPC,"The heat is taking its toll on you.");

                    if(GetLocalInt(oItem,"nFatigue") == TRUE)
                    {
                        SetLocalInt(oItem,"nExhaust",TRUE);
                        SendMessageToPC(oPC,"You are exhausted.");
                    }
                    else
                    {
                        SetLocalInt(oItem,"nFatigue",TRUE);
                        SendMessageToPC(oPC,"You are fatigued.");
                    }
                }
            }
        }
        //Temperature Check: 1d6 Nonlethal every 6 Minutes
        else if(fTemperature <= 60.0f && fTemperature > 43.333f)
        {
            SetLocalInt(oItem,"nWet",nWet-1);
            if(nLastCheck+360 <= nTimeNow)
            {
                SetLocalInt(oItem,"TempCheck",nTimeNow);
                SetLocalInt(oItem,"nDCCheck",nDCCheck+1);
                //Debug
                //SendMessageToPC(oPC,sFeedback);
                if(FortitudeSave(oPC,nDC+nDCCheck,SAVING_THROW_TYPE_FIRE,OBJECT_SELF) == 0)
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d4(1),DAMAGE_TYPE_FIRE,DAMAGE_POWER_NORMAL),oPC);
                    SendMessageToPC(oPC,"The heat is taking its toll on you.");
                    if(GetLocalInt(oItem,"nFatigue") == TRUE)
                    {
                        SetLocalInt(oItem,"nExhaust",TRUE);
                        SendMessageToPC(oPC,"You are exhausted.");
                    }
                    else
                    {
                        SetLocalInt(oItem,"nFatigue",TRUE);
                        SendMessageToPC(oPC,"You are fatigued.");
                    }
                }
            }
        }
        //Temperature Check: 1d6 Nonlethal every 6 Minutes
        else if(fTemperature > 60.0f)
        {
            SetLocalInt(oItem,"nWet",nWet-1);
            SetLocalInt(oItem,"TempCheck",nTimeNow);
            if(nLastCheck+60 <= nTimeNow)
            {
                //Debug
                //SendMessageToPC(oPC,sFeedback);
                SetLocalInt(oItem,"nDCCheck",nDCCheck+1);
                if(FortitudeSave(oPC,nDC+nDCCheck,SAVING_THROW_TYPE_FIRE,OBJECT_SELF) == 0)
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d4(1),DAMAGE_TYPE_FIRE,DAMAGE_POWER_NORMAL),oPC);
                    SendMessageToPC(oPC,"The heat is taking its toll on you.");
                    if(GetLocalInt(oItem,"nFatigue") == TRUE)
                    {
                        SetLocalInt(oItem,"nExhaust",TRUE);
                        SendMessageToPC(oPC,"You are exhausted.");
                    }
                    else
                    {
                        SetLocalInt(oItem,"nFatigue",TRUE);
                        SendMessageToPC(oPC,"You are fatigued.");
                    }
                }
            }
        }
    }

    if(nWet >= 100) {SetLocalInt(oItem,"nWet",100);}
    if(nWet <= 0)   {SetLocalInt(oItem,"nWet",0);}
    ////////////////////////////////////////////////////////////////////////////
    //Rain: -4 Spot, -4 Search, -4 Listen.
    //Fog: 20% miss chance.
    //Moderate: (5-9)
    //Strong Wind: -2 Ranged Attack, -2 Listen. (9-13)
    //Severe Wind: -4 Ranged, -4 Listen. (13-22)
    //Wind Storm: No Ranged Attacks, -8 Listen. (23-33)
    //Hurricane: No Ranged Attacks, -30 Listen. (33-77)

    int nSize = GetCreatureSize(oPC);

    if(HorseGetIsMounted(oPC) == TRUE)
    {
        nSize = nSize+1;
    }

    if ((fWind >=9.0)&&(fWind <13.0))
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectMissChance(25,MISS_CHANCE_TYPE_VS_RANGED),oPC,7.0);
        if(nSize <1)
        {
            if(FortitudeSave(oPC,10,SAVING_THROW_TYPE_NONE,OBJECT_SELF) == 0)
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectKnockdown(),oPC,4.0);
                SendMessageToPC(oPC,"A gust of wind knocks you down!");
            }
            else
            {
                SendMessageToPC(oPC,"A gust of wind nearly knocks you down!");
            }
        }
    }
    else if ((fWind >=13.0)&&(fWind <22.0))
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectMissChance(50,MISS_CHANCE_TYPE_VS_RANGED),oPC,7.0);
        if(nSize <1)
        {
            if(FortitudeSave(oPC,15,SAVING_THROW_TYPE_NONE,OBJECT_SELF) == 0)
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectKnockdown(),oPC,4.0);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d4(d4()),DAMAGE_TYPE_BLUDGEONING,DAMAGE_POWER_NORMAL),oPC);
                SendMessageToPC(oPC,"A gust of wind knocks you down hard!");
            }
            else
            {
                SendMessageToPC(oPC,"A gust of wind nearly knocks you down!");
            }
        }
        else if(nSize == CREATURE_SIZE_SMALL)
        {
            if(FortitudeSave(oPC,15,SAVING_THROW_TYPE_NONE,OBJECT_SELF) == 0)
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectKnockdown(),oPC,4.0);
                SendMessageToPC(oPC,"A gust of wind knocks you down!");
            }
            else
            {
                SendMessageToPC(oPC,"A gust of wind nearly knocks you down!");
            }
        }
        else if(nSize == CREATURE_SIZE_MEDIUM)
        {
            if(FortitudeSave(oPC,15,SAVING_THROW_TYPE_NONE,OBJECT_SELF) == 0)
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSlow(),oPC,3.0);
                SendMessageToPC(oPC,"A gust of wind slows you down as you brace yourself!");
            }
            else
            {
                SendMessageToPC(oPC,"A gust of wind blows hard against you!");
            }
        }
    }
    else if ((fWind >=22.0)&&(fWind <33.0))
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectMissChance(100,MISS_CHANCE_TYPE_VS_RANGED),oPC,7.0);

        if(nSize <= CREATURE_SIZE_SMALL)
        {
            if(FortitudeSave(oPC,18,SAVING_THROW_TYPE_NONE,OBJECT_SELF) == 0)
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectKnockdown(),oPC,4.0);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d4(d4()),DAMAGE_TYPE_BLUDGEONING,DAMAGE_POWER_NORMAL),oPC);
                SendMessageToPC(oPC,"A gust of wind knocks you down hard!");
            }
            else
            {
                SendMessageToPC(oPC,"A gust of wind nearly knocks you down!");
            }
        }
        else if(nSize == CREATURE_SIZE_MEDIUM)
        {
            if(FortitudeSave(oPC,15,SAVING_THROW_TYPE_NONE,OBJECT_SELF) == 0)
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectKnockdown(),oPC,4.0);
                SendMessageToPC(oPC,"A gust of wind knocks you down!");
            }
            else
            {
                SendMessageToPC(oPC,"A gust of wind blows hard against you!");
            }
        }
        else if(nSize >= CREATURE_SIZE_LARGE)
        {
            if(FortitudeSave(oPC,15,SAVING_THROW_TYPE_NONE,OBJECT_SELF) == 0)
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSlow(),oPC,3.0);
                SendMessageToPC(oPC,"A gust of wind slows you down as you brace yourself!");
            }
            else
            {
                SendMessageToPC(oPC,"A gust of wind blows hard against you!");
            }
        }

    }
     else if (fWind >=33.0)
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectMissChance(100,MISS_CHANCE_TYPE_VS_RANGED),oPC,7.0);

        if(nSize <= CREATURE_SIZE_MEDIUM)
        {
            if(FortitudeSave(oPC,20,SAVING_THROW_TYPE_NONE,OBJECT_SELF) == 0)
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectKnockdown(),oPC,4.0);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d4(d4()),DAMAGE_TYPE_BLUDGEONING,DAMAGE_POWER_NORMAL),oPC);
                SendMessageToPC(oPC,"A gust of wind knocks you down hard!");
            }
            else
            {
                SendMessageToPC(oPC,"A gust of wind nearly knocks you down!");
            }
        }
        else if(nSize == CREATURE_SIZE_LARGE)
        {
            if(FortitudeSave(oPC,15,SAVING_THROW_TYPE_NONE,OBJECT_SELF) == 0)
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectKnockdown(),oPC,4.0);
                SendMessageToPC(oPC,"A gust of wind knocks you down!");
            }
            else
            {
                SendMessageToPC(oPC,"A gust of wind blows hard against you!");
            }
        }
        else if(nSize >= CREATURE_SIZE_HUGE)
        {
            if(FortitudeSave(oPC,15,SAVING_THROW_TYPE_NONE,OBJECT_SELF) == 0)
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSlow(),oPC,3.0);
                SendMessageToPC(oPC,"A gust of wind slows you down as you brace yourself!");
            }
            else
            {
                SendMessageToPC(oPC,"A gust of wind blows hard against you!");
            }
        }
    }

}
