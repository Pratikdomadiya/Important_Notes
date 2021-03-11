for i in range(10,0,-1):# reverse loop 
    #write code here

t1=list_1
t2=list_2
temp=(set(t1).intersection(t2))# return common elements in two different list

#sieve method for finding the prime number is efficient among all-->> go geeksforgeek.com

#taking input in coding python
1. effective way (almost 10 time faster than "normal way" to get input of large amount of data)
    for _  in range(int(sys.stdin.readline())):
        x,y=map(int,sys.stdin.readline().split())
2. normal way
    for _ in range(int(input())):
        x,y=map(int,input().split())    
                

#to find out time taken by perticular operation using python magic functions
    %%timeit -n 10# note write in single block only
    
