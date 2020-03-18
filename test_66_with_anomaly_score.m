clear all
close all
%20-03-13

name = 'corr_epoch600'
as_num = 5; % the number of anomaly score
for sub = 1:21
T = readtable(sprintf('results_66//%d//results//results.csv',sub));
max_You(1:5) = 0;
tmp = 0;
for i = 1 : size(T,1)
    tmp_data{i,1} = T.Var1{i};
    data(i,:) = strsplit(tmp_data{i,1},',');
    if strcmp(data{i,3},'fm_1') == true
        k = 1;
    elseif strcmp(data{i,3},'fm_2') ==true
        k = 2;
    elseif strcmp(data{i,3},'l1') == true
        k = 3;
    elseif strcmp(data{i,3},'l2') == true
        k = 4;
    elseif strcmp(data{i,3},'cs') == true
        k = 5;
    end
    for j = 5: 16
        data_neu{k}(i,j-4) = str2double(data{i,j});
    end
    You_tmp(k) = (data_neu{k}(i,10) + data_neu{k}(i,11)) / 2;
    if You_tmp(k) >= max_You(k)
        max_You(k) = You_tmp(k);
        tmp(k) = i;
    end    
end

for k = 1 : as_num
performance_sub7{k}(sub,1) = max(data_neu{k}(:,4));
performance_sub7{k}(sub,2) = max(data_neu{k}(:,5));
performance_sub7{k}(sub,3) = max(data_neu{k}(:,6));
performance_sub7{k}(sub,4) = max(data_neu{k}(:,7));
performance_sub7{k}(sub,5) = max(data_neu{k}(:,8));
performance_sub7{k}(sub,6) = max(data_neu{k}(:,9));
performance_sub7{k}(sub,7) = (data_neu{k}(tmp(k),10));
performance_sub7{k}(sub,8) = (data_neu{k}(tmp(k),11));
performance_sub7{k}(sub,9) = max_You(k);
end
clear T tmp_data data data_neu tmp You_tmp max_You
end

for k = 1: as_num
performance7{k,1} = mean(performance_sub7{k}(:,1));
performance7{k,2} = mean(performance_sub7{k}(:,2));
performance7{k,3} = mean(performance_sub7{k}(:,3));
performance7{k,4} = mean(performance_sub7{k}(:,4));
performance7{k,5} = mean(performance_sub7{k}(:,5));
performance7{k,6} = mean(performance_sub7{k}(:,6));
performance7{k,7} = mean(performance_sub7{k}(:,7));
performance7{k,8} = mean(performance_sub7{k}(:,8));
performance7{k,9} = mean(performance_sub7{k}(:,9));
end

performance7{as_num+1,1} = 'AUROC';
performance7{as_num+1,2} = 'PRC';
performance7{as_num+1,3} = 'precision';
performance7{as_num+1,4} = 'recall';
performance7{as_num+1,5} = 'f1_score';
performance7{as_num+1,6} = 'accuracy';
performance7{as_num+1,7} = 'sensitivity';
performance7{as_num+1,8} = 'specificity';
performance7{as_num+1,9} = 'Youden';

performance7{1,10} = 'fm_1';
performance7{2,10} = 'fm_2';
performance7{3,10} = 'l1';
performance7{4,10} = 'l2';
performance7{5,10} = 'cs';

performance7
clear data data_neu i j max_You sub T tmp_data You_tmp
