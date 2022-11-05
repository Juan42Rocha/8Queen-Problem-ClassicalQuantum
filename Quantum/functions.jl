#-===============================================
# Baltazar F. Hans                              
#-===============================================

#-===============================================
# Functions file                                
# code for  N queens problem                    
# I try use metropolis-hastings algorithm        
#-===============================================



#-===============================================
# permutate(Tab,N)                                
#  compute the permutation array of 1 to n     
#-==============================================
function permutate(n,np)
  
  tarray = zeros(Int64,n)
  for i=0:n*n*n-1
    t1 = string(i,base=n,pad=n)

    for j=1:n
      tarray[j] = parse(Int64,t1[j])
    end

   # if(i != j & i != k & j != k )
      println(tarray)
   # end
  end


end
