clear all;

[y,Fs] = audioread('C:\Users\Dan\Desktop\disertatie\Baza de date\Audio test\f1_0258474181.wav');
[y_noise,Fs_noise] = audioread('C:\Users\Dan\Desktop\disertatie\Baza de date\Audio test\babble.wav');
for snr = -10:5:20
    [y_noisy, noise] = addnoise(y,y_noise,snr,Fs);
    name = strcat('C:\Users\Dan\Desktop\disertatie\Baza de date\Audio test\','babble_',num2str(snr),'_f1_0258474181','.wav');
    audiowrite(name,y_noisy,Fs);
end


% player = audioplayer(var1,Fs);
% play(player);
% player = audioplayer(y,Fs);
% player_noise = audioplayer(y_noise,Fs_noise);
% play(player);
% pause
% play(player_noise);
% stop(player_noise);
