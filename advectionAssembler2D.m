%---------------------------------------------------------------------------------------------------------------------
%   	Objetivo: Ensamblar la matriz de adveccion "D" para un sistema de "np" nodos y "nt" triangulos. 
%             Las entradas de las submatrices "D^k" estan dadas por
%                
%                            | 2*psi_1 1*psi_2 1*psi_3 |
%                      D^k = | 1*psi_1 2*psi_2 1*psi_3 | |k|/12 ,   k = 1,...,n-1
%                            | 1*psi_1 1*psi_2 2*psi_3 |
%
%			Donde
%				   psi_j = u_j · grad(phi_j),   j = 1, 2, 3 (para cada triangulo)
%   	Datos entrada:                                                                                                                               
%			p   - Matriz (2,np), coordenadas de los puntos de la malla
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

function D = advectionAssembler2D(p,t,u,ti)
  np = size(p,2); % numero de nodos de la malla
  nt = size(t,2); % numero de triangulos de la malla
  D = sparse(np,np);
  for K = 1:nt
    loc2glb = t(1:3,K); % mapeo local-to-global
    x = p(1,loc2glb); % coordenadas "x" de los nodos
    y = p(2,loc2glb); % coordenadas "y" de los nodos
    ux = u(1,loc2glb,ti); % velocidades en "x" en el instante "ti" en el triangulo "k"
    uy = u(2,loc2glb,ti); % velocidades en "y" en el instante "ti" en el triangulo "k"
    [area, a,b] = gradPhi(x,y); % Area y gradientes de las funciones gorro en los nodos del triangulo "k"
    DK = [2,1,1;1,2,1;1,1,2]*area/12; 
    DK(1,:) = (ux.*a'+uy.*b').*DK(1,:);
    DK(2,:) = (ux.*a'+uy.*b').*DK(2,:);
    DK(3,:) = (ux.*a'+uy.*b').*DK(3,:); 
    D(loc2glb,loc2glb) = D(loc2glb,loc2glb) + DK; % Adicion de la contribución a la matriz global D
  end
endfunction
