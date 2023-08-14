function [lon_slice, height_slice, us_slice] = ...
    create_lon_height_slice(lon,lat,height,us)
%[lon_slice, height_slice, us_slice] = ...
%    create_lon_height_slice(lon,lat,height,us)

nz = size(us,1);
loni_eq = -180:179;
lon_slice = zeros(nz,360);
height_slice = zeros(nz,360);
us_slice = zeros(nz,360);
ieq = find(abs(lat)<1);   %just consider columns in a belt around the equator

lon1 = lon(ieq);
lat1 = lat(ieq);
us1 = us(:,ieq);
height1 = height(:,ieq);

for iz = 1:nz
    us_interp = scatteredInterpolant(lon1,lat1,us1(iz,:)');
    usii = us_interp(loni_eq,0.0.*loni_eq);
    us_slice(iz,:) = usii;
    zs = height1(iz,:)';
    height_interp = scatteredInterpolant(lon1,lat1,zs);
    hii = height_interp(loni_eq,0.0.*loni_eq);
    height_slice(iz,:) = hii./1e3;
    lon_slice(iz,:) = loni_eq;
end

end