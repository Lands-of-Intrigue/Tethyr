    float ADDNANIM_DEFAULT_SPEED_1  = 1.0;
    float ADDNANIM_DEFAULT_SPEED_2  = 1.0;
    float ADDNANIM_DEFAULT_SPEED_3  = 1.0;
    float ADDNANIM_DEFAULT_SPEED_4  = 1.0;
    float ADDNANIM_DEFAULT_SPEED_5  = 1.5;
    float ADDNANIM_DEFAULT_SPEED_6  = 2.0;
    float ADDNANIM_DEFAULT_SPEED_7  = 1.0;
    float ADDNANIM_DEFAULT_SPEED_8  = 1.0;
    float ADDNANIM_DEFAULT_SPEED_9  = 1.5;
    float ADDNANIM_DEFAULT_SPEED_10 = 1.0;

    float ADDNANIM_DEFAULT_DURATION_1  = 1.5;
    float ADDNANIM_DEFAULT_DURATION_2  = 30.0;
    float ADDNANIM_DEFAULT_DURATION_3  = 30.0;
    float ADDNANIM_DEFAULT_DURATION_4  = 30.0;
    float ADDNANIM_DEFAULT_DURATION_5  = 3.5;
    float ADDNANIM_DEFAULT_DURATION_6  = 2.0;
    float ADDNANIM_DEFAULT_DURATION_7  = 30.0;
    float ADDNANIM_DEFAULT_DURATION_8  = 30.0;
    float ADDNANIM_DEFAULT_DURATION_9  = 8.0;
    float ADDNANIM_DEFAULT_DURATION_10 = 60.0;

void AddnAnimWrapper(int iAnimIndex, float fAnimSpeed, float fAnimDuration)
{
    // SendMessageToPC(oPC, "Playing Animation"); // Debug Line
    DelayCommand(0.1, AssignCommand(OBJECT_SELF, ClearAllActions()));
    DelayCommand(0.15, AssignCommand(OBJECT_SELF, ActionPlayAnimation(iAnimIndex, fAnimSpeed, fAnimDuration)));
    return;
}
