clear all;

director = 'C:\Users\Dan\Desktop\disertatie\Baza de date\Noise';
Fs_default = 16000;
D = dir(fullfile(director,'*.wav'));
D = D(~ismember({D.name}, {'.', '..'}));
for i=1:numel(D)
    filename = fullfile(director,D(i).name);
    [y,Fs] = audioread(filename);
    y = resample(y,Fs_default,Fs);
    audiowrite(filename,y,Fs_default);
end