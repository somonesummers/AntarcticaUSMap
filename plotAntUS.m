clear
close all
US = shaperead('cb_2018_us_state_500k/cb_2018_us_state_500k.shp');
load Coastxy.mat %this loads the coast of Antarctica, for reference only. 

const = jsondecode(fileread('projection_constants.json'));

lamb = Lambert(...
    [const.phi_1, const.phi_2],  ...  % Latitude of the first and second standard parallel (33 and 45)
    const.phi_F, const.lambda_F, ...  % Central latitude and longitude (I use Center of Cont. US)
    const.E_F, const.N_F,        ...  % False easting and northing (0,0)
    const.a, const.f_inv         ...  % Ellipsoid: Semi-major axis and inverse flattening
);

figure
for i = 1:numel(US)
    %This is all US territories, here I exclude non-continental regions
    if (max(i == [46,45,43,39,38,28,14]) ~= 1)  
        [x_proj, y_proj] = lamb.geographic2cartesian(US(i).Y, US(i).X);
        plot(x_proj,y_proj,'k-','linewidth',2);
        hold on
    end
end
% 
plot(coastxy(1,:),coastxy(2,:),'b','linewidth',2);
