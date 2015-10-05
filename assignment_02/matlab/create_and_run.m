function [ v ] = create_and_run(N, order, ratio)
 h = 1.0/N;
 k = ratio*h;
 A = -[0, 1;  1, 0];
 alpha = [-0.2; -1];
 beta = [1; -0.2];%Setting it to 1 = energy conservation thus right answer
 [D, H] = SBP(N, h, order);
 Hinv = inv(H);
 e0 = zeros(1,N+1);
 e0(1) = 1;
 eN = zeros(1,N+1);
 eN(N+1) = 1;
 
 SAT1 = kron(alpha, Hinv)*e0.'*(kron([1, 0], e0));
 SAT2 = kron(beta, Hinv)*eN.'*(kron([0, 1], eN));
 
 v = zeros(2*(N+1),1);
 for i = 1:N
     v(i) = exp(-60*(i*h-0.5)^2);
     v(i+N) = -v(i);
 end
 F = kron(A, D) + SAT1 + SAT2;
 for i = k:k:1
     k1 = F*v;
     k2 = F*(v+k/2*k1);
     k3 = F*(v+k/2*k2);
     k4 = F*(v+k*k3);
     v = v + k/6*(k1+2*k2+2*k3+k4);
 end
end

