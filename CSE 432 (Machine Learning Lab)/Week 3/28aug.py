#a= int(input("Enter an integer: "))
#b= int(input("Enter an integer: "))
#sum = a+b
#print ("The sum is" ,sum)
#a= int(input("Enter an integer: "))
#if a>5:
#    print( str(a) +" Greater than 5")
#elif a==5:
#    print( a," Equal to 5")
#else:
#    print(f"(a)"," Smaller than 5")
#for i in range(1,6,2):
#    print (i);   

## factorial

a= int(input("Enter an integer: "))
factorial=1
for i in range(1,a+1):
    factorial= factorial*i
print(factorial)

import math as mt
print(mt.factorial(5))
    