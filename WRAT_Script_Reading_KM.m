%Created by Katherine McDonald

function[] = WRAT_Script_reading
%% Variables 
%Note:score zero removed from standard scoring sheets
%replace FileName_Data to most recent output name/move old file to "Old_Folder"
FilePath = '/Volumes/Data/KatherineM/SNEACY/SNEACY_Child/Scoring/WRAT_Scoring';
FileName_Blue = 'WRAT4_Blue_Standards.xlsx';
FileName_Green = 'WRAT4_Green_Standards.xlsx';
FileName_Data = 'SNEACYChild-WRATReadingInMATLABf_DATA_2021-03-25_1606.csv';
SaveOutput_RM = 'SNEACY_Child_WRAT_Reading_RM.xlsx';
SaveOutput_Long= 'SNEACY_Child_WRAT_Reading_Long.xlsx';
%% Import the standard scores
cd(FilePath);
StandardScores_Blue = readtable(FileName_Blue, 'Sheet', 'WRAT4_WordReading');

StandardScores_Blue.Properties.VariableNames = {'Raw', 'age5x0_5x2','age5x3_5x5','age5x6_5x8','age5x9_5x11',...
                                                  'age6x0_6x2','age6x3_6x5','age6x6_6x8','age6x9_6x11',...
                                                  'age7x0_7x2','age7x3_7x5','age7x6_7x8','age7x9_7x11',...
                                                  'age8x0_8x3','age8x4_8x7','age8x8_8x11','age9x0_9x3',...
                                                  'age9x4_9x7','age9x8_9x11','age10x0_10x3','age10x4_10x7',...
                                                  'age10x8_10x11','age11x0_11x3','age11x4_11x7','age11x8_11x11',...
                                                  'age12x0_12x3','age12x4_12x7','age12x8_12x11','age13x0_13x5',...
                                                  'age13x6_13x11','age14x0_14x5','age14x6_14x11','age15x0_15x11',...
                                                  'age16x0_16x11','age17x0_17x11','age18x0_19x11','age20x0_24x11','age25x0_34x11'};

cd(FilePath);
StandardScores_Green = readtable(FileName_Green, 'Sheet', 'WRAT4_WordReading');

StandardScores_Green.Properties.VariableNames = {'Raw', 'age5x0_5x2','age5x3_5x5','age5x6_5x8','age5x9_5x11',...
                                                  'age6x0_6x2','age6x3_6x5','age6x6_6x8','age6x9_6x11',...
                                                  'age7x0_7x2','age7x3_7x5','age7x6_7x8','age7x9_7x11',...
                                                  'age8x0_8x3','age8x4_8x7','age8x8_8x11','age9x0_9x3',...
                                                  'age9x4_9x7','age9x8_9x11','age10x0_10x3','age10x4_10x7',...
                                                  'age10x8_10x11','age11x0_11x3','age11x4_11x7','age11x8_11x11',...
                                                  'age12x0_12x3','age12x4_12x7','age12x8_12x11','age13x0_13x5',...
                                                  'age13x6_13x11','age14x0_14x5','age14x6_14x11','age15x0_15x11',...
                                                  'age16x0_16x11','age17x0_17x11','age18x0_19x11','age20x0_24x11','age25x0_34x11'};
                                  
%% Import the data
cd(FilePath);
WordReading = readtable(FileName_Data);

%% Organizing Data
%making the table with numbers instead of strings
WordReading.wrat_g_reading_score=str2double(WordReading.wrat_g_reading_score);
%pulling age from WordReading 
Age = WordReading(WordReading.redcap_event_name==string('baseline_parent_su_arm_1'),:);
%Remove unneeded columns
Age = removevars(Age,{'redcap_event_name','wrat_g_int','wrat_g_reading_score','wrat_b_int','wrat_b_reading_score'});
%pulling intervention and scores from WordReading
Int_Score=WordReading(WordReading.redcap_event_name==string('wrat_arm_1'),:);
%remove unneeded columns
Int_Score=removevars(Int_Score,{'redcap_event_name','dob_years'});
%combine tables 
Combined_age_int_score= outerjoin(Age, Int_Score);
%remove duplicate ID
Combined_age_int_score= removevars(Combined_age_int_score, 'redcap_id_Int_Score');
%rename solumns
Combined_age_int_score.Properties.VariableNames{1} = 'Subject';
Combined_age_int_score.Properties.VariableNames{2} = 'Age';

%% Indexing Categorical Age
DataTableRows = height(Combined_age_int_score);

for P = 1:DataTableRows
   if Combined_age_int_score.Age(P) > 9.000 && Combined_age_int_score.Age(P) < 9.332
       Combined_age_int_score.CatAge(P) = {'age9x0_9x3'};
  elseif Combined_age_int_score.Age(P) > 9.333 && Combined_age_int_score.Age(P) < 9.665       
       Combined_age_int_score.CatAge(P) = {'age9x4_9x7'};
  elseif Combined_age_int_score.Age(P) > 9.666 && Combined_age_int_score.Age(P) < 9.999          
      Combined_age_int_score.CatAge(P) = {'age9x8_9x11'};
  elseif Combined_age_int_score.Age(P) > 10.000 && Combined_age_int_score.Age(P) < 10.332    
   Combined_age_int_score.CatAge(P) = {'age10x0_10x3'};
  elseif Combined_age_int_score.Age(P) > 10.333 && Combined_age_int_score.Age(P) < 10.665    
    Combined_age_int_score.CatAge(P) = {'age10x4_10x7'};
  elseif Combined_age_int_score.Age(P) > 10.666 && Combined_age_int_score.Age(P) < 10.999    
    Combined_age_int_score.CatAge(P) = {'age10x8_10x11'};
  elseif Combined_age_int_score.Age(P) > 11.000 && Combined_age_int_score.Age(P) < 11.332
    Combined_age_int_score.CatAge(P) = {'age11x0_11x3'};
  elseif Combined_age_int_score.Age(P) > 11.333 && Combined_age_int_score.Age(P) < 11.665    
    Combined_age_int_score.CatAge(P) = {'age11x4_11x7'};
  elseif Combined_age_int_score.Age(P) > 11.666 && Combined_age_int_score.Age(P) < 11.999    
    Combined_age_int_score.CatAge(P) = {'age11x8_11x11'};
   end
end
%% Indexing Standardized Score
%Score all standard scores
%Green standard scores
for P = 1:DataTableRows
    if Combined_age_int_score.wrat_g_reading_score(P) > 0
        temp = char(Combined_age_int_score.CatAge(P));
        StandScore = array2table(StandardScores_Green.(temp)(Combined_age_int_score.wrat_g_reading_score(P))) ;
       Combined_age_int_score(P,'wrat_g_reading_standard') = StandScore;
    elseif ismissing(Combined_age_int_score.wrat_g_reading_score(P))
        StandScore = array2table(NaN);
        Combined_age_int_score(P,'wrat_g_reading_standard') = StandScore;
    end
end

%Blue Standard Scores
for P = 1:DataTableRows
    if Combined_age_int_score.wrat_b_reading_score(P) > 0
        temp = char(Combined_age_int_score.CatAge(P));
        StandScore = array2table(StandardScores_Blue.(temp)(Combined_age_int_score.wrat_b_reading_score(P))) ;
        Combined_age_int_score(P,'wrat_b_reading_standard') = StandScore;
    elseif ismissing(Combined_age_int_score.wrat_g_reading_score(P))
        StandScore = array2table(NaN);
        Combined_age_int_score(P,'wrat_b_reading_standard') = StandScore;
    end
end

%% Create Long format spreadsheet
SNEACY_WRAT_G = Combined_age_int_score(:,{'Subject','Age','wrat_g_int','wrat_g_reading_score','wrat_g_reading_standard'}); %pull out green scores
SNEACY_WRAT_G.Properties.VariableNames{3} = 'WRAT_Int'; % change to neutral name
SNEACY_WRAT_G.Properties.VariableNames{4} = 'WRAT_Reading_RawScore'; % change to neutral name
SNEACY_WRAT_G.Properties.VariableNames{5} = 'WRAT_Reading_StandScore'; % change to neutral name

n = height(SNEACY_WRAT_G);
SNEACY_WRAT_G.WRAT_Type = ones(n,1); %create variable WRAT_Type (1 = G, 0 = B)

SNEACY_WRAT_B = Combined_age_int_score(:,{'Subject','Age','wrat_b_int','wrat_b_reading_score','wrat_b_reading_standard'}); %pull out blue scores
SNEACY_WRAT_B.Properties.VariableNames{3} = 'WRAT_Int'; % change to neutral name
SNEACY_WRAT_B.Properties.VariableNames{4} = 'WRAT_Reading_RawScore'; % change to neutral name
SNEACY_WRAT_B.Properties.VariableNames{5} = 'WRAT_Reading_StandScore'; % change to neutral name

n = height(SNEACY_WRAT_B);
SNEACY_WRAT_B.WRAT_Type = zeros(n,1); %create variable WRAT_Type (1 = G, 0 = B)

SNEACY_WRAT_Long = [SNEACY_WRAT_G; SNEACY_WRAT_B]; % create long format of SNEACY WRAT (green + blue)

%% Create RM spreadsheet
SNEACY_WRAT_RM = table; %create table to put RM data into
SNEACY_WRAT_RM.Subject = unique(SNEACY_WRAT_Long.Subject); %add subject column into SNEACY_WRAT_RM

% Create RawScore RM variables
Variable_Names = {'WRAT_Reading_RawScore_T'; 'WRAT_Reading_RawScore_R'; 'WRAT_Reading_RawScore_E'};  %create variable names for each variable
SNEACY_WRAT_RM_Raw = unstack(SNEACY_WRAT_Long, 'WRAT_Reading_RawScore', 'WRAT_Int', 'GroupingVariables', 'Subject', 'NewDataVariableNames', Variable_Names);

% Create StandScore RM variables
Variable_Names = {'WRAT_Reading_StandScore_T'; 'WRAT_Reading_StandScore_R'; 'WRAT_Reading_StandScore_E'};  %create variable names for each variable
SNEACY_WRAT_RM_Standard = unstack(SNEACY_WRAT_Long, 'WRAT_Reading_StandScore', 'WRAT_Int', 'GroupingVariables', 'Subject', 'NewDataVariableNames', Variable_Names);

%Prepare Age table to combine with SNEACY_WRAT_RM
Age.Properties.VariableNames{1} = 'Subject';
Age.Properties.VariableNames{2} = 'Age';

%Combine SNEACY_WRAT_RM and Age variable
SNEACY_WRAT_RM = outerjoin(Age, SNEACY_WRAT_RM_Raw); %join Age + SNEACY raw RM scores
SNEACY_WRAT_RM.Properties.VariableNames{1} = 'Subject'; %rename first column back to subject (so next compare works)

SNEACY_WRAT_RM = outerjoin(SNEACY_WRAT_RM, SNEACY_WRAT_RM_Standard); %join SNEACY RM sheet with standard scores
SNEACY_WRAT_RM.Properties.VariableNames{1} = 'Subject'; %rename first column back to subject

SNEACY_WRAT_RM(:,strncmp(SNEACY_WRAT_RM.Properties.VariableNames, 'Subject_', length('Subject_')) ) = [];  %Remove excess Subject columns

%% Creat RM Spreadsheet by color 
% SNEACY_WRAT_G = Combined_age_int_score(:,{'Subject','Age','wrat_g_int','wrat_g_reading_score','wrat_g_reading_standard'}); %pull out green scores
% SNEACY_WRAT_B = Combined_age_int_score(:,{'Subject','Age','wrat_b_int','wrat_b_reading_score','wrat_b_reading_standard'}); %pull out blue scores
% SNEACY_WRAT_G(end,:) = [];%delete sA140, which is labeled incorrectly and has no data and fucks shit up
% SNEACY_WRAT_B(end,:) = []; %delete sA140, which is labeled incorrectly and has no data and fucks shit up
% 
% SNEACY_WRAT_RM_bycolor = table;
% SNEACY_WRAT_RM_bycolor.Subject = unique(SNEACY_WRAT_Long.Subject);
% SNEACY_WRAT_RM_bycolor = Combined_age_int_score(:,{'Subject','Age','wrat_g_int','wrat_g_reading_standard','wrat_b_int','wrat_b_reading_standard'});
% SNEACY_WRAT_RM_bycolor(end,:) = []; %delete sA140, which is labeled incorrectly and has no data and fucks shit up
% 
% Variable_Names = {'G_WRAT_Reading_StandScore_T'; 'G_WRAT_Reading_StandScore_R'; 'G_WRAT_Reading_StandScore_E'};  %create variable names for each variable
% SNEACY_WRAT_RM_G = unstack(SNEACY_WRAT_RM_bycolor, 'wrat_g_reading_standard', 'wrat_g_int', 'GroupingVariables', 'Subject', 'NewDataVariableNames', Variable_Names);
% 
% Variable_Names = {'B_WRAT_Reading_StandScore_T'; 'B_WRAT_Reading_StandScore_R'; 'B_WRAT_Reading_StandScore_E'};  %create variable names for each variable
% SNEACY_WRAT_RM_B = unstack(SNEACY_WRAT_RM_bycolor, 'wrat_b_reading_standard', 'wrat_b_int', 'GroupingVariables', 'Subject', 'NewDataVariableNames', Variable_Names);
% 
% SNEACY_WRAT_RM_bycolor = removevars(SNEACY_WRAT_RM_bycolor, {'wrat_g_int','wrat_g_reading_standard','wrat_b_int','wrat_b_reading_standard'});%delete old variables 
% Age.Properties.VariableNames{1} = 'Subject';
% Age.Properties.VariableNames{2} = 'Age';
% 
% SNEACY_WRAT_RM_bycolor = outerjoin(Age, SNEACY_WRAT_RM_G); %join Age + SNEACY raw RM G
% SNEACY_WRAT_RM_bycolor.Properties.VariableNames{1} = 'Subject'; %rename first column back to subject (so next compare works)
% SNEACY_WRAT_RM_bycolor(end,:) = [];%delete sA140, which is labeled incorrectly and has no data and fucks shit up
% 
% SNEACY_WRAT_RM_bycolor = outerjoin(SNEACY_WRAT_RM_G, SNEACY_WRAT_RM_B); %join SNEACY RM G with SNEACY RM B
% SNEACY_WRAT_RM_bycolor.Properties.VariableNames{1} = 'Subject'; %rename first column back to subject
% 
% SNEACY_WRAT_RM_bycolor = removevars(SNEACY_WRAT_RM_bycolor, 'Subject_SNEACY_WRAT_RM_B');
%% Clear temp variables 
clearvars -except SNEACY_WRAT_RM SNEACY_WRAT_Long SaveOutput_RM SaveOutput_Long FilePath

%% Saving Excel File
cd(FilePath)
save SNEACY_WRAT_Reading %save output as Matlab variable
writetable(SNEACY_WRAT_RM,SaveOutput_RM, 'WriteRowNames',true);
writetable(SNEACY_WRAT_Long,SaveOutput_Long, 'WriteRowNames',true);


