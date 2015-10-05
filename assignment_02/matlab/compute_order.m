function [ ] = compute_order(N_min, N_max, N_logstep)
 reference = create_and_run(N_max*N_logstep, 6, 0.0025);
 ratio =0.0025;
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
     disp(N)
     X(end+1) = N
     computed = create_and_run(N, 6, ratio);
     size(computed)
     size(reference)
     step = (N_max*N_logstep)/N;
     %for i = 1:(N+1)
      %   computed(i) = computed(i) - reference(step*(i-1)+1);
%         computed(N+1+i) = computed(N+1+i) - reference(N_max+1+(step*(i-1)+1));
%     end
     Y6(end+1) = dot(computed, computed);
     figure(1)
     x= linspace(0,2,2*(N+1));
     plot(x, computed);
     computed = create_and_run(N, 4, ratio);
     size(computed)
     step = (N_max*N_logstep)/N;
     %for i = 1:(N+1)
%         computed(i) = computed(i) - reference(step*(i-1)+1);
%         computed(N+1+i) = computed(N+1+i) - reference(N_max+1+(step*(i-1)+1));
%     end
     Y4(end+1) = dot(computed, computed);
     figure(2);
     plot(x, computed);
     N = N*N_logstep;
 end
 %X
 %Y4
 %Y6
 %loglog(X,Y6,X,Y4)
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