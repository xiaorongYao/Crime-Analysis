%bubble plot, bubble size: district count, bubble xy: first case of the
%district, bubble cause: district name
%in data process, much like lab4 ex2_2 uses struct
%it's also as good to use table manipulations as well
crime = readtable('Crimes_2022.csv');

%struct: latitude, longtiude, communityarea
	for i = 1:size(crime, 1)
		% structure the data
		data{i} = struct(...
			'Latitude', table2array(crime(i, 20)), ...
			'Longitude', table2array(crime(i, 21)), ...
			'District', table2array(crime(i, 12)));
		% use an array to store case count for ease of use
    end

    %struct: communityarea,latitude, longtitude,count
    %todo: in sorting, we can also use sortrows and other commands to
    %manipulate
    %some of the latitude, longtitude maybe nan need to take care of it
    %for easy, the district bubble is placed on the first location of the
    %case of the district which is not nan
   processed_data = {};
   for i = 1:size(data, 2) 
		record = data{i};
        record.Count = 1; %the count of the case in district
        found_entry = false; %default
		for i = 1:size(processed_data, 2)
			if processed_data{i}.District == record.District % already exists entry
				processed_data{i}.Count = processed_data{i}.Count + 1; % update existing entry
				found_entry = true; % already found, no need to create new
                if isnan(processed_data{i}.Latitude) 
                    processed_data{i}.Latitude = record.Latitude;
                end
                if isnan(processed_data{i}.Longitude) 
                    processed_data{i}.Longitude = record.Longitude;
                end
            end
		end
		if ~found_entry % no existing entry
			processed_data{end+1} = record; % create a new entry
		end
   end

s = struct('District',[],'Latitude',[],'Longitude',[],'Count',[]);
for i = 1:size(processed_data, 2)
    s.District = [s.District;processed_data{i}.District];
    s.Latitude = [s.Latitude;processed_data{i}.Latitude];
    s.Longitude = [s.Longitude;processed_data{i}.Longitude];
    s.Count = [s.Count;processed_data{i}.Count];
end

crimeLocation = struct2table(s);

%bubble plot
   
cause = categorical(crimeLocation .District);
gb = geobubble(crimeLocation.Latitude,crimeLocation.Longitude,crimeLocation.Count,cause);
title('crime location bubble plot');
gb.SizeLegendTitle = 'Count';
gb.ColorLegendTitle = 'District';
geobasemap topographic
