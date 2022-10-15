#-===============================================
# Baltazar F. Hans                              
#-===============================================

#-===============================================
# Main file                                     
# code for  N queens problem                    
# I try use metropolis-hastings algorithm        
#-===============================================

using Random
using Plots
include("functions.jl")

#-===============================================
# main(N,Mts,rel)
# N size of board
# Mts MonteCarlo time steps
# rel realizations
# solve and plot Energy vs MCts 
#-===============================================
function main(N,Mts,rel)
#N = 5                                           # number of queens
  #Mts = 1
  arrayE = zeros(Mts*N+1)

for i =1:rel
  Tab = collect(1:N)                               # initial state             
  E = Energy(Tab,N)
  arrayE[1] = E +arrayE[1]

  for k=1:Mts*N
    Tab = OneMCt(Tab,N,E)  
    E =Energy(Tab,N)
    arrayE[k+1] = E +arrayE[k+1]
  end
end
  #println("final")
  #print(E)
  #println(Tab)
  arrayE= arrayE/rel
  #print(arrayE)
  plot(collect(1:Mts*N+1)/N,arrayE,label=string(N), xlabel="MCts",ylabel="Interacciones")

end
