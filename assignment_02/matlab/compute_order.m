function [ ] = compute_order(N_min, N_max, N_logstep)
 reference = create_and_run(N_max*N_logstep, 6, 50);
 ratio =100;
 X = []
 Y4 = []
 Y6 = []
 N = N_min
 x= linspace(0,2,2*(N_max*N_logstep+1));
 figure(1);
 hold on;
 plot(x, reference)
 figure(2);
 hold on;
 plot(x, reference)
 
 while N <= N_max
     X(end+1) = 1/N
     x= linspace(0,2,2*(N+1));
     computed = create_and_run(N, 6, ratio);
     step = (N_max*N_logstep)/N;
     figure(1)
     plot(x, computed);
     for i = 1:(N+1)
         computed(i) = computed(i) - reference(step*(i-1)+1);
         computed(N+1+i) = computed(N+1+i) - reference(N_max*N_logstep+1+(step*(i-1)+1));
     end

     Y6(end+1) = sqrt(dot(computed, computed));
     computed = create_and_run(N, 4, ratio);
     step = (N_max*N_logstep)/N;
     figure(2);
     plot(x, computed);
     for i = 1:(N+1)
         computed(i) = computed(i) - reference(step*(i-1)+1);
         computed(N+1+i) = computed(N+1+i) - reference(N_max*N_logstep+1+(step*(i-1)+1));
     end
     Y4(end+1) = sqrt(dot(computed, computed));
     
     N = N*N_logstep;
 end
figure(3)
X
Y4
Y6
for i = 1:size(X)
    fourthorder(i) = X(i)^4;
end
loglog(X,Y6,X,Y4)
grid on
end

%1,      2,      3, 4,      5,      6 //2
%1,  2,  3,  4,  5, 6,  7,  8,  9,  0 //4
%1,2,3,4,5,6,7,8,9, 0,1,2,3,4,5,6,7,8 //8


%Nmax = 4*N
%step = 4
%N=2
%(1->1)
%(2->5)
%(3->9)

%1->(4->0)
%2->(5->4)
%3->(6->8)