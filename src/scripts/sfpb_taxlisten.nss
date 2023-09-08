void main()
{
    // Set the banker to listen
    DeleteLocalString(OBJECT_SELF, "GOLD");
    SetListening(OBJECT_SELF, TRUE);
    SetListenPattern(OBJECT_SELF, "*n", 1);
}
