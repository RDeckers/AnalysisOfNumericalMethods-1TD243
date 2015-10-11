function [ v ] = create_and_run(N, order, ratio)
 h = 1.0/N;
 M = N*ratio;
 k = 1.0/M;
 A = [0, 1;  1, 0];
 alpha = [-1; -1];
 beta = [1; -1];
 [D, H] = SBP(N, h, order);
 Hinv = inv(H);
 e0 = zeros(1,N+1);
 e0(1) = 1;
 eN = zeros(1,N+1);
 eN(N+1) = 1;
 
 SAT1 = kron(alpha, Hinv)*e0.'*(kron([1, 0], e0));
 SAT2 = kron(beta, Hinv)*eN.'*(kron([0, 1], eN));

x = linspace(0,1,N+1)';
v = [exp(-60*(x-0.5).^2); - exp(-60*(x-0.5).^2)];
F = sparse(kron(-A, D) + SAT1 + SAT2);
K = 0;
 for i = 1:M
     k1 = F*v;
     k2 = F*(v+k/2*k1);
     k3 = F*(v+k/2*k2);
     k4 = F*(v+k*k3);
     v = v + k/6*(k1+2*k2+2*k3+k4);
     K = K+k;
 end
end
%k/h = C, k = h*C , h = 1/N, K = 1/N*C, C = 1/ratio, 
