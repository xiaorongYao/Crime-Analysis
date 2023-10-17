%clean data, correct wrong formatted data in coommareas.csv
%it's in line 36 in pos 50575, and 75 in 84767
%the wrongs are ')' does not influence data becuase it's where the boundary
%closes and begin again
function correctBoundary(filename)
    areaBorder = readtable(filename);
    border = extractBetween(areaBorder.the_geom, 'MULTIPOLYGON (((',')))'); %this column is sufficient for our inquiry 
    %find wrong format line
    rowWrongs = findWrongRow(border);
    %find first position of wrong format line and correct it
    for i = 1:numel(rowWrongs)
        s{i} = correctWrong(border,rowWrongs(i));
        areaBorder.the_geom(rowWrongs(i)) = {s{i}};
    end
    writetable(areaBorder,'CommAreas_fixed.csv');
end

%use str2num to find 
function rowWrong = findWrongRow(border)
    rowWrong = [];
    for i = 1:numel(border)
        if isempty(str2num(border{i}))
            rowWrong = [rowWrong i];
        end
    end
end

function s = correctWrong(border,row_wrong)
    loc = cell2mat(border(row_wrong)); % to a string 
    pos = findWrongPos(loc,1,length(loc));%the first wrong position
    loc = loc(1:pos-1);%the convertable string
    s = toGeom(loc);%convert back to the right format
end

function s = toGeom(loc)
     s = sprintf('MULTIPOLYGON (((%s)))',loc); 
end


%bisect the string to s1, s2 
%if s1 can use str2num, checkout s2 and bisect s2
%if s1 cannot use str2num, bisect s1
%bisect until pStart = pEnd
function pos = findWrongPos(loc,pStart,pEnd)
    if pStart == pEnd
        pos = pStart;
    else
        %check for the first half
        [~, is_num] = str2num(loc(pStart:floor((pStart+pEnd)/2)));
        if is_num
            %find in the other half 
            pos = findWrongPos(loc,floor(((pStart+pEnd)/2))+1,pEnd);
        else
            %find in the first half
            pos = findWrongPos(loc,pStart,floor((pStart+pEnd)/2));
        end
    end
end