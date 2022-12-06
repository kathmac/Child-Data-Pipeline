%Created by Katherine McDonald

% Create KBIT Verbal and Non-Verbal Standard Scores 
%MISALIGNED RAW TABLE = NEEDS FIXING
%% Variables to Change
Composite_Table_Standard = '/Volumes/Data/KatherineM/SNEACY/SNEACY_Child/Scoring/KBIT_Scoring/KBIT_Standard.xlsx';
Verbal_Standard_Output = '/Volumes/Data/KatherineM/SNEACY/SNEACY_Child/Scoring/KBIT_Scoring/KBit_Verbal_Standard_Output.xlsx';
NonVerbal_Standard_Output = '/Volumes/Data/KatherineM/SNEACY/SNEACY_Child/Scoring/KBIT_Scoring/KBit_NonVerbal_Standard_Output.xlsx';
SaveOutput = '/Volumes/Data/KatherineM/SNEACY/SNEACY_Child/Scoring/KBIT_Scoring/KBit_Composite_Standard_Output.xlsx';

%% Load Standard Scoring sheet for Composite scores
Composite_Table_Standard = readtable(Composite_Table_Standard,'Sheet','KBIT2_Composite');

%% Load and organize raw data 
%Load data
Verbal_Standard_Output = readtable(Verbal_Standard_Output);
NonVerbal_Standard_Output = readtable(NonVerbal_Standard_Output);

%% Create table to add Verbal and NonVerbal standard scores
%Create table
Composite_AddScores_Table = outerjoin(Verbal_Standard_Output, NonVerbal_Standard_Output);

%Remove duplicate columns 
Composite_AddScores_Table = removevars(Composite_AddScores_Table, {'Verbal_Raw','CatAge_Verbal_Standard_Output',...
    'Subject_NonVerbal_Standard_Output','Age_NonVerbal_Standard_Output','NonVerbal_Raw','CatAge_NonVerbal_Standard_Output'});

%Add cells together and create new column called Composite_AddScores
Composite_AddScores_Table.Composite_AddScores = Composite_AddScores_Table.Verbal_Standard_Auto + Composite_AddScores_Table.NonVerbal_Standard_Auto;

%Remove single standard scores, leave only composite
Composite_AddScores_Table = removevars(Composite_AddScores_Table, {'Verbal_Standard_Auto','NonVerbal_Standard_Auto'});

%Rename final columns 
Composite_AddScores_Table.Properties.VariableNames{1} = 'Subject';
Composite_AddScores_Table.Properties.VariableNames{2} = 'Age';

%% Indexing Sum of Verbal + NonVerbal Scores to Composite Standard Scores
%Composite_Standard_Auto is the calculated score from Composite_AddScores column
DataTableRows = height(Composite_AddScores_Table);

for P = 1:DataTableRows
    if Composite_AddScores_Table.Composite_AddScores(P) > 0 
       StandScore_Composite = array2table(Composite_Table_Standard.(2)(Composite_AddScores_Table.Composite_AddScores(P)));
       Composite_AddScores_Table(P,'Composite_Standard_Auto') = StandScore_Composite;
    elseif ismissing(Composite_AddScores_Table.Composite_AddScores(P))
        StandScore = array2table(NaN);
        Composite_AddScores_Table(P,'Composite_Standard_Auto') = StandScore;
    end
end

%% Saving Excel File
writetable(Composite_AddScores_Table,SaveOutput,'WriteRowNames',true);
