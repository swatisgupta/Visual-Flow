clear all;
clc;
load('../Data/Data.mat');
for i = 1:length(x)
    Events{i,1} = [x(i) y(i) ts(i)];
end

[Vx, Vy, Parameters] = Algorithm1(Events);


% Plot data
subplot(1,2,1)
plot3(x, y, ts, 'r.');
view(0,90)
title('Original Data')
subplot(1,2,2);
quiver(x, y, Vx', Vy');
title('Results')
saveas(gcf, '../Data/results.jpg');

