clear all;
clc;
load('../Data/Data.mat');
for i = 1:length(x)
    Events{i,1} = [x(i) y(i) ts(i)];
end

[Parameters] = Algorithm1(Events);

% Plotting code
X = 1:length(I);
Y = 1:length(I);
tmin = min(ts);
tmax = max(ts);
T = tmin:tmax;

%[X1,Y1,T1] = meshgrid(x,y,ts);
[X1,Y1,T1] = meshgrid(X,Y,T);
quiver(x,y,Velocity{:,1}, Velocity{:,2});


