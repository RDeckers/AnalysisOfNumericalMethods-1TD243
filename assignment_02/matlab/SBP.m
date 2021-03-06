% Generate SBP matrices D and H of internal order
%                   2, 4 or 6 on equidistant grids with N+1 points.

function [D, H] = SBP(N, dx, order)

    if order == 2
        Pinv= [2 ones(1,N-1) 2] / dx;                             % 2nd
        Q = 0.5*sparse(diag([-1;zeros(N-1,1);1])...            % 2nd
            +diag(ones(N,1),1)-diag(ones(N,1),-1));
        %D1=Pinv*Q;
    elseif order==4
        if N<8
            disp('too small ind'); return
        end
        Pinv=[48/17 48/59 48/43 48/49 ...     % 4th
            ones(1,N-7) 48/49 48/43 48/59 48/17] / dx;
        diagQ=ones(N+1,1)*[1/12 -2/3 0 2/3 -1/12];          % 4th
        Q=spdiags(diagQ,-2:2,N+1,N+1);
        Q(1:4,1:4)=[-1/2 59/96 -1/12 -1/32;-59/96 0 59/96 0;...
            1/12 -59/96 0 59/96; 1/32 0 -59/96 0];
        Q(N-2:N+1,N-2:N+1) = -rot90(Q(1:4,1:4),2);
        %D1=Pinv*Q;
    elseif order==6
        if N<12
            disp('too small ind'); return
        end
        Pinv=[43200/13649 8640/12013 4320/2711 4320/5359 8640/7877 43200/43801 ...
            ones(1,N+1-12) ...
            43200/43801 8640/7877 4320/5359 4320/2711 8640/12013 43200/13649] / dx;
        diagQ=ones(N+1,1)*[-1 9 -45 0 45 -9 1]/60;
        Q=spdiags(diagQ,-3:3,N+1,N+1);   

        Q(1,1) = -1/2;
        Q(1,2) =  104009/172800;
        Q(1,3) =  30443/259200;
        Q(1,4) = -33311/86400;
        Q(1,5) =  16863/86400;
        Q(1,6) = -15025/518400;

        Q(2,1) = -104009/172800;
        Q(2,2) =  0;
        Q(2,3) = -311/51840;
        Q(2,4) =  20229/17280;
        Q(2,5) = -24337/34560;
        Q(2,6) =  36661/259200;

        Q(3,1) = -30443/259200;
        Q(3,2) =  311/51840;
        Q(3,3) =  0;
        Q(3,4) = -11155/25920;
        Q(3,5) =  41287/51840;
        Q(3,6) = -21999/86400;

        Q(4,1) =  33311/86400;
        Q(4,2) = -20229/17280;
        Q(4,3) =  11155/25920;
        Q(4,4) =  0;
        Q(4,5) =  4147/17280;
        Q(4,6) =  25427/259200;     %    Q(4,7) =  1/60;

        Q(5,1) = -16863/86400;
        Q(5,2) =  24337/34560;
        Q(5,3) = -41287/51840;
        Q(5,4) = -4147/17280;
        Q(5,5) =  0;
        Q(5,6) =  342523/518400;    %    Q(5,7) = -9/60;    Q(5,8) =  1/60;

        Q(6,1) =  15025/518400;
        Q(6,2) = -36661/259200;
        Q(6,3) =  21999/86400;
        Q(6,4) = -25427/259200;
        Q(6,5) = -342523/518400;
        Q(6,6) =  0;    %    Q(6,7) =  45/60;  Q(6,8) = -9/60;  Q(6,9) =  1/60;

        Q(N-4:N+1,N-4:N+1) = -rot90(Q(1:6,1:6),2);
    end
    
    H = spdiags((1./Pinv).',0,N+1,N+1);
    D = spdiags(Pinv.',0,N+1,N+1) * Q;
    