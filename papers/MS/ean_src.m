% EAN_SRC Creates a source for the EAN dataset
%
% Usage
%    src = EAN_SRC(directory, N)
%
% Input
%    directory (char): The directory containing the EAN dataset.
%    N (int): The size to which the audio files are to be truncated (default 
%       5*2^17).
%
% Output
%    src (struct): The EAN source.
%
% Description
%    Creates a source index for the EAN dataset
%
% See also
%    CREATE_SRC

function src = ean_src(directory,N)
	if nargin < 1
		directory = 'ean';
	end
	
	if nargin < 2
		N = 1428;
	end
	
	src = create_src(directory,@(file)(ean_objects_fun(file,N)));
end

function [objects,classes] = ean_objects_fun(file,N)
	objects.u1 = 1;
	objects.u2 = N;
	
	path_str = fileparts(file);
	
	path_parts = regexp(path_str,filesep,'split');
	
	classes = {path_parts{end}};
end