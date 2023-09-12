//Routing all bioware traps script through one script for easy
//changes and adding more.  (W.I.P.)

#include "ccc_inc_traps"

//Standard traps routing.
//Custom traps routing


object oTarget =GetEnteringObject();
void main()
{
    //Standard traps from traps.2da
    //Only changes I made was give divine S.T. for half damage for undead
    //and custom spike function in hr_inc_traps so you can make change without going into
    //x0_i0_spells script (functin DoTrapSpike) if you wanted to make changes.
    //Change them as you see fit.
    int iT_Base =GetTrapBaseType(OBJECT_SELF);
    string sT_Base =IntToString(iT_Base);
    int iCustT =GetLocalInt(OBJECT_SELF, "C_TRAP");
    //Debug
    //SendMessageToPC(oTarget,"This the line in trap.2da that has fired: "+sT_Base);
    //SendMessageToPC(oTarget,"We are routing all traps");

    if(!iCustT)
    {
        switch (iT_Base)
        {
            //SPIKE
            //Spike Trap, Minor
            //wow all DC 15 for spikes, weird. You can put what you want in here.
            case 0:
            CustomDoTrapSpike(oTarget,d6(2),15);
            break;

            //Spike Trap, Average
            case 1:
            CustomDoTrapSpike(oTarget,d6(3),15);

            break;

            //Spike Trap, Strong
            case 2:
            CustomDoTrapSpike(oTarget,d6(5),15);
            break;

            //Spike Trap, Deadly
            case 3:
            CustomDoTrapSpike(oTarget,d6(25),15);
            break;


            //HOLY
            //Holy Trap, Minor
            case 4:
            HolyTrap(oTarget,d10(4),d4(2),12);
            break;

            //Holy Trap, Average
            case 5:
            HolyTrap(oTarget,d10(5),d4(3),15);
            break;

            //Holy Trap, Strong
            case 6:
            HolyTrap(oTarget,d10(8),d4(6),18);
            break;

            //Holy Trap, Deadly
            case 7:
            HolyTrap(oTarget,d10(12),d4(8),21);
            break;


            //TANGLE
            //Tangle Trap, Minor
            case 8:
            TangleTrap(oTarget,3,RADIUS_SIZE_SMALL,20);
            break;

            //Tangle Trap, Average
            case 9:
            TangleTrap(oTarget,4,RADIUS_SIZE_SMALL,25);
            break;

            //Tangle Trap, Strong
            case 10:
            TangleTrap(oTarget,4,RADIUS_SIZE_MEDIUM,30);
            break;

            //Tangle Trap, Deadly
            case 11:
            TangleTrap(oTarget,5,RADIUS_SIZE_MEDIUM,35);
            break;


            //ACID BLOB
            //Acid Trap Blob, Minor (Level 5)
            case 12:
            AcidBlob(oTarget,d6(3),2,15);
            break;

            //Acid Trap Blob, Average (Level 8)
            case 13:
            AcidBlob(oTarget,d6(5),3,20);
            break;

            //Acid Trap Blob, Strong (Level 12)
            case 14:
            AcidBlob(oTarget,d6(12),4,25);
            break;

            //Acid Trap Blob, Deadly (Level 15)
            case 15:
            AcidBlob(oTarget,d6(18),5,25);
            break;


            //FIRE
            //Fire Trap, Minor
            case 16:
            FireTrap(oTarget,RADIUS_SIZE_SMALL,d6(5),18);
            break;

            //Fire Trap, Average
            case 17:
            FireTrap(oTarget,RADIUS_SIZE_SMALL,d6(8),20);
            break;

            //Fire Trap, Strong
            case 18:
            FireTrap(oTarget,RADIUS_SIZE_MEDIUM,d6(15),23);
            break;

            //Fire Trap, Deadly
            case 19:
            FireTrap(oTarget,RADIUS_SIZE_MEDIUM,d6(25),26);
            break;

            //Fire Trap, Epic
            case 45:
            FireTrap(oTarget,RADIUS_SIZE_MEDIUM,d6(50),33);
            break;


            //ELECTRICAL
            //Electrical Trap, Minor
            case 20:
            TrapDoElectricalDamage(d6(8),19,3);
            break;

            //Electrical Trap, Average
            case 21:
            TrapDoElectricalDamage(d6(15), 22, 4);
            break;

            //Electrical Trap, Strong
            case 22:
            TrapDoElectricalDamage(d6(20),26,5);
            break;

            //Electrical Trap, Deadly
            case 23:
            TrapDoElectricalDamage(d6(30),28,6);
            break;

            //Electrical Trap, Epic
            case 44:
            TrapDoElectricalDamage(d6(60),35,6);
            break;


            //GAS
            //could route these into one also
            //do that later though.
            //These only fire once for onenter
            //if you want to have S.T. vs every
            //round add the script agin in heartbeat
            //part. Look at the function.
            //Gas Trap, Minor
            case 24:
            GasTrap(oTarget,"NW_T1_GasMinoC1",2);
            break;

            //Gas Trap, Average
            case 25:
            GasTrap(oTarget,"NW_T1_GasAvgC1",2);
            break;

            //Gas Trap, Strong
            case 26:
            GasTrap(oTarget,"NW_T1_GasStrC1",2);
            break;

            //Gas Trap, Deadly
            case 27:
            GasTrap(oTarget,"NW_T1_GasDeadC1",2);
            break;


            //FROST
            //Frost Trap, Minor
            case 28:
            FrostTrap(oTarget,d4(2),12,1);
            break;

            //Frost Trap, Average
            case 29:
            FrostTrap(oTarget,d4(3),13,2);
            break;

            //Frost Trap, Strong
            case 30:
            FrostTrap(oTarget,d4(5),14,3);
            break;

            //Frost Trap, Deadly
            case 31:
            FrostTrap(oTarget,d4(8),15,4);
            break;

            //Frost Trap, Epic
            case 46:
            FrostTrap(oTarget,d4(40),30,4);
            break;


            //NEGATIVE
            //Negative Trap, Minor
            case 32:
            NegativeTrap(oTarget,1,d6(2),12,0);
            break;

            //Negative Trap, Average
            case 33:
            NegativeTrap(oTarget,1,d6(3),15,0);
            break;

            //Negative Trap, Strong
            case 34:
            NegativeTrap(oTarget,2,d6(5),18,0);
            break;

            //Negative Trap, Deadly
            case 35:
            NegativeTrap(oTarget,1,d6(8),21,1);
            break;


            //SONIC
            //Sonic Trap, Minor
            case 36:
            SonicTrap(oTarget,d4(2),RADIUS_SIZE_MEDIUM,12,2);
            break;

            //Sonic Trap, Average
            case 37:
            SonicTrap(oTarget,d4(3),RADIUS_SIZE_MEDIUM,14,2);
            break;

            //Sonic Trap, Strong
            case 38:
            SonicTrap(oTarget,d4(5),RADIUS_SIZE_MEDIUM,17,3);
            break;

            //Sonic Trap, Deadly
            case 39:
            SonicTrap(oTarget,d4(8),RADIUS_SIZE_MEDIUM,20,4);
            break;

            //Sonic Trap, Epic
            case 47:
            SonicTrap(oTarget,d4(40),RADIUS_SIZE_MEDIUM,30,4);
            break;


            //ACID SPLASH
            //Acid Splash Trap, Minor
            case 40:
            AcidSplash(oTarget,d8(2),12);
            break;

            //Acid Splash Trap, Average
            case 41:
            AcidSplash(oTarget,d8(3),14);
            break;

            //Acid Splash Trap, Strong
            case 42:
            AcidSplash(oTarget,d8(5),17);
            break;

            //Acid Splash Trap, Deadly
            case 43:
            AcidSplash(oTarget,d8(8),20);
            break;



        }
     }

    //Use these to make custom traps that are not recoverable
    //Saves on scripts.
    //You can also put spells to fire off with
    //calling spell functions with spell level int in them.
    //some samples below.
    //These only fire off placables/doors not triggers(if trigger is a one shot).
    //You can have spell version fire off triggers but you
    //have to make a custom function in hr_inc_traps.
    //You can also make differant version of standard
    //traps by using the cutom functions in hr_inc_traps
    //These will work with all three triggers/placables/traps(functions shown above (acid splash etc..)
    if(iCustT)
    {
        switch (iCustT)
        {

        //sample of variant of standard
        case 5:
        //SendMessageToPC(oTarget, "Custom Trap 5");
        CustomDoTrapSpike(oTarget, d4(1),99);
        break;


        //etc...

        }
    }
}
