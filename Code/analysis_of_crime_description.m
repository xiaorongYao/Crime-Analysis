%word cloud! of crime description
%delete primaryType description
crime = readtable('Crimes_2022.csv');
crime_sorted = sortrows(crime,'PrimaryType');
primaryType = groupcounts(crime_sorted,'PrimaryType').PrimaryType;
descriptions = '';
for i = 1:size(crime,1)
    word = crime.Description{i};
    if ~isPrimaryType(word,primaryType)
        descriptions = [descriptions,' ',word];
    end
end
words = extractWords(descriptions);   
C = categorical(words);  % convert list into a categorical object
wordcloud(C);
title("Word Cloud");



function words = extractWords(text)
    punctuationCharacters = ["." "?" "!" "," ";" ":"];
    text = replace(text,punctuationCharacters," ");
    words = split(join(text));
    words(strlength(words)<5) = [];
end

function prime = isPrimaryType(word,primaryType)
    prime = 0;
    for i = 1: size(primaryType,1)
        if contains(word, primaryType{i},'IgnoreCase',true)
            prime = 1;
            return;
        end
    end
end
