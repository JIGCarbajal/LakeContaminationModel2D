%--------------------------------------------------------------------------------------------------------------------
%	Objetivo: Resolver el modelo 2D:
%
%			{\partial\rho}/{\partial t} - E\lapl\rho + u·grad(\rho) + k*rho = 1/h \sum_l m_l(t)*dirac(r-P_l), para x\in \Omega, t\in I=[0,t]
%
%	          Con condiciones:
%
%			        \rho(x,0) = \rho_0(x)
%			        {\partial\rho}/{\partial n} = 0,  para x\in\partial\Omega , t>0
%
%           Calculando la parte espacial de la solucion con MEF y la parte temporal
%           con el metodo de diferencias finitas usando euler hacia atras.
%
%	Funciones externas:
%
%			massAssembler2D                                                                            
%			stiffnessAssembler2D
%			loadAssembler2D (Dirac version)
%			advectionAssembler2D
%
%	Datos entrada:
%			      E		- Escalar, Coeficiente de difusividad
%			      u 	- Matriz, matriz de velocidades del fluido en cada nodo de la malla en cada instante
%			      k 	- Escalar, razon temporal de "desintegracion" del contaminante 
%			      p		- Matriz (2,np), posiciones de los nodos en la malla
%			      t 	- Matriz (3,nt), conectividad de los nodos en los triangulos de la malla
%			      f 	- Matlab anonimous function, forzamiento externo del modelo (contaminante)
%			      nod	- Vector, indices donde se vierte contaminante nod(i)\in [1,np]
%
%	Datos de salida:
%			      M	  - Matriz (np x np), matriz de masa
%			      A	  - Matriz (np x np), matriz de rigidez
%			      D	  - Matriz (np x np), matriz de adveccion
%			      b	  - Vector (np x 1), vector de peso
%			      x	  - Vector (np x 1), coordenadas de los nodos de la malla \mathcal(I)
%			      uh  - Matriz (np x t), aproximacion del MEF a la solucion "u" en cada nodo en cada instante
%
% Fecha elaboracion: 3/Nov/2018
% Ultima actualizacion: 16/Nov/2018
%---------------------------------------------------------------------------------------------------------------------
function [uh] = modelSolver2D()
%===============================================================================
% Incializacion de parametros del modelo
%===============================================================================
	E = 5e4; % Coeficiente de difusividad
	k = 1e-6;  % Coeficiente de extincion de contaminante

	dt = 0.6; % paso de tiempo

	load 'Cajimalla.mat' % se cargan los parámetros de malla y las velocidades
  
	p = z_mts; % matriz de coordenadas de los puntos de la malla
	t = mm; % matriz de conectividad de los nodos de la malla
	u = zeros(2, size(Vqx,1), size(Vqx,2)); % se crea un vector unico de velocidades
	for i=1:size(Vqx,2)
		u(1,:,i) = Vqx(:,i); % velocidad en "x" en cada nodo
		u(2,:,i) = Vqy(:,i); % velocidad en "y" en cada nodo
		h(:,i) = Vqz(:,i)+h_mts(:);  % profundidad del lago en cada nodo
	end
 
	f = @(t) 0 ;             % Funcion de forzamiento del contaminante
	nod = [100;200;300];              % Puntos donde se añade el contaminante

%===============================================================================
% Calculo de las matrices necesarias para la solucion
%===============================================================================
	M = massAssembler2D(p,t); % matriz de masa del sistema
	A = stiffnessAssembler2D(p,t); % matriz de rigidez del sistema

%===============================================================================
% Ciclo de calculo temporal para euler hacia atras
%===============================================================================
	uh(:,1) = zeros(length(p),1); % condicion inicial de ceros
	uh(:,1) = exp(-((p(1,:)-p(1,1080)).^2 + (p(2,:)-p(2,1080)).^2 )./(2*100^2)); 

	D = advectionAssembler2D(p,t,u,1); % Matriz de adveccion del sistema en cada instante (es constante aquí)
	R = inv(M + dt*(E*A+k*M+D)); % Calculo de la matriz invesa para solucion del sistema
	for i=2:size(Vqx,2)
		b = loadAssembler2D(p,h(:,i),nod,f(dt*i)); % calculo del vector de carga en cada instante de tiempo
		uh(:,i) = R*(M*uh(:,i-1)+dt*b); % Solucion de la 
	end

end
