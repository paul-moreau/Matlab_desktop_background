%% Read data from file

data = load('Data2Use.asc');

%% Interp data

% Parameters
factorInterp = 2;
typeInterp = 'linear';

% Determining of X,Y,Xq and Yq
X = 1:1:size(m,1);
Y = 1:1:size(m,2);
[XX,YY] = meshgrid(X,Y);

Xq = 1:1/factorInterp:size(m,1);
Yq = 1:1/factorInterp:size(m,2);
[XqXq,YqYq] = meshgrid(Xq,Yq);

% Interpolation
dataInterp = interpn(XX',YY',data,XqXq,YqYq,typeInterp);
