clear all;

Fs_default = 16000;
director_zgomot = 'C:\Users\Dan\Desktop\disertatie\Baza de date\Noise';
D_zgomot = dir(fullfile(director_zgomot,'*.wav'));
D_zgomot = D_zgomot(~ismember({D_zgomot.name}, {'.', '..'}));
for i=1:numel(D_zgomot)
    filename = fullfile(director_zgomot,D_zgomot(i).name);
    str = D_zgomot(i).name;
    str = str(1:length(str)-4);
    tip_zgomot{i,1} = str;
    [y_zgomot(i,:),Fs_zgomot(i,:)] = audioread(filename);
end

director = 'C:\Users\Dan\Desktop\disertatie\Baza de date\BD_ATM\test';
D = dir(director);
D = D(~ismember({D.name}, {'.', '..'}));
for i=1:numel(D)
    SD = dir(fullfile(director,D(i).name)); 
    SD = SD(~ismember({SD.name}, {'.', '..'}));
    for j=1:numel(SD)
        SSD = dir(fullfile(director,D(i).name,SD(j).name,'*.wav'));
        SSD = SSD(~ismember({SSD.name}, {'.', '..'}));
        for k = 1:numel(SSD)
            filename = fullfile(director,D(i).name,SD(j).name,SSD(k).name);
            [y,Fs] = audioread(filename); 
            for i_zgomot = 1:size(y_zgomot,1)
                for snr = -10:10:20
                    [y_noisy, noise] = addnoise(y,y_zgomot(i_zgomot,:)',snr,Fs_zgomot(i));
                    name = strcat(director,'\',D(i).name,'\',SD(j).name,'\',tip_zgomot{i_zgomot,1},'_',num2str(snr),'_',SSD(k).name);
                    audiowrite(name,y_noisy,Fs);
                end
            end
            audiowrite(filename,y,Fs_default,'BitsPerSample',16);
        end
   end
end