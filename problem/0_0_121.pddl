(define (problem spot_problem)
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
)

(:init
  (is_exit exit)
  (is_free spot)
  (battery_checked spot)
  (robot_at spot r02f0)
  (not_emergency spot)
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
  (person_detected p1 r01f0)
  (door_notchecked r02f0)
  (person_detected p2 r02f0)
  (door_notchecked r10f0)
  (door_notchecked r11f0)
  (door_notchecked r12f0)
  (person_detected p3 r12f0)
  (door_notchecked r20f0)
  (person_detected p4 r20f0)
  (door_notchecked r21f0)
  (door_notchecked r22f0)
  (person_detected p5 r22f0)
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
  (searched spot r02f0) 
  (environment_checked r02f0) 
  (searched spot r10f0) 
  (environment_checked r10f0) 
  (searched spot r11f0) 
  (environment_checked r11f0) 
  (person_evaluated p3) 
  (person_reported p3) 
  (dialog_finished p3) 
  (searched spot r12f0) 
  (environment_checked r12f0) 
  (person_evaluated p4) 
  (person_reported p4) 
  (dialog_finished p4) 
  (searched spot r21f0) 
  (environment_checked r21f0) 
  (person_evaluated p5) 
  (person_reported p5) 
  (dialog_finished p5) 
  (searched spot r22f0) 
  (environment_checked r22f0) 
)
))