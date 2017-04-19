function [P] = PlaneFitting(N_e)
 Mat = [];
 for i =1:length(N_e)
   Mat = [Mat; N_e{i,1} 1];     
 end 
 
 P = lsqlin(Mat,zeros(length(N_e), 1),[],[],[]);
   
end