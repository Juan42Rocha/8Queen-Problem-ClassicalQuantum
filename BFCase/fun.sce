//===============================================//
// Baltazra F.
//===============================================//

//===============================================//
// Funtions file 
// code for  N queens problem
// I try use the brute force and other methos
//===============================================//



//===============================================//
// Compute the energy for interaction between
// n queens by the configuracion st
//===============================================//
function Eval=Energy(st,n)
   s=dec2base(k-1,n,n);
   Eval=0;
   for i=1:n
      for j=1:n
         if(i ~= j)
			if(part(s,i)==part(s,j))
               Eval=Eval+1;
            end

            t3=abs( strtod(part(s,i))-strtod(part(s,j)) );
			if(abs(i-j)==t3)
               Eval=Eval+1;
			end
		 end 
	  end 
   end 

endfunction



//===============================================//
//  Array of energys 
//===============================================//
function Earray=ArrayEnergy(n)
   Earray=zeros(n^n,1);
   for k=1:n^n;
      Earray(k,1)=Energy(k-1,n);
 //     mprintf("%G\n",k/n^n)
   end
  

endfunction


function DifE=ChangeE(Earray,opos,npos,n)

   //for k=1:


endfunction














