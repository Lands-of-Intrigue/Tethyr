//Function: Pickup Script // Date: 23MAR16
//Creator: Jonathan Lorentsen // Email: jlorents93@hotmail.com
//Instructions: Ensure Item (TAG) & Placeable (Blueprint Resref) is same
//Place Script inside Conversation to be called from

#include "loi_functions"


void main()
{
    object oPC = GetPCSpeaker(); //Get PC Speaker
    EventTakePlaceable(oPC,OBJECT_SELF);
}
