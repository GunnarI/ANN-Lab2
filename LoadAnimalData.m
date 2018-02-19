function [props, animalNames, animalAttributes] = LoadAnimalData()
% No change
if exist('animalNames.mat', 'file') == 2
    load animalNames;
else
    animalNamesID = fopen('animalnames.txt');
    animalNames = textscan(animalNamesID,'%s');
    %animalNames = convertCharsToStrings(animalNames{1});
    animalNames = cellstr(animalNames{1});
    fclose(animalNamesID);
end

if exist('animalAttributes.mat','file') == 2
    load animalAttributes;
else
    animalAttrID = fopen('animalattributes.txt');
    animalAttributes = textscan(animalAttrID,'%s');
    %animalAttributes = convertCharsToStrings(animalAttributes{1});
    animalAttributes = cellstr(animalAttributes{1});
    fclose(animalAttrID);
end

if exist('props.mat', 'file') == 2
    load props;
else
    props = reshape(importdata('animals.dat'),...
        [length(animalAttributes), length(animalNames)])';
end
end