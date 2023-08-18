%KAMF doesn't have composite

try
[accuracy(1), RMSE(1)]=Chills_Profile_CrossValidation({1,2,3,4},{1,2,3,4,5}, {'DPES','KAMF','MODTAS','NEOFFI'},'Individual','Binary');
catch
end
try
[accuracy(2), RMSE(2)]=Chills_Profile_CrossValidation({1,2,3,4},{1,2,3,4,5}, {'DPES','KAMF','MODTAS','NEOFFI'},'Singular','Binary');
catch
end
try
[accuracy(3), RMSE(3)]=Chills_Profile_CrossValidation({1,2,3,4},{1,2,3,4,5}, {'DPES','KAMF','MODTAS','NEOFFI'},'Composite','Binary');
catch
end
try
[accuracy(4), RMSE(4)]=Chills_Profile_CrossValidation({1,2,3,4},{1,2,3,4,5}, {'DPES'},'Individual','Binary');
catch
end
try
[accuracy(5), RMSE(5)]=Chills_Profile_CrossValidation({1,2,3,4},{1,2,3,4,5}, {'DPES'},'Singular','Binary');
catch
end
try
[accuracy(6), RMSE(6)]=Chills_Profile_CrossValidation({1,2,3,4},{1,2,3,4,5}, {'DPES'},'Composite','Binary');
catch
end
try
[accuracy(7), RMSE(7)]=Chills_Profile_CrossValidation({1,2,3,4},{1,2,3,4,5}, {'MODTAS',},'Individual','Binary');
catch
end
try
[accuracy(8), RMSE(8)]=Chills_Profile_CrossValidation({1,2,3,4},{1,2,3,4,5}, {'MODTAS'},'Singular','Binary');
catch
end
try
[accuracy(9), RMSE(9)]=Chills_Profile_CrossValidation({1,2,3,4},{1,2,3,4,5}, {'MODTAS'},'Composite','Binary');
catch
end
try
[accuracy(10), RMSE(10)]=Chills_Profile_CrossValidation({1,2,3,4},{1,2,3,4,5}, {'NEOFFI'},'Individual','Binary');
catch
end
try
[accuracy(11), RMSE(11)]=Chills_Profile_CrossValidation({1,2,3,4},{1,2,3,4,5}, {'NEOFFI'},'Singular','Binary');
catch
end
try
[accuracy(12), RMSE(12)]=Chills_Profile_CrossValidation({1,2,3,4},{1,2,3,4,5}, {'NEOFFI'},'Composite','Binary');
catch
end
try
[accuracy(13), RMSE(13)]=Chills_Profile_CrossValidation({1,2,3,4},{1,2,3,4,5}, {'KAMF'},'Individual','Binary');
catch
end
try
[accuracy(14), RMSE(14)]=Chills_Profile_CrossValidation({1,2,3,4},{1,2,3,4,5}, {'KAMF'},'Singular','Binary');
catch
end

