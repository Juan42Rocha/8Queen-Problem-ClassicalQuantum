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
  Tab = OneMCt(Tab,N,E)  
  E =Energy(Tab,N)
end
  println("final")
  print(E)
  println(Tab)


end
