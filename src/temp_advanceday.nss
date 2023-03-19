void main()
{
object oPC=GetItemActivator();
SetTime(23, 59, 59, 59);
SendMessageToPC(oPC, "Time advanced by one day.");
}
