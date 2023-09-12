#include "so_inc_weather"

void main()
{
    object oModule = GetModule();
    UpdateGlobalWeather(FALSE);
    DelayCommand(60.0, AssignCommand(oModule, ExecuteScript("te_weathpseud", oModule)));
}
