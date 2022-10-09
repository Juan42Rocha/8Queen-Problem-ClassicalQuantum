#-===============================================
# Baltazar F. Hans                              
#-===============================================

#-===============================================
# Main file                                     
# code for  N queens problem                    
# I try use metropolis-hastings algorithm        
#-===============================================

using Random
include("functions.jl")


function main(N,Mts)

#N = 5                                           # number of queens

Tab = collect(1:N)                               # initial state             

#Mts = 1
  E = Energy(Tab,N)

for k=1:Mts
  println("Mts")
  println(Tab)
  Tab = OneMCt(Tab,N,E)  
end
  println("final")
  E3 =Energy(Tab,N)
  print(E3)
  println(Tab)


end
