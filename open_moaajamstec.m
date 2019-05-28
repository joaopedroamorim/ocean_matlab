clear all; close all; clc

%Initial script for read different files of MOAA/JAMSTEC reanalysis with
%different names

addpath '~/Desktop/MOAA_GPV'; %Path of the directory containg the files
str = dir('~/Desktop/MOAA_GPV/TS_*.nc'); %Uploading files names
pasta = cell(12,18);%Creating a cell with months on lines and years on columns

%Data files strings changes with months and years, here i'm uploading them
%all
for i = 1:size(pasta,2)
    for m = 1:12
    if i<= 9 && m<=9;
    pasta{m,i} = dir(['~/Desktop/MOAA_GPV/TS_200',num2str(i),'0',num2str(m),'_GLB.nc']);
    else if i<= 9 && m>9;
    pasta{m,i} = dir(['~/Desktop/MOAA_GPV/TS_200',num2str(i),num2str(m),'_GLB.nc']);       
    elseif i>9 && m<=9;
    pasta{m,i} = dir(['~/Desktop/MOAA_GPV/TS_20',num2str(i),'0',num2str(m),'_GLB.nc']);
    elseif i>9 && m>9;
    pasta{m,i} = dir(['~/Desktop/MOAA_GPV/TS_20',num2str(i),num2str(m),'_GLB.nc']);
    end
    end
    end
end

%Variable with the name of eachfile
name = cell(size(pasta));
for i = 1:size(name,2);
    for m = 1:size(name,1);
        name{m,i} = pasta{m,i}.name;
    end
end

%%%Opening the first file just to get constant variables and create sizes
lon = ncread(name{1,1},'LONGITUDE');
lat = ncread(name{1,1},'LATITUDE');
dep = ncread(name{1,1},'PRES');

%Creating T-S variables and cells to storage my T-S data
temp = zeros(size(lon,1),size(lat,1),size(dep,1),size(pasta,1));
sal = zeros(size(lon,1),size(lat,1),size(dep,1),size(pasta,1));
TEMP = cell(size(pasta,2),1);
SALT = cell(size(pasta,2),1);

for y = 1:size(pasta,2)
    for m = 1:size(pasta,1);
    temp(:,:,:,m) = ncread(name{m,y},'TOI');
    sal(:,:,:,m) = ncread(name{m,y},'SOI');
    end
TEMP{y,1} = temp;
SALT{y,1} = sal;

clear temp sal
end
