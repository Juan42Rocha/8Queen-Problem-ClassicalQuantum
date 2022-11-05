#-===============================================
# Baltazar F. Hans                              
#-===============================================

#-===============================================
# Main file                                
# code for  N queens problem                    
# I try to use glauber algorithm with cuantum 
# extension 
#-===============================================

include("functions.jl")
using LinearAlgebra

function main(N,Mts,Temp)

#  N = 3
#  Mts = 3
#  Temp = 0
   

  t1, Tabs = permutate(N)  
  idTabs = t1 .+ 1

  idtoidx = zeros(Int64,N^N)
  idtoidx[idTabs] = collect(1:factorial(N))


  E = EnergyArray(Tabs)
  
  szrho = factorial(N) 
  rho = zeros(szrho,szrho)
  ks = zeros(szrho,szrho)
  kc = zeros(szrho,szrho)
  rho[1,1] = 1
    
  Eob = zeros(N*Mts+1)
  Eob[1] = E[1]

  for k=1:N*Mts
    println(tr(rho))
    rho ,kc, ks= NewRho(rho,idtoidx,Tabs,idTabs,E,N)
    tras = diag(rho)
    Eob[k+1] = E'* tras
  end


# -= save data
io = open("SN"*string(N)*"-T"*string(Temp)*"-Mts"*string(Mts)*".dat","w");
for i=1:Mts*N+1
	println(io, Eob[i])
end
close(io)
  
  return rho,ks,kc


end
