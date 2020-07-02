clear all;

director = 'C:\Users\Dan\Desktop\disertatie\Baza de date\Noise';
Fs = 19980;
D = dir(fullfile(director,'*.mat'));
D = D(~ismember({D.name}, {'.', '..'}));
for i=1:numel(D)
    filename = fullfile(director,D(i).name);
    y = load(filename);
    signal = fieldnames(y);
    new_filename=strrep(filename,'.mat','.wav');
    audiowrite(new_filename,y.(char(signal)),Fs);
end