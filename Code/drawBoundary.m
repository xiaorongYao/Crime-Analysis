
function drawBoundary(filename)
    %plot the boundaries of the community areas of chicago 
    areaBorder = readtable(filename);
    areaBorder = table2cell(areaBorder);
    
    
    % extract the longtitude and latitude from the strings and put it into a
    % table for each community area 
    for i = 1:size(areaBorder,1)
        %test now for a{1}
        table = struct("Latitude",[],"Longitude",[]);
         n = extractBetween(areaBorder{i}, 'MULTIPOLYGON (((',')))');
         n = cell2mat(n);
       
          n =  str2num(n);
         
         for j = 1: numel(n)/2
            table.Latitude = [table.Latitude;n(1,2*j)];
            table.Longitude = [table.Longitude;n(1,2*j-1)];
         end

         table = struct2table(table);
          h = geoplot(table,"Latitude","Longitude",'Color','b','LineWidth',0.8);
          meanloc = mean(table);
          text(meanloc.Latitude,meanloc.Longitude,num2str(cell2mat(areaBorder(i,6))));
          geobasemap topographic;
          
          hold on;
    end
    geolimits('manual');
end

