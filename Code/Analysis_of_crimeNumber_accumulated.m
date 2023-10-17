% describe crime number by year accumulated

crime = readtable('Crimes_2015_to_2022.csv');
sorted_crime = sortrows(crime,'Year');
countYear = groupcounts(sorted_crime,'Year');
countYear.cumSum = cumsum(countYear.GroupCount);
plot(countYear, 'Year','cumSum');
title('the cumulated number of recorded crimes by year');
xlabel('year');
ylabel('total number of crimes');
legend('total number of crimes');

