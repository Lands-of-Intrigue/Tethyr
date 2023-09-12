// Name     : Avlis / NWNX Persistence System
// Purpose  : NWNX related functions
// Authors  : Ingmar Stieger, Adam Colon, Josh Simon, Benton
// Modified : January 1st, 2005
// Modified : December 28, 2017 Glorwinger - Updated for NWNX EE

// This file is licensed under the terms of the
// GNU GENERAL PUBLIC LICENSE (GPL) Version 2

#include "nwnx_sql"

/************************************/
/* Return codes                     */
/************************************/

const int SQL_ERROR = 0;
const int SQL_SUCCESS = 1;

/************************************/
/* Function prototypes              */
/************************************/

// Added to support both SQLLite and MySQL. Coded by Mith, designed by Glorwinger.
string SQLRandom();

// Setup placeholders for ODBC requests and responses
void SQLInit();

// Execute statement in sSQL
int SQLExecDirect(string sSQL);

// Position cursor on next row of the resultset
// Call this before using SQLGet<type>Data().
// returns: SQL_SUCCESS if there is a row
//          SQL_ERROR if there are no more rows
int SQLFetch();

// Return value of column iCol in the current row of result set sResultSetName
string SQLGetStringData(int iCol);

// Return a string value when given a location
string NWNXLocationToString(location lLocation);

// Return a location value when given the string form of the location
location NWNXStringToLocation(string sLocation);

// Return a string value when given a vector
string NWNXVectorToString(vector vVector);

// Return a vector value when given the string form of the vector
vector NWNXStringToVector(string sVector);

// Set oObject's persistent string variable sVarName to sValue
// Optional parameters:
//   sTable: Name of the table where variable should be stored (default: pwdata)
void SetPersistentString(object oObject, string sVarName, string sValue, string sTable);

// Set oObject's persistent integer variable sVarName to iValue
// Optional parameters:
//   sTable: Name of the table where variable should be stored (default: pwdata)
void SetPersistentInt(object oObject, string sVarName, int iValue, string sTable);

// Set oObject's persistent float variable sVarName to fValue
// Optional parameters:
//   sTable: Name of the table where variable should be stored (default: pwdata)
void SetPersistentFloat(object oObject, string sVarName, float fValue, string sTable);

// Set oObject's persistent location variable sVarName to lLocation
// Optional parameters:
//   sTable: Name of the table where variable should be stored (default: pwdata)
//   This function converts location to a string for storage in the database.
void SetPersistentLocation(object oObject, string sVarName, location lLocation, string sTable);

// Set oObject's persistent vector variable sVarName to vVector
// Optional parameters:
//   sTable: Name of the table where variable should be stored (default: pwdata)
//   This function converts vector to a string for storage in the database.
void SetPersistentVector(object oObject, string sVarName, vector vVector, string sTable);

// Set oObject's persistent object with sVarName to sValue
// Optional parameters:
//   sTable: Name of the table where variable should be stored (default: pwobjdata)
int SetPersistentObject(string sObjectName, object oObject, object oOwner, string sTable);

// Get oObject's persistent string variable sVarName
// Optional parameters:
//   sTable: Name of the table where variable is stored (default: pwdata)
// * Return value on error: ""
string GetPersistentString(object oObject, string sVarName, string sTable, int nRandom=FALSE);

// Get oObject's persistent integer variable sVarName
// Optional parameters:
//   sTable: Name of the table where variable is stored (default: pwdata)
// * Return value on error: 0
int GetPersistentInt(object oObject, string sVarName, string sTable);

// Get oObject's persistent float variable sVarName
// Optional parameters:
//   sTable: Name of the table where variable is stored (default: pwdata)
// * Return value on error: 0
float GetPersistentFloat(object oObject, string sVarName, string sTable);

// Get oObject's persistent location variable sVarName
// Optional parameters:
//   sTable: Name of the table where variable is stored (default: pwdata)
// * Return value on error: 0
location GetPersistentLocation(object oObject, string sVarname, string sTable);

// Get oObject's persistent vector variable sVarName
// Optional parameters:
//   sTable: Name of the table where variable is stored (default: pwdata)
// * Return value on error: 0
vector GetPersistentVector(object oObject, string sVarName, string sTable);

// Get oObject's persistent object sVarName
// Optional parameters:
//   sTable: Name of the table where object is stored (default: pwobjdata)
// * Return value on error: 0
object GetPersistentObject(string sObjectName, object oOwner, string sTable, location lLocation);

// Delete persistent variable sVarName stored on oObject
// Optional parameters:
//   sTable: Name of the table where variable is stored (default: pwdata)
void DeletePersistentVariable(string sVarName, string sTable, object oObject);

// (private function) Replace special character ' with ~
string SQLEncodeSpecialChars(string sString);

// (private function)Replace special character ' with ~
string SQLDecodeSpecialChars(string sString);


/************************************/
/* Implementation                   */
/************************************/

// Added to support both SQLLite and MySQL. Coded by Mith, designed by
// Glorwinger.
string SQLRandom()
{
    string sSuffix = "";
    switch (GetLocalInt(GetModule(), "TC_DB_SYSTEM")) {
        case 1:
            sSuffix = " ORDER BY RAND() LIMIT 1";
            break;
        case 2:
            sSuffix = " ORDER BY RANDOM( * ) LIMIT 1";
            break;
        default:
            // Should never hit this case.
            sSuffix = "";
            break;
    }
    return sSuffix;
}

int SQLExecDirect(string sSQL) {
    return NWNX_SQL_ExecuteQuery(sSQL);
}

int SQLFetch() {
    if (NWNX_SQL_ReadyToReadNextRow()) {
        return SQL_SUCCESS;
    } else {
        return SQL_ERROR;
    }
}

// deprecated. use SQLFetch().
int SQLFirstRow() {
    return SQLFetch();
}

// deprecated. use SQLFetch().
int SQLNextRow() {
    return SQLFetch();
}

string SQLGetStringData(int iCol) {

    string sValue = "";

    if (NWNX_SQL_ReadyToReadNextRow()) {
        NWNX_SQL_ReadNextRow();
        sValue = NWNX_SQL_ReadDataInActiveRow(iCol - 1);
    }

    return sValue;
}

// These functions deal with various data types. Ultimately, all information
// must be stored in the database as strings, and converted back to the proper
// form when retrieved.

string NWNXVectorToString(vector vVector) {
    return "#POSITION_X#" + FloatToString(vVector.x) + "#POSITION_Y#" + FloatToString(vVector.y) +
        "#POSITION_Z#" + FloatToString(vVector.z) + "#END#";
}

vector NWNXStringToVector(string sVector) {
    float fX, fY, fZ;
    int iPos, iCount;
    int iLen = GetStringLength(sVector);

    if (iLen > 0)     {
        iPos = FindSubString(sVector, "#POSITION_X#") + 12;
        iCount = FindSubString(GetSubString(sVector, iPos, iLen - iPos), "#");
        fX = StringToFloat(GetSubString(sVector, iPos, iCount));

        iPos = FindSubString(sVector, "#POSITION_Y#") + 12;
        iCount = FindSubString(GetSubString(sVector, iPos, iLen - iPos), "#");
        fY = StringToFloat(GetSubString(sVector, iPos, iCount));

        iPos = FindSubString(sVector, "#POSITION_Z#") + 12;
        iCount = FindSubString(GetSubString(sVector, iPos, iLen - iPos), "#");
        fZ = StringToFloat(GetSubString(sVector, iPos, iCount));
    }

    return Vector(fX, fY, fZ);
}

string NWNXLocationToString(location lLocation) {
    object oArea = GetAreaFromLocation(lLocation);
    vector vPosition = GetPositionFromLocation(lLocation);
    float fOrientation = GetFacingFromLocation(lLocation);
    string sReturnValue;

    if (GetIsObjectValid(oArea)) {
        sReturnValue =
            "#AREA#" + GetTag(oArea) + "#POSITION_X#" + FloatToString(vPosition.x) +
            "#POSITION_Y#" + FloatToString(vPosition.y) + "#POSITION_Z#" +
            FloatToString(vPosition.z) + "#ORIENTATION#" + FloatToString(fOrientation) + "#END#";
    }

    return sReturnValue;
}

location NWNXStringToLocation(string sLocation) {
    location lReturnValue;
    object oArea;
    vector vPosition;
    float fOrientation, fX, fY, fZ;

    int iPos, iCount;
    int iLen = GetStringLength(sLocation);

    if (iLen > 0)     {
        iPos = FindSubString(sLocation, "#AREA#") + 6;
        iCount = FindSubString(GetSubString(sLocation, iPos, iLen - iPos), "#");
        oArea = GetObjectByTag(GetSubString(sLocation, iPos, iCount));

        iPos = FindSubString(sLocation, "#POSITION_X#") + 12;
        iCount = FindSubString(GetSubString(sLocation, iPos, iLen - iPos), "#");
        fX = StringToFloat(GetSubString(sLocation, iPos, iCount));

        iPos = FindSubString(sLocation, "#POSITION_Y#") + 12;
        iCount = FindSubString(GetSubString(sLocation, iPos, iLen - iPos), "#");
        fY = StringToFloat(GetSubString(sLocation, iPos, iCount));

        iPos = FindSubString(sLocation, "#POSITION_Z#") + 12;
        iCount = FindSubString(GetSubString(sLocation, iPos, iLen - iPos), "#");
        fZ = StringToFloat(GetSubString(sLocation, iPos, iCount));

        vPosition = Vector(fX, fY, fZ);

        iPos = FindSubString(sLocation, "#ORIENTATION#") + 13;
        iCount = FindSubString(GetSubString(sLocation, iPos, iLen - iPos), "#");
        fOrientation = StringToFloat(GetSubString(sLocation, iPos, iCount));

        lReturnValue = Location(oArea, vPosition, fOrientation);
    }

    return lReturnValue;
}

// These functions are responsible for transporting the various data types back
// and forth to the database.

void SetPersistentString(object oObject, string sVarName, string sValue, string sTable) {
    string sPlayer;
    string sTag;

    if (GetIsPC(oObject)) {
        sPlayer = SQLEncodeSpecialChars(GetPCPlayerName(oObject));
        sTag = SQLEncodeSpecialChars(GetName(oObject));
    } else {
        sPlayer = "~";
        sTag = GetTag(oObject);
    }

    sVarName = SQLEncodeSpecialChars(sVarName);
    sValue = SQLEncodeSpecialChars(sValue);

    string sSQL = "SELECT player FROM " + sTable + " WHERE player='" + sPlayer +
        "' AND tag='" + sTag + "' AND name='" + sVarName + "'";
    SQLExecDirect(sSQL);

    if (SQLFetch() == SQL_SUCCESS) {
        // row exists
        sSQL = "UPDATE " + sTable + " SET val='" + sValue +
            "' WHERE player='" + sPlayer +
            "' AND tag='" + sTag + "' AND name='" + sVarName + "'";
        SQLExecDirect(sSQL);
    } else {
        // row doesn't exist
        sSQL = "INSERT INTO " + sTable + " (player,tag,name,val) VALUES" +
            "('" + sPlayer + "','" + sTag + "','" + sVarName + "','" +
            sValue + "')";
        SQLExecDirect(sSQL);
    }
}

string GetPersistentString(object oObject, string sVarName, string sTable, int nRandom=FALSE) {
    string sPlayer;
    string sTag;

    if (GetIsPC(oObject)) {
        sPlayer = SQLEncodeSpecialChars(GetPCPlayerName(oObject));
        sTag = SQLEncodeSpecialChars(GetName(oObject));
    } else {
        sPlayer = "~";
        sTag = GetTag(oObject);
    }

    sVarName = SQLEncodeSpecialChars(sVarName);
    string sSQL;

    if (nRandom) {
      sSQL = "SELECT val FROM " + sTable + " WHERE player='" + sPlayer +
             "' AND tag='" + sTag + "' AND name LIKE '" + sVarName + "'" +
             SQLRandom();
    } else {
      sSQL = "SELECT val FROM " + sTable + " WHERE player='" + sPlayer +
             "' AND tag='" + sTag + "' AND name='" + sVarName + "'";
    }

    SQLExecDirect(sSQL);

    if (SQLFetch() == SQL_SUCCESS) {
        return SQLDecodeSpecialChars(SQLGetStringData(1));
    } else {
        return "";
    }
}

void SetPersistentInt(object oObject, string sVarName, int iValue, string sTable) {
    SetPersistentString(oObject, sVarName, IntToString(iValue), sTable);
}

int GetPersistentInt(object oObject, string sVarName, string sTable) {
    string sPlayer;
    string sTag;

    if (GetIsPC(oObject)) {
        sPlayer = SQLEncodeSpecialChars(GetPCPlayerName(oObject));
        sTag = SQLEncodeSpecialChars(GetName(oObject));
    } else {
        sPlayer = "~";
        sTag = GetTag(oObject);
    }

    sVarName = SQLEncodeSpecialChars(sVarName);

    string sSQL = "SELECT val FROM " + sTable + " WHERE player='" + sPlayer +
        "' AND tag='" + sTag + "' AND name='" + sVarName + "'";
    SQLExecDirect(sSQL);

    if (SQLFetch() == SQL_SUCCESS) {
        return StringToInt (SQLGetStringData(1));
    } else {
        return 0;
    }
}

void SetPersistentFloat(object oObject, string sVarName, float fValue, string sTable) {
    SetPersistentString(oObject, sVarName, FloatToString(fValue), sTable);
}

float GetPersistentFloat(object oObject, string sVarName, string sTable) {
    string sPlayer;
    string sTag;

    if (GetIsPC(oObject)) {
        sPlayer = SQLEncodeSpecialChars(GetPCPlayerName(oObject));
        sTag = SQLEncodeSpecialChars(GetName(oObject));
    } else {
        sPlayer = "~";
        sTag = GetTag(oObject);
    }

    sVarName = SQLEncodeSpecialChars(sVarName);

    string sSQL = "SELECT val FROM " + sTable + " WHERE player='" + sPlayer +
        "' AND tag='" + sTag + "' AND name='" + sVarName + "'";
    SQLExecDirect(sSQL);

    if (SQLFetch() == SQL_SUCCESS) {
        return StringToFloat (SQLGetStringData(1));
    } else {
        return 0.0;
    }
}

void SetPersistentLocation(object oObject, string sVarName, location lLocation, string sTable) {
    SetPersistentString(oObject, sVarName, NWNXLocationToString(lLocation), sTable);
}

location GetPersistentLocation(object oObject, string sVarName, string sTable) {
    return NWNXStringToLocation(GetPersistentString(oObject, sVarName, sTable));
}

void SetPersistentVector(object oObject, string sVarName, vector vVector, string sTable) {
    SetPersistentString(oObject, sVarName, NWNXVectorToString(vVector), sTable);
}

vector GetPersistentVector(object oObject, string sVarName, string sTable) {
    return NWNXStringToVector(GetPersistentString(oObject, sVarName, sTable));
}

int SetPersistentObject(string sObjectName, object oObject, object oOwner, string sTable) {
    string sPlayer;
    string sTag;
    int iExecResult = 0;
    int iPrepareResult = 0;

    if (GetIsPC(oOwner)) {
        sPlayer = SQLEncodeSpecialChars(GetPCPlayerName(oOwner));
        sTag = SQLEncodeSpecialChars(GetName(oOwner));
    } else {
        sPlayer = "~";
        sTag = GetTag(oOwner);
    }
    sObjectName = SQLEncodeSpecialChars(sObjectName);

    string sSQL = "SELECT player FROM " + sTable + " WHERE player='" + sPlayer +
        "' AND tag='" + sTag + "' AND name='" + sObjectName + "'";
    SQLExecDirect(sSQL);

    if (SQLFetch() == SQL_SUCCESS) {
        // row exists
        iPrepareResult = NWNX_SQL_PrepareQuery ("UPDATE " + sTable + " SET val=? WHERE player=? AND tag=? AND name=?");

        if (iPrepareResult) {
            NWNX_SQL_PreparedObjectFull(0,oObject);
            NWNX_SQL_PreparedString(1,sPlayer);
            NWNX_SQL_PreparedString(2,sTag);
            NWNX_SQL_PreparedString(3,sObjectName);

            iExecResult = NWNX_SQL_ExecutePreparedQuery();
        }
    } else {
        // row doesn't exist
        iPrepareResult = NWNX_SQL_PrepareQuery ("INSERT INTO " + sTable + " (player,tag,name,val) VALUES (?,?,?,?)");

        if (iPrepareResult) {
            NWNX_SQL_PreparedString(0,sPlayer);
            NWNX_SQL_PreparedString(1,sTag);
            NWNX_SQL_PreparedString(2,sObjectName);
            NWNX_SQL_PreparedObjectFull(3,oObject);

            iExecResult = NWNX_SQL_ExecutePreparedQuery();
        }
    }
    return iExecResult;
}

object GetPersistentObject(string sObjectName, object oOwner, string sTable, location lLocation) {
    string sPlayer;
    string sTag;
    object oSqlObject = OBJECT_INVALID;
    object oDestObject;
    float  fXPos = 0.0;
    float  fYPos = 0.0;
    float  fZPos = 0.0;

    if (oOwner != OBJECT_INVALID) {
        oDestObject = oOwner;
    } else {
        oDestObject = GetAreaFromLocation (lLocation);
        if (oDestObject != OBJECT_INVALID) {
            vector vPosition = GetPositionFromLocation (lLocation);
            fXPos = vPosition.x;
            fYPos = vPosition.y;
            fZPos = vPosition.z;
        }
    }

    if (oDestObject != OBJECT_INVALID) {

        if (GetIsPC(oDestObject)) {
            sPlayer = SQLEncodeSpecialChars(GetPCPlayerName(oDestObject));
            sTag = SQLEncodeSpecialChars(GetName(oDestObject));
        } else {
            sPlayer = "~";
            sTag = GetTag(oDestObject);
        }
        sObjectName = SQLEncodeSpecialChars(sObjectName);

        int result;

        WriteTimestampedLogEntry("getting Item [" +sObjectName+"]["+sTag+"]");

        result = NWNX_SQL_PrepareQuery ("SELECT val FROM " + sTable + " WHERE player=? AND tag=? AND name=?");

        WriteTimestampedLogEntry("prepare query result [" +IntToString(result)+"]");

        if (result) {
            NWNX_SQL_PreparedString(0,sPlayer);
            NWNX_SQL_PreparedString(1,sTag);
            NWNX_SQL_PreparedString(2,sObjectName);

            result = NWNX_SQL_ExecutePreparedQuery ();
            WriteTimestampedLogEntry("Execute Query result [" +IntToString(result)+"]");
        }

        if (result) {
            if (NWNX_SQL_ReadyToReadNextRow()) {
                NWNX_SQL_ReadNextRow ();
                oSqlObject = NWNX_SQL_ReadFullObjectInActiveRow (0, oDestObject, fXPos, fYPos, fZPos);
                WriteTimestampedLogEntry("object [" +GetTag(oSqlObject)+"]");
            }
        }
    }

    return oSqlObject;
}

void DeletePersistentVariable(string sVarName, string sTable, object oObject) {
    string sPlayer;
    string sTag;

    if (GetIsPC(oObject)) {
        sPlayer = SQLEncodeSpecialChars(GetPCPlayerName(oObject));
        sTag = SQLEncodeSpecialChars(GetName(oObject));
    } else {
        sPlayer = "~";
        sTag = GetTag(oObject);
    }

    sVarName = SQLEncodeSpecialChars(sVarName);
    string sSQL = "DELETE FROM " + sTable + " WHERE player='" + sPlayer +
        "' AND tag='" + sTag + "' AND name='" + sVarName + "'";
    SQLExecDirect(sSQL);
}

// Problems can arise with SQL commands if variables or values have single quotes
// in their names. These functions are a replace these quote with the tilde character

string SQLEncodeSpecialChars(string sString) {
    if (FindSubString(sString, "'") == -1)      // not found
        return sString;

    int i;
    string sReturn = "";
    string sChar;

    // Loop over every character and replace special characters
    for (i = 0; i < GetStringLength(sString); i++) {
        sChar = GetSubString(sString, i, 1);
        if (sChar == "'")
            sReturn += "~";
        else
            sReturn += sChar;
    }
    return sReturn;
}

string SQLDecodeSpecialChars(string sString) {
    if (FindSubString(sString, "~") == -1)      // not found
        return sString;

    int i;
    string sReturn = "";
    string sChar;

    // Loop over every character and replace special characters
    for (i = 0; i < GetStringLength(sString); i++) {
        sChar = GetSubString(sString, i, 1);
        if (sChar == "~")
            sReturn += "'";
        else
            sReturn += sChar;
    }
    return sReturn;
}


