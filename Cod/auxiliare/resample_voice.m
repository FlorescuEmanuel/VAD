clear all;

Fs_default = 16000;
%director = '..\..\Baza de date\BD_ATM\wav';
director = 'C:\Users\Dan\Desktop\disertatie\Baza de date\BD_TIMIT\wav';
D = dir(director);
D = D(~ismember({D.name}, {'.', '..'}));
for i=1:numel(D)
    SD = dir(fullfile(director,D(i).name)); 
    SD = SD(~ismember({SD.name}, {'.', '..'}));
    for j=1:numel(SD)
        SSD = dir(fullfile(director,D(i).name,SD(j).name));
        SSD = SSD(~ismember({SSD.name}, {'.', '..'}));
        for k = 1:numel(SSD)
            filename = fullfile(director,D(i).name,SD(j).name,SSD(k).name);
            [y,Fs] = audioread(filename); 
            %y = [zeros(Fs,1); y; zeros(Fs,1)];
            y = resample(y,Fs_default,Fs);
            audiowrite(filename,y,Fs_default,'BitsPerSample',16);
        end
   end
end