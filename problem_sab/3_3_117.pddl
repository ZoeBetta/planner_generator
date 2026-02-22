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
  s11 - stairs
  s21 - stairs
  r00f1 - location
  r01f1 - location
  r02f1 - location
  r10f1 - location
  r11f1 - location
  r12f1 - location
  r20f1 - location
  r21f1 - location
  r22f1 - location
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
  (robot_at spot r02f1)
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
  (connected r11f0 r10f0)
  (connected r10f0 r11f0)
  (connected r21f0 r11f0)
  (connected r11f0 r21f0)
  (connected r22f0 r12f0)
  (connected r12f0 r22f0)
  (connected r21f0 r20f0)
  (connected r20f0 r21f0)
  (connected r22f0 r21f0)
  (connected r21f0 r22f0)
  (connected r10f1 r00f1)
  (connected r00f1 r10f1)
  (connected r01f1 r00f1)
  (connected r00f1 r01f1)
  (connected r11f1 r01f1)
  (connected r01f1 r11f1)
  (connected r12f1 r02f1)
  (connected r02f1 r12f1)
  (connected r20f1 r10f1)
  (connected r10f1 r20f1)
  (connected r11f1 r10f1)
  (connected r10f1 r11f1)
  (connected r21f1 r11f1)
  (connected r11f1 r21f1)
  (connected r12f1 r11f1)
  (connected r11f1 r12f1)
  (connected r22f1 r12f1)
  (connected r12f1 r22f1)
  (connected r21f1 r20f1)
  (connected r20f1 r21f1)
  (connected r22f1 r21f1)
  (connected r21f1 r22f1)
  (connected exit r00f0)
  (connected r00f0 exit)
  (door_notchecked r00f0)
  (person_detected p1 r00f0)
  (door_notchecked r01f0)
  (door_notchecked r02f0)
  (door_closed r10f0)
  (door_closed r11f0)
  (door_closed r12f0)
  (door_notchecked r20f0)
  (door_closed r21f0)
  (person_detected p2 r21f0)
  (door_notchecked r22f0)
  (door_notchecked r00f1)
  (person_detected p3 r00f1)
  (door_closed r01f1)
  (door_notchecked r02f1)
  (person_detected p4 r02f1)
  (door_notchecked r10f1)
  (door_notchecked r11f1)
  (person_detected p5 r11f1)
  (door_notchecked r12f1)
  (person_detected p6 r12f1)
  (door_notchecked r20f1)
  (person_detected p7 r20f1)
  (door_notchecked r21f1)
  (door_notchecked r22f1)
  (stairs_connected r02f0 s21)
  (stairs_connected r02f1 s21)
)

(:goal
(and
  (person_evaluated p1) 
  (person_reported p1) 
  (dialog_finished p1) 
  (searched spot r00f0) 
  (environment_checked r00f0) 
  (searched spot r02f0) 
  (environment_checked r02f0) 
  (searched spot r10f0) 
  (environment_checked r10f0) 
  (searched spot r11f0) 
  (environment_checked r11f0) 
  (searched spot r12f0) 
  (environment_checked r12f0) 
  (searched spot r20f0) 
  (environment_checked r20f0) 
  (person_evaluated p2) 
  (person_reported p2) 
  (dialog_finished p2) 
  (searched spot r21f0) 
  (environment_checked r21f0) 
  (searched spot r22f0) 
  (environment_checked r22f0) 
  (person_evaluated p3) 
  (person_reported p3) 
  (dialog_finished p3) 
  (searched spot r00f1) 
  (environment_checked r00f1) 
  (searched spot r01f1) 
  (environment_checked r01f1) 
  (person_evaluated p4) 
  (person_reported p4) 
  (dialog_finished p4) 
  (searched spot r02f1) 
  (environment_checked r02f1) 
  (searched spot r10f1) 
  (environment_checked r10f1) 
  (person_evaluated p5) 
  (person_reported p5) 
  (dialog_finished p5) 
  (person_evaluated p6) 
  (person_reported p6) 
  (dialog_finished p6) 
  (searched spot r12f1) 
  (environment_checked r12f1) 
  (person_evaluated p7) 
  (person_reported p7) 
  (dialog_finished p7) 
  (searched spot r20f1) 
  (environment_checked r20f1) 
  (searched spot r21f1) 
  (environment_checked r21f1) 
)
))