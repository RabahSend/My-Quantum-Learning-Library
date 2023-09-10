import qsharp
from DeutschAlgorithm import Main

print("My Quantum Learning Library\nPlease Choose a quantum algorithm to execute :")
print("1 - Deutsch Algorithm")

value = int(input("Enter your choice : "))

if (value == 1):
    Main.simulate()
