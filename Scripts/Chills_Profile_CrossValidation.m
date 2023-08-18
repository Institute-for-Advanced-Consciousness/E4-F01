%Pre-States Variables
% Column 1 = Arousal, 2 = Valence, 3 = Mood, 4 = Prior Exposure, 5=VideoID
%
%Demographics Variables
% Column 1 = Age, 2 = Education, 3 = Sex, 4 = Political Preference
%
%NEOFFI.Composite:
% Negative Affect, Self-Reproach, Positive Affect, Sociability, Activity,...
% Aesthetic Interests, Intellectual Interests, Unconventiality, ...
% Nonantagonistic Orientation, Prosocial Orientation,...
% Ordiliness, Goal-Striving, Dependability
%
%NEOFFI.Singular:
% Neuroticism, Extraversion, Openness, Agreeableness, Conscientiousness
%
%
% MODTAS.Composite
%synesthesia, asc, aesthetic involvement, imaginative involvement, ESP


function [mean_accuracy]=Chills_Profile_CrossValidation(Demographic_Features, Pre_State_Features, Trait_Features,Summary_Style,Prediction)
%Trait_Features should be a cell array containing all the variable names to
%be used. Future: 'All' will use all variable available. 'None' is none.
%
%Pre_State_Features should be a cell array containing all the variable
%names to be used. Future: 'All' will use all variables available.'None' is none.
%
%Demographic_Features should be a cell array containing all the variable
%names to be used. Future: 'All' will use all variables available.'None' is none.
%
%Summary style should take on the form of 'Individual','Singular','or
%'Composite'
%Prediction should be either 'Binary' or 'Intensity'
%
%Within_Video -- 0 for all videos; # for specific video; 999 for
%iteratively through each video.

%% Path Definition
paths.top_dir='E:\Chills_Profile\E4-F01';
paths.reference=[paths.top_dir '\Reference\'];
paths.data=[paths.top_dir '\Data\'];

%% Flags
flags.n_out=.25; %Percent of the dataset to leave-out for training.
flag.n_cv=10000; %Number of random shufflings to conduct

%% Load In All Necessary Variables
load([paths.reference 'Traits.mat'])
load([paths.reference 'Subj_ID.mat'])
load([paths.reference 'Demographics.mat'])
load([paths.data 'Pre_State.mat'])
load([paths.data 'Chills_Outcome.mat'])

%% Remove Subjects without responses on the variables of interest
%Load in variables of interest, identify indices with 999 and add them to a
%master list to remove those subjs
bad_idx=zeros(length(Subj_ID),1);

%If predicting chills intensity, the first step is to limit subjects to only those that got chills
switch Prediction
    case 'Intensity'
        bad_idx(find(Chills_Binary==2))=1; %1 = Yes; 2 = No
end

% TRAITS
all_traits=[]; %Initialize to aggregate all trait variables into one section
for t=1:size(Trait_Features,2)
    cur_trait=eval(Trait_Features{t});
    switch Summary_Style
        case 'Individual'
            cur_traits=cur_trait.Individual;
        case 'Composite'
            cur_traits=cur_trait.Composite;
        case 'Singular'
            cur_traits=cur_trait.Singular;
    end
    for ti = 1: size(cur_traits,2)
        temp_bad=find(cur_traits(:,ti)==999); %Find if the current column has 999 (coded as N/A before) and remove if so.
        if ~isempty(temp_bad)
            bad_idx(temp_bad)=1;
        end
        clear temp_bad
    end
    all_traits=[all_traits,cur_traits];
end

% DEMOGRAPHICS
%Demographics Variables
% Column 1 = Age, 2 = Education, 3 = Sex, 4 = Political Preference
all_demographics=[];

for d=1:size(Demographic_Features,2)
    cur_demo=Demographics(:,Demographic_Features{d});
    temp_bad=find(cur_demo==999); %Find if the current column has 999 (coded as N/A before) and remove if so.
    if ~isempty(temp_bad)
        bad_idx(temp_bad)=1;
    end
    clear temp_bad
    all_demographics=[all_demographics,cur_demo];
end

% PRE STATE FEATURES
all_pre_state=[];

for p=1:size(Pre_State_Features,2)
    cur_prestate=Pre_State(:,Pre_State_Features{p});
    temp_bad=find(cur_prestate==999); %Find if the current column has 999 (coded as N/A before) and remove if so.
    if ~isempty(temp_bad)
        bad_idx(temp_bad)=1;
    end
    clear temp_bad
    all_pre_state=[all_pre_state,cur_prestate];
end

%% Build Feature Set & Prediction Array
good_idx = ~bad_idx;
Subj_IDs_Used=Subj_ID(good_idx);

%Concatenate Feature Sets
Features=[all_traits,all_demographics,all_pre_state];
Features=Features(good_idx,:);

%Create Prediction Array
switch Prediction
    case 'Binary'
        Prediction_Array=Chills_Binary;
    case 'Intensity'
        Prediction_Array=Chills_Intensity;
end
Prediction_Array=Prediction_Array(good_idx);

%% Create Cross-Validation
%Simple, non-exhaustive, random x-val setup
n_trials_out=ceil(length(Prediction_Array)*flags.n_out);
for c = 1:flag.n_cv
    xval_idxs{c}=ones(1,length(Prediction_Array));
    rand_out=randperm(length(Prediction_Array),n_trials_out);
    xval_idxs{c}(rand_out)=2;
end

%% Classification
master_lasso_prediction=zeros(1,length(Prediction_Array));
master_prediction_counter=zeros(1,length(Prediction_Array));

for cv = 1:size(xval_idxs,2)
    xval_idx=xval_idxs{cv};
    training_idx=find(xval_idx==1);
    testing_idx=find(xval_idx==2);

    training_features=Features(training_idx,:);
    testing_features=Features(testing_idx,:);

    training_prediction=Prediction_Array(training_idx);
    testing_prediction=Prediction_Array(testing_idx);

    switch Prediction
        case 'Binary'

        case 'Intensity'

            %TRAIN
            [B fitinfo]=lasso(training_features,training_prediction','lambda',.002);

            for p=1:length(testing_prediction)
                    %TEST
                    lasso_prediction(testing_idx(p))=sum(testing_features(p,:)'.*B)+fitinfo.Intercept;
                    lasso_prediction_simple(p)=sum(testing_features(p,:)'.*B)+fitinfo.Intercept;
            end

            %Set a ceiling on prediction at the scale limit.
            limiter_idx=find(lasso_prediction_simple>100);
            lasso_prediction_simple(limiter_idx)=100;
            limiter_idx=find(lasso_prediction>100);
            lasso_prediction(limiter_idx)=100;

            master_prediction_counter(testing_idx)=master_prediction_counter(testing_idx)+1;
            master_lasso_prediction(testing_idx)=master_lasso_prediction(testing_idx)+lasso_prediction(testing_idx);
            [acc_value, pval]=corrcoef(lasso_prediction_simple,testing_prediction');
            accuracy(cv)=acc_value(1,2);
            p_value(cv)=pval(1,2);
            RMSE(cv)=sqrt(mean((lasso_prediction_simple'-testing_prediction).^2));

    end
end

total_prediction=master_lasso_prediction./master_prediction_counter; %account for the number of times this value was predicted
[total_accuracy, total_pval]=corrcoef(total_prediction, Prediction_Array);
%scatter(total_prediction, Prediction_Array);

total_accuracy=total_accuracy(1,2);
total_pval=total_pval(1,2);
total_RMSE = sqrt(mean((total_prediction' - Prediction_Array).^2));

mean_accuracy=mean(accuracy);
mean_RMSE=mean(RMSE);
mean_pval=mean(p_value);

end
