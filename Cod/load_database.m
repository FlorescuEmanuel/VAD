clear all
close all;

tic

addpath algoritmi\G729\

%% parcurgerea fisierelor cu inregistrari audio si salvarea acestora intr-o lista

lista_vorbitori = {};
ctr_inregistrare = 1;
ctr_vorbitori = 1;
director_vorbitori = 'C:\Users\Emi\Desktop\disertatie\Baza de date\BD_TIMIT\wav\'; % directorul cu fisiere audio, cale absoluta
DV = dir(director_vorbitori);
DV = DV(~ismember({DV.name}, {'.', '..'})); % se elimina folderele '.' si '..'
for i = 1:numel(DV)
    if ctr_inregistrare == 11 % stim ca pentru fiecare vorbitor exista cate 10 inregistrari
        ctr_inregistrare = 1; % se reseteaza counter-ul pentru numarul inregistrarii
        ctr_vorbitori = ctr_vorbitori + 1; % se reseteaza counter-ul pentru numarul vorbitorului
    end
    gen = DV(i).name(1); % se creeaza genul (m/f) - primul caracter din numele fisierului
    numar = regexp(DV(i).name, '[fm](\d*)_','tokens'); % se creeaza numarul vorbitorului
    filename = fullfile(director_vorbitori,DV(i).name); % se creeaza calea absoluta pentru fiecare fisier 
    [y, Fs] = audioread(filename); % se citeste fisierul audio
    lista_vorbitori(ctr_vorbitori).gen = gen; % se salveaza genul
    lista_vorbitori(ctr_vorbitori).numar = strcat(gen,num2str(cell2mat(numar{:}))); % se salveaza id-ul
    lista_vorbitori(ctr_vorbitori).inregistrari(ctr_inregistrare).nume = DV(i).name(1:length(DV(i).name)-4);
    lista_vorbitori(ctr_vorbitori).inregistrari(ctr_inregistrare).fisier = filename; % se salveaza numele si calea fisierului
    lista_vorbitori(ctr_vorbitori).inregistrari(ctr_inregistrare).audio = y; % se salveaza stream-ul audio
    lista_vorbitori(ctr_vorbitori).inregistrari(ctr_inregistrare).etichete = G729(y, Fs, 320, 160); % se salveaza etichetele
    ctr_inregistrare = ctr_inregistrare + 1;
end

%% parcurgerea fisierelor cu zgomote si salvarea acestora intr-o lista

director_zgomote = 'C:\Users\Emi\Desktop\disertatie\Baza de date\Noise\*.wav'; % directorul cu fisiere audio
DZ = dir(director_zgomote);
DZ = DZ(~ismember({DZ.name}, {'.', '..'}));
director_zgomote = director_zgomote(1:length(director_zgomote)-5); % se sterg ultimele 5 caractere din calea directorului
for i = 1:numel(DZ)
    filename = fullfile(director_zgomote,DZ(i).name); % se construieste calea absoluta catre fisierele audio
    [y, Fs] = audioread(filename); % se citesc fisierele audio
    lista_zgomote(i).nume = DZ(i).name(1:length(DZ(i).name)-4); % se salveaza numele fisierelor cu zgomot
    lista_zgomote(i).fisier = filename; % se salveaza numele si calea fisierelor
    lista_zgomote(i).audio = y; % se salveaza stream-ul audio
end

%% salvarea listelor in fisiere .mat, pentru incarcarea ulterioara intr-un alt script

save(sprintf('.\\variabile\\%s.mat','lista_vorbitori'),'lista_vorbitori');
save(sprintf('.\\variabile\\%s.mat','lista_zgomote'),'lista_zgomote');

time_load_database = toc;