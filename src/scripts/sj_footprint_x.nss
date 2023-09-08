// -----------------------------------------------------------------------------
//  sj_footprint_x
// -----------------------------------------------------------------------------
/*
    Temporary library for Sunjammer's Footprint System containing structures,
    constants and functions which are part of the SJ Framework's Core library.

    If when you install the SJ Framework this file can be removed and the
    reference in sj_footprint_i replaced with a reference to sj_core_i.
*/
// -----------------------------------------------------------------------------
/*
    Version 0.00 - 25 Feb 2005 - Sunjammer
    - created
*/
// -----------------------------------------------------------------------------

struct polar
{
    float radius;
    float angle;
};


// Increments oObject's local integer variable sVarName by 1
int IncLocalInt(object oObject, string sVarName, int bPreIncrement=TRUE);
int IncLocalInt(object oObject, string sVarName, int bPreIncrement=TRUE)
{
    int nRet;

    if(bPreIncrement)
    {
        nRet = GetLocalInt(oObject, sVarName) + 1;
        SetLocalInt(oObject, sVarName, nRet);
    }
    else
    {
        nRet = GetLocalInt(oObject, sVarName);
        SetLocalInt(oObject, sVarName, nRet + 1);
    }

    return nRet;
}

// Decrements oObject's local integer variable sVarName by 1
int DecLocalInt(object oObject, string sVarName, int bPreDecrement=TRUE);
int DecLocalInt(object oObject, string sVarName, int bPreDecrement=TRUE)
{
    int nRet;

    if(bPreDecrement)
    {
        nRet = GetLocalInt(oObject, sVarName) - 1;
        SetLocalInt(oObject, sVarName, nRet);
    }
    else
    {
        nRet = GetLocalInt(oObject, sVarName);
        SetLocalInt(oObject, sVarName, nRet  - 1);
    }

    return nRet;
}


// Returns a random float between 0.0 and fMax
float Frandom(float fMax);
float Frandom(float fMax)
{
    return IntToFloat(Random(FloatToInt(fMax) + 1));
}


// Normalises fAngle to: 0.0 <= fAngle < 360.0
float NormalizeAngle(float fAngle);
float NormalizeAngle(float fAngle)
{
    // normalize the angle
    while(fAngle >= 360.0) fAngle -= 360.0;
    while(fAngle < 0.0) fAngle += 360.0;
    return fAngle;
}


// Constructor for polar co-ordinates
struct polar Polar(float fRadius, float fAngle);
struct polar Polar(float fRadius, float fAngle)
{
    struct polar uRet;

    uRet.radius = fRadius;
    uRet.angle = NormalizeAngle(fAngle);

    return uRet;
}


// Converts polar co-ordinates in to vector co-ordinates
vector PolarToVector(struct polar uPolar);
vector PolarToVector(struct polar uPolar)
{
    float fX = uPolar.radius * cos(uPolar.angle);
    float fY = uPolar.radius * sin(uPolar.angle);

    return Vector(fX, fY);
}
