#-===============================================
# Baltazar F. Hans                              
#-===============================================

#-===============================================
# Functions file                                
# code for  N queens problem                    
# I try use glauber algorithm with cuantum       
# extension
#-===============================================



#-===============================================
# permutate(Tab,N)                                
#  compute the permutation array of 1 to n     
#-==============================================
function permutate(n)
  
  tarray = zeros(Int64,n^n,n)
  filtro = zeros(Int64,n^n)
  for i=0:n^n-1
    t1 = string(i,base=n,pad=n)

    for j=1:n
      tarray[i+1,j] = parse(Int64,t1[j])
    end

  end
  for i=1:n-1
    for j=i+1:n
      filtro = filtro .| (tarray[:,i] .== tarray[:,j])
 #     print(i,j,"  ")
    end
  end

  per = findall(filtro .==0)
  return  per , tarray[per,:]

end


#-===============================================
# Energy(Tab,N)                                
#  compute the energy of a board state       
#-===============================================
function Energy(Tab,N) 
  Eval = 0
  for i=1:N
    for j=1:N
      if i != j
        if Tab[i]==Tab[j]
          Eval = Eval+1
        end

        t1 = abs(Tab[i]-Tab[j])
        if abs(i-j)==t1
          Eval = Eval + 1
        end
      end
    end
  end
  
  return Eval
end



#-===============================================
# EnergyArray(Tabs,N)                                
#  construct the energy array        
#-===============================================
function EnergyArray(Tabs)

  t1,N=size(Tabs)
  Earray = zeros(t1)

  for i=1:t1
    Earray[i] = Energy(Tabs[i,:],N)

  end

  return Earray
end



#-===============================================
# IdState(Tabs,N)                                
#  compute de Id state of one board        
#-===============================================
function IdState(Tab,N)

  t1=size(Tab) 
  pw = N .^collect(N-1:-1:0)
  val = Tab' * pw
  
  return val
end



#-===============================================
# IdStateArray(Tabs,N)                                
#  compute de Id state of one board        
#-===============================================
function IdStateArray(Tabs)

  t1,N=size(Tabs)
  IdArray = zeros(Int64,t1)

  for i=1:t1
    IdArray[i] = IdState(Tabs[i,:],N)
  end
  
  return IdArray
end



#-===============================================
# PermuteColumn(Tabs,ci,cj)                                
#  change two columns of position         
#-===============================================
function PermuteColumn(Tabs,ci,cj)

  t1,N=size(Tabs)
  tarray = zeros(t1)
  NTabs = copy(Tabs)

  tarray = Tabs[:,ci]
  NTabs[:,ci] = Tabs[:,cj]
  NTabs[:,cj] = tarray  

  return NTabs
end



#-===============================================
# ContructK(Tabs,ci,cj)                                
#  contruct a kraus equivalent matrix w T=0      
#-===============================================
function ConstructK(idtoidx,Tabs,idTabs,E,c1,c2)

  t1,N=size(Tabs)
  NTabs = copy(Tabs)
  NTabs = PermuteColumn(Tabs,c1,c2)
  IdC = IdStateArray(NTabs-Tabs)
  NidTabs = idTabs + IdC
  E2 = EnergyArray(NTabs)

  dE  = E2 - E
  ndE = dE .< 0
  soc = length(dE[dE .<0])
  Kchange = zeros(t1,t1)  
  col = idtoidx[idTabs[ndE]]
  row = idtoidx[NidTabs[ndE]]

  for k=1:soc
    Kchange[row[k],col[k]] = 1
  end


  ndE = dE .> 0
  soc = length(dE[dE .>0])
  Knothing = zeros(t1,t1)  
  col = idtoidx[idTabs[ndE]]
  row = idtoidx[NidTabs[ndE]]

  for k=1:soc
    Knothing[col[k],col[k]] = 1
  end


  ndE = dE .== 0
  soc = length(dE[dE .==0])
  Ksuper = zeros(t1,t1)  
  col = idtoidx[idTabs[ndE]]
  row = idtoidx[NidTabs[ndE]]

  for k=1:soc
    Ksuper[row[k],col[k]] = sqrt(0.5)
    Ksuper[col[k],col[k]] = -sqrt(0.5)
  end
  
  Ksuper2 = Ksuper*Ksuper'
  for k=1:soc
    if sum(Ksuper[:,col[k]]) !=1
       Ksuper[col[k],col[k]] = Ksuper[col[k],col[k]] *Ksuper[row[k],row[k]]/sqrt(0.5)
    end
  end
#  for k=1:soc
#    tro = Ksuper[col[k],col[k]]
#    Ksuper[col[k],col[k]] = Ksuper[row[k],row[k]]  
#    Ksuper[row[k],row[k]] = tro
#  end

  return Kchange,Knothing+Ksuper

end



#-===============================================
# ContructKwT(idtoidx,Tabs,idTabs,ci,cj,Temp)                                
#  contruct a kraus equivalent matrix w T!=0      
#-===============================================
function ConstructKwT(idtoidx,Tabs,idTabs,E,c1,c2,Temp)

  t1,N=size(Tabs)
  NTabs = copy(Tabs)
  NTabs = PermuteColumn(Tabs,c1,c2)
  IdC = IdStateArray(NTabs-Tabs)
  NidTabs = idTabs + IdC
  E2 = EnergyArray(NTabs)

  dE  = E2 - E

  # when always change
  ndE = dE .< 0
  soc = length(dE[dE .<0])
  Kchange = zeros(t1,t1)  
  col = idtoidx[idTabs[ndE]]
  row = idtoidx[NidTabs[ndE]]

  for k=1:soc
    Kchange[row[k],col[k]] = 1
  end

  # first superpositions
  ndE = dE .> 0
  soc = length(dE[dE .>0])
  Knothing = zeros(t1,t1)  
  col = idtoidx[idTabs[ndE]]
  row = idtoidx[NidTabs[ndE]]

  for k=1:soc
    dEk = dE[col[k]]
    prob = 1/(1+exp(dEk/Temp))
    Knothing[row[k],col[k]] = sqrt(prob)
    Knothing[col[k],col[k]] = -sqrt(1-prob)
  end

  Knothing2 = Knothing*Knothing'
  for k=1:soc
    if sum(Knothing2[:,col[k]]) !=1
       dEk = ndE[col[k]]
       prob = 1/(1+exp(dEk/Temp))
 #      Knothing[col[k],col[k]] = Knothing[col[k],col[k]] *Knothing[row[k],row[k]]/abs(1)
    end
  end

  ndE = dE .== 0
  soc = length(dE[dE .==0])
  Ksuper = zeros(t1,t1)  
  col = idtoidx[idTabs[ndE]]
  row = idtoidx[NidTabs[ndE]]

  for k=1:soc
    Ksuper[row[k],col[k]] = sqrt(0.5)
    Ksuper[col[k],col[k]] = -sqrt(0.5)
  end
  
  Ksuper2 = Ksuper*Ksuper'
  for k=1:soc
    if sum(Ksuper[:,col[k]]) !=1
       Ksuper[col[k],col[k]] = Ksuper[col[k],col[k]] *Ksuper[row[k],row[k]]/sqrt(0.5)
    end
  end
#  for k=1:soc
#    tro = Ksuper[col[k],col[k]]
#    Ksuper[col[k],col[k]] = Ksuper[row[k],row[k]]  
#    Ksuper[row[k],row[k]] = tro
#  end

  return Kchange,Knothing, Ksuper

end





#-===============================================
# NewRho(Tabs,ci,cj)                                
#  make one step of rho         
#-===============================================
function NewRho(Rho,idtoidx,Tabs,idTabs,E,N,Temp)

  Nrho = copy(Rho)
  Nrho = Nrho*0
  kc = copy(Nrho)
  kn = copy(Nrho)
  ks = copy(Nrho)
  con = 0
  for i=1:N-1
    for j=i+1:N
      con = con +1
      kc, kn, ks = ConstructKwT(idtoidx,Tabs,idTabs,E,i,j,Temp)
      Nrho = Nrho + kc*Rho*kc' + kn*Rho*kn' + ks*Rho*ks'
    end
  end
  #print("con  ",con,"  N ",N)
  return Nrho./(N*(N-1)/2), kc,kn, ks
end
