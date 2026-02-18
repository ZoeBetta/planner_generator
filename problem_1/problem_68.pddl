(define (problem spot_problem_68)
  (:domain simple)

(:objects
  spot - robot
  exit - location
  r00f0 - location
  r01f0 - location
  r02f0 - location
  r10f0 - location
  r11f0 - location
  r12f0 - location
  r20f0 - location
  r21f0 - location
  r22f0 - location
)

(:init
  (is_exit exit)
  (is_free spot)
  (battery_checked spot)
  (robot_at spot r01f0)
  (emergency spot)
  (connected r10f0 r00f0)
  (connected r00f0 r10f0)
  (connected r01f0 r00f0)
  (connected r00f0 r01f0)
  (connected r11f0 r01f0)
  (connected r01f0 r11f0)
  (connected r02f0 r01f0)
  (connected r01f0 r02f0)
  (connected r12f0 r02f0)
  (connected r02f0 r12f0)
  (connected r20f0 r10f0)
  (connected r10f0 r20f0)
  (connected r11f0 r10f0)
  (connected r10f0 r11f0)
  (connected r21f0 r11f0)
  (connected r11f0 r21f0)
  (connected r12f0 r11f0)
  (connected r11f0 r12f0)
  (connected r22f0 r12f0)
  (connected r12f0 r22f0)
  (connected r21f0 r20f0)
  (connected r20f0 r21f0)
  (connected r22f0 r21f0)
  (connected r21f0 r22f0)
  (connected exit r00f0)
  (connected r00f0 exit)
  (door_notchecked r00f0)
  (door_notchecked r01f0)
  (door_notchecked r02f0)
  (door_notchecked r10f0)
  (door_notchecked r11f0)
  (door_notchecked r12f0)
  (door_blocked r20f0)
  (door_notchecked r21f0)
  (door_notchecked r22f0)
)

(:goal
(and
  (searched spot r00f0) 
  (environment_checked r00f0) 
  (searched spot r01f0) 
  (environment_checked r01f0) 
  (searched spot r02f0) 
  (environment_checked r02f0) 
  (searched spot r10f0) 
  (environment_checked r10f0) 
  (searched spot r11f0) 
  (environment_checked r11f0) 
  (searched spot r12f0) 
  (environment_checked r12f0) 
  (searched spot r20f0) 
  (searched spot r21f0) 
  (environment_checked r21f0) 
  (searched spot r22f0) 
  (environment_checked r22f0) 
)
))