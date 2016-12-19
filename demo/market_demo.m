% Prepare file index & class assignments.
addpath_scatnet;
DB_EANQTE='../sample/ean'
src = ean_src(DB_EANQTE);

% EAN files will be truncated to 1428 samples by default, so let's define
% the filters for this length.
N = 1428;

% Calculate coefficients with averaging scale of 8192 samples (~370 ms @
% 22050 Hz sampling rate).
T = 256;

% First-order filter bank with 8 wavelets per octave. Second-order filter bank
% with 1 wavelet per octave.
filt_opt.Q = [8 1];

% Calculate maximal wavelet scale so that largest wavelet will be of bandwidth 
% T.
filt_opt.J = T_to_J(T, filt_opt);

% Only calculate scattering coefficients up to second order.
scat_opt.M = 2;

% Prepare wavelet transforms to be used for scattering.
Wop = wavelet_factory_1d(N, filt_opt, scat_opt);

% Define feature function, taking a signal as input and returning a table
% of feature vectors.
feature_fun = @(x)(format_scat(log_scat(renorm_scat(scat(x, Wop)))));

% Only store every eighth feature vector (to reduce training complexity 
% later).
database_options.feature_sampling = 8;

% Calculate feature vectors for all files in src using feature_fun.
database = prepare_database(src, feature_fun, database_options);
disp(database);
