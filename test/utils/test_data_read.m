clear;

%% Test read lst file
file = '14100077121.lst';
[x,Nx] = data_read(file);
disp('size(x)')
size(x)
disp('size(Nx)')
size(Nx)
Nx
%% Test read wav file
file = 'chord_signal.wav'
[x,y] = data_read(file);
disp('size(x)')
size(x)
disp('size(y)')
size(y)
Nx
%% Test read au file (todo)

