%---------------------------------------------------------------------------------------------------------------------
%    Objetivo: Ensamblar la matriz de rigidez "A" para un sistema de "np" nodos y "nt" triangulos. 
%             Las entradas de las submatrices "A^k" estan dadas por
%
%                      A^k = (alpha_j * alpha_i + beta_j * beta_i) |k| ,   k = 1,...,n-1 , i,j=1,2,3
%                
%    Datos entrada:                                                                                                                               
%			p   - Matriz (2,np), coordenadas de los puntos de la malla
%			t   - Matriz (3,np), Matriz de conectividad de los puntos de la malla
%	Funciones externas:
%			gradPhi()
%
%    Datos salida:
%           	A   - Matriz (np,np), matriz de rigidez del sistema
% Fecha elaboracion: 3/Nov/2018
% Ultima actualizacion: 16/Nov/2018
%---------------------------------------------------------------------------------------------------------------------

function A = stiffnessAssembler2D(p,t)
  np = size(p,2); % numero de nodos de la malla
  nt = size(t,2); % numero de triangulos de la malla
  A = sparse(np,np); % se crea la matriz con el tamaño necesario
  for K = 1:nt
    loc2glb = t(:,K); % mapeo local-to-global
    x = p(1,loc2glb); % coordenadas "x" de los nodos
    y = p(2,loc2glb); % coordenadas "y" de los nodos
    [area,a,b] = gradPhi(x,y); % Area y gradientes de las funciones gorro en los nodos del triangulo "k"
    AK = (a*a'+ b*b')*area; % Contribucion de la matriz de rigidez al sistema
    A(loc2glb,loc2glb) = A(loc2glb,loc2glb) + AK; % Adicion de la contribucion a la matriz global A
  end
endfunction
