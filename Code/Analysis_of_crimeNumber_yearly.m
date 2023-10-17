%bar plot of yearly cime number
crime = readtable('Crimes_2015_to_2022.csv');
sorted_crime = sortrows(crime,'Year');
countYear = groupcounts(sorted_crime,"Year");
bar(countYear.Year, countYear.GroupCount);
title('the recorded crimes by year');
xlabel('year');
ylabel('yearly number of crimes');
legend('yearly number of crimes');



