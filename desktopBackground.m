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
interpData = interpn(XX',YY',data,XqXq,YqYq,typeInterp);

%% Separate data : positive datas and negative datas

negativeData = zeros(size(interpData));
positiveData = zeros(size(interpData));

for i = 1:1:size(interpData,1)
    for j = 1:1:size(interpData,2)
        negativeData(i,j) = NaN;
        positiveData(i,j) = NaN;
        if(interpData(i,j)>=0)
            positiveData(i,j) = interpData(i,j);
        else
            negativeData(i,j) = interpData(i,j);
        end
    end
end
