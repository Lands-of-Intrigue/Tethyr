#include "so_inc_weather"
const int CUSTOM_TOKEN_WEATHER=3100;

int StartingConditional()
{
    object oModule=GetModule();
    string sFeedback="";
    sFeedback+="-->O<-- WEATHER INFO -->O<--\n";
    sFeedback+="\nGlobal:";
    sFeedback+="\nSun Influx:  "+IntToString(FloatToInt(100*GetLocalFloat(oModule,WEATHER_GLOBAL_SUN_INFLUX)))+" %";
    sFeedback+="\nMoonlight:   "+IntToString(FloatToInt(100*GetLocalFloat(oModule,WEATHER_GLOBAL_MOONLIGHT)))+" %";
    sFeedback+="\nWind:        "+IntToString(FloatToInt(100*GetLocalFloat(oModule,WEATHER_GLOBAL_WIND)*2.23693629))+"mph ("+IntToString(FloatToInt(100*GetLocalFloat(oModule,WEATHER_GLOBAL_WIND)))+" m/s)";
    sFeedback+="\nSun Redshft: "+IntToString(FloatToInt(100*GetLocalFloat(oModule,WEATHER_GLOBAL_SUN_REDSHIFT)))+" %";
    sFeedback+="\nLocal:";
    sFeedback+="\nGround Temp.:"+IntToString(FloatToInt((GetLocalFloat(oModule,WEATHER_LOCAL_GROUND_TEMPERATURE)*(9.0/5.0)+32.0)))+"°F ("
                                +IntToString(FloatToInt(GetLocalFloat(oModule,WEATHER_LOCAL_GROUND_TEMPERATURE)))+"°C)";
    sFeedback+="\nSky Temp.:   "+IntToString(FloatToInt((GetLocalFloat(oModule,WEATHER_LOCAL_SKY_TEMPERATURE)*(9.0/5.0)+32.0)))+"°F ("
                                +IntToString(FloatToInt(GetLocalFloat(oModule,WEATHER_LOCAL_SKY_TEMPERATURE)))+"°C)";
    sFeedback+="\nGround Hum.: "+IntToString(FloatToInt(GetLocalFloat(oModule,WEATHER_LOCAL_GROUND_HUMIDITY)))+" %";
    sFeedback+="\nSky Hum.:    "+IntToString(FloatToInt(GetLocalFloat(oModule,WEATHER_LOCAL_SKY_HUMIDITY)))+" %";
    sFeedback+="\nCloudiness:  "+IntToString(FloatToInt(100*GetLocalFloat(oModule,WEATHER_LOCAL_CLOUDINESS)))+" %";
    sFeedback+="\nRain:        "+IntToString(FloatToInt(100*GetLocalFloat(oModule,WEATHER_LOCAL_RAIN)))+" mm";
    sFeedback+="\nBeyond:";
    sFeedback+="\nGround Temp.:"+IntToString(FloatToInt((GetLocalFloat(oModule,WEATHER_BEYOND_GROUND_TEMPERATURE)*(9.0/5.0)+32.0)))+"°F ("
                                +IntToString(FloatToInt(GetLocalFloat(oModule,WEATHER_BEYOND_GROUND_TEMPERATURE)))+"°C)";
    sFeedback+="\nSky Temp.:   "+IntToString(FloatToInt((GetLocalFloat(oModule,WEATHER_BEYOND_SKY_TEMPERATURE)*(9.0/5.0)+32.0)))+"°F ("
                                +IntToString(FloatToInt(GetLocalFloat(oModule,WEATHER_BEYOND_SKY_TEMPERATURE)))+"°C)";
    sFeedback+="\nGround Hum.: "+IntToString(FloatToInt(GetLocalFloat(oModule,WEATHER_BEYOND_GROUND_HUMIDITY)))+" %";
    sFeedback+="\nSky Hum.:    "+IntToString(FloatToInt(GetLocalFloat(oModule,WEATHER_BEYOND_SKY_HUMIDITY)))+" %";

    /*


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
    const string WEATHER_GLOBAL_SUN_REDSHIFT="Weather_Global_Sun_Redshift";*/


    SetCustomToken(CUSTOM_TOKEN_WEATHER,sFeedback);
    return TRUE;
}
