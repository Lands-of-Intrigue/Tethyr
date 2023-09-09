void main()
{
    object oPC = OBJECT_SELF;
    int nToggle = GetLastSpell();

    if(nToggle == 1055) //Frightful Blast
    {
        if(GetLocalInt(oPC,"nEssence") == 1055) {SetLocalInt(oPC,"nEssence",0); SendMessageToPC(oPC,"You are no longer using an essence.");}
        else {SetLocalInt(oPC,"nEssence",1055);  SendMessageToPC(oPC,"You are now using Frightful Blast essence.");}
    }
    else if(nToggle == 1056) // Sickening Blast
    {
        if(GetLocalInt(oPC,"nEssence") == 1056) {SetLocalInt(oPC,"nEssence",0); SendMessageToPC(oPC,"You are no longer using an essence.");}
        else {SetLocalInt(oPC,"nEssence",1056);  SendMessageToPC(oPC,"You are now using Sickening Blast essence.");}
    }
    else if(nToggle == 1057) // Brimstone Blast
    {
        if(GetLocalInt(oPC,"nEssence") == 1057) {SetLocalInt(oPC,"nEssence",0); SendMessageToPC(oPC,"You are no longer using an essence.");}
        else {SetLocalInt(oPC,"nEssence",1057);  SendMessageToPC(oPC,"You are now using Brimstone Blast essence.");}
    }
    else if(nToggle == 1058) // Hellrime Blast
    {
        if(GetLocalInt(oPC,"nEssence") == 1058) {SetLocalInt(oPC,"nEssence",0); SendMessageToPC(oPC,"You are no longer using an essence.");}
        else {SetLocalInt(oPC,"nEssence",1058);  SendMessageToPC(oPC,"You are now using Hellrime Blast essence.");}
    }
    else if(nToggle == 1059) // Vitriolic Blast
    {
        if(GetLocalInt(oPC,"nEssence") == 1059) {SetLocalInt(oPC,"nEssence",0); SendMessageToPC(oPC,"You are no longer using an essence.");}
        else {SetLocalInt(oPC,"nEssence",1059);  SendMessageToPC(oPC,"You are now using Vitriolic Blast essence.");}
    }
    else if(nToggle == 1060) // Bewitching Blast
    {
        if(GetLocalInt(oPC,"nEssence") == 1060) {SetLocalInt(oPC,"nEssence",0); SendMessageToPC(oPC,"You are no longer using an essence.");}
        else {SetLocalInt(oPC,"nEssence",1060);  SendMessageToPC(oPC,"You are now using Bewitching Blast essence.");}
    }
    else if(nToggle == 1061) // Utterdark Blast
    {
        if(GetLocalInt(oPC,"nEssence") == 1061) {SetLocalInt(oPC,"nEssence",0); SendMessageToPC(oPC,"You are no longer using an essence.");}
        else {SetLocalInt(oPC,"nEssence",1061);  SendMessageToPC(oPC,"You are now using Utterdark Blast essence.");}
    }
    else if(nToggle == 1062) // Repelling Blast
    {
        if(GetLocalInt(oPC,"nEssence") == 1062) {SetLocalInt(oPC,"nEssence",0); SendMessageToPC(oPC,"You are no longer using an essence.");}
        else {SetLocalInt(oPC,"nEssence",1062);  SendMessageToPC(oPC,"You are now using Repelling Blast essence.");}
    }
}
