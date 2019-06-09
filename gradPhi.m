%---------------------------------------------------------------------------------------------------------------------
%   Objetivo: Calcular el area y el gradiente de las funciones gorro asociadas a un triangulo de la malla
%                
%                            phi_j = alpha_j * x + beta_j * y + gamma_j,   j = 1, 2, 3 
%
%			El area se calcula usando el producto cruz de dos de los vectores asociados a las posiciones de los
%			nodos en el triangulo. El sistema a resolver es
%					|x(1) y(1) 1| |alpha_j|   |1|   |0|   |0|
%					|x(2) y(2) 1| |beta_j | = |0| o |1| o |0|  dependiendo si j = 1, 2 o 3
%					|x(3) y(3) 1| |gamma_j|   |0|   |0|   |1|
%   Datos entrada:                                                                                                                               
%           	x   - Vector (3), coordenadas en "x" de los tres nodos del triangulo
%           	y   - Vector (3), coordenadas en "y" de los tres nodos del triangulo
%   Datos salida: 
%          	area - Escalar, Area del triangulo formado
%		alpha- Vector (3), coeficientes alpha de cada una de las funciones gorro en cada nodo
%		beta - Vector (3), coeficientes beta de cada una de las funciones gorro en cada nodo
%               gamma- Vector (3), coeficientes gamma de cada una de las funciones gorro en cada nodo
% Fecha elaboracion: 3/Nov/2018
% Ultima actualizacion: 08/Jun/2019
%---------------------------------------------------------------------------------------------------------------------   
function [area, alpha, beta, gamma] = gradPhi(x,y)
	
	Delta = det([x(1), y(1), 1; x(2), y(2), 1; x(3), y(3), 1]); % determinante del sistema de ecuaciones
	
	alpha = [y(2)-y(3);y(3)-y(1);y(1)-y(2)]/Delta; % valor de los coeficientes alpha en cada nodo
	beta  = [x(3)-x(2);x(1)-x(3);x(2)-x(1)]/Delta;  % valor de los coeficientes beta en cada nodo
	gamma = [x(2)*y(3)-x(3)*y(2);x(3)*y(1)-x(1)*y(3);x(1)*y(2)-x(2)*y(1) ]/Delta; % valor de los coeficientes gamma en cada nodo
						
	area = abs(Delta)/2;

endfunction
