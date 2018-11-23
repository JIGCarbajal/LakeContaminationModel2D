%---------------------------------------------------------------------------------------------------------------------
%   	Objetivo: Ensamblar la matriz de masa "M" para un sistema de "np" nodos y "nt" triangulos. 
%             Las entradas de las submatrices "M^k" estan dadas por
%
%                            | 2 1 1 |
%                      M^k = | 1 2 1 | |k|/12 ,   k = 1,...,n-1
%                            | 1 1 2 |
%                
%   	Datos entrada:                                                                                                                               
%			p   - Matriz (2,np), coordenadas de los puntos de la malla
%			t   - Matriz (3,np), Matriz de conectividad de los puntos de la malla
%	Funciones externas:
%			gradPhi()
%
%   	Datos salida:
%           	M   - Matriz (np,np), matriz de masa del sistema
% Fecha elaboracion: 3/Nov/2018
% Ultima actualizacion: 16/Nov/2018
%---------------------------------------------------------------------------------------------------------------------

function M = massAssembler2D(p,t)
  np = size(p,2); % numero de nodos de la malla
  nt = size(t,2); % numero de triangulos de la malla
  M = sparse(np,np); % Se crea la matriz con el tamaño necesario
  for K = 1:nt
    loc2glb = t(1:3,K); % mapeo local-to-global
    x = p(1,loc2glb); % coordenadas "x" de los nodos
    y = p(2,loc2glb); % coordenadas "y" de los nodos
    area = gradPhi(x,y); % area del triangulo "k"
    MK = [2,1,1;1,2,1;1,1,2]*area/12; % Contribucion del triangulo a la matriz de masa
    M(loc2glb,loc2glb) = M(loc2glb,loc2glb) + MK; % Adicion de la contribucion a la matriz global M
  end
endfunction
