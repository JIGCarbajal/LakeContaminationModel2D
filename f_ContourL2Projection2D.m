function [PF,X,Y] = f_ContourL2Projection2D(delta,t,p,Pf)
xI=min(p(1,:));
xf=max(p(1,:));
yI=min(p(2,:));
yf=max(p(2,:));
x=xI:delta:xf;
m=length(x);
y=yI:delta:yf;
n=length(y);
y=sort(y,'descend');
[po,i]=sort(p,2); % Se ordena la matriz de puntos por componente
[to,j]=sort(t,2); % Se ordena la matriz
[X,Y]=meshgrid(x',y');
% Bucle que evalua la funcion phi_gorro en cada punto del mallado 
% rectangular
PF=zeros(n,m);
for k=1:n
  for l=1:m
     PF(k,l) = evalPoint([X(k,l);Y(k,l)],p,po,i,t,to,j,Pf);
      %if isnan(PF(k,l)) == 1
      %    PF(k,l) = 0;
      %end
  end
end
[C]=contour(X,Y,PF,10);
clabel(C)
end
