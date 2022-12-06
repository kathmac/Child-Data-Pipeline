%Created by Katherine McDonald

%MISALIGNED RAW DATA TABLE, NEEDS FIXING 
% function[] = KBIT_Script_NonVerbal
%% PART 1 
% export redcap data to excel sheet; name "KBIT_NonVerbal_Redcap_output";
% organize into PID, Age, NonVerbal_Raw columns 
%% Variables to change
NonVerbal_Table_Standard = '/Volumes/Data/KatherineM/SNEACY/SNEACY_Child/Scoring/KBIT_Scoring/KBIT_Standard.xlsx';
NonVerbal_Raw_Redcap = '/Volumes/Data/KatherineM/SNEACY/SNEACY_Child/Scoring/KBIT_Scoring/SNEACYChild-KbitNonVerbalInMATLA_DATA_2021-03-17_1601.csv'; 
SaveOutput = '/Volumes/Data/KatherineM/SNEACY/SNEACY_Child/Scoring/KBIT_Scoring/KBit_NonVerbal_Standard_Output.xlsx';

%% Standard Scores
NonVerbal_Table_Standard = readtable(NonVerbal_Table_Standard,'sheet','KBIT2_NonVerbal');

%% Load and rename raw data
%Load data
NonVerbal_Raw_Redcap = readtable(NonVerbal_Raw_Redcap);
%Rename data
NonVerbal_Raw_Redcap.Properties.VariableNames{1} = 'Subject';
NonVerbal_Raw_Redcap.Properties.VariableNames{2} = 'Age';
NonVerbal_Raw_Redcap.Properties.VariableNames{3} = 'NonVerbal_Raw';

%% Indexing Categorical Age %%not working - missing row information
NonVerbal_Raw_RedcapRows = height(NonVerbal_Raw_Redcap);


for P = 1:NonVerbal_Raw_RedcapRows
   if NonVerbal_Raw_Redcap.Age(P) > 9.000 && NonVerbal_Raw_Redcap.Age(P) < 9.332
       NonVerbal_Raw_Redcap.CatAge(P) = {'x9'};
  elseif NonVerbal_Raw_Redcap.Age(P) > 9.333 && NonVerbal_Raw_Redcap.Age(P) < 9.665       
       NonVerbal_Raw_Redcap.CatAge(P) = {'x9_33'};
  elseif NonVerbal_Raw_Redcap.Age(P) > 9.666 && NonVerbal_Raw_Redcap.Age(P) < 9.999          
       NonVerbal_Raw_Redcap.CatAge(P) = {'x9_67'};
  elseif NonVerbal_Raw_Redcap.Age(P) > 10.000 && NonVerbal_Raw_Redcap.Age(P) < 10.332    
    NonVerbal_Raw_Redcap.CatAge(P) = {'x10'};
  elseif NonVerbal_Raw_Redcap.Age(P) > 10.333 && NonVerbal_Raw_Redcap.Age(P) < 10.665    
    NonVerbal_Raw_Redcap.CatAge(P) = {'x10_33'};
  elseif NonVerbal_Raw_Redcap.Age(P) > 10.666 && NonVerbal_Raw_Redcap.Age(P) < 10.999    
    NonVerbal_Raw_Redcap.CatAge(P) = {'x10_67'};
   end
end

%% Indexing Standardized Score
%NonVerbal
for P = 1:NonVerbal_Raw_RedcapRows
    if NonVerbal_Raw_Redcap.NonVerbal_Raw(P) > 0
        tempcol = char(NonVerbal_Raw_Redcap.CatAge(P));
        StandardScore = array2table (NonVerbal_Table_Standard.(tempcol)(NonVerbal_Raw_Redcap.NonVerbal_Raw(P)));
        NonVerbal_Raw_Redcap(P,'NonVerbal_Standard_Auto') = StandardScore;
    elseif ismissing(NonVerbal_Raw_Redcap.NonVerbal_Raw(P))
        StandardScore = array2table(NaN);
        NonVerbal_Raw_Redcap(P,'NonVerbal_Standard_Auto') = StandardScore;
     end
end

%% Saving Excel File
writetable(NonVerbal_Raw_Redcap,SaveOutput, 'WriteRowNames',true);



