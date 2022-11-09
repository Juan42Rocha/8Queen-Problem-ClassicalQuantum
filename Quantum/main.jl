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
  kn = zeros(szrho,szrho)
  kc = zeros(szrho,szrho)
  rho[1,1] = 1
    
  Eob = zeros(N*Mts+1)
  ProbEqui = zeros(N*Mts+1)
  Cohe = zeros(N*Mts+1)
  idProbequi = findall(E.==0)
  Eob[1] = E[1]
  ProbEqui[1] = 0
  Cohe[1] = 0

    println("traza ",tr(rho))

  for k=1:N*Mts
    rho ,kc,kn, ks= NewRho(rho,idtoidx,Tabs,idTabs,E,N,Temp)
    println("traza ",tr(rho))
    tras = diag(rho)
    Eob[k+1] = E'* tras
    ProbEqui[k+1] = sum(tras[idProbequi])
    Cohe[k+1] = sum(-(rho.<0).*rho + (rho.>0).*rho)-1
  end


# -= save data
io = open("2SN"*string(N)*"-T"*string(Temp)*"-Mts"*string(Mts)*".dat","w");
for i=1:Mts*N+1
	println(io, Eob[i],"   ", ProbEqui[i], "   ", Cohe[i]  )
end
close(io)
  
  return rho,kc,kn,ks


end
