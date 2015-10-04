function [ ] = compute_order(N_min, N_max, N_logstep)
 reference = create_and_run(N_max*N_logstep, 6, 0.1);
 h= surf(reference)
 set(h,'LineStyle','none')
end

