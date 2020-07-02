clear all
close all;

addpath algoritmi\G729\
load lista_zgomote.mat;

%% parcurgerea fisierelor cu inregistrari audio si salvarea acestora

director_vorbitori = 'C:\Users\Emi\Desktop\disertatie\Baza de date\BD_TIMIT\2_recunoastere_vorbitor\selectii\antrenare_fara_VAD'; % directorul cu fisiere audio, cale absoluta
director_after = 'C:\Users\Emi\Desktop\disertatie\Baza de date\BD_TIMIT\2_recunoastere_vorbitor\selectii\antrenare_cu_VAD';
DV = dir(director_vorbitori);
DV = DV(~ismember({DV.name}, {'.', '..'})); % se elimina folderele '.' si '..'
for i = 1:numel(DV)
    filename = fullfile(director_vorbitori,DV(i).name); % se creeaza calea absoluta pentru fiecare fisier 
    [y, Fs] = audioread(filename); % se citeste fisierul audio
    etichete = G729(y, Fs, 320, 160); % se salveaza etichetele
    y_after = y(etichete == 1);
    filename_after = fullfile(director_after,DV(i).name);
    audiowrite(filename_after,y_after,Fs);
end


