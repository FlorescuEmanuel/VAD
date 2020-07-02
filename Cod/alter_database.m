clear all;
close all;

addpath variabile\;

load lista_vorbitori.mat;
load lista_zgomote.mat;

SNR = -10:5:20;
Fs = 16000;
director = 'C:\Users\Dan\Desktop\disertatie\Baza de date\BD_ATM\Semnale\';

for ctr_vorbitor = 1:numel(lista_vorbitori)
    for ctr_inregistrare = 1:numel(lista_vorbitori(ctr_vorbitor).inregistrari)
        for ctr_zgomot = 1:numel(lista_zgomote)
            for ctr_snr = 1:numel(SNR)
                snr = SNR(ctr_snr);
                gen = lista_vorbitori(ctr_vorbitor).gen;
                zgomot = lista_zgomote(ctr_zgomot).nume;
                nume = lista_vorbitori(ctr_vorbitor).inregistrari(ctr_inregistrare).nume;
                y_semnal = lista_vorbitori(ctr_vorbitor).inregistrari(ctr_inregistrare).audio;
                y_zgomot = lista_zgomote(ctr_zgomot).audio;
                %semnal = addnoise(y_semnal, y_zgomot, snr, Fs);
                [semnal,var] = addnoise(y_semnal, y_zgomot, snr);
                fisier = sprintf('%s_%d_%s_%s.mat',zgomot,snr,gen,nume);
                cale = strcat(director,fisier);
                save(cale,'semnal')
            end
        end
    end
    fprintf('%d\n',ctr_vorbitor);
end
