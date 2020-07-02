clear all;
close all;

tic

addpath variabile\;

load 'lista_zgomote';

SNR = 20:-5:-5;

%  tabel_hr0 = fopen('tabel_hr0.txt','w');
%  tabel_hr1 = fopen('tabel_hr1.txt','w');
%  fprintf(tabel_hr0,'%s\t%s\t%s\t%s\t%s\t%s\t\n','Zgomot','SNR','G.729','Ramirez','Van Segbroeck','Sohn');
%  fprintf(tabel_hr1,'%s\t%s\t%s\t%s\t%s\t%s\t\n','Zgomot','SNR','G.729','Ramirez','Van Segbroeck','Sohn');

for i = 1:numel(lista_zgomote)
    for ctr_snr = 1:numel(SNR)
%          fprintf(tabel_hr0,'%s\t%s\t',lista_zgomote(i).nume,num2str(SNR(ctr_snr)));
%          fprintf(tabel_hr1,'%s\t%s\t',lista_zgomote(i).nume,num2str(SNR(ctr_snr)));
        load(sprintf('.\\variabile\\rezultate\\%s_%s_%d.mat','G729',lista_zgomote(i).nume,SNR(ctr_snr)));
        load(sprintf('.\\variabile\\rezultate\\%s_%s_%d.mat','LTSD',lista_zgomote(i).nume,SNR(ctr_snr)));
        load(sprintf('.\\variabile\\rezultate\\%s_%s_%d.mat','LTSV',lista_zgomote(i).nume,SNR(ctr_snr)));
        load(sprintf('.\\variabile\\rezultate\\%s_%s_%d.mat','Sohn',lista_zgomote(i).nume,SNR(ctr_snr)));
%          fprintf(tabel_hr0,'%s\t%s\t%s\t%s\t\n',num2str(100*G729_rezultate.HR0),num2str(100*LTSD_rezultate.HR0),num2str(100*LTSV_rezultate.HR0),num2str(100*Sohn_rezultate.HR0));
%          fprintf(tabel_hr1,'%s\t%s\t%s\t%s\t\n',num2str(100*G729_rezultate.HR1),num2str(100*LTSD_rezultate.HR1),num2str(100*LTSV_rezultate.HR1),num2str(100*Sohn_rezultate.HR1));
       
        hr0(1,ctr_snr) = G729_rezultate.HR0; hr0(2,ctr_snr) = LTSD_rezultate.HR0; hr0(3,ctr_snr) = LTSV_rezultate.HR0; hr0(4,ctr_snr) = Sohn_rezultate.HR0;
        hr1(1,ctr_snr) = G729_rezultate.HR1; hr1(2,ctr_snr) = LTSD_rezultate.HR1; hr1(3,ctr_snr) = LTSV_rezultate.HR1; hr1(4,ctr_snr) = Sohn_rezultate.HR1;
        pc(1,ctr_snr) = G729_rezultate.Pc; pc(2,ctr_snr) = LTSD_rezultate.Pc; pc(3,ctr_snr) = LTSV_rezultate.Pc; pc(4,ctr_snr) = Sohn_rezultate.Pc;
    end
    
% figure
%      subplot(2, 1, 1)
%          title(sprintf('%s',lista_zgomote(i).nume));
%          hold on
%          grid
%          set(gca, 'XDir','reverse');
%          set(gca, 'XGrid', 'off');
%          bar(SNR,100*hr1');
%          legend('G.729','Ramirez','Van Segbroek','Sohn');
%          ylim([70 100]);
%          ylabel('HR1'); xlabel('SNR');
%          hold off;
%      subplot(2, 1, 2)
%          hold on
%          grid
%          set(gca, 'XDir','reverse');
%          set(gca, 'XGrid', 'off');
%          bar(SNR,100*hr0');
%          legend('G.729','Ramirez','Van Segbroek','Sohn');
%          ylabel('HR0'); xlabel('SNR');
%          hold off;
% end
         
figure
       title(sprintf('%s',lista_zgomote(i).nume));
       hold on
       grid
       set(gca, 'XDir','reverse')
       p1 = plot(SNR,100*pc(1,:),'LineWidth',1.5,'Marker','o','Color','black');
       p2 = plot(SNR,100*pc(2,:),'LineWidth',1.5,'Marker','*','Color','blue');
       p3 = plot(SNR,100*pc(3,:),'LineWidth',1.5,'Marker','^','Color','green');
       p4 = plot(SNR,100*pc(4,:),'LineWidth',1.5,'Marker','x','Color','red');
       leg = legend('G.729','Ramirez','Van Segbroeck','Sohn');
       set(leg,'location','southwest')
       ylabel('Pc'); xlabel('SNR');
       hold off;
end

%  fclose(tabel_hr0);
%  fclose(tabel_hr1);

time_plot_results = toc;