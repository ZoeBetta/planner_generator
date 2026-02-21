#!/usr/bin/env python3

## @package spot_apf
# 
# \file ray.py
# \brief this node casts rays to retreive obstacles position
#
# author Zoe Betta
# version 1.0
# date 09/05/2025
# \details
# 
# Subscribes to: <BR>
# 
#
# Publishes to: <BR>
#    /obstacle_marker
#
# Client: <BR>
# 
#
# Action Service: <BR>
# 
#
# Parameters: <BR>
# angle: angle of the rays
# 
# Description: <BR>
#  This node connects to the spot robot and, using its SDK it casts ray every "angle" degrees to collect the position of the obstacles around the robot in the body frame
# 
import argparse
import numpy as np
import math
import random
#from scipy.stats import qmc
from openpyxl import Workbook



def problem(ws, seed, rng, problem_file, floor, roomxfloor, blockedlinks, closeddoors, blockeddoors, people, visited_rooms, broken_stairs):
    #print(f"\nGenerating problem {i+1}...")
    rows=int(math.sqrt(int(roomxfloor)))
    file = open(problem_file, "w")
    #file_goal = open(goal_file, "w")
    file.write(f"(define (problem spot_problem)\n")
    file.write("  (:domain simple)\n\n")
    objects=[]
    init=[]
    goal=[]
    objects.append("spot - robot")
    objects.append("exit - location")
    init.append("(is_exit exit)")
    init.append("(is_free spot)")
    init.append("(battery_checked spot)")
    rooms= np.empty((int(floor), int(rows), int(rows)), dtype=object)
    for j in range(int(floor)):
        if j!=0:
            objects.append("s1"+str(j)+" - stairs")
            objects.append("s2"+str(j)+" - stairs")
        for k in range(int(rows)):
            for l in range(int(rows)):
                rooms[j][k][l] = "r"+str(k)+str(l)+"f"+str(j)
                name="r"+str(k)+str(l)+"f"+str(j)
                objects.append(name+" - location")
    # dove parte il robot
    start= rng.choice(rooms.flatten())
    #file.write(f'problem_expert_->addPredicate(plansys2::Predicate("(robot_at spot {start})"));\n')
    init.append("(robot_at spot "+start+")")
    emergency= rng.choice(['y', 'n'])
    if emergency=="y":
        init.append("(emergency spot)")
    else:
        init.append("(not_emergency spot)")
    # connessioni
    number_link= int(rows)*(int(rows)-1)*2*int(floor)
    blocked_link_number= int(number_link*int(blockedlinks)/100)
    block_link= random.sample(range(0, number_link), blocked_link_number)
    #print(block_link)
    counter=0
    for i in range(int(floor)):
        for j in range(int(rows)):
            for k in range(int(rows)):
                if j!=int(rows)-1:
                    if counter not in block_link:
                        #file.write(f'problem_expert_->addPredicate(plansys2::Predicate("(connected {rooms[i][j+1][k]} {rooms[i][j][k]})"));\n')
                        init.append("(connected "+rooms[i][j+1][k]+" "+rooms[i][j][k]+")")
                        init.append("(connected "+rooms[i][j][k]+" "+rooms[i][j+1][k]+")")
                        #file.write(f'problem_expert_->addPredicate(plansys2::Predicate("(connected {rooms[i][j][k]} {rooms[i][j+1][k]})"));\n')
                    counter+=1
                if k!=int(rows)-1:
                    if counter not in block_link:
                        init.append("(connected "+rooms[i][j][k+1]+" "+rooms[i][j][k]+")")
                        init.append("(connected "+rooms[i][j][k]+" "+rooms[i][j][k+1]+")")
                        #file.write(f'problem_expert_->addPredicate(plansys2::Predicate("(connected {rooms[i][j][k+1]} {rooms[i][j][k]})"));\n')
                        #file.write(f'problem_expert_->addPredicate(plansys2::Predicate("(connected {rooms[i][j][k]} {rooms[i][j][k+1]})"));\n')
                    counter+=1
    #file.write(f'problem_expert_->addPredicate(plansys2::Predicate("(connected exit {rooms[0][0][0]})"));\n')
    init.append("(connected exit "+rooms[0][0][0]+")")
    init.append("(connected "+rooms[0][0][0]+" exit)")
    #file.write(f'problem_expert_->addPredicate(plansys2::Predicate("(connected {rooms[0][0][0]} exit)"));\n')
    # doors blocked and closed
    number_rooms= int(rows)*int(rows)*int(floor)
    blocked_doors_number= int(number_rooms*int(blockeddoors)/100)
    closed_doors_number= int(number_rooms*int(closeddoors)/100)
    block_close= random.sample(range(0, number_rooms), blocked_doors_number+closed_doors_number)
    block= block_close[:blocked_doors_number]
    close= block_close[blocked_doors_number:]
    people_where=random.choices(range(0, number_rooms), k=int(people))
    for i in range(int(people)):
        #file.write(f'problem_expert_->addInstance(plansys2::Instance{{"p{i+1}", "person"}});\n')
        objects.append("p"+str(i+1)+" - person")
    counter=0
    people_counter=1
    visited_rooms_number= int(number_rooms*int(visited_rooms)/100)
    visited_rooms_list= random.sample(range(0, number_rooms), visited_rooms_number)
    for i in range(int(floor)):
        for j in range(int(rows)):
            for k in range(int(rows)):
                if counter in block:
                    #file.write(f'problem_expert_->addPredicate(plansys2::Predicate("(door_blocked {rooms[i][j][k]})"));\n')
                    init.append("(door_blocked "+rooms[i][j][k]+")")
                elif counter in close:
                    #file.write(f'problem_expert_->addPredicate(plansys2::Predicate("(door_closed {rooms[i][j][k]})"));\n')
                    init.append("(door_closed "+rooms[i][j][k]+")")
                else:
                    #file.write(f'problem_expert_->addPredicate(plansys2::Predicate("(door_notchecked {rooms[i][j][k]})"));\n')
                    init.append("(door_notchecked "+rooms[i][j][k]+")")
                if counter in people_where:
                    #file.write(f'problem_expert_->addPredicate(plansys2::Predicate("(person_detected p{people_counter} {rooms[i][j][k]})"));\n')
                    init.append("(person_detected p"+str(people_counter)+" "+rooms[i][j][k]+")")
                    if counter not in block:
                        goal.append("(person_evaluated p"+str(people_counter)+") ")
                        goal.append("(person_reported p"+str(people_counter)+") ")
                        goal.append("(dialog_finished p"+str(people_counter)+") ")
                    people_counter+=1
                if counter not in visited_rooms_list:
                    goal.append("(searched spot "+rooms[i][j][k]+") ")
                    if counter not in block:
                        goal.append("(environment_checked "+rooms[i][j][k]+") ")
                counter+=1
    stairs_number= (int(floor)-1)*2
    #broken_stairs_number= int(stairs_number*int(broken_stairs)/100)
    while broken_stairs>(stairs_number/2):
        broken_stairs=int(broken_stairs/2)
    broken_stairs_list= random.sample(range(0, stairs_number), int(broken_stairs))
    counter=0
    for i in range(1, int(floor)):
        if counter not in broken_stairs_list:
            #file.write(f'problem_expert_->addPredicate(plansys2::Predicate("(stairs_connected {rooms[i-1][0][0]} s1{i})"));\n')
            init.append("(stairs_connected "+rooms[i-1][0][0]+" s1"+str(i)+")")
            #file.write(f'problem_expert_->addPredicate(plansys2::Predicate("(stairs_connected {rooms[i][0][0]} s1{i})"));\n')
            init.append("(stairs_connected "+rooms[i][0][0]+" s1"+str(i)+")")
        counter+=1
        if counter not in broken_stairs_list:
            #file.write(f'problem_expert_->addPredicate(plansys2::Predicate("(stairs_connected {rooms[i-1][0][int(rows)-1]} s2{i})"));\n')
            init.append("(stairs_connected "+rooms[i-1][0][int(rows)-1]+" s2"+str(i)+")")
            init.append("(stairs_connected "+rooms[i][0][int(rows)-1]+" s2"+str(i)+")")
            #file.write(f'problem_expert_->addPredicate(plansys2::Predicate("(stairs_connected {rooms[i][0][int(rows)-1]} s2{i})"));\n')
        counter+=1
    file.write("(:objects\n")
    for obj in objects:
        file.write(f"  {obj}\n")
    file.write(")\n\n")
    file.write("(:init\n")
    for ini in init:
        file.write(f"  {ini}\n")
    file.write(")\n\n")
    file.write("(:goal\n")
    file.write("(and\n")
    for go in goal:
        file.write(f"  {go}\n")
    file.write(")\n")
    file.write(")")
    file.write(")")
    goal_number=len(goal)
    init_number=len(init)
    objects_number=len(objects)
    ws.append([
            problem_file,
            seed,
            floor,
            roomxfloor,
            blockedlinks,
            start,
            closeddoors,
            blockeddoors,
            people,
            emergency,
            visited_rooms,
            broken_stairs,
            objects_number,
            init_number,
            goal_number
    ])
    file.close()


def main():
    seed = input("Enter the seed number for randomness: ")
    while not seed.isdigit():
        print("Please enter a valid number.")
        seed = input("Enter the seed number for randomness: ")
    rng = np.random.default_rng(seed=int(seed))
    random.seed(int(seed)) 
    wb = Workbook()
    ws = wb.active
    ws.title = "Problems Log"
    ws.append([
    "Problem",
    "Seed",
    "Floor",
    "Rooms per floor",
    "Blocked links (%)",
    "Initial position",
    "Closed doors (%)",
    "Blocked doors (%)",
    "People",
    "Emergency",
    "Visited rooms (%)",
    "Broken stairs",
    "predicates", 
    "init",
    "goal"
    ])

    values= [
        [1,2,3,4],
        [4, 9, 16,25],
        [0, 5, 10, 15],
        [0, 10, 20,30],
        [0, 5,10, 15],
        [0, 5, 10, 15, 20],
        [0, 10,20 ,30],
        [0,1,2]
    ]

    n=150
    for i in range(len(values)):
        for j in range(len(values[i])):
            for k in range(n):
                average=[[2], [9], [10], [10], [5], [10], [20], [1]]
                average[i][0]= values[i][j]
                problem(ws, seed, rng, f"problem/{i}_{j}_{k}.pddl", average[0][0], average[1][0], average[2][0], average[3][0], average[4][0], average[5][0], average[6][0], average[7][0])
                print(f"Generated problem_{i}{j}{k}.pddl with parameter {average}")


    wb.save("prova_log.xlsx")


if __name__ == "__main__":
    main()
