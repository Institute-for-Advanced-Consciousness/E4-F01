%KAMF doesn't have composite

try
accuracy(1)=Chills_Profile_CrossValidation({1,2,3,4},{1,2,3,4,5}, {'DPES','KAMF','MODTAS','NEOFFI'},'Individual','Intensity');
catch
end
try
accuracy(2)=Chills_Profile_CrossValidation({1,2,3,4},{1,2,3,4,5}, {'DPES','KAMF','MODTAS','NEOFFI'},'Singular','Intensity');
catch
end
try
accuracy(3)=Chills_Profile_CrossValidation({1,2,3,4},{1,2,3,4,5}, {'DPES','KAMF','MODTAS','NEOFFI'},'Composite','Intensity');
catch
end
try
accuracy(4)=Chills_Profile_CrossValidation({1,2,3,4},{1,2,3,4,5}, {'DPES'},'Individual','Intensity');
catch
end
try
accuracy(5)=Chills_Profile_CrossValidation({1,2,3,4},{1,2,3,4,5}, {'DPES'},'Singular','Intensity');
catch
end
try
accuracy(6)=Chills_Profile_CrossValidation({1,2,3,4},{1,2,3,4,5}, {'DPES'},'Composite','Intensity');
catch
end
try
accuracy(7)=Chills_Profile_CrossValidation({1,2,3,4},{1,2,3,4,5}, {'MODTAS',},'Individual','Intensity');
catch
end
try
accuracy(8)=Chills_Profile_CrossValidation({1,2,3,4},{1,2,3,4,5}, {'MODTAS'},'Singular','Intensity');
catch
end
try
accuracy(9)=Chills_Profile_CrossValidation({1,2,3,4},{1,2,3,4,5}, {'MODTAS'},'Composite','Intensity');
catch
end
try
accuracy(10)=Chills_Profile_CrossValidation({1,2,3,4},{1,2,3,4,5}, {'NEOFFI'},'Individual','Intensity');
catch
end
try
accuracy(11)=Chills_Profile_CrossValidation({1,2,3,4},{1,2,3,4,5}, {'NEOFFI'},'Singular','Intensity');
catch
end
try
accuracy(12)=Chills_Profile_CrossValidation({1,2,3,4},{1,2,3,4,5}, {'NEOFFI'},'Composite','Intensity');
catch
end
try
accuracy(13)=Chills_Profile_CrossValidation({1,2,3,4},{1,2,3,4,5}, {'KAMF'},'Individual','Intensity');
catch
end
try
accuracy(14)=Chills_Profile_CrossValidation({1,2,3,4},{1,2,3,4,5}, {'KAMF'},'Singular','Intensity');
catch
end

