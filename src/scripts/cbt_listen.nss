void main()
{
    // Get the number
    int nMatch = GetListenPatternNumber();
    if(nMatch == 19781)
    {
        if(GetName(GetLastSpeaker())==GetLocalString(OBJECT_SELF, "character") )
        {
            string sSpoken = GetMatchedSubstring(0);
            SetDescription(GetNearestObjectByTag("sceneofinterest"), sSpoken);
            SendMessageToPC(GetLastSpeaker(), "Description is set.");
            DestroyObject(OBJECT_SELF);
        }
    }
}
