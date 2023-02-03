%% clc

clc;
clear all;
close all;


%% Read data from file

data = load('Data2Use.asc');

%% Interp data

% Parameters
factorInterp = 2;
typeInterp = 'linear';

% Determining of X,Y,Xq and Yq
X = 1:1:size(data,1);
Y = 1:1:size(data,2);
[XX,YY] = meshgrid(X,Y);

Xq = 1:1/factorInterp:size(data,1);
Yq = 1:1/factorInterp:size(data,2);
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

%% Definition of useful colors

blue = '#000080';
cyan = '#00FFFF';
yellow = '#FAFF55';
red = '#EA0000';
black = '#000000';

%% Custom colormaps

% For positive values
positiveColorMap = customcolormap([0,1],{red,yellow},512);

% For negative values
negativeColorMap = customcolormap([0,1],{cyan,blue},512);

%% Print data

titre = ['Brest, ',typeInterp];

figure('name',titre);

s = surface(positiveData);
view(3);
axis off; grid off;
s.EdgeColor = 'none';
colormap(positiveColorMap);
caxis([min(min(positiveData)),max(max(positiveData))]);

freezeColors();
hold on;

s2 = surface(negativeData);
view(3);
axis off; grid off;
s2.EdgeColor = 'none';
colormap(negativeColorMap);
caxis([min(min(negativeData)),0]);

title = titre;

