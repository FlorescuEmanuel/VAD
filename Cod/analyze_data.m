clear all;
close all;

tic

%% se adauga calea catre variabile
addpath variabile\

%% se adauga calea catre algoritmii de analiza folositi
addpath algoritmi\G729\
addpath algoritmi\LTSD\
addpath algoritmi\LTSV\
addpath algoritmi\voicebox\

%% se incarca variabilele necesare
load 'lista_vorbitori.mat';
load 'lista_zgomote.mat';

%% se incepe analiza semnalelor de intrare, folosind algoritmii selectati

SNR = -5:5:20;
Fs = 16000;
Nw = Fs * 0.02;
Nsh = Fs * 0.01;

G_729 = cell(numel(lista_vorbitori),numel(lista_vorbitori(1).inregistrari));
LTSD = cell(numel(lista_vorbitori),numel(lista_vorbitori(1).inregistrari));
LTSV = cell(numel(lista_vorbitori),numel(lista_vorbitori(1).inregistrari));
Sohn = cell(numel(lista_vorbitori),numel(lista_vorbitori(1).inregistrari));

for ctr_snr = 1:numel(SNR)
    for ctr_zgomot = 1:numel(lista_zgomote)
        for ctr_vorbitor = 1:numel(lista_vorbitori)
            for ctr_inregistrare = 1:numel(lista_vorbitori(ctr_vorbitor).inregistrari)
                y_semnal = lista_vorbitori(ctr_vorbitor).inregistrari(ctr_inregistrare).audio;
                y_zgomot = lista_zgomote(ctr_zgomot).audio;
                semnal = addnoise(y_semnal, y_zgomot(1:length(y_semnal)), SNR(ctr_snr), Fs);%verificare lungime semnal
                
                % se calculeaza etichetele folosind VAD G.729 
                G_729{int32(ctr_vorbitor), int32(ctr_inregistrare)} = G729(semnal,Fs,Nw,Nsh);
                
                % se calculeaza etichetele folosind VAD Ramirez
                LTSD{int32(ctr_vorbitor), int32(ctr_inregistrare)} = vadramirez(semnal,Fs);
                
                % se calculeaza etichetele folosind VAD van Segbroeck
                LTSV{int32(ctr_vorbitor), int32(ctr_inregistrare)} = vadsegbroeck(semnal,Fs,50,10);
                
                % se calculeaza etichetele folosind VAD SOHN 
                Sohn{int32(ctr_vorbitor), int32(ctr_inregistrare)} = vadsohn(semnal,Fs);
            end
        end
        save(sprintf('.\\variabile\\analiza\\%s_%s_%d.mat','G729',lista_zgomote(ctr_zgomot).nume,SNR(ctr_snr)),'G_729');
        save(sprintf('.\\variabile\\analiza\\%s_%s_%d.mat','LTSD',lista_zgomote(ctr_zgomot).nume,SNR(ctr_snr)),'LTSD');
        save(sprintf('.\\variabile\\analiza\\%s_%s_%d.mat','LTSV',lista_zgomote(ctr_zgomot).nume,SNR(ctr_snr)),'LTSV');
        save(sprintf('.\\variabile\\analiza\\%s_%s_%d.mat','Sohn',lista_zgomote(ctr_zgomot).nume,SNR(ctr_snr)),'Sohn');
    end
end

time_analyze_data = toc;