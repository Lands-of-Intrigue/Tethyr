#include "so_inc_weather"

void main()
{
    object oModule=GetModule();

    //Global Variables
    int nHour=GetTimeHour();
    int nMonth=GetCalendarMonth();
    int nDay=GetCalendarDay();
    float fDay=IntToFloat((nMonth-1)*28+(nDay-1));
    int nMinute=GetTimeMinute();

    float fTemperatureAimHourlyVariation=(cos((IntToFloat(nHour)-16.0)*360.0/24.0)*5.0-5.0);
    float fTemperatureAim=GetLocalFloat(oModule,"Weather_Temperature_Month_"+IntToString(nMonth))+fTemperatureAimHourlyVariation;
    float fHumidityAim=GetLocalFloat(oModule,"Weather_Humidity_Month_"+IntToString(nMonth));
    SetLocalFloat(oModule,WEATHER_LOCAL_GROUND_HUMIDITY,100.0-fHumidityAim);
    SetLocalFloat(oModule,WEATHER_LOCAL_GROUND_TEMPERATURE,fTemperatureAim);
    SetLocalFloat(oModule,WEATHER_BEYOND_GROUND_TEMPERATURE,fTemperatureAim);
    SetLocalFloat(oModule,WEATHER_BEYOND_GROUND_HUMIDITY,100.0-fHumidityAim);
    SetLocalFloat(oModule,WEATHER_LOCAL_SKY_HUMIDITY,fHumidityAim);
    SetLocalFloat(oModule,WEATHER_LOCAL_SKY_TEMPERATURE,fTemperatureAim);
    SetLocalFloat(oModule,WEATHER_BEYOND_SKY_TEMPERATURE,fTemperatureAim);
    SetLocalFloat(oModule,WEATHER_BEYOND_SKY_HUMIDITY,fHumidityAim);
}
