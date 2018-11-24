%---------------------------------------------------------------------------------------------------------------------
%   	Objetivo: Usar el algoritmo de busqueda binaria para encontrar todos los elementos "elem" dentro del arreglo 
%		  ordenado "p", con cierto valor de tolerancia "tol" en el valor de "elem"
%                
%   	Datos entrada:                                                                                                                               
%           	elem	- Escalar, elemento a buscar en el arreglo 
%           	tol	- Escalar, tolerancia en el valor de "elem"
%		p   	- Vector, Arreglo donde se buscara el dato
%
%	Funciones externas:
%
%   	Datos salida:
%           	x	- Vector, Arreglo con los indices donde se encuentran los elementos entre [elem-tol,elem+tol] 
% Fecha elaboracion: 3/Nov/2018
% Ultima actualizacion: 16/Nov/2018
%--------------------------------------------------------------------------------------------------------------------- 

function [x] = binSrch(elem, tol, p)

        n = length(p); % numero de elementos del arreglo

%---------------------------------------------------------------------------------------------------------------------
% Busqueda binaria para encontrar algun elemento dentro del intervalo [elem-tol,elem+tol]
%---------------------------------------------------------------------------------------------------------------------

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

%---------------------------------------------------------------------------------------------------------------------
% Busqueda lineal de elementos hacia adelante y hacia atras de p(mid) dentro del intervalo [elem-tol,elem+tol]
%---------------------------------------------------------------------------------------------------------------------

        j = 0;
        k = 0;

	if(tol) % si la tolerancia es distinta de "0"
        	while(mid-j > 1 && p(mid-j)>elem-tol) % busqueda hacia la izquierda
                	j = j + 1;
        	end

       		while(mid+k < n && p(mid+k)<elem+tol) % busqueda hacia la derecha
                	k = k + 1;
        	end
		
		x=[mid-j:mid+k];

        else % si la tolerancia es igual a cero, se buscan los elementos iguales
		while(mid-j > 1 && p(mid-j)==p(mid)) % busqueda hacia la izquierda
			j = j + 1;
		end

		while(mid+k < n && p(mid+k)==p(mid)) % busqueda hacia la derecha
			k = k + 1;
		end

		x = [mid-j+1:mid+k-1];

	end
	


endfunction
