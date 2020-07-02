clear all;
close all;

[y_baza, Fs] = audioread('C:\Users\Dan\Desktop\disertatie\Baza de date\Audio test\f1_0258474181.wav');
t_baza = (0 : length(y_baza) - 1) / Fs; 

%% Analiza in timp - determinarea amplitudinii maxime si medii a semnalului

% y1 = y_baza(1:27200);
% t1 = (0 : length(y1) - 1) / Fs;
% 
% L_fereastra = round(Fs * (20e-3));
% c = zeros(length(y1),1);
% v = zeros(length(y1),1);
% 
% c(160:2300) = 1;  %z
% v(2400:4450) = 1; %e
% c(4550:4900) = 1; %r
% v(5000:6880) = 1; %o
% 
% v(19840:22400) = 1; %o
% c(23520:24320) = 1; %p
% c(24960:25920) = 1; %t
% 
% figure
% plot(t1, y1);
% xlim([0 length(t1)/Fs]);
% ylim([-0.03 0.03]);
% title('Semnalul unei secvente vorbite');
% xlabel('Timp (s)');
% ylabel('Amplitudine');
% hold on
% plot(t1,c*max(y1),'r-');
% plot(t1,v*max(y1),'g--');
% legend('Semnal','Consoane','Vocale');

%% Analiza in timp - determinarea energiei semnalului (E)

% Nw = Fs .* 30e-3;
% Nsh = Fs .* 29e-3;
% Nfft = 2048;
% 
% M = [];
% 
% for i = 1:Nsh:length(y_baza)-Nsh
%     temp = y_baza(i:i+Nw);
%     M = [M temp];
% end
% 
% [w, n_w]=size(M);
% w_hamming=hamming(w);
% M_hamming=zeros(w,n_w);
% M_fft=zeros(Nfft,n_w);
% E=zeros(1,n_w);
% x_E = linspace(0,(length(y_baza)-1)/Fs,length(E));
% 
% for i=1:n_w
%     M_hamming(:,i)=M(:,i).*w_hamming;
%     E(i)=sum(M_hamming(:,i).^2);
% end
% 
% figure
% plot(t_baza,y_baza);
% hold on
% plot(x_E,E*2,'r-');
% title('Energia semnalului');
% xlabel('Timp (s)'); ylabel('Amplitudine');
% legend('Semnal', 'Valoarea normalizata a energiei');

%% Analiza in timp - determinarea numarului de treceri prin zero (ZCR)

% Nw = Fs .* 30e-3;
% Nsh = Fs .* 29e-3;
% Nfft = 2048;
% 
% M = [];
% 
% for i = 1:Nsh:length(y_baza)-Nsh
%     temp = y_baza(i:i+Nw);
%     M = [M temp];
% end
% 
% [w, n_w]=size(M);
% w_hamming=hamming(w);
% ZCR=zeros(1,n_w);
% x_ZCR = linspace(0,(length(y_baza)-1)/Fs,length(ZCR));
% 
% for i=1:n_w
%     ZCR(i)=sum(abs(diff(M(:,i)>0)))/length(M(:,i));
% end
% 
% figure
% plot(t_baza,y_baza);
% hold on
% plot(x_ZCR,ZCR*2*max(y_baza),'r-');
% title('Numarul de treceri prin zero');
% xlabel('Timp (s)'); ylabel('Amplitudine');
% legend('Semnal', 'Valoarea ZCR normalizata');

%% Analiza in timp - determinarea frecventei fundamentale a semnalului (pitch)

% figure
% subplot(2, 2, 1);
% plot(t_baza, y_baza);
% xlim([0 length(t_baza)/Fs]);
% title('Semnalul unei secvente vorbite');
% legend('Semnal');
% xlabel('Timp (s)');
% ylabel('Amplitudine');
% 
% per_min = round (Fs .* 2e-3);            
% per_max = round (Fs .* 20e-3);
% R = xcorr(y_baza, per_max, 'coeff');
% d = (-per_max : per_max) / Fs;
% 
% subplot(2, 2, 3);
% plot(d,R);
% title('Functia de autocorelare');
% legend('Autocorelare');
% xlabel('Intarziere(s)');
% ylabel('Coeficient de corelare');
% 
% director_vorbitori = 'C:\Users\Dan\Desktop\disertatie\Baza de date\BD_ATM\wav\'; % directorul cu fisiere audio, cale absoluta
% DV = dir(director_vorbitori);
% DV = DV(~ismember({DV.name}, {'.', '..'})); % se elimina folderele '.' si '..'
% 
% F0_f = [];
% F0_b = [];
% 
% for i = 1:10:numel(DV)
%     filename = fullfile(director_vorbitori,DV(i).name); % se creeaza calea absoluta pentru fiecare fisier 
%     [y, Fs] = audioread(filename); % se citeste fisierul audio
%     R = xcorr(y, per_max,'coeff');
%     R = R(per_max + 1 : 2 * per_max + 1);
%     [Rmax, Tx] = max(R(per_min : per_max));
%     F0 = Fs /(per_min + Tx - 1);
%     if(DV(i).name(1) == 'f')
%         F0_f = [F0_f F0];
%     else
%         F0_b = [F0_b F0];
%     end
% end
% 
% F0_f_mediu = mean(F0_f);
% F0_m_mediu = mean(F0_b);
% 
% F0_f_x = 1:numel(F0_f);
% F0_m_x = 1:numel(F0_b);
% 
% subplot(2, 2, 2)
% plot(F0_f_x, F0_f,'or-');
% xlim([0 numel(F0_f)]);
% axis 'auto y'
% title('Valori ale frecventei fundamentale feminine');
% legend(strcat('Valoarea medie: ',num2str(F0_f_mediu),' Hz'),'Location', 'Southeast');
% xlabel('Timp (s)');
% ylabel('Amplitudine');
% 
% subplot(2, 2, 4)
% plot(F0_m_x, F0_b,'xblack-');
% xlim([0 numel(F0_b)]);
% axis 'auto y'
% title('Valori ale frecventei fundamentale masculine');
% legend(strcat('Valoarea medie: ',num2str(F0_m_mediu),' Hz'),'Location', 'Southeast');
% xlabel('Timp (s)');
% ylabel('Amplitudine');

%% Analiza in frecventa - analiza prin banc de filtre digitale

% frecvente = 1:500:8000;
% 
% filt_y = zeros(numel(frecvente)-1,length(y_baza));
% E = zeros(numel(frecvente)-1,1);
% x_E = frecvente(1,1:end-1)+250;
% 
% for i = 1:numel(frecvente)-1
%     filtru = design(fdesign.bandpass('N,Fc1,Fc2',100,frecvente(i),frecvente(i+1),Fs));
%     filt_y(i,:) = filter(filtru,y_baza);
%     E(i) = sum(filt_y(i,:).^2);
% end
% 
% figure
% subplot(2, 1, 1); 
% plot(t_baza, y_baza); 
% title('Analiza prin banc de filtre');
% xlabel('Timp (s)');
% ylabel('Amplitudine');
% legend('Semnal');
% 
% subplot(2, 1, 2); 
% plot(x_E, E, '*r'); 
% set(gca, 'YScale', 'log');
% xlabel('Frecventa (Hz)');
% ylabel('Energia');

%% Analiza in frecventa - utilizarea Short-Time Fourier Transform

% Nw = Fs * 30e-3;
% Nsh = Fs * 29e-3;
% Nfft = 2048;
% 
% M=[];
% 
% for i = 1:Nsh:length(y_baza)-Nsh
%     temp = y_baza(i:i+Nw);
%     M = [M temp];
% end
% [w, n_w] = size(M);
% win_hamming = hamming(w);
% M_hamming = zeros(w,n_w);
% M_fft = zeros(Nfft,n_w);
% E = zeros(1,n_w);
% 
% for i = 1:n_w
%     M_hamming(:,i) = M(:,i) .* win_hamming;
%     M_fft(:,i) = fft(M_hamming(:,i),Nfft);
%     E(i) = sum(M_hamming(:,i).^2);
% end
% 
% M_abs = abs(M_fft);
% M_max = max(max(M_abs));
% 
% M_spectrogram = 10*log10(M_abs/M_max);
% 
% figure
% subplot(2, 1, 1);
% plot(t_baza,y_baza);
% title('Analiza cu STFT - Spectrograma');
% xlabel('Timp (s)');
% ylabel('Amplitudine');
% legend('Semnal');
% 
% subplot(2, 1, 2);
% spectrogram(y_baza,Nw,Nsh,Nfft,Fs,'yaxis');
% xlabel('Timp (s)');
% ylabel('Frecventa (Hz)');

%% Analiza in frecventa - analiza prin predictie liniara (LP)

% nr_coef = 4 + Fs/1000;
% anvelopa = lpc(y_baza,nr_coef);
% 
% est_y = filter([0 - anvelopa(2:end)],1,y_baza);
% 
% Nfft = 2^nextpow2(length(y_baza)+1);
% 
% y_fft = fft(y_baza,Nfft);
% 
% [h,f] = freqz(1,anvelopa,Nfft/2,Fs);
% 
% r = roots(anvelopa);     
% r = r(imag(r)>0.01);     
% ffreq = sort(atan2(imag(r),real(r))*Fs/(2*pi));
% 
% figure
% plot(f,20*log10(abs(h)+eps));
% title('Analiza LPC');
% xlabel('Frecventa (Hz)');
% ylabel('Amplitudine (dB)');
% hold on 
% plot(f,20*log10(abs(y_fft(1:end/2))+eps)); grid on;
% stem(ffreq(1),25,'k'),stem(ffreq(2),22,'k'),stem(ffreq(3),9,'k')
% legend('Filtru LP','Semnal vocal','Formant 1','Formant 2','Formant 3')

%% Analiza in frecventa - analiza cepstrala

% y_zgomot = y_baza(25120:25720, 1);
% t_zgomot = t_baza(1,25120:25720);
% N = length(y_zgomot);
% 
% w = hamming(N);
% y_hamming = y_zgomot .* w;
% N_unice = ceil((N+1)/2);
% C = real(ifft(log(abs(fft(y_hamming)))));
% C = C(1:N_unice);
% q = (0:N_unice-1)/Fs;
% 
% figure
% subplot(2, 1, 1)
% plot(q*1000, C);
% title('Analiza cepstrala');
% grid on;
% xlim([0 10])
% 
% y_vocala = y_baza(2800:3440, 1);
% t_vocala = t_baza(1,2800:3440);
% N = length(y_vocala);
% 
% w = hamming(N);
% y_hamming = y_vocala .* w;
% N_unice = ceil((N+1)/2);
% C = real(ifft(log(abs(fft(y_hamming)))));
% C = C(1:N_unice);
% q = (0:N_unice-1)/Fs;
% 
% subplot(2, 1, 2)
% plot(q*1000, C);
% grid on
% xlim([0 10])

%% Analiza in frecventa - analiza perceptuala

% Nfft = 1024;
% 
% p = 30;
% m = melfb(p,Nfft,Fs);
% f = 0:Fs/Nfft:Fs-Fs/Nfft;
% 
% figure
% plot(f(1:513),m')
% grid on
% title('Banc de filtre pe scara Mel')