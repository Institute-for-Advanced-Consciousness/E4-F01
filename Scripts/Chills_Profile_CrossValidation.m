%Pre-States Variables
% Column 1 = Arousal, 2 = Valence, 3 = Mood, 4 = Prior Exposure
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


function []=Chills_Profile_CrossValidation(Features,Summary_Style,Prediction, Within_Video)
%Trait-Features should be a cell array containing all the variable names to
%be used.
%Summary style should take on the form of 'Individual','Singular','or
%'Composite'
%Prediction should be either 'Binary' or 'Intensity'
%
%Within_Video -- 0 for all videos; # for specific video; 999 for
%iteratively through each video.
%
%

%% Remove Subjects without responses on the variables of interest
%If predicting chills intensity, the first step is to limit subjects to only those that got chills
switch Prediction
    case 'Intensity'
    case 'Binary'
end

%Load in variables of interest, identify indices with 999
bad_idx=zeros(length(Subj_ID),1);


%% Build Feature Sets


%% Create Cross-Validation


%% Balance before Classification

switch Prediction
    case 'Binary'
    case 'Intensity'
        %No need to balance if it's on a continual scale
end

%% Classification
