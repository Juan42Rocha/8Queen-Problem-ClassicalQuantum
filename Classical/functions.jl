#-===============================================
# Baltazar F. Hans                              
#-===============================================

#-===============================================
# Functions file                                
# code for  N queens problem                    
# I try use metropolis-hastings algorithm        
#-===============================================


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
# OneMove(Tab,N)                                
#  Evolution process
#  An element operation, single move of a random
#  Queen
#-===============================================
function OneMove(Tab,N)
  Taba = Tab
  rndQ1 = rand(1:N)
  rndQ2 = rand(1:N)
  while rndQ2 == rndQ1
    rndQ2 = rand(1:N)
  end
  t1 = Taba[rndQ1]
  Taba[rndQ1] = Taba[rndQ2]
  Taba[rndQ2] = t1

  return Taba
end


#-===============================================
# OneMCtMove(Tab,N)                                
#  Evolution process
#  Apply N times ONeMove
#  
#-===============================================
function OneMCt(Tab,N,E)
  for i=1:N*N
    Tab2 = OneMove(Tab,N)
    E2 = Energy(Tab2,N)
    rnd = rand()    

    if E2 < E
      Tab = Tab2
      E = E2
      print(E)
      println(Tab)
    end
  end
  
  return Tab
end

