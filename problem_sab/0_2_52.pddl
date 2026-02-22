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
  s12 - stairs
  s22 - stairs
  r00f2 - location
  r01f2 - location
  r02f2 - location
  r10f2 - location
  r11f2 - location
  r12f2 - location
  r20f2 - location
  r21f2 - location
  r22f2 - location
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
  (robot_at spot r21f2)
  (emergency spot)
  (connected r10f0 r00f0)
  (connected r00f0 r10f0)
  (connected r01f0 r00f0)
  (connected r00f0 r01f0)
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
  (connected r10f1 r00f1)
  (connected r00f1 r10f1)
  (connected r01f1 r00f1)
  (connected r00f1 r01f1)
  (connected r11f1 r01f1)
  (connected r01f1 r11f1)
  (connected r02f1 r01f1)
  (connected r01f1 r02f1)
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
  (connected r10f2 r00f2)
  (connected r00f2 r10f2)
  (connected r01f2 r00f2)
  (connected r00f2 r01f2)
  (connected r11f2 r01f2)
  (connected r01f2 r11f2)
  (connected r02f2 r01f2)
  (connected r01f2 r02f2)
  (connected r12f2 r02f2)
  (connected r02f2 r12f2)
  (connected r11f2 r10f2)
  (connected r10f2 r11f2)
  (connected r21f2 r11f2)
  (connected r11f2 r21f2)
  (connected r12f2 r11f2)
  (connected r11f2 r12f2)
  (connected r22f2 r12f2)
  (connected r12f2 r22f2)
  (connected r22f2 r21f2)
  (connected r21f2 r22f2)
  (connected exit r00f0)
  (connected r00f0 exit)
  (door_notchecked r00f0)
  (door_notchecked r01f0)
  (person_detected p1 r01f0)
  (door_notchecked r02f0)
  (person_detected p2 r02f0)
  (door_notchecked r10f0)
  (door_closed r11f0)
  (door_notchecked r12f0)
  (door_notchecked r20f0)
  (door_notchecked r21f0)
  (door_notchecked r22f0)
  (person_detected p3 r22f0)
  (door_closed r00f1)
  (door_notchecked r01f1)
  (person_detected p4 r01f1)
  (door_notchecked r02f1)
  (person_detected p5 r02f1)
  (door_notchecked r10f1)
  (door_notchecked r11f1)
  (person_detected p6 r11f1)
  (door_notchecked r12f1)
  (door_notchecked r20f1)
  (door_notchecked r21f1)
  (door_blocked r22f1)
  (person_detected p7 r22f1)
  (door_notchecked r00f2)
  (door_notchecked r01f2)
  (door_notchecked r02f2)
  (door_notchecked r10f2)
  (door_notchecked r11f2)
  (door_notchecked r12f2)
  (door_notchecked r20f2)
  (person_detected p8 r20f2)
  (door_notchecked r21f2)
  (door_notchecked r22f2)
  (person_detected p9 r22f2)
  (stairs_connected r02f0 s21)
  (stairs_connected r02f1 s21)
  (stairs_connected r00f1 s12)
  (stairs_connected r00f2 s12)
  (stairs_connected r02f1 s22)
  (stairs_connected r02f2 s22)
)

(:goal
(and
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
  (searched spot r12f0) 
  (environment_checked r12f0) 
  (searched spot r20f0) 
  (environment_checked r20f0) 
  (person_evaluated p3) 
  (person_reported p3) 
  (dialog_finished p3) 
  (searched spot r22f0) 
  (environment_checked r22f0) 
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
  (searched spot r02f1) 
  (environment_checked r02f1) 
  (searched spot r10f1) 
  (environment_checked r10f1) 
  (person_evaluated p6) 
  (person_reported p6) 
  (dialog_finished p6) 
  (searched spot r11f1) 
  (environment_checked r11f1) 
  (searched spot r20f1) 
  (environment_checked r20f1) 
  (searched spot r21f1) 
  (environment_checked r21f1) 
  (searched spot r00f2) 
  (environment_checked r00f2) 
  (searched spot r01f2) 
  (environment_checked r01f2) 
  (searched spot r02f2) 
  (environment_checked r02f2) 
  (searched spot r10f2) 
  (environment_checked r10f2) 
  (searched spot r11f2) 
  (environment_checked r11f2) 
  (person_evaluated p8) 
  (person_reported p8) 
  (dialog_finished p8) 
  (searched spot r20f2) 
  (environment_checked r20f2) 
  (searched spot r21f2) 
  (environment_checked r21f2) 
  (person_evaluated p9) 
  (person_reported p9) 
  (dialog_finished p9) 
  (searched spot r22f2) 
  (environment_checked r22f2) 
)
))