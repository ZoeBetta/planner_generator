(define (problem spot_problem_145)
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
  s13 - stairs
  s23 - stairs
  r00f3 - location
  r01f3 - location
  r10f3 - location
  r11f3 - location
  p1 - person
  p2 - person
  p3 - person
  p4 - person
  p5 - person
  p6 - person
  p7 - person
  p8 - person
  p9 - person
  p10 - person
  p11 - person
  p12 - person
  p13 - person
  p14 - person
  p15 - person
)

(:init
  (is_exit exit)
  (is_free spot)
  (battery_checked spot)
  (robot_at spot r10f1)
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
  (connected r10f2 r00f2)
  (connected r00f2 r10f2)
  (connected r01f2 r00f2)
  (connected r00f2 r01f2)
  (connected r11f2 r01f2)
  (connected r01f2 r11f2)
  (connected r11f2 r10f2)
  (connected r10f2 r11f2)
  (connected r10f3 r00f3)
  (connected r00f3 r10f3)
  (connected r01f3 r00f3)
  (connected r00f3 r01f3)
  (connected r11f3 r01f3)
  (connected r01f3 r11f3)
  (connected r11f3 r10f3)
  (connected r10f3 r11f3)
  (connected exit r00f0)
  (connected r00f0 exit)
  (door_closed r00f0)
  (door_closed r01f0)
  (person_detected p1 r01f0)
  (door_notchecked r10f0)
  (person_detected p2 r10f0)
  (door_notchecked r11f0)
  (person_detected p3 r11f0)
  (door_notchecked r00f1)
  (door_notchecked r01f1)
  (person_detected p4 r01f1)
  (door_notchecked r10f1)
  (person_detected p5 r10f1)
  (door_notchecked r11f1)
  (door_notchecked r00f2)
  (person_detected p6 r00f2)
  (door_notchecked r01f2)
  (person_detected p7 r01f2)
  (door_closed r10f2)
  (person_detected p8 r10f2)
  (door_notchecked r11f2)
  (door_notchecked r00f3)
  (door_blocked r01f3)
  (person_detected p9 r01f3)
  (door_notchecked r10f3)
  (door_notchecked r11f3)
  (person_detected p10 r11f3)
  (stairs_connected r01f0 s21)
  (stairs_connected r01f1 s21)
  (stairs_connected r00f1 s12)
  (stairs_connected r00f2 s12)
  (stairs_connected r01f1 s22)
  (stairs_connected r01f2 s22)
  (stairs_connected r01f2 s23)
  (stairs_connected r01f3 s23)
)

(:goal
(and
  (searched spot r00f0) 
  (environment_checked r00f0) 
  (person_evaluated p1) 
  (person_reported p1) 
  (dialog_finished p1) 
  (searched spot r01f0) 
  (environment_checked r01f0) 
  (person_evaluated p2) 
  (person_reported p2) 
  (dialog_finished p2) 
  (searched spot r10f0) 
  (environment_checked r10f0) 
  (person_evaluated p3) 
  (person_reported p3) 
  (dialog_finished p3) 
  (searched spot r11f0) 
  (environment_checked r11f0) 
  (searched spot r00f1) 
  (environment_checked r00f1) 
  (person_evaluated p4) 
  (person_reported p4) 
  (dialog_finished p4) 
  (searched spot r01f1) 
  (environment_checked r01f1) 
  (person_evaluated p5) 
  (person_reported p5) 
  (dialog_finished p5) 
  (searched spot r10f1) 
  (environment_checked r10f1) 
  (person_evaluated p6) 
  (person_reported p6) 
  (dialog_finished p6) 
  (searched spot r00f2) 
  (environment_checked r00f2) 
  (person_evaluated p7) 
  (person_reported p7) 
  (dialog_finished p7) 
  (person_evaluated p8) 
  (person_reported p8) 
  (dialog_finished p8) 
  (searched spot r11f2) 
  (environment_checked r11f2) 
  (searched spot r00f3) 
  (environment_checked r00f3) 
  (searched spot r01f3) 
  (searched spot r10f3) 
  (environment_checked r10f3) 
  (person_evaluated p10) 
  (person_reported p10) 
  (dialog_finished p10) 
  (searched spot r11f3) 
  (environment_checked r11f3) 
)
))