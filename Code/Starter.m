clear all;
clc;
load('../Data/Data.mat');
for i = 1:length(x)
    e = [x(i) y(i) ts(1)];
    Events{i,1} = e;
end
[Velocity, P] = Algorithm1(Events);

X = 1:length(I);
Y = 1:length(I);
tmin = min(ts);
tmax = max(ts);
T = tmin:tmax;

%[X1,Y1,T1] = meshgrid(x,y,ts);
[X1,Y1,T1] = meshgrid(X,Y,T);
quiver(x,y,Velocity{:,1}, Velocity{:,2});


