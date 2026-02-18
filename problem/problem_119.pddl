(define (problem spot_problem_119)
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
)

(:init
  (is_exit exit)
  (is_free spot)
  (battery_checked spot)
  (robot_at spot r00f1)
  (emergency spot)
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
  (connected r11f1 r01f1)
  (connected r01f1 r11f1)
  (connected r11f1 r10f1)
  (connected r10f1 r11f1)
  (connected exit r00f0)
  (connected r00f0 exit)
  (door_notchecked r00f0)
  (door_notchecked r01f0)
  (door_notchecked r10f0)
  (door_notchecked r11f0)
  (door_notchecked r00f1)
  (door_closed r01f1)
  (door_notchecked r10f1)
  (door_notchecked r11f1)
  (stairs_connected r00f0 s11)
  (stairs_connected r00f1 s11)
  (stairs_connected r01f0 s21)
  (stairs_connected r01f1 s21)
)

(:goal
(and
  (searched spot r00f0) 
  (environment_checked r00f0) 
  (searched spot r01f0) 
  (environment_checked r01f0) 
  (searched spot r10f0) 
  (environment_checked r10f0) 
  (searched spot r11f0) 
  (environment_checked r11f0) 
  (searched spot r00f1) 
  (environment_checked r00f1) 
  (searched spot r01f1) 
  (environment_checked r01f1) 
  (searched spot r10f1) 
  (environment_checked r10f1) 
  (searched spot r11f1) 
  (environment_checked r11f1) 
)
))