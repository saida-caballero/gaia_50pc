
function plotstars3d(RA, DEC, dist, plottitle)

%{

This function generates a 3D plot to visualize stellar positional data.

Example function call:

    plotstars3d(data{:,'RA (degrees)'}, data{:,'DEC (degrees)'}, data{:,'r_hi_geo (pc)'}, 'Example Plot')

            - data for this example can be found here: https://github.com/saida-caballero/gaia_50pc/tree/main/Data


Input(s):

* RA        - Right ascension values of all data points in DECIMAL DEGREES. 
            - data type: n x 1 double

* DEC       - Declination values of all data points in DECIMAL DEGREES.
            - data type: n x 1 double

* dist      - Distance values (from observer/Sun) of all data points in any units.
            - data type: n x 1 double

* plottitle - Desired title for output plot.
            - data type: a string
 

Output(s):

* 3D MATLAB figure


Dependencies:

* This function is not dependent on any other external functions/scripts.


Author(s):

* Function created by Rhiannon Hicks
* Creation date: 6-12-2025


Update History:

* None

%}


%% function script start


% Convert right ascension and declination into radians.
RA = deg2rad(RA);
DEC = deg2rad(DEC);


% Convert into cartesian coordinates, this is what will be plotted.
[x,y,z] = sph2cart(RA, DEC, dist);

% These are hardcoded values needed for galactic pole, celestial pole, and galactic
% plane.
dec_NGP_orig = 27.12825;
ra_NGP_orig = 192.8595;
l_NCP_orig = 122.932;
dec_SGP_orig = -27.12825;
ra_SGP_orig = 12.8595;

% Converting hardcoded values into radians.
ra_NGP = deg2rad(ra_NGP_orig);
dec_NGP = deg2rad(dec_NGP_orig);
ra_SGP = deg2rad(ra_SGP_orig);
dec_SGP = deg2rad(dec_SGP_orig);
ra_NCP = deg2rad(0);
dec_NCP = deg2rad(90);
ra_SCP = deg2rad(0);
dec_SCP = deg2rad(-90);

% Cartesian coordinates for galactic pole.
[a1,a2,a3] = sph2cart(ra_NGP, dec_NGP, 70);
[b1,b2,b3] = sph2cart(ra_SGP, dec_SGP, 70);
gpoles = [a1, a2, a3; b1, b2, b3];

% Cartesian coordinates for celestial pole.
[c1,c2,c3] = sph2cart(ra_NCP, dec_NCP, 70);
[d1,d2,d3] = sph2cart(ra_SCP,dec_SCP,70);
cpoles = [c1, c2, c3; d1, d2, d3];

% Galactic plane coordinates in galactic coordinates (hardcoded).
g_long = linspace(0,360,360)'; % b values
g_lat = zeros(1,360)'; % l values

% Converting galactic coordinates into RA and DEC.
sin_plane_dec = asind((sind(dec_NGP_orig).*sind(g_lat))+(cosd(dec_NGP_orig).*cosd(g_lat).*cosd((l_NCP_orig-g_long))));
plane_dec = zeros(1,360)';

for i = 1:length(sin_plane_dec)
    if sin_plane_dec(i) >=0 
        plane_dec(i) = 180-sin_plane_dec(i);
    else
        plane_dec(i) = sin_plane_dec(i);
    end
end

% Final coordinates for plane RA values.
plane_ra = asind((cosd(g_lat).*sind(l_NCP_orig-g_long))./(cosd(plane_dec)))+ra_NGP_orig;
plane_ra_rad = deg2rad(plane_ra);

% Final coordinates for plane DEC values.
plane_dec_rad = deg2rad(plane_dec);

% Cartesian coordinates for galactic plane.
g_dist = 50*ones(1,360)';
[e1,e2,e3] = sph2cart(plane_ra_rad, plane_dec_rad, g_dist);

% Coordinates for galactic center.
gal_cen = [0 0 0; e1(1) e2(1) e3(1)];

% Optimizing features for sphere plot.
[X,Y,Z] = sphere;                                                  
figure;
hm = mesh(X,Y,Z);
hold on

% Plotting data.
h1 = plot3(x, y, z, '.', 'MarkerSize', 1, 'MarkerFaceColor','b', 'DisplayName', 'Stars');
% Plot galactic poles.
h2 = plot3(gpoles(:,1), gpoles(:,2), gpoles(:,3), 'MarkerSize', 1, 'MarkerFaceColor','k', 'Color', 'k', 'LineWidth', 2, 'DisplayName', 'Galactic Pole');
% Plot celestial poles.
h3 = plot3(cpoles(:,1), cpoles(:,2), cpoles(:,3), 'MarkerSize', 1, 'MarkerFaceColor','r', 'Color', 'r', 'LineWidth', 2, 'DisplayName', 'Celestial Pole');
% Plot galactic plane.
h4 = plot3(e1, e2, e3, '--', 'Color', 'k', 'LineWidth', 1, 'DisplayName', 'Galactic Plane');
% Plot galactic center.
h5 = plot3(gal_cen(:,1), gal_cen(:,2), gal_cen(:,3), '->', 'Color', 'k', 'Linewidth', 1, 'DisplayName', 'Towards Galactic Center');

hold off

% Optimizing plot viewing features.
axis equal
set(hm, 'EdgeAlpha', '0' ,'FaceAlpha',0)
view(55,20)

% Creating legend.
handlevec = [h1 h2 h3 h4 h5];
legend(handlevec)

% Adding a title.
title(plottitle, 'FontSize', 24)

end
