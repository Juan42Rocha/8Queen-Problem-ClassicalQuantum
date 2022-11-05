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
function main(N,Temp,Mts,rel)
#N = 5                                           # number of queens
  #Mts = 1
  arrayE = zeros(Mts*N+1)
  probEqui  = zeros(Mts*N+1)

for i =1:rel
  Tab = collect(1:N)                               # initial state             
#  println(Tab)
  E = Energy(Tab,N)
  arrayE[1] = E +arrayE[1]
  probEqui[1] = 0 +probEqui[1]

  for k=1:Mts*N
    Tab = OneMCt(Tab,N,E,Temp)  
    E =Energy(Tab,N)
    arrayE[k+1] = E +arrayE[k+1]
    probEqui[k+1] = (E==0)*1 + probEqui[k+1]
  end
# println(Tab)
end

arrayE= arrayE/rel
probEqui= probEqui/rel


# -= save data
io = open("N"*string(N)*"-T"*string(Temp)*"-Mts"*string(Mts)*"-Rel"*string(rel)*".dat","w");
for i=1:Mts*N+1
	println(io, arrayE[i],"  ",probEqui[i])
end
close(io)
  
#  plot(collect(1:Mts*N+1)/N,arrayE/maximum(arrayE),label=string(N), xlabel="MCts",ylabel="Interacciones",lw=3)
return [arrayE]

end



function main2()

temp = collect(0:10:100)*0.015



for i in temp
  main(10,i,1000,3000)
end




end
