%---------------------------------------------------------------------------------------------------------------------
%   	Objetivo: Usar el algoritmo de busqueda binaria para encontrar todos los elementos "elem" dentro del arreglo 
%		  ordenado "p", con cierto valor de tolerancia "tol" en el valor de "elem"
%                
%   	Datos entrada:                                                                                                                               
%		p   - Matriz (2,np), coordenadas de los puntos de la malla
%           	t   - Matriz (3,nt), matriz de conectividad de los puntos de la malla
%           	u   - Matriz (2,np), matriz de las velocidades en "x" y "y" en cada nodo 
%           	ti  - Escalar, instante de tiempo en el que se calculará la matriz de advección (indice de u(t))
%
%	Funciones externas:
%			gradPhi()
%
%   	Datos salida:
%           	D   - Matriz (np,np), matriz de adveccion del sistema en el instante "ti"
% Fecha elaboracion: 3/Nov/2018
% Ultima actualizacion: 16/Nov/2018
%--------------------------------------------------------------------------------------------------------------------- 

function [x] = binSrch(elem, tol, p)

        n = length(p);
        low = 1;
        high = n;
	mid=[];

        while(low <= high)
                mid = floor((low+high)/2);
                val = p(mid);
                if(val <= elem+tol && val >= elem-tol)
                        break;
                end
                if(val > elem+tol)
                        high = mid -1;
                else
                        low = mid +1;
                end
        end

        j = 0;
        k = 0;

	if(tol)
        	while(mid-j > 1 && p(mid-j)>elem-tol)
                	j = j + 1;
        	end

       		while(mid+k < n && p(mid+k)<elem+tol)
                	k = k + 1;
        	end
		
		x=[mid-j:mid+k];

        else
		while(mid-j > 1 && p(mid-j)==p(mid))
			j = j + 1;
		end

		while(mid+k < n && p(mid+k)==p(mid))
			k = k + 1;
		end

		x = [mid-j+1:mid+k-1];

	end
	


endfunction
