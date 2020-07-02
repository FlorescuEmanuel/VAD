function rezultate = comparare( etichete_actuale, etichete_prezise)

    etichete_actuale = etichete_actuale == 1;
    etichete_prezise = etichete_prezise == 1;

    c = confusionmat(etichete_actuale, etichete_prezise, 'order', [0 1]);

%     rezultate(1,1) = c(2,2)/sum(c(:,2)); % speech precision
%     rezultate(1,2) = c(2,2)/sum(c(2,:)); % speech recall
%  
%     rezultate(1,3) = c(1,1)/sum(c(:,1)); % nonspeech precision
%     rezultate(1,4) = c(1,1)/sum(c(1,:)); % nonspeech recall
    rezultate(1,1) = c(1,1);
    rezultate(1,2) = c(1,2);
    rezultate(1,3) = c(2,1);
    rezultate(1,4) = c(2,2);

end

