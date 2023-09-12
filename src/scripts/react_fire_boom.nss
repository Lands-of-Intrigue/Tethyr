void main()
{
//Function: Object Explodes on Fire Damage
//Created by: Jonathan Lorentsen // Email: jlorents93@hotmail.com
//Instructions: Place script in Object's OnDamaged
//Add following Variables to Object; iNum & iDC
//iNum (Number you want multiplied to d8)
//iDC (Number you want for Reflex Save DC)

//Common Variables
object oDamager;
object oSelf;
object oTarget;
object oTarget2;
int iDamageType;
location lTarget;
effect eEffect;

iDamageType = GetDamageDealtByType(DAMAGE_TYPE_FIRE); //Check for Fire Damage
oSelf = OBJECT_SELF; //Defaults oSelf to Caller
lTarget = GetLocation(oSelf); //Get Location of oSelf
oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE); //Sets oTarget to First Objects in Radius
if (iDamageType >= 1) //Continues Script if oSelf Recieved 1 Fire Damage
    {
    DestroyObject(oSelf, 0.01f); //Destroys oSelf
    eEffect = EffectVisualEffect(VFX_FNF_FIREBALL); //Visual Fireball Explosion
    DelayCommand(0.01, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, lTarget)); //Visual on oSelf Location
    while(GetIsObjectValid(oTarget)) //Applies following script to current selected oTarget in Radius
        {
        int iDC = GetLocalInt(oSelf, "iDC"); //Sets Object Variable "iDC" as DC Save
        if (ReflexSave(oTarget, iDC, SAVING_THROW_TYPE_NONE) == 0) //Damage if fails ReflexSave
            if (GetHasFeat(FEAT_IMPROVED_EVASION, oTarget) == TRUE) //If fail with Improved Evasion, take half
                {
                int iX = GetLocalInt(oSelf, "iNum"); //Sets Object Variable "iNum" to multiply to d8 (Ex. iNum = 5, iNum*d8 or 5d8)
                int iY = (d4(iX)); //Multiplies d8 to iNum
                effect eDamage = EffectDamage(iY, DAMAGE_TYPE_FIRE, DAMAGE_POWER_NORMAL); //Set Effect to Rolled Fire Damage
                DelayCommand(0.01, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget, 0.0f)); //Apply Effect to current Target
                }
            else
                {
                int iX = GetLocalInt(oSelf, "iNum"); //Sets Object Variable "iNum" to multiply to d8 (Ex. iNum = 5, iNum*d8 or 5d8)
                int iY = (d8(iX)); //Multiplies d8 to iNum
                effect eDamage = EffectDamage(iY, DAMAGE_TYPE_FIRE, DAMAGE_POWER_NORMAL); //Set Effect to Rolled Fire Damage
                DelayCommand(0.01, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget, 0.0f)); //Apply Effect to current Target
                }
        else if (GetHasFeat(FEAT_EVASION, oTarget) == FALSE) //If passes without Feat without Evasion Take Half
            {
            int iX = GetLocalInt(oSelf, "iNum"); //Sets Object Variable "iNum" to multiply to d8 (Ex. iNum = 5, iNum*d8 or 5d8)
            int iY = (d4(iX)); //Multiplies d8 to iNum
            effect eDamage = EffectDamage(iY, DAMAGE_TYPE_FIRE, DAMAGE_POWER_NORMAL); //Set Effect to Rolled Fire Damage
            DelayCommand(0.01, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget, 0.0f)); //Apply Effect to current Target
            }
        else
            {
            //Nothing
            }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE); //Cycle to next target in Radius
        }
    }
}
