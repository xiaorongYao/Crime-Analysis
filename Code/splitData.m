%clean data, output data from 2015-2022, and data of 2022 only
function splitData(filename)
    table = readtable(filename);
    %data between 2010-2022
    data1 = table;
    row_clean = (table.Year-2015)<0; 
    data1(row_clean,:) = [];
    row_clean = (data1.Year-2022)>0; 
    data1(row_clean,:) = [];
    writetable(data1,"Crimes_2015_to_2022.csv");
    %data in 2022
    data2 = table(table.Year == 2022,:);
    writetable(data2,"Crimes_2022.csv");
    % %data in 2023
    % data3 = table(table.Year == 2023,:);
    % writetable(data3,"Crimes_-_2023.csv");
end
    


