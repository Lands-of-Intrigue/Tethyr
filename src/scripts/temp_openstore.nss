void main()
{

object oPC = GetPCSpeaker();

object oTarget;
oTarget = GetObjectByTag("NW_STORGENRAL002");

OpenStore(oTarget, oPC, 0, 0);

}
