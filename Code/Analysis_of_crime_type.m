%pie chart of crime primary type
%top several crime, and the rest
%first ten and then others
top_num = 10;
crime = readtable('Crimes_2015_to_2022.csv');
crime_sorted = sortrows(crime,'PrimaryType');
typecounts = groupcounts(crime_sorted,'PrimaryType');
typecounts = sortrows(typecounts,'GroupCount','descend');

%pie chart
plotdata = [typecounts.GroupCount(1:8); sum(typecounts.GroupCount)-sum(typecounts.GroupCount(1:8))];
pie(plotdata,[typecounts.PrimaryType(1:8).',{'others'}]);
title('Crime Primary Type');