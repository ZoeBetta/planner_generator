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
            i + 1,
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
        [1,2,3],
        [4, 9, 16,25],
        [0, 5, 10, 15],
        [0, 10, 30],
        [0, 5,10],
        [0, 5, 10, 15],
        [10,20 ,30],
        [0,1,2]
    ]

    n=10
    for i in range(len(values)):
        for j in range(len(values[i])):
            for k in range(n):
                average=[[2], [9], [10], [10], [5], [10], [20], [1]]
                average[i][0]= values[i][j]
                problem(ws, seed, rng, f"problem/problem_{i}{j}{k}.pddl", average[0][0], average[1][0], average[2][0], average[3][0], average[4][0], average[5][0], average[6][0], average[7][0])
                print(f"Generated problem_{i}{j}{k}.pddl with parameter {average}")

    """ 
    d = len(values)
    n_samples=10
    sampler = qmc.LatinHypercube(d=d, seed= int(seed))
    lhs_samples = sampler.random(n=n_samples)
    discrete_samples= []
    for i in range(n_samples):
        point=[]
        for j in range(d):
            val = values[j]
            idx= int(lhs_samples[i][j] * len(val))
            idx= min(idx, len(val)-1)
            point.append(val[idx])
        discrete_samples.append(point)
    discrete_samples= np.array(discrete_samples)
    print("Generated samples:")
    print(discrete_samples)

    for i in range(len(discrete_samples)):
        problem(ws, seed, rng, f"problem/problem_{i}0.pddl", discrete_samples[i][0], discrete_samples[i][1], discrete_samples[i][2], discrete_samples[i][3], discrete_samples[i][4], discrete_samples[i][5], discrete_samples[i][6], discrete_samples[i][7])
        print(f"Generated problem_{i}0.pddl with parameters: {discrete_samples[i]}")
        for j in range(len(discrete_samples[i])):
            sign= random.choice(["+", "-"])
            index= values[j].index(discrete_samples[i][j])
            if index==0:
                sign= "+"
            elif index== len(values[j])-1:
                sign= "-"
            if sign=="+":
                new_index= min(index+1, len(values[j])-1)
            else:
                new_index= max(index-1, 0)
            discrete_samples[i][j]= values[j][new_index]
            problem(ws, seed, rng, f"problem/problem_{i}{j+1}.pddl", discrete_samples[i][0], discrete_samples[i][1], discrete_samples[i][2], discrete_samples[i][3], discrete_samples[i][4], discrete_samples[i][5], discrete_samples[i][6], discrete_samples[i][7])   
            print(f"Generated problem_{i}{j+1}.pddl with parameter {discrete_samples[i]}") """
    wb.save("prova_log.xlsx")

""" 
    problem_number = input("Enter the number of problems to generate: ")
    while not problem_number.isdigit():
        print("Please enter a valid number.")
        problem_number = input("Enter the number of problems to generate: ")
    seed = input("Enter the seed number for randomness: ")
    while not seed.isdigit():
        print("Please enter a valid number.")
        seed = input("Enter the seed number for randomness: ")
    #floor = input("Enter the number of floors: ")
    floor_possible=[1,2,3,4]
    #while not floor.isdigit():
       # print("Please enter a valid number.")
        #loor = input("Enter the number of floors: ")
    #roomxfloor = input("Enter the number of rooms x floor (4, 9, 16, 25): ")
    room_possible=[4,9,16,25]
    #while not roomxfloor.isdigit():
     #   print("Please enter a valid number.")
    #    roomxfloor = input("Enter the number of rooms x floor: ")
    #blockedlinks = input("Enter the percentage of blocked links: ")
    blocked_possible=[0,5, 10, 15]
    #while not blockedlinks.isdigit():
    #    print("Please enter a valid number.")
    #    blockedlinks = input("Enter the percentage of blocked links: ") 
    initialposition = input("Enter the initial position (room number ex r11f3 if room of floor 4), if 0 random start: ")
    #closeddoors = input("Enter the percentage of closed doors: ")
    closed_possible=[0, 10,20 , 30 ,40]
    #while not closeddoors.isdigit():
    #    print("Please enter a valid number.")
    #    closeddoors = input("Enter the percentage of closed doors: ")
    #blockeddoors = input("Enter the percentage of blocked doors: ")
    blockeddoor_possible=[0, 5, 10, 15, 20]
    #while not blockeddoors.isdigit():
    #    print("Please enter a valid number.")
    #    blockeddoors = input("Enter the percentage of blocked doors: ")
    #people = input("Enter the number of people in the environment: ")
    people_possible=[0, 5, 10, 15]
    #while not people.isdigit():
    #    print("Please enter a valid number.")
    #    people = input("Enter the number of people in the environment: ")
    emergency= input("Is there an emergency? (y/n), if 0 random: ")
    while emergency.lower() not in ['y', 'n', '0']:
        print("Please enter 'y', 'n', or '0'.")
        emergency = input("Is there an emergency? (y/n) if 0 random: ")
    #visited_rooms = input("Enter the percentage of visited rooms: ")
    visited_possible=[0, 10, 20, 30]
    #while not visited_rooms.isdigit():
    #    print("Please enter a valid number.")
    #    visited_rooms = input("Enter the percentage of visited rooms: ")
    #broken_stairs = input("Enter the number of broken stairs: ")
    brokenstairs_possible=[0, 1, 2]
    #while not broken_stairs.isdigit():
    #    print("Please enter a valid number.")
    #    broken_stairs = input("Enter the number of broken stairs: ")   
    
    rng = np.random.default_rng(seed=int(seed))
    random.seed(int(seed)) 
    goal = []
    goal.append("and")
    file_log = open("problem_generation_log.txt", "a")
    for i in range(int(problem_number)):
        floor=random.choice(floor_possible)
        roomxfloor=random.choice(room_possible)
        blockedlinks=random.choice(blocked_possible)
        closeddoors=random.choice(closed_possible)
        blockeddoors=random.choice(blockeddoor_possible)
        people=random.choice(people_possible)
        visited_rooms=random.choice(visited_possible)
        broken_stairs=random.choice(brokenstairs_possible)
        emergency='0'
        initialposition='0'
        print(f"\nGenerating problem {i+1}...")
        rows=int(math.sqrt(int(roomxfloor)))
        problem_file= f"problem/problem_{i+1}.pddl"
        goal_file= f"goal_{i+1}.txt"
        file = open(problem_file, "w")
        
        file_log.write(f"Problem {i+1}:\n")
        file_log.write(f"Seed: {seed}\n")
        file_log.write(f"Floor: {floor}\n")
        file_log.write(f"Rooms per floor: {roomxfloor}\n")
        file_log.write(f"Blocked links: {blockedlinks}%\n")
        file_log.write(f"Initial position: {initialposition}\n")
        file_log.write(f"Closed doors: {closeddoors}%\n")
        file_log.write(f"Blocked doors: {blockeddoors}%\n")
        file_log.write(f"People: {people}\n")
        file_log.write(f"Emergency: {emergency}\n")
        file_log.write(f"Visited rooms: {visited_rooms}%\n")
        file_log.write(f"Broken stairs: {broken_stairs}\n")
        file_log.write("\n ---------- \n")

        #file_goal = open(goal_file, "w")
        file.write(f"(define (problem spot_problem_{i+1})\n")
        file.write("  (:domain simple)\n\n")
        objects=[]
        init=[]
        goal=[]
        #file.write(f'problem_expert_->addInstance(plansys2::Instance{{"spot", "robot"}});\n')
        objects.append("spot - robot")
        #file.write(f'problem_expert_->addInstance(plansys2::Instance{{"stand", "state"}});\n')
        #file.write(f'problem_expert_->addInstance(plansys2::Instance{{"lay", "state"}});\n')
        #file.write(f'problem_expert_->addInstance(plansys2::Instance{{"sit", "state"}});\n')
        #objects.append("stand lay sit unknown - state")
        #file.write(f'problem_expert_->addInstance(plansys2::Instance{{"unknown", "state"}});\n')
        #file.write(f'problem_expert_->addInstance(plansys2::Instance{{"conscious", "consciousness"}});\n')
        #file.write(f'problem_expert_->addInstance(plansys2::Instance{{"unconscious", "consciousness"}});\n')
        #file.write(f'problem_expert_->addInstance(plansys2::Instance{{"confused", "consciousness"}});\n')
        #objects.append("conscious unconscious confused - consciousness")
        #file.write(f'problem_expert_->addInstance(plansys2::Instance{{"exit", "location"}});\n')
        objects.append("exit - location")
        #file.write(f'problem_expert_->addPredicate(plansys2::Predicate("(is_exit exit)"));\n')
        init.append("(is_exit exit)")
        init.append("(is_free spot)")
        init.append("(battery_checked spot)")
        #file.write(f'problem_expert_->addPredicate(plansys2::Predicate("(is_free spot)"));\n')

        rooms= np.empty((int(floor), int(rows), int(rows)), dtype=object)
        for j in range(int(floor)):
            if j!=0:
                #file.write(f'problem_expert_->addInstance(plansys2::Instance{{"s1{j}", "stairs"}});\n')
                objects.append("s1"+str(j)+" - stairs")
                objects.append("s2"+str(j)+" - stairs")
                #file.write(f'problem_expert_->addInstance(plansys2::Instance{{"s2{j}", "stairs"}});\n')
            for k in range(int(rows)):
                for l in range(int(rows)):
                    rooms[j][k][l] = "r"+str(k)+str(l)+"f"+str(j)
                    name="r"+str(k)+str(l)+"f"+str(j)
                    #file.write(f'problem_expert_->addInstance(plansys2::Instance{{"{name}", "location"}});\n')
                    objects.append(name+" - location")
        # dove parte il robot
        start= rng.choice(rooms.flatten()) if initialposition=="0" else initialposition
        #file.write(f'problem_expert_->addPredicate(plansys2::Predicate("(robot_at spot {start})"));\n')
        init.append("(robot_at spot "+start+")")
        if emergency=="0":
            emergency= rng.choice(['y', 'n'])
        if emergency=="y":
            #file.write(f'problem_expert_->addPredicate(plansys2::Predicate("(emergency spot)"));\n')
            init.append("(emergency spot)")
        else:
            #file.write(f'problem_expert_->addPredicate(plansys2::Predicate("(not_emergency spot)"));\n')
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
            i + 1,
            seed,
            floor,
            roomxfloor,
            blockedlinks,
            initialposition,
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

        #goal_str= "".join(goal)
        #file_goal.write(goal_str)
        file.close()
        seed = int(seed)+1
        #file_goal.close()

    print(rooms)
    wb.save("problems_log.xlsx")
        # Here you would add the code to generate the problem based on the input parameters
        # For example, you could create a function that takes these parameters and generates a problem instance
        # generate_problem(seed, floor, roomxfloor, blockedlinks, initialposition, closeddoors, blockeddoors, people, emergency, visited_rooms, broken_stairs)


    print("\n--- Summary ---")
    print(f"Number of problems: {problem_number}")
    print(f"Seed: {seed}")
    print(f"Floor: {floor}")
    print(f"Rooms per floor: {roomxfloor}")
    print(f"Blocked links: {blockedlinks}%")
    print(f"Initial position: {initialposition}")
    print(f"Closed doors: {closeddoors}%")
    print(f"Blocked doors: {blockeddoors}%")
    print(f"People: {people}")
    print(f"Emergency: {emergency}")
    print(f"Visited rooms: {visited_rooms}%")
    print(f"Broken stairs: {broken_stairs}%")
    
 """
if __name__ == "__main__":
    main()
