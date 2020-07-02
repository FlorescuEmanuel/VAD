function vadout = vadsegbroeck(y, Fs, R, M)
    
    %% initializarea parametrilor
    % ---vad parameters (to tune)---
    % speech noise threshold
    if ~exist('p1','var')
      p1=0.1;
    end
    % speech region smoothing
    if ~exist('p2','var')
      p2=20;
    end

    % set path
    pwd;
    addpath algoritmi/LTSV/mfiles/;
    % ---vad model---
    load('algoritmi/LTSV/models/model.mat')

    % ---feature---
    % GT
    NbCh=64;
    % Gabor
    nb_mod_freq=2;
    % LTSV
    ltsvThr=0.5;
    ltsvSlope=0.2;
    % vprob2 and ltsv2
    K=30; order=4;
    
    %% implementarea algoritmului
    % [1] extract cochleagram
    gt=FE_GT(y,Fs,NbCh);

    % [2] Gabor filtering applied on mel
    gbf=FE_GBF(y,Fs,nb_mod_freq,false);
    gbf= [gbf gbf(:,ones(1,10)*size(gbf,2))];
    gbf = gbf(:,1:size(gt,2));

    % [3] LTSV
    ltsv=FE_LTSV(y,Fs,R,M,gt,ltsvThr,ltsvSlope);
    ltsv2 = convert_to_context_stream(ltsv, K, order);
    ltsv2= [ltsv2 ltsv2(:,ones(1,10)*size(ltsv,2))];
    ltsv2 = ltsv2(:,1:size(gt,2));

    % [4] vprob prob
    vprob=voicingfeature(y,Fs);
    vprob2 = convert_to_context_stream(vprob, K, order);
    vprob2 = [vprob2 vprob2(:,ones(1,10)*size(vprob,2))];
    vprob2 = vprob2(:,1:size(gt,2));

    % feature for VAD
    test_x = [gt;gbf;ltsv2;vprob2];
    test_x_norm = mvn(test_x);

    % VAD decoding
    [~,~,output] = nntest(dnn, test_x_norm');
    outprob=double(output(:,1));
    vadout=medfilt1(outprob.^2,p2)>p1;
    frmWin = Fs*0.01;
    na = frmWin / 2;
    nb = size(vadout,1) * frmWin;
    nc = length(y) - na - nb;
    temp = zeros(na+nb+nc,1);
    temp(na+(1:nb),1) = reshape(repmat(vadout',frmWin,1),nb,1);
    temp(1:na,1) = temp(na+1,1);
    temp(na+nb+1:end,1) = temp(na+nb,1);
    vadout = temp;
end

