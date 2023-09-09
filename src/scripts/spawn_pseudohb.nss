//
// NESS V8.1
//
// Spawn Pseudo-heartbeat
//
// This script is executed when a PC enters an otherwise empty area
//

#include "spawn_functions"
#include "spawn_main"

void main()
{
  // No pseudo-heartbeats scheduled, since we just fired this one
  SetLocalInt( OBJECT_SELF, SPAWN_HEARTBEAT_SCHEDULED, FALSE );

  // Do a heartbeat if there are PCs in the area or any spawns up
  if ( NeedPseudoHeartbeat( OBJECT_SELF ) )
  {
    // start actual heartbeat code
    Spawn();
    // end actual heartbeat code

    // This function sets SPAWN_HEARTBEAT_SCHEDULED to TRUE
    ScheduleNextPseudoHeartbeat( OBJECT_SELF );
  }
}
