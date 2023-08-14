function [coord_cart, vel_cart, rho, theta,time] = read_numa_nc(file)
% [coord_cart, vel_cart, rho, theta,time] = read_numa_nc(file)

time = ncread(file,'time');
rho = ncread(file,'density');
theta = ncread(file,'theta');
u = ncread(file,'u'); 
v = ncread(file,'v'); 
w = ncread(file,'w');

x = ncread(file,'x'); y = ncread(file,'y'); z = ncread(file,'z');

%Remove Repetitions
coord_cart = [x y z];
[coord_cart,ia,ic] = unique(coord_cart,'rows','stable');
u = u(ia); v = v(ia); w = w(ia);
rho = rho(ia); theta = theta(ia);
vel_cart = [u v w];


end