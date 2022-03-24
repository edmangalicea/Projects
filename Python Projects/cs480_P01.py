## -*- coding: utf-8 -*-
"""
Created on Sun Oct 17 18:20:16 2021

@author: Edman Alicea
CS 480 F2021
Programming Assignment 01
"""

import timeit
import sys
from queue import PriorityQueue
import pandas
class Problem:
   

   

    dd = pandas.read_csv("driving.csv")

    file_path = "straightline.csv"

    sld = pandas.read_csv("straightline.csv")    



    def __init__(self, init_state, goal_state): 
        self.INITIALSTATE = init_state
        self.GOALSTATE = goal_state
        
        
        
    def getInitialState(self):
        return self.INITIALSTATE
    def getGoalState(self):
        return self.GOALSTATE
    def setInitialState(self, init_state):
        self.INITIALSTATE = init_state
    def setGoalState(self, goal_state):
        self.GOALSTATE = goal_state
        
    def drivingDistance(self, init_state, next_state):  #get the driving ditance given a initial and next state
        dd = pandas.read_csv("driving.csv", index_col=0)
        ddDistance = dd.loc[init_state, next_state]
        if ddDistance == -1 or 0: #if the init state is not connected return a -1 or if it is return the distance
            return -1
        else:
            return ddDistance
        
    def straightlineDistance(self, init_state, next_state): #get the straighline distance given a initial and next state
        sld = pandas.read_csv("straightline.csv", index_col=0)  
        sldDistance = sld.loc[init_state, next_state]   
        if sldDistance == -1 or 0:  #if the init state is not connected return a -1 or if it is return the distance
            return -1
        else:
            return sldDistance
    def stateList(self, x):   #get the statelist from any specific node
            dd = pandas.read_csv("driving.csv")
            statelist = []
            for next_state in dd.columns:   #go through the csv file and get the list of connect nodes to our node
                  init_state = x
                  test = dd[dd['Unnamed: 0'] == init_state][next_state].tolist()[0] 
                  if test != -1 or 0:
                             statelist.append(next_state)
                  
            
            statelist.remove("Unnamed: 0")  
            statelist.remove(init_state)         
            return statelist
            
  


class Node: #node object class
    def __init__(self, state, parent, pathCost, heuristics, algorithm): #initial parameters
        self.STATE = state
        self.PARENT = parent
        self.PATHCOST = pathCost
        self.HEURISTICS = heuristics
        if algorithm == 'GBFS':
            self.EVAL = self.HEURISTICS
        elif algorithm == 'ASTAR':
            self.EVAL = self.PATHCOST + self.HEURISTICS
        
    def getState(self):
        return self.STATE
        
    def getParent(self):
        return self.PARENT

    def getPathCost(self):
        return self.PATHCOST
        
    def getHeuristics(self):
        return self.HEURISTICS
      
    def getEval(self):
        return self.EVAL
      
    def __lt__(self, other):
        return self.getEval() < other.getEval()
        
    

class Solver:
    
    
                 
    def expand (self, problem, node, algorithm): #expand implementation
        children = [] #initialize linked list
        for s in problem.stateList(node.getState()):   #iterate through all actions for specific node
          cost = node.getPathCost() + problem.drivingDistance(node.getState(), s) #action cost function
          child = Node(s, node, cost, problem.straightlineDistance(s, problem.getGoalState()), algorithm) #create a child object with appropiate parameters
          children.append(child)    #add child object to linked list
        return children   #return linked list 
             
        
    def GBFS(self, problem, algorithm):
        #straightToGoal <- read the straight line distance between initial state and goal state and store
        straightToGoal = problem.straightlineDistance(problem.getInitialState(),problem.getGoalState())
        node = Node(problem.getInitialState(), None, 0, straightToGoal, algorithm)
        frontier = PriorityQueue()   #priority queue
        frontier.put((node.getEval(),node)) #add first node to prio queue
        reached = dict()   
        reached[problem.getInitialState()] = node #A table were we keep a list of visited nodees

        
        while not frontier.empty(): 
            node = frontier.get()[1]
            if problem.getGoalState() == node.getState():   #if the node is the goal state then return the node
                return node
            children = self.expand(problem, node, algorithm)    #create a children object with expand implementation
            for child in children:  #look at all the children of our current node
                s = child.getState()
                if s not in reached or child.getPathCost() < reached[s].getPathCost():  #if node is not visited or if the path cost is less than the path cost of the node in reached then execute
                    reached[s] = child#mark the child as reached
                    frontier.put((child.getEval(),child))   #add the child to the prio queue
                 
        return None

                    
                    

                    



 
numberOfArgumentsPassedFromCommandLine = len(sys.argv)

if numberOfArgumentsPassedFromCommandLine == 3:
    print("Number of arguments passed (including your script name):", numberOfArgumentsPassedFromCommandLine)
else:
    print("ERROR: Not enough or too many input arguments.")
    quit()
 
# Arguments passed
firstArgument = sys.argv[0]
#print("\nScript name:", sys.argv[0])

print("Alicea, Edman")
 
secondArgument = sys.argv[1]
print("INITIAL state:", secondArgument)

thirdArgument = sys.argv[2]
print("GOAL state:", thirdArgument)            
            
myProblem = Problem(secondArgument, thirdArgument)    #pass input to create a solver object        

my_solver = Solver()   #create solver object


#Code below runs GBFS Search  



try:  
    timeStart = timeit.default_timer() #start timer
    finalNode = my_solver.GBFS(myProblem, 'GBFS') #input initial and goal state to start solver program
    print("\nGreedy Best First Search:")
    currentNode = finalNode
    finalList = []      #the solution path
    while currentNode != None:
        finalList.append(currentNode.getState()) #get a a single state from solution and add it to the list
        currentNode.getState()              #get a single state from solution
        currentNode = currentNode.getParent() #set the single state to its parent to loop program
        
    finalList.reverse() #reverse solution path
    print("Solution Path: ",finalList)
    numstate = len(finalList)
    print("Number of States on a path: ", numstate)
    print("Path Cost: ",finalNode.getPathCost())
    
    timeEnd= timeit.default_timer() #end timer
    elapsedTime = timeEnd - timeStart
    print("Execution time: ",elapsedTime, " Seconds" )  #print timer 
    
except:
    print('\nERROR!\nSolution Path: FAILURE: NO PATH FOUND \nNumber of states on a path: 0 \nPath cost: 0 \nExecution time: 0 seconds')
    quit()




#Code belows runs ASTAR SEACH


try:
    timeStart2 = timeit.default_timer() #start timer
    
    finalNode = my_solver.GBFS(myProblem, 'ASTAR') #input initial and goal state to start solver program
    print('\nA* Search')
    currentNode = finalNode
    finalList = []
    while currentNode != None:
        finalList.append(currentNode.getState())
        currentNode.getState()
        currentNode = currentNode.getParent()
        
    finalList.reverse()
    print("Solution Path: ",finalList)
    numstate = len(finalList)
    print("Number of States on a path: ", numstate)
    
    print("Path Cost: ",finalNode.getPathCost())
    
    timeEnd2= timeit.default_timer() #end timer
    elapsedTime2 = timeEnd2 - timeStart2
    print("Execution time: ",elapsedTime2, " Seconds" )

except:
    print('\nSolution Path: FAILURE: NO PATH FOUND \nNumber of states on a path: 0 \nPath cost: 0 \nExecution time: 0 seconds')
    quit()

