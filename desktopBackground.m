%% clc

clc;
close all;


%% Read data from file

data = load('Data2Use.asc');

%% Interp data

% Parameters
factorInterp = 10;
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

%% Definition of 

maxData = max(max(interpData));
minData = min(min(interpData));

range = abs(maxData-minData);

percentageOfPositiveData = maxData/range;
next = percentageOfPositiveData +  0.0001;


%% Definition of useful colors

blue = '#000080';
cyan = '#00FFFF';
yellow = '#FAFF55';
red = '#FF0000';

%% Custom colormap

myColorMap = customcolormap([0,percentageOfPositiveData,next,1],{red,yellow,cyan,blue},1024);

%% Print picture

f = figure();
i = imagesc(interpData');

axis off; grid off;
colormap(myColorMap);
f.Color = 'k';
f.InvertHardcopy = 'off';
saveas(f,"finalResult.png");




