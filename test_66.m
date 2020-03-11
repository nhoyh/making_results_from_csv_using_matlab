clear all
close all
clc
%Model	Dataset	Method	Weight	Label	Step	Percentile
% AUROC	PRC	Precision	Recall	F1 score	Accuracy	Sensitivity	Specificity	Random Seed	Date

for sub = 1:21
T = readtable(sprintf('results_66//%d//results//results.csv',sub));
max_You = 0;
tmp = 0;
for i = 1 : size(T,1)
    tmp_data{i,1} = T.Var1{i};
    data(i,:) = strsplit(tmp_data{i,1},',');
    for j = 5: 16
        data_neu(i,j-4) = str2double(data{i,j});
    end
    You_tmp = (data_neu(i,10) + data_neu(i,11)) / 2;
    if You_tmp >= max_You
        max_You = You_tmp;
        tmp = i;
    end    
end

performance_sub(sub,1) = max(data_neu(:,4));
performance_sub(sub,2) = max(data_neu(:,5));
performance_sub(sub,3) = max(data_neu(:,6));
performance_sub(sub,4) = max(data_neu(:,7));
performance_sub(sub,5) = max(data_neu(:,8));
performance_sub(sub,6) = max(data_neu(:,9));
performance_sub(sub,7) = (data_neu(tmp,10));
performance_sub(sub,8) = (data_neu(tmp,11));
performance_sub(sub,9) = max_You;
clear T tmp_data data data_neu

end

performance{1,1} = mean(performance_sub(:,1));
performance{1,2} = mean(performance_sub(:,2));
performance{1,3} = mean(performance_sub(:,3));
performance{1,4} = mean(performance_sub(:,4));
performance{1,5} = mean(performance_sub(:,5));
performance{1,6} = mean(performance_sub(:,6));
performance{1,7} = mean(performance_sub(:,7));
performance{1,8} = mean(performance_sub(:,8));
performance{1,9} = mean(performance_sub(:,9));

performance{2,1} = 'AUROC';
performance{2,2} = 'PRC';
performance{2,3} = 'precision';
performance{2,4} = 'recall';
performance{2,5} = 'f1_score';
performance{2,6} = 'accuracy';
performance{2,7} = 'sensitivity';
performance{2,8} = 'specificity';
performance{2,9} = 'Youden';

clear data data_neu i j max_You sub T tmp_data You_tmp