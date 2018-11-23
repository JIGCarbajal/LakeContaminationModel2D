%---------------------------------------------------------------------------------------------------------------------
%   Objetivo: Calcular el area y el gradiente de las funciones gorro asociadas a un triangulo de la malla
%                
%                            phi_j = alpha_j * x + beta_j * y + gamma_j,   j = 1, 2, 3 
%
%			El area se calcula usando el producto cruz de dos de los vectores asociados a las posiciones de los
%			nodos en el triangulo.
%   Datos entrada:                                                                                                                               
%           	x   - Vector (3), coordenadas en "x" de los tres nodos del triangulo
%           	y   - Vector (3), coordenadas en "y" de los tres nodos del triangulo
%   Datos salida: 
%          	area - Escalar, Area del triangulo formado
%			alpha- Vector (3), constantes alpha de cada una de las funciones gorro en cada nodo
%			beta - Vector (3), constantes beta de cada una de las funciones gorro en cada nodo
% Fecha elaboracion: 3/Nov/2018
% Ultima actualizacion: 16/Nov/2018
%---------------------------------------------------------------------------------------------------------------------   
function [area, alpha, beta, gamma] = gradPhi(x,y)
  
  tmpVec=cross([x(2)-x(1),y(2)-y(1),0],[x(3)-x(1),y(3)-y(1),0]); % Calcula el producto cruz entre dos vectores
													% asociados a las posiciones
  area = 0.5*sqrt(dot(tmpVec,tmpVec));	% Calcula el area en base al producto cruz 
  
  alpha = [y(2)-y(3);y(3)-y(1);y(1)-y(2)]/(2*area); % valor de las constantes alpha en cada nodo
  beta  = [x(3)-x(2);x(1)-x(3);x(2)-x(1)]/(2*area);  % valor de las constantes beta en cada nodo
  gamma = [x(2)*y(3)-x(3)*y(2);x(3)*y(1)-x(1)*y(3);x(1)*y(2)-x(2)*y(1) ]/(2*area); % alpha's i, j, k
  
endfunction
