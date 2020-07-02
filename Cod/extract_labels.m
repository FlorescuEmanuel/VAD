clear all;

Fs_default = 16000;
director = 'C:\Users\Dan\Desktop\disertatie\Baza de date\BD_ATM\wav';
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
            labels = vadsohn(y,Fs);
            str = SSD(k).name;
            str = str(1:length(str)-4);
            name = strcat(director,'\',D(i).name,'\',SD(j).name,'\',str,'_labels','.mat');
            save(name,'labels');
        end
   end
end