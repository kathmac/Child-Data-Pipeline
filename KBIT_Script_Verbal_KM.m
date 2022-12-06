%Created by Katherine McDonald

%MISALIGNED RAW DATA TABLE, NEEDS FIXING 
function[] = KBIT_Script_Verbal_KM
%% PART 1 
% export redcap data to excel sheet; rename Raw_Redcap
% organize into PID, Age, Verbal_Raw columns 
%% Variables to change
Verbal_Table_Standard = '/Volumes/Data/KatherineM/SNEACY/SNEACY_Child/Scoring/KBIT_Scoring/KBIT_Standard.xlsx';
Verbal_Raw_Redcap = '/Volumes/Data/KatherineM/SNEACY/SNEACY_Child/Scoring/KBIT_Scoring/SNEACY2Child-KBitVerbal_DATA_2022-09-23_1109.csv'; 
SaveOutput = '/Volumes/Data/KatherineM/SNEACY/SNEACY_Child/Scoring/KBIT_Scoring/KBit_Verbal_Standard_Output.xlsx';

%% Standard Scores
Verbal_Table_Standard = readtable(Verbal_Table_Standard,'sheet','KBIT2_Verbal');

%% Load and rename raw data
%Load data
Verbal_Raw_Redcap = readtable(Verbal_Raw_Redcap);
%Rename data
Verbal_Raw_Redcap.Properties.VariableNames{1} = 'Subject';
Verbal_Raw_Redcap.Properties.VariableNames{2} = 'Age';
Verbal_Raw_Redcap.Properties.VariableNames{3} = 'Verbal_Raw';

%% Indexing Categorical Age %%not working - missing row information
Verbal_Raw_RedcapRows = height(Verbal_Raw_Redcap);


for P = 1:Verbal_Raw_RedcapRows
   if Verbal_Raw_Redcap.Age(P) > 9.000 && Verbal_Raw_Redcap.Age(P) < 9.332
       Verbal_Raw_Redcap.CatAge(P) = {'x9'};
  elseif Verbal_Raw_Redcap.Age(P) > 9.333 && Verbal_Raw_Redcap.Age(P) < 9.665       
       Verbal_Raw_Redcap.CatAge(P) = {'x9_33'};
  elseif Verbal_Raw_Redcap.Age(P) > 9.666 && Verbal_Raw_Redcap.Age(P) < 9.999          
       Verbal_Raw_Redcap.CatAge(P) = {'x9_67'};
  elseif Verbal_Raw_Redcap.Age(P) > 10.000 && Verbal_Raw_Redcap.Age(P) < 10.332    
    Verbal_Raw_Redcap.CatAge(P) = {'x10'};
  elseif Verbal_Raw_Redcap.Age(P) > 10.333 && Verbal_Raw_Redcap.Age(P) < 10.665    
    Verbal_Raw_Redcap.CatAge(P) = {'x10_33'};
  elseif Verbal_Raw_Redcap.Age(P) > 10.666 && Verbal_Raw_Redcap.Age(P) < 10.999    
    Verbal_Raw_Redcap.CatAge(P) = {'x10_67'};
   end
end

%% Indexing Standardized Score
%Verbal
for P = 1:Verbal_Raw_RedcapRows
    if Verbal_Raw_Redcap.Verbal_Raw(P) > 0
        tempcol = char(Verbal_Raw_Redcap.CatAge(P));
        StandardScore = array2table (Verbal_Table_Standard.(tempcol)(Verbal_Raw_Redcap.Verbal_Raw(P)));
        Verbal_Raw_Redcap(P,'Verbal_Standard_Auto') = StandardScore;
    elseif ismissing(Verbal_Raw_Redcap.Verbal_Raw(P))
        StandardScore = array2table(NaN);
        Verbal_Raw_Redcap(P,'Verbal_Standard_Auto') = StandardScore;
     end
end

%% Saving Excel File
writetable(Verbal_Raw_Redcap,SaveOutput, 'WriteRowNames',true);



