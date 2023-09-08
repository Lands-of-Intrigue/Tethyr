#include "so_inc_weather"

void main()
{
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

    object oModule=GetModule();

    float fLocalSkyTemperature=GetLocalFloat(oModule,WEATHER_LOCAL_SKY_TEMPERATURE);
    float fLocalSkyHumidity=GetLocalFloat(oModule,WEATHER_LOCAL_SKY_HUMIDITY);

    float fBeyondSkyHumidity=GetLocalFloat(oModule,WEATHER_BEYOND_SKY_HUMIDITY);
    float fBeyondGroundHumidity=GetLocalFloat(oModule,WEATHER_BEYOND_GROUND_HUMIDITY);
    float fBeyondChange=(fBeyondSkyHumidity-(fLocalSkyHumidity+30));

    SetLocalFloat(oModule, WEATHER_BEYOND_SKY_TEMPERATURE, fLocalSkyTemperature-20.0);
    SetLocalFloat(oModule, WEATHER_BEYOND_SKY_HUMIDITY, fLocalSkyHumidity+30.0);
    SetLocalFloat(oModule, WEATHER_BEYOND_GROUND_HUMIDITY, fBeyondGroundHumidity+fBeyondChange);

}
