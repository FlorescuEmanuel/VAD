clear all;
close all;

tic

addpath variabile\;

load 'lista_vorbitori.mat';
load 'lista_zgomote.mat';

SNR = -5:5:20;

G729_total = zeros(1,4);
LTSD_total = zeros(1,4);
LTSV_total = zeros(1,4);
Sohn_total = zeros(1,4);

G729_rezultate = struct('HR0', 0.0, 'HR1', 0.0, 'Pc', 0.0);
LTSD_rezultate = struct('HR0', 0.0, 'HR1', 0.0, 'Pc', 0.0);
LTSV_rezultate = struct('HR0', 0.0, 'HR1', 0.0, 'Pc', 0.0);
Sohn_rezultate = struct('HR0', 0.0, 'HR1', 0.0, 'Pc', 0.0);

for ctr_snr = 1:numel(SNR)
    for ctr_zgomot = 1:numel(lista_zgomote)
        load(sprintf('.\\variabile\\analiza\\%s_%s_%d.mat','G729',lista_zgomote(ctr_zgomot).nume,SNR(ctr_snr)));
        load(sprintf('.\\variabile\\analiza\\%s_%s_%d.mat','LTSD',lista_zgomote(ctr_zgomot).nume,SNR(ctr_snr)));
        load(sprintf('.\\variabile\\analiza\\%s_%s_%d.mat','LTSV',lista_zgomote(ctr_zgomot).nume,SNR(ctr_snr)));
        load(sprintf('.\\variabile\\analiza\\%s_%s_%d.mat','Sohn',lista_zgomote(ctr_zgomot).nume,SNR(ctr_snr)));
        for ctr_vorbitor = 1:numel(lista_vorbitori)
            for ctr_inregistrare = 1:numel(lista_vorbitori(ctr_vorbitor).inregistrari)
                G729_total = G729_total + ... 
                    comparare(lista_vorbitori(ctr_vorbitor).inregistrari(ctr_inregistrare).etichete,...
                    cell2mat(G_729(int32(ctr_vorbitor),int32(ctr_inregistrare))));
                LTSD_total = LTSD_total + ...
                    comparare(lista_vorbitori(ctr_vorbitor).inregistrari(ctr_inregistrare).etichete,...
                    cell2mat(LTSD(int32(ctr_vorbitor),int32(ctr_inregistrare))));
                LTSV_total = LTSV_total + ...
                    comparare(lista_vorbitori(ctr_vorbitor).inregistrari(ctr_inregistrare).etichete,...
                    cell2mat(LTSV(int32(ctr_vorbitor),int32(ctr_inregistrare))));
                Sohn_total = Sohn_total + ...
                    comparare(lista_vorbitori(ctr_vorbitor).inregistrari(ctr_inregistrare).etichete,...
                    cell2mat(Sohn(int32(ctr_vorbitor),int32(ctr_inregistrare))));
            end
        end
        G729_rezultate.HR0 = G729_total(1,1) / (G729_total(1,1) + G729_total(1,3));
        G729_rezultate.HR1 = G729_total(1,4) / (G729_total(1,4) + G729_total(1,2));
        G729_rezultate.Pc = (G729_total(1,1) + G729_total(1,4)) / sum(G729_total(1,:));
        
        LTSD_rezultate.HR0 = LTSD_total(1,1) / (LTSD_total(1,1) + LTSD_total(1,3));
        LTSD_rezultate.HR1 = LTSD_total(1,4) / (LTSD_total(1,4) + LTSD_total(1,2));
        LTSD_rezultate.Pc = (LTSD_total(1,1) + LTSD_total(1,4)) / sum(LTSD_total(1,:));
        
        LTSV_rezultate.HR0 = LTSV_total(1,1) / (LTSV_total(1,1) + LTSV_total(1,3));
        LTSV_rezultate.HR1 = LTSV_total(1,4) / (LTSV_total(1,4) + LTSV_total(1,2));
        LTSV_rezultate.Pc = (LTSV_total(1,1) + LTSV_total(1,4)) / sum(LTSV_total(1,:));
        
        Sohn_rezultate.HR0 = Sohn_total(1,1) / (Sohn_total(1,1) + Sohn_total(1,3));
        Sohn_rezultate.HR1 = Sohn_total(1,4) / (Sohn_total(1,4) + Sohn_total(1,2));
        Sohn_rezultate.Pc = (Sohn_total(1,1) + Sohn_total(1,4)) / sum(Sohn_total(1,:));
        
        save(sprintf('.\\variabile\\rezultate\\%s_%s_%d.mat','G729',lista_zgomote(ctr_zgomot).nume,SNR(ctr_snr)),'G729_rezultate');
        save(sprintf('.\\variabile\\rezultate\\%s_%s_%d.mat','LTSD',lista_zgomote(ctr_zgomot).nume,SNR(ctr_snr)),'LTSD_rezultate');
        save(sprintf('.\\variabile\\rezultate\\%s_%s_%d.mat','LTSV',lista_zgomote(ctr_zgomot).nume,SNR(ctr_snr)),'LTSV_rezultate');
        save(sprintf('.\\variabile\\rezultate\\%s_%s_%d.mat','Sohn',lista_zgomote(ctr_zgomot).nume,SNR(ctr_snr)),'Sohn_rezultate');
    end
end

time_compare_data = toc;