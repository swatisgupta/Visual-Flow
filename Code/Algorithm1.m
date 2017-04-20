function [slope_x, slope_y, parameters] = Algorithm1(Events)

% Setting Neighborhood parameters as described in paper
L = 17;
deltaT = 1000;
thresh1 = 1e-5;
thresh2 = 5e-2;
%     Create empty neighborhood
Neighborhood = cell(length(Events),1);

%     Step 1 and 2
for i = 1:length(Events)
% for i = 1:5000
    e = Events{i}; k = 1;
    %         This loop collects all points in the neighborhood and stores them
    %         in N_e
    for j = 1:length(Events)
        en = Events{j};
        if (en(1) < e(1) - L/2 || en(1) > e(1) + L/2)
            continue;
        end
        if (en(2) < e(2) - L/2 || en(2) > e(2) + L/2 )
            continue;
        end
        if en(3) < e(3) - deltaT || en(3) > e(3) + deltaT
            continue;
        end
        N_e{k,1} = en;
        k = k+1;
    end
    %         Calculate Plane Parameter using the points in N_e.
    plane_parameters = PlaneFitting(N_e);
    
    %         Steps 4 to 7
    epsilon = 10e6;
    disp(['this is the ', num2str(i), 'th event']);
    
    %         Step 5
    while epsilon > thresh1
        for j = 1:length(N_e)
            if plane_parameters'*[N_e{j,1} 1]' > thresh2
                N_e{j,1} = [];
                
            end
        end
        N_e = N_e(find(~cellfun(@isempty, N_e)> 0));
        P1 = PlaneFitting(N_e);
        %             Step 6
        epsilon = norm(P1 - plane_parameters);
        plane_parameters = P1;
    end
    Neighborhood{i} = N_e;
    parameters{i} = P1;
    
    %   Calculate Velocity
   
%     Choosing a Random Point in neighborhood with differnt coordinates (so that we dont get NaN)
    for l =1:length(N_e)
        second = cell2mat(N_e(l));
        if(second(1) ~= e(1) && second(2) ~= e(2) && second(3) ~= e(3))
            break;
            
        end
    end
    
% %   Calculating Slopes: dx/dt, dy/dt
    diff_x = e(1) - second(1);
    diff_y = e(2) - second(2);
    diff_t = e(3) - second(3);
    slope_x(i) = diff_x/diff_t;
    slope_x(i) = 1/slope_x(i);
    slope_y(i) = diff_y/diff_t;
    slope_y(i) = 1/slope_y(i);
end




end