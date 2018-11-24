%---------------------------------------------------------------------------------------------------------------------
%   Objetivo: Ensamblar el vector de carga "b" del sistema, en un valor de tiempo "ti"
%                
%   Datos entrada:                                                                                                                               
%			p   - Matriz (2,np), coordenadas de los puntos de la malla
%			h   - Vector (np,1), sobre-elevacion del fluido en los puntos de la malla, en el tiempo de interes
%     nod - Vector (npi,1), Indices de la malla donde se añadira la carga
%			f   - Vector, Valor de la funcion que seguira la carga en el instante de tiempo, en cada punto de
%				 inyeccion 
%           	ti  - Escalar, Valor del tiempo en el cual se desea calcular el vector de carga
%   Datos salida:
%           	b   - Vector (np,1), Vector de carga del sistema en el instante "ti"
% Fecha elaboracion: 3/Nov/2018
% Ultima actualizacion: 16/Nov/2018
%---------------------------------------------------------------------------------------------------------------------

function b = loadAssembler2D(p,h,nod,f)
  np = size(p,2); % numero de puntos de la malla
  
  b = sparse(np,1); % crea el vector del tamaño necesario
  
  b(nod) = f./h(nod); % añade las contribuciones de los nodos mencionados en el tiempo indicado
  
endfunction
