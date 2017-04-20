function [parameters] = Algorithm1(Events)

% Setting Neighborhood parameters as described in paper
L = 11;
deltaT = 150;
thresh1 = 1e-5;
thresh2 = 5e-2;
%     Create empty neighborhood
Neighborhood = cell(length(Events),1);

%     Step 1 and 2
% for i = 1:length(Events)
for i = 1:100
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
                
            else 
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
end

%   Calculate Velocity ..(Yet To Complete)

for i = 1:length(parameters)
    
    pixel1 = 
    
    
    
    
    
end

end