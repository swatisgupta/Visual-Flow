function [V, ResP] = Algorithm1(Events)
  L = 3;
  deltaT = 1e-3;
  thresh1 = 1e-2;
  thresh2 = 1e-2;
  Neighborhood = cell(length(Events),1);
  for i = 1:length(Events)
    e = Events{i}; k = 1; 
    for j = 1:length(Events)
        en = Events{j};
        if (en(1,1) < e(1) - L/2 || en(1) > e(1) + L/2) 
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
    
    P0 = PlaneFitting(N_e);
    
    epsilon = 10e6;
    
    while epsilon > thresh1
      for j = 1:length(N_e)
        if P0'*[N_e{j,1} 1]' > thresh2
            N_e{j,1} = [];
        end 
      end
      N_e = N_e(find(~cellfun(@isempty, N_e)> 0));
      P1 = PlaneFitting(N_e);
      epsilon = norm(P1 - P0);
      P0 = P1;
    end
    Neighborhood{i} = N_e;
    ResP{i} = P1;
  end
  
end