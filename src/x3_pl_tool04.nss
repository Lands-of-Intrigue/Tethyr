/*
Numos' Minion Command Tool v1.0

This sytem allows PCs to direct followers using the feat PlayerTool01. Requires an NWN 1.69, and for PCs to have a creature skin attached.

INSTALLATION
1) Import nu_minion.erf
2) Overwrite x3_pl_tool01
3) Add the following line to your OnClientEnter. This will attach the feat PlayerTool01 to PC Skins:

ExecuteScript("nu_minion_oce", GetEnteringObject());

If you're using PlayerTool01 for another purpose, simply paste the source code to another PlayerTool and give it to players as a feat.

USEAGE
1) Use PlayerTool01 on a follower (Animal Companion, Familiar, Henchman, Summon) to select it.
2) Use PlayerTool01 on location to make the chosen follower walk to it.
3) Use PlayerTool01 on an object to make the chosen follower attack it.
4) Use PlayerTool01 on yourself to regroup all followers at your location.

Scripts:
-nu_minion_oce
-x3_pl_tool01
*/

void main()
{
    object oUser = OBJECT_SELF;
    //SendMessageToPC(oUser, "Player Tool 01 activated.");
    object oTarget = GetSpellTargetObject();
    location lTarget = GetSpellTargetLocation();
    object oAssociate = GetLocalObject(oUser, "nu_minion");

    if (oTarget == oUser)
    {
        object oMinion = GetFirstFactionMember(oUser, FALSE);
        while (GetIsObjectValid(oMinion))
        {
            if (GetMaster(oMinion) == oUser)
            {
                AssignCommand(oMinion, JumpToLocation(GetLocation(oUser)));
            }
            oMinion = GetNextFactionMember(oUser, FALSE);
        }
        SendMessageToPC(oUser, "Command Minion: Regrouping");
    }
    else if (GetIsObjectValid(oTarget) && GetMaster(oTarget) == oUser)
    {
        SetLocalObject(oUser, "nu_minion", oTarget);
        SendMessageToPC(oUser, "Command Minion: " + GetName(oTarget));
    }
    else if (GetIsObjectValid(oTarget) && GetIsObjectValid(oAssociate) && GetMaster(oTarget) != oUser)
    {
        AssignCommand(oAssociate, ClearAllActions());
        AssignCommand(oAssociate, ActionAttack(oTarget));
        SendMessageToPC(oUser, "Command Minion: Attacking " + GetName(oTarget));
    }
    else if (!GetIsObjectValid(oTarget) && GetIsObjectValid(oAssociate))
    {
        AssignCommand(oAssociate, ClearAllActions());
        AssignCommand(oAssociate, ActionMoveToLocation(lTarget, TRUE));
        SendMessageToPC(oUser, "Command Minion: Moving");
    }
    else if (!GetIsObjectValid(oAssociate))
    {
        SendMessageToPC(oUser, "Command Minion: Failed! No Associate was selected.");
    }
    else
    {
        SendMessageToPC(oUser, "Command Minion: Failed!");
    }
}
