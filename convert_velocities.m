function [vel_sph, coord_sph] = convert_velocities(vel_cart,coord_cart)
% [vel_sph, coord_sph] = convert_velocities(vel_cart,coord_cart)
% Converts coordinates and velocities in Cartesian coordinates to
% coordinates and velocities in spherical coordinates.
% [vel_sph] = [zonal meridional vertical]
% [coord_sph] = [lon lat height]


  vel_sph = zeros(size(vel_cart));
  coord_sph = zeros(size(coord_cart));
  npoin = size(coord_cart,1);
  T_sph2cart = zeros(3,3);
  earth_rad = 6.37122e6;
  for ix = 1:npoin
    x = coord_cart(ix,1);
    y = coord_cart(ix,2);
    z = coord_cart(ix,3);
  
    tol = 1.0e-16;
    r = sqrt(x*x + y*y + z*z);
    height = r - earth_rad;
    lam = atan2(y, x + tol);
    phi = asin(z/r);
    
    coord_sph(ix,:) = [lam phi height]';
    sinlam = sin(lam);
    coslam = cos(lam);
    sinphi = sin(phi);
    cosphi = cos(phi);

   
%Construct the forward transformation matrix
        T_sph2cart(1,1) = -sinlam;
        T_sph2cart(1,2) = -sinphi*coslam;
        T_sph2cart(1,3) = cosphi*coslam;
        T_sph2cart(2,1) = coslam;
        T_sph2cart(2,2) = -sinphi*sinlam;
        T_sph2cart(2,3) = cosphi*sinlam;
        T_sph2cart(3,1) = 0.0;
        T_sph2cart(3,2) = cosphi;
        T_sph2cart(3,3) = sinphi;
        T_cart2sph = inv(T_sph2cart);
    
        u_cart = vel_cart(ix,:)';
     
        
        u_sph = T_cart2sph*u_cart;
        
        vel_sph(ix,:) = u_sph;
        
  end       