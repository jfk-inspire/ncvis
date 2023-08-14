function [rho, us, vs, ws, theta, lon, lat, height] ...
    = convert_neptune_format(coord_cart, vel_cart, rho, theta, file)
% [rho, us, vs, ws, theta, lon, lat, height] ...
%    = convert_neptune_format(coord_cart, vel_cart, rho, theta, file)
% Converts Global NUMA NetCDF data to a format similar to NEPTUNE HDF5
% Output data is stored as nz by ncol, where ncol is the number of unique
% columns and nz is the number of vertical layers

% James F. Kelly
% 11 August 2023

nelz = ncread(file,'nelz');
nopz = ncread(file,'nopz');
nz = nelz*nopz + 1;
npoin = length(rho);
ncol = npoin/nz;


[vel_sph, coord_sph] = convert_velocities(vel_cart,coord_cart);
rho = reshape(rho,nz,ncol);
us = reshape(vel_sph(:,1),nz,ncol);
vs = reshape(vel_sph(:,2),nz,ncol);
ws = reshape(vel_sph(:,3),nz,ncol);
theta = reshape(theta,nz,ncol);
lon0 = reshape(coord_sph(:,1),nz,ncol);
lon = lon0(1,:);
lat0 = reshape(coord_sph(:,2),nz,ncol);
lat = lat0(1,:);
height = reshape(coord_sph(:,3),nz,ncol);

%Convert to degrees
lon = 180./pi.*lon';
lat = 180./pi.*lat'; 

end
