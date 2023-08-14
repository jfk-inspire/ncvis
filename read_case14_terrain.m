%Demonstrates Suite of Matlab scripts for loading NetCDF data generated 
%by NUMA and doing basic visualization

%James F. Kelly
%14 August 2023


close all;
clear all;

p00 = 1e5;
rgas = 287.17;  
cp = 1004.67;
cv = 717.5;
gamma = cp/cv;
earth_rad = 6.37122e6;
kappa = rgas/cp;
gravity = 9.80616;

%This netcdf file is low res (E10P5L26) with no cos^2 factor
frame = 30;                                 %output frame to plot
base = ['case14_curl-invariant_100.000000_set2nc_cgc_ark2_no_schur_1d_p6est_'];  %base file name
file = [base num2str(frame,'%4.4d') '.nc'];


%Read NetCDF Output
[coord_cart, vel_cart, rho, theta,time] = read_numa_nc(file);
time_days = time./86400;

%Convert to column/level format
[rho, us, vs, ws, theta, lon, lat, height] ...
    = convert_neptune_format(coord_cart, vel_cart, rho, theta, file);

%Create a longitude/height slice at the equator
[lon_slice, height_slice, us_slice] = ...
    create_lon_height_slice(lon,lat,height,us);

[lon_slice, height_slice, ws_slice] = ...
    create_lon_height_slice(lon,lat,height,ws);


%Use equation of state to get pressure
press = p00.*(rho.*rgas.*theta./p00).^gamma;

%Create a lon/lat slice of surface pressure
[loni,lati,psi] = create_lon_lat_slice(lon,lat,1,press);

%Convert to hPa
psi = psi./100;


figure(1)
contourf(lon_slice,height_slice,us_slice)
set(gca,'FontSize',22)
xlabel('longitude')
ylabel('height (km)')
colorbar
title('zonal velocity (m/s)')
colormap jet
axis tight

figure(2)
contourf(lon_slice,height_slice,ws_slice)
set(gca,'FontSize',22)
xlabel('longitude')
ylabel('height (km)')
colorbar
title('vertical velocity (m/s)')
colormap jet
axis tight


figure(3)
contourf(loni,lati,psi);
set(gca,'FontSize',22)
xlabel('longitude')
ylabel('latitude')
colorbar
title('surface pressure (hPa)')
colormap jet
axis tight


