%Created by Katherine McDonald
%If you use my script, I kindly ask for co-authorship on your work as a
%significant contributor to your data processing pipeline

%==========Script to run all scripts!============

%% Resting EO 
cd '/Volumes/Data/KatherineM/SNEACY/SNEACY2_HIIT/EEG/EO/'; 

%Run Exercise Pre Resting EEG EO
run('SNEACY2_Child_EO_EEG_Exercise_Pre.m');

cd '/Volumes/Data/KatherineM/SNEACY/SNEACY2_HIIT/EEG/EO/'; 

%Run Exercise Post Resting EEG EO
run('SNEACY2_Child_EO_EEG_Exercise_Post.m');

cd '/Volumes/Data/KatherineM/SNEACY/SNEACY2_HIIT/EEG/EO/'; 

%Run Rest Pre Resting EEG EO
run('SNEACY2_Child_EO_EEG_Rest_Pre.m');

cd '/Volumes/Data/KatherineM/SNEACY/SNEACY2_HIIT/EEG/EO/'; 

%Run Exercise Post Resting EEG EO
run('SNEACY2_Child_EO_EEG_Rest_Post.m');

cd '/Volumes/Data/KatherineM/SNEACY/SNEACY2_HIIT/EEG/EO/'; 

%Run Trier Pre Resting EEG EO
run('SNEACY2_Child_EO_EEG_Trier_Pre.m');

cd '/Volumes/Data/KatherineM/SNEACY/SNEACY2_HIIT/EEG/EO/';  

%Run Trier Post Resting EEG EO
run('SNEACY2_Child_EO_EEG_Trier_Post.m');

%% Flanker EEG
cd '/Volumes/Data/KatherineM/SNEACY/SNEACY2_HIIT/EEG/Flanker_DL/';

%Run Exercise Pre Flanker
run('SNEACY2_Child_Flanker_EEG_E_Pre.m');

cd '/Volumes/Data/KatherineM/SNEACY/SNEACY2_HIIT/EEG/Flanker_DL/';

%Run Exercise Post Flanker
run('SNEACY2_Child_Flanker_EEG_E_Post.m');
 
cd '/Volumes/Data/KatherineM/SNEACY/SNEACY2_HIIT/EEG/Flanker_DL/';

%Run Rest Pre Flanker
run('SNEACY2_Child_Flanker_EEG_R_Pre.m');

cd '/Volumes/Data/KatherineM/SNEACY/SNEACY2_HIIT/EEG/Flanker_DL/';
 
%Run Exercise Post Flanker
run('SNEACY2_Child_Flanker_EEG_R_Post.m');

cd '/Volumes/Data/KatherineM/SNEACY/SNEACY2_HIIT/EEG/Flanker_DL/';
 
%Run Trier Pre Flanker
run('SNEACY2_Child_Flanker_EEG_T_Pre.m');

cd '/Volumes/Data/KatherineM/SNEACY/SNEACY2_HIIT/EEG/Flanker_DL/';
 
%Run Trier Post Flanker
run('SNEACY2_Child_Flanker_EEG_T_Post.m');

%% Flanker EEG Peak Amplitude and Latency


%% Flanker Behavior 
%LR runs on collaborator's website
