
function cluster_table = findclusters(RA, DEC, dist, plottitle)

%{

This function identifies stellar overdensities in 3D space by applying a
nearest neighbor approach.

Example function call:

    findclusters(data{:,'RA (degrees)'}, data{:,'DEC (degrees)'}, data{:,'r_hi_geo (pc)'}, 'Example Plot')

            - data for this example can be found here: https://github.com/saida-caballero/gaia_50pc/tree/main/Data


Input(s):

* RA        - Right ascension values of all data points in DECIMAL DEGREES. 
            - data type: n x 1 double

* DEC       - Declination values of all data points in DECIMAL DEGREES.
            - data type: n x 1 double

* dist      - Distance values (from observer/Sun) of all data points in any units.
            - data type: n x 1 double

* plottitle - Desired title for output plot of plotstars3d.m.
            - data type: a string


Output(s):

* MATLAB figure (histogram)
* n x 3 table of RA, DEC, and dist for the rows of your data that are
    clustered
* MATLAB 3D figure (output of plotstars3d.m)


Dependencies:

* This function is dependent on the external function plotstars3d.m
    This can be downloaded here: https://github.com/saida-caballero/gaia_50pc


Author(s):

* Function created by Rhiannon Hicks
* Creation date: 6-19-2025


Update History:

* None

%}


%% function script start


% Convert right ascension and declination into radians.
RA = deg2rad(RA);
DEC = deg2rad(DEC);

% Convert into cartesian coordinates.
[x,y,z] = sph2cart(RA, DEC, dist);

% Get input for nearest neighbor calculation.
nn_data = [x y z];

% Calculate the 100 nearest neighbors for each star in dataset. Returns
% index position `ind` and distance value `d`.
[ind, d] = knnsearch(nn_data, nn_data, 'K', 101, 'Distance', 'euclidean'); 

% Find the mean distance value of all first nearest neighbors. This is
% referenced as 'criteria 1' throughout the rest of this script.
mean_1nn = mean(d(:,2));

% Identify the index position (column 1 of `num_cluster_array`), and the
% total number of stars for that index position who have `d` less than or 
% equal to criteria 1 (column 2 of `num_cluster_array`).
num_cluster_array = zeros(size(d,1),2);

for n = 1:size(d,1)
    
    count = find(d(n,2:end) <= mean_1nn);
    num_cluster_array(n,1) = ind(n,1);
    num_cluster_array(n,2) = size(count,2);
    
end

% Calculate the mean and standard deviation of column 2 of
% `num_cluster_array`.
mean_cluster = mean(num_cluster_array(:,2));
std_cluster = std(num_cluster_array(:,2));

% Identify the necessary number of total stars that meet criteria 1 to be
% considered in a cluster. This is referenced as 'criteria 2' throughout
% the rest of this script.
mem_criteria = floor(mean_cluster + (3 * std_cluster) );



% Create a histogram to visualize the input data and criteria 2 value.
figure('Position',[600 100 1000 500]);
num_clus_h = histogram(num_cluster_array(:,2), 'BinWidth', 1);
hold on

% Optimize plot features.
pos = max(num_clus_h.BinCounts);

% Plot the mean.
line([mean_cluster, mean_cluster], ylim, 'LineWidth', 1, 'Color', 'r');
txt1 = '\leftarrow mean';
text(mean_cluster, pos, txt1, 'FontSize', 16)

% Plot the 3 sigma 99.7% of data.
line([mean_cluster+(3*std_cluster), mean_cluster+(3*std_cluster)], ylim, 'LineWidth', 1, 'Color', 'k', 'LineStyle', '--');
txt4 = sprintf('\\leftarrow 3\\sigma ~ %i members', mem_criteria);
text(mean_cluster + (3 * std_cluster), pos, txt4, 'FontSize', 14)

% Other labels.
title('Investigating Cluster Membership Criteria Cutoff', 'fontsize', 24);
xlabel('Number of Stars Within Mean Distance of First Nearest Neighbor', 'fontsize', 18);
ylabel('Frequency', 'fontsize', 18);

hold off



% Find all the stars who exceed criteria 2.
cluster_stars_initial = find(num_cluster_array(:,2) > mem_criteria);

% The purpose of the next part of the script is to ensure the final
% function output contains all of the neighbors for stars who exceed 
% criteria 2. This way, if a neighboring star does not exceed criteria 2
% itself, it is still recorded as being in a cluster. 

% Initialize an array with all nan values.
ind_array = nan(length(cluster_stars_initial), max(num_cluster_array(:,2)) + 1);

% Populate array with indicies of each member of `cluster_stars_initial`
% and all its neighbors that exceed criteria 2.
for z = 1:length(cluster_stars_initial)

    ind_array(z,1:(num_cluster_array(cluster_stars_initial(z),2)+1)) = ind(cluster_stars_initial(z),1:(num_cluster_array(cluster_stars_initial(z),2)+1));

end

% Downsize `ind_array` by getting rid of nan's and duplicate values.
% `cluster_stars_final` will contain the finalized list of indicies for
% stars who are designated as in a cluster.
cluster_stars_final = reshape(ind_array, ( size(ind_array,1) * size(ind_array,2) ), 1);
cluster_stars_final(any(isnan(cluster_stars_final), 2), :) = [];
cluster_stars_final = unique(cluster_stars_final);

% Create, populate, and label the output table.
cluster_table = table();
cluster_table{:,1} = rad2deg(RA(cluster_stars_final));
cluster_table{:,2} = rad2deg(DEC(cluster_stars_final));
cluster_table{:,3} = dist(cluster_stars_final);
cluster_table.Properties.VariableNames = {'RA', 'DEC', 'dist'};



% Call external function to plot the clustered stars in 3D
plotstars3d(cluster_table{:,'RA'}, cluster_table{:,'DEC'}, cluster_table{:,'dist'}, plottitle);


end
