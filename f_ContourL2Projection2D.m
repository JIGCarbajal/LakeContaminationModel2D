%---------------------------------------------------------------------------------------------------------------------
%   	Objetivo: Evaluar una solucion de un modelo de elementos finitos en un punto dentro de una malla (,no 
%		  necesariamente un nodo,) de elementos finitos triangulares y graficar los contornos de esta.
%                
%   	Datos entrada:                                                                                                                               
%           	delta	- Escalar, tamaño de celda de la malla rectangular
%           	t	- Matriz (2,Np), Matriz de conectividad de los nodos de la malla triangular
%           	p	- Matriz (2,Np), Matriz de coordenadas de los nodos de la malla triangular
%             Pf- Vector (Np), Valor de la solucion en cada elemento de la malla triangular
%
%     Funciones externas:
%		          evalPoint()
%
%   	Datos salida:
%           	PF - Matriz (m,n), Valor de la solucion en cada elemento de la malla rectangular
%		          X - Matriz (m,n), Vector "x" repetido "n" veces
%		          Y - Matriz (m,n), Vector "y" repetido "m" veces
%
% Fecha elaboracion: 3/Nov/2018
% Ultima actualizacion: 16/Nov/2018
%---------------------------------------------------------------------------------------------------------------------

function [PF,X,Y] = f_ContourL2Projection2D(delta,t,p,Pf)
xI=min(p(1,:)); % "x" minimo de toda la malla
xf=max(p(1,:)); % "x" maximo de toda la malla
yI=min(p(2,:)); % "y" minimo de toda la malla
yf=max(p(2,:)); % "y" maximo de toda la malla
x=xI:delta:xf; % valores discretos de "x"
m=length(x); % longitud del vector "x"
y=yI:delta:yf; % valores discretos de "y"
n=length(y); % longitud del vector "y"
y=sort(y,'descend'); % Se ordena desencentemente el vector "y"
[po,i]=sort(p,2); % Se ordena la matriz de puntos por componente
[to,j]=sort(t,2); % Se ordena la matriz de conectividad por fila
[X,Y]=meshgrid(x',y'); % Se crea una malla con los intervalos de "x" e "y"
% Bucle que evalua la funcion phi_gorro en cada punto del mallado rectangular
PF=zeros(n,m);
for k=1:n
  for l=1:m
     PF(k,l) = evalPoint([X(k,l);Y(k,l)],p,po,i,t,to,j,Pf);
      if(isnan(PF(k,l)))
          PF(k,l) = 0;
      end
  end
end
[C]=contour(X,Y,PF,10);
clabel(C)
end
