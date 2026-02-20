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
  s13 - stairs
  s23 - stairs
  r00f3 - location
  r01f3 - location
  r02f3 - location
  r10f3 - location
  r11f3 - location
  r12f3 - location
  r20f3 - location
  r21f3 - location
  r22f3 - location
  s14 - stairs
  s24 - stairs
  r00f4 - location
  r01f4 - location
  r02f4 - location
  r10f4 - location
  r11f4 - location
  r12f4 - location
  r20f4 - location
  r21f4 - location
  r22f4 - location
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
  p16 - person
  p17 - person
  p18 - person
  p19 - person
  p20 - person
  p21 - person
  p22 - person
  p23 - person
  p24 - person
  p25 - person
  p26 - person
  p27 - person
  p28 - person
  p29 - person
  p30 - person
)

(:init
  (is_exit exit)
  (is_free spot)
  (battery_checked spot)
  (robot_at spot r21f0)
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
  (connected r20f2 r10f2)
  (connected r10f2 r20f2)
  (connected r11f2 r10f2)
  (connected r10f2 r11f2)
  (connected r21f2 r11f2)
  (connected r11f2 r21f2)
  (connected r12f2 r11f2)
  (connected r11f2 r12f2)
  (connected r22f2 r12f2)
  (connected r12f2 r22f2)
  (connected r21f2 r20f2)
  (connected r20f2 r21f2)
  (connected r22f2 r21f2)
  (connected r21f2 r22f2)
  (connected r10f3 r00f3)
  (connected r00f3 r10f3)
  (connected r01f3 r00f3)
  (connected r00f3 r01f3)
  (connected r11f3 r01f3)
  (connected r01f3 r11f3)
  (connected r02f3 r01f3)
  (connected r01f3 r02f3)
  (connected r12f3 r02f3)
  (connected r02f3 r12f3)
  (connected r20f3 r10f3)
  (connected r10f3 r20f3)
  (connected r11f3 r10f3)
  (connected r10f3 r11f3)
  (connected r21f3 r11f3)
  (connected r11f3 r21f3)
  (connected r12f3 r11f3)
  (connected r11f3 r12f3)
  (connected r22f3 r12f3)
  (connected r12f3 r22f3)
  (connected r21f3 r20f3)
  (connected r20f3 r21f3)
  (connected r22f3 r21f3)
  (connected r21f3 r22f3)
  (connected r10f4 r00f4)
  (connected r00f4 r10f4)
  (connected r01f4 r00f4)
  (connected r00f4 r01f4)
  (connected r11f4 r01f4)
  (connected r01f4 r11f4)
  (connected r02f4 r01f4)
  (connected r01f4 r02f4)
  (connected r12f4 r02f4)
  (connected r02f4 r12f4)
  (connected r20f4 r10f4)
  (connected r10f4 r20f4)
  (connected r11f4 r10f4)
  (connected r10f4 r11f4)
  (connected r21f4 r11f4)
  (connected r11f4 r21f4)
  (connected r12f4 r11f4)
  (connected r11f4 r12f4)
  (connected r22f4 r12f4)
  (connected r12f4 r22f4)
  (connected r21f4 r20f4)
  (connected r20f4 r21f4)
  (connected r22f4 r21f4)
  (connected r21f4 r22f4)
  (connected exit r00f0)
  (connected r00f0 exit)
  (door_notchecked r00f0)
  (door_closed r01f0)
  (person_detected p1 r01f0)
  (door_closed r02f0)
  (person_detected p2 r02f0)
  (door_closed r10f0)
  (person_detected p3 r10f0)
  (door_closed r11f0)
  (door_notchecked r12f0)
  (person_detected p4 r12f0)
  (door_closed r20f0)
  (door_closed r21f0)
  (person_detected p5 r21f0)
  (door_notchecked r22f0)
  (person_detected p6 r22f0)
  (door_blocked r00f1)
  (person_detected p7 r00f1)
  (door_closed r01f1)
  (door_closed r02f1)
  (person_detected p8 r02f1)
  (door_closed r10f1)
  (person_detected p9 r10f1)
  (door_notchecked r11f1)
  (person_detected p10 r11f1)
  (door_closed r12f1)
  (door_blocked r20f1)
  (person_detected p11 r20f1)
  (door_closed r21f1)
  (door_closed r22f1)
  (door_notchecked r00f2)
  (person_detected p12 r00f2)
  (door_closed r01f2)
  (person_detected p13 r01f2)
  (door_notchecked r02f2)
  (door_blocked r10f2)
  (person_detected p14 r10f2)
  (door_notchecked r11f2)
  (person_detected p15 r11f2)
  (door_notchecked r12f2)
  (door_closed r20f2)
  (door_blocked r21f2)
  (door_closed r22f2)
  (door_notchecked r00f3)
  (door_blocked r01f3)
  (door_blocked r02f3)
  (door_notchecked r10f3)
  (person_detected p16 r10f3)
  (door_notchecked r11f3)
  (door_blocked r12f3)
  (person_detected p17 r12f3)
  (door_closed r20f3)
  (door_blocked r21f3)
  (door_closed r22f3)
  (door_notchecked r00f4)
  (door_closed r01f4)
  (door_closed r02f4)
  (person_detected p18 r02f4)
  (door_notchecked r10f4)
  (person_detected p19 r10f4)
  (door_closed r11f4)
  (person_detected p20 r11f4)
  (door_closed r12f4)
  (person_detected p21 r12f4)
  (door_blocked r20f4)
  (door_notchecked r21f4)
  (door_closed r22f4)
  (stairs_connected r00f0 s11)
  (stairs_connected r00f1 s11)
  (stairs_connected r02f0 s21)
  (stairs_connected r02f1 s21)
  (stairs_connected r00f1 s12)
  (stairs_connected r00f2 s12)
  (stairs_connected r02f1 s22)
  (stairs_connected r02f2 s22)
  (stairs_connected r02f2 s23)
  (stairs_connected r02f3 s23)
  (stairs_connected r00f3 s14)
  (stairs_connected r00f4 s14)
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
  (person_evaluated p3) 
  (person_reported p3) 
  (dialog_finished p3) 
  (searched spot r10f0) 
  (environment_checked r10f0) 
  (searched spot r11f0) 
  (environment_checked r11f0) 
  (person_evaluated p4) 
  (person_reported p4) 
  (dialog_finished p4) 
  (searched spot r12f0) 
  (environment_checked r12f0) 
  (person_evaluated p5) 
  (person_reported p5) 
  (dialog_finished p5) 
  (person_evaluated p6) 
  (person_reported p6) 
  (dialog_finished p6) 
  (searched spot r22f0) 
  (environment_checked r22f0) 
  (searched spot r00f1) 
  (searched spot r01f1) 
  (environment_checked r01f1) 
  (person_evaluated p8) 
  (person_reported p8) 
  (dialog_finished p8) 
  (searched spot r02f1) 
  (environment_checked r02f1) 
  (person_evaluated p9) 
  (person_reported p9) 
  (dialog_finished p9) 
  (searched spot r10f1) 
  (environment_checked r10f1) 
  (person_evaluated p10) 
  (person_reported p10) 
  (dialog_finished p10) 
  (searched spot r11f1) 
  (environment_checked r11f1) 
  (searched spot r12f1) 
  (environment_checked r12f1) 
  (searched spot r20f1) 
  (searched spot r21f1) 
  (environment_checked r21f1) 
  (searched spot r22f1) 
  (environment_checked r22f1) 
  (person_evaluated p12) 
  (person_reported p12) 
  (dialog_finished p12) 
  (person_evaluated p13) 
  (person_reported p13) 
  (dialog_finished p13) 
  (searched spot r01f2) 
  (environment_checked r01f2) 
  (searched spot r10f2) 
  (person_evaluated p15) 
  (person_reported p15) 
  (dialog_finished p15) 
  (searched spot r11f2) 
  (environment_checked r11f2) 
  (searched spot r12f2) 
  (environment_checked r12f2) 
  (searched spot r20f2) 
  (environment_checked r20f2) 
  (searched spot r21f2) 
  (searched spot r22f2) 
  (environment_checked r22f2) 
  (searched spot r01f3) 
  (searched spot r02f3) 
  (person_evaluated p16) 
  (person_reported p16) 
  (dialog_finished p16) 
  (searched spot r10f3) 
  (environment_checked r10f3) 
  (searched spot r11f3) 
  (environment_checked r11f3) 
  (searched spot r12f3) 
  (searched spot r20f3) 
  (environment_checked r20f3) 
  (searched spot r22f3) 
  (environment_checked r22f3) 
  (searched spot r00f4) 
  (environment_checked r00f4) 
  (searched spot r01f4) 
  (environment_checked r01f4) 
  (person_evaluated p18) 
  (person_reported p18) 
  (dialog_finished p18) 
  (searched spot r02f4) 
  (environment_checked r02f4) 
  (person_evaluated p19) 
  (person_reported p19) 
  (dialog_finished p19) 
  (searched spot r10f4) 
  (environment_checked r10f4) 
  (person_evaluated p20) 
  (person_reported p20) 
  (dialog_finished p20) 
  (searched spot r11f4) 
  (environment_checked r11f4) 
  (person_evaluated p21) 
  (person_reported p21) 
  (dialog_finished p21) 
  (searched spot r12f4) 
  (environment_checked r12f4) 
  (searched spot r20f4) 
)
))