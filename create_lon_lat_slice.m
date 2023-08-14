function [loni, lati, usi] = create_lon_lat_slice(lon,lat,ilev,us)
%[loni, lati, usi] = create_lon_lat_slice(lon,lat,ilev,us)
% Create a lon-lat plot at height level ilev
% Assumes 1 degree spacing in both lon and lat

[loni, lati] = meshgrid(-179:1:180,-90:1:90);
us_interp = scatteredInterpolant(lon,lat,us(ilev,:)');
usi = us_interp(loni,lati);

end