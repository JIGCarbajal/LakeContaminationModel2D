%---------------------------------------------------------------------------------------------------------------------
%   	Objetivo: Evaluar una solucion de un modelo de elementos finitos en un punto dentro de una malla (,no 
%		  necesariamente un nodo,) de elementos finitos triangulares.
%                
%   	Datos entrada:                                                                                                                               
%           	point	- Vector (2), coordenadas (x,y) del punto a evaluar
%           	p	- Matriz (2,Np), Matriz de coordenadas de los nodos de la malla
%           	po	- Matriz (2,Np), Matriz de coordenadas de los nodos de la malla con las filas ordenadas
%           	pind	- Matriz (2,Np), Matriz de indices originales ordenados de la matriz "p"
%           	t	- Matriz (3,Np), Matriz de conectividad de los nodos de la malla
%           	to	- Matriz (3,Np), Matriz de conectividad de los nodos de la malla con las filas ordenadas
%           	tind	- Matriz (3,Np), Matriz de indices originales ordenados de la matriz "t"
%		f   	- Vector (Np), Valor de la solucion en cada elemento de la malla
%
%	Funciones externas:
%		binSrch()
%		findNod()
%		gradPhi()
%
%   	Datos salida:
%           	val	- Escalar, Valor de la solucion en el punto "point"
%		Kpol	- Escalar, Triangulo en el cual se encuentra el punto "point"
%
% Fecha elaboracion: 3/Nov/2018
% Ultima actualizacion: 16/Nov/2018
%---------------------------------------------------------------------------------------------------------------------

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

endfunction
