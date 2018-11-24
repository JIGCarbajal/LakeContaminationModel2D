%---------------------------------------------------------------------------------------------------------------------
%   	Objetivo: Dado una coordenada en el espacio "pos" encuentra el conjunto de nodos mas cercanos dentro de una
%		  tolerancia "d" en una malla triangular "p".
%                
%   	Datos entrada:                                                                                                                               
%           	pos	- Vector (2), posicion donde se buscaran los nodos cercanos
%           	d	- Escalar, tolerancia en la distancia de busqueda de nodos
%           	p	- Matriz (2,Np), Matriz de coordenadas de los nodos de la malla triangular
%           	po	- Matriz (2,Np), Matriz de coordenadas de los nodos de la malla triangular ordenadas por componente
%           	i	- Matriz (2,Np), Matriz de indices originales ordenados de los nodos de la malla triangular
%
%     Funciones externas:
%	        binSrch()
%
%   	Datos salida:
%           	y - Vector, Indices de los nodos cercanos a el punto "pos" dentro de la tolerancia "d"
%
% Fecha elaboracion: 3/Nov/2018
% Ultima actualizacion: 16/Nov/2018
%---------------------------------------------------------------------------------------------------------------------

function [y] = findNod(pos,d,p,po,i)	

	x = binSrch(pos(1),d,po(1,:)); % busca horizontalmente los nodos que se encuentran en cierta tolerancia "d"

	[Po,l] = sort(p(2,i(1,x))); % ordena las alturas de los nodos encontrados en "x"

	idx = binSrch(pos(2),d,Po); % busca verticalmente en ese subconjunto los nodos que se encuentran a cierta tolerancia "d"

	y = i(1,x(l(idx))); % retorna los indices de la matriz original "p"

endfunction
