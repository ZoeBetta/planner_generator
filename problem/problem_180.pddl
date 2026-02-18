(define (problem spot_problem_180)
  (:domain simple)

(:objects
  spot - robot
  exit - location
  r00f0 - location
  r01f0 - location
  r10f0 - location
  r11f0 - location
  s11 - stairs
  s21 - stairs
  r00f1 - location
  r01f1 - location
  r10f1 - location
  r11f1 - location
  s12 - stairs
  s22 - stairs
  r00f2 - location
  r01f2 - location
  r10f2 - location
  r11f2 - location
)

(:init
  (is_exit exit)
  (is_free spot)
  (battery_checked spot)
  (robot_at spot r01f2)
  (not_emergency spot)
  (connected r10f0 r00f0)
  (connected r00f0 r10f0)
  (connected r01f0 r00f0)
  (connected r00f0 r01f0)
  (connected r11f0 r01f0)
  (connected r01f0 r11f0)
  (connected r11f0 r10f0)
  (connected r10f0 r11f0)
  (connected r10f1 r00f1)
  (connected r00f1 r10f1)
  (connected r01f1 r00f1)
  (connected r00f1 r01f1)
  (connected r11f1 r10f1)
  (connected r10f1 r11f1)
  (connected r10f2 r00f2)
  (connected r00f2 r10f2)
  (connected r01f2 r00f2)
  (connected r00f2 r01f2)
  (connected r11f2 r01f2)
  (connected r01f2 r11f2)
  (connected r11f2 r10f2)
  (connected r10f2 r11f2)
  (connected exit r00f0)
  (connected r00f0 exit)
  (door_notchecked r00f0)
  (door_closed r01f0)
  (door_notchecked r10f0)
  (door_notchecked r11f0)
  (door_notchecked r00f1)
  (door_closed r01f1)
  (door_notchecked r10f1)
  (door_closed r11f1)
  (door_notchecked r00f2)
  (door_closed r01f2)
  (door_notchecked r10f2)
  (door_notchecked r11f2)
  (stairs_connected r00f0 s11)
  (stairs_connected r00f1 s11)
  (stairs_connected r01f0 s21)
  (stairs_connected r01f1 s21)
  (stairs_connected r00f1 s12)
  (stairs_connected r00f2 s12)
  (stairs_connected r01f1 s22)
  (stairs_connected r01f2 s22)
)

(:goal
(and
  (searched spot r00f0) 
  (environment_checked r00f0) 
  (searched spot r01f0) 
  (environment_checked r01f0) 
  (searched spot r10f0) 
  (environment_checked r10f0) 
  (searched spot r01f1) 
  (environment_checked r01f1) 
  (searched spot r10f1) 
  (environment_checked r10f1) 
  (searched spot r11f1) 
  (environment_checked r11f1) 
  (searched spot r00f2) 
  (environment_checked r00f2) 
  (searched spot r01f2) 
  (environment_checked r01f2) 
  (searched spot r10f2) 
  (environment_checked r10f2) 
  (searched spot r11f2) 
  (environment_checked r11f2) 
)
))