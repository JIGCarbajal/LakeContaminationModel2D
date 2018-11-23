function [val, Kpol] = evalPoint(point,p,po,pind,t,to,tind,f)

	[y]=findNod(point,70,p,po,pind);

	idx=[];

	for i = 1:3
		for l=1:length(y)	

			tmpInd = binSrch(y(l),0,to(i,:));
			idx = [idx,tind(i,tmpInd)];

		end
	end


	for K=1:length(idx)
    		loc2glb = t(:,idx(K));
    		x = p(1,loc2glb);
    		y = p(2,loc2glb);
    		[~,alpha,beta,gamma] = gradPhi(x,y);
    		hatphi = [alpha beta gamma]* [point(1); point(2); 1];
    		if (hatphi(1) <= 10^(-15) && hatphi(2) <= 10^(-15) && hatphi(3) <= 10^(-15)) % Chapuza aqui para evitar NaNs innecesarios
    			val = f(loc2glb)' * hatphi;  
     		Kpol = K;
        		return
    		else
        		val = NaN('single');
        		Kpol = 0;
    		end
	end

end
