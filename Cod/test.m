clear all

addpath algoritmi\ltsv
addpath algoritmi\ltsd
addpath algoritmi\voicebox
addpath algoritmi\G729

[y, Fs] = audioread('C:\Users\Dan\Desktop\disertatie\Baza de date\Audio test\m16_0772064246.wav');
[n, Fs] = audioread('C:\Users\Dan\Desktop\disertatie\Baza de date\Audio test\babble.wav');
y20 = addnoise(y,n(1:length(y)),20,Fs);
y10 = addnoise(y,n(1:length(y)),10,Fs);
y0 = addnoise(y,n(1:length(y)),0,Fs);
y_10 = addnoise(y,n(1:length(y)),-10,Fs);
res_soh = vadsohn(y,Fs);

% res_soh20 = vadsohn(y20,Fs);
% res_soh10 = vadsohn(y10,Fs);
% res_soh0 = vadsohn(y0,Fs);
% res_soh_10 = vadsohn(y_10,Fs);
res_ram = vadramirez(y,Fs);
res_seg = vadsegbroeck(y,Fs,30,20);
res_g72 = G729(y,Fs,320,160);

% res_comparare20 = comparare(res_soh,res_soh20);
% hr0_20 = res_comparare20(1,1)/(res_comparare20(1,1) + res_comparare20(1,2));
% hr1_20 = res_comparare20(1,4)/(res_comparare20(1,3) + res_comparare20(1,4));
% 
% res_comparare10 = comparare(res_soh,res_soh10);
% hr0_10 = res_comparare10(1,1)/(res_comparare10(1,1) + res_comparare10(1,2));
% hr1_10 = res_comparare10(1,4)/(res_comparare10(1,3) + res_comparare10(1,4));
% 
% res_comparare0 = comparare(res_soh,res_soh0);
% hr0_0 = res_comparare0(1,1)/(res_comparare0(1,1) + res_comparare0(1,2));
% hr1_0 = res_comparare0(1,4)/(res_comparare0(1,3) + res_comparare0(1,4));
% 
% res_comparare_10 = comparare(res_soh,res_soh_10);
% hr0__10 = res_comparare_10(1,1)/(res_comparare_10(1,1) + res_comparare_10(1,2));
% hr1__10 = res_comparare_10(1,4)/(res_comparare_10(1,3) + res_comparare_10(1,4));


t = (0:length(y)-1)/Fs;

figure
hold on
plot(t,y0,'black');
plot(t,y10,'magenta');
plot(t,y,'red');
ylabel('Amplitudine'); xlabel('Timp');
title('Semnal alterat cu zgomot de tip Babble');
xlim([0, length(y)/Fs]);
legend('Semnal alterat la SNR = 0','Semnal alterat la SNR = 10','Semnal nealterat');
% hold on
% plot(t,res_soh*max(y)*1.5,'red');
% plot(t,res_ram*max(y)*1.4,'green');
% plot(t,res_seg*max(y)*1.3,'blue');
% plot(t,res_g72*max(y)*1.2,'black');
% legend('Semnal','Sohn','LTSD','LTSV','G.729');
% ylabel('Amplitudine'); xlabel('Timp');