function vadout = vadramirez(y, Fs)
    %%
    threshold = -6; % Threshold to update the noise spectrum
    alpha = 0.4; % update rate (forgotten factor)
    NOrder = 6; % order
    frmWin = Fs*0.02; % window size
    window = hamming(frmWin,'symmetric'); % hamming window
    firstWindowNum = 1; % number of window frames to get the initial noise statistc => the first FIRSTWindowNUM * WINSIZE / rfs seconds
    ltsd = LTSD(frmWin,window,NOrder,alpha,threshold, firstWindowNum);
    % if you don't want the noise to be adapted 
    % ltsd = LTSD(WINSIZE,WINDOW,NORDER);
    res =  ltsd.compute(y);
    %% SHOW RESULT
    uSize = 4; % to throw away segments which are less that USIZE * WINSIZE
    IDX = res>2.5; % speech/non-speech threshold
    d = IDX(2:end) - IDX(1:end-1);
    vadStart = find(d==1);
    vadEnd = find(d==-1);
    len = (vadEnd - vadStart)*frmWin/Fs;
    to_remove = len < uSize*frmWin/Fs;
    vadStart(to_remove)= [];
    vadEnd(to_remove) = [];
    frmSh = Fs * 0.01;
    var1 = floor((length(y)-frmSh)/frmSh);
    na = round(frmSh/2);
    nb = var1 * frmSh;
    nc = length(y) - na - nb;
    prob = zeros(var1,1);
    for i = 1:length(vadStart)
        prob(vadStart(i)+1:vadEnd(i),1) = 1;
    end
    temp = zeros(na+nb+nc,1);
    temp(na+(1:nb),1) = reshape(repmat(prob',frmSh,1),nb,1);
    temp(1:na,1) = temp(na+1,1);
    temp(na+nb+1:end,1) = temp(na+nb,1);
    vadout = temp;
end

