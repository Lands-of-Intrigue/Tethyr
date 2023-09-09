// Name     : Mock SQL Persistence System include
// Purpose  : Mock SQL related functions
// Authors  : Ingmar Stieger, Adam Colon, Josh Simon, Benton
// Modified : January 1st, 2005
// Modified : December 28, 2017 Glorwinger - Updated for NWNX EE

// This file is licensed under the terms of the
// GNU GENERAL PUBLIC LICENSE (GPL) Version 2

//==================   SQL compatibilty functions ===================//
// These are put in for SQL compatibility
// As of PFv1.0, they return empty SQL sets

int SQL_ERROR = 0;
int SQL_SUCCESS = 1;

void SQLExecDirect(string sSQL) { }
int SQLFetch() {return SQL_SUCCESS; }
string SQLGetData(int iCol) { return "" ; }

