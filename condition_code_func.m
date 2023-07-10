%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%define root dir (where project data is) and sessions of interest:
conditions = [];
root_dir='Y:\';
[~,sessions]=fetch_flicker_subjectIDs(root_dir,'flickerneuro');
conditions.ses = join([sessions.sub,sessions.ses],'_',2);

output_path = 'Y:\Sina\stg-analysis\IED_distributions';


for exp_nber=3:size(conditions.ses,1)-1
    disp("Processing session data: " + sessions{exp_nber,'sub'}{:} + '_ses-'...
        + sessions{exp_nber,'ses'}{:});
    %get soz channels:
    fnames=struct;
    fnames.root_dir=root_dir;
    fnames.subjectID=sessions{exp_nber,'sub'}{:};
    fnames.task=sessions{exp_nber,'task'}{:};
    fnames.ses=sessions{exp_nber,'ses'}{:};
    fnames.analysis_folder = 'stg-analysis\IED_distributions';
    
    %% Import the LFP PSD Laplacian refernced data for the channels

    data = [root_dir 'stg-preproc\sub-' sessions{exp_nber,'sub'}{:}...
        '\task-' sessions{exp_nber,'task'}{:} '\ses-' sessions{exp_nber,'ses'}{:}...
        '\sub-' sessions{exp_nber,'sub'}{:} '_stg-preproc_task-'...
        sessions{exp_nber,'task'}{:} '_ses-' sessions{exp_nber,'ses'}{:}...
        '_nat-beh.mat'];

    trials_Obj= matfile(data); 
    trials = trials_Obj.trials;
    condition_code = trials.condition_code;
    
    file_path = fullfile(output_path, ['\sub-' sessions{exp_nber,'sub'}{:}...
        '_ses-' sessions{exp_nber,'ses'}{:} '_condition-codes.xlsx']);
    disp("file path is: "+ file_path);
    xlswrite(file_path,condition_code);
    clear trials;

end