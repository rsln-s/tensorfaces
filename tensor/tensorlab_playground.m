dirpath = 'subset/*.png';
assumed_size_of_image = [110,115];
assumed_size_flattened = 8830;
vps = [0,1,2,3,4];
ills = [0,1,2];
exs = [2];

imfiles = dir(dirpath);

num_ills = size(ills);
num_ills = num_ills(2);
num_vps = size(vps);
num_vps = num_vps(2);
num_exs = size(exs);
num_exs = num_exs(2);
num_people = size(imfiles') ./ (size(vps) .* size(ills) .* size(exs));
num_people = num_people(2)

initial_tensor = uint8.empty(0, num_vps, num_ills, num_exs, assumed_size_flattened);

people = {};
for file = imfiles'
    imdata = imread(strcat('subset/', file.name));
    disp(strcat('Importing: ',file.name))
    if ~isequal(size(imdata), assumed_size_of_image)
        disp('Error: image of incorrect size encountered')
        return
    end
    idents = strsplit(file.name, {'-', '.'});
    ident = idents(1);
    person_ind = -1;
    if ismember(ident, people)
        person_ind = find(ismember(people, ident));
        if ~isequal(size(person_ind), [1,1])
            disp('Oooops, something went wrong with people cell array')
            return
        end
        person_ind = person_ind(1);
    else
        people{end+1} = ident{1};
        person_ind = size(people);
        person_ind = person_ind(2);
    end
    
    strids = regexp(idents(2:end-1),'[0-9]+', 'match');
    if ~isequal(size(strids), [1,3])
        disp('Error: incorrect file name')
        return
    end
    % offsets hardcoded to incorporate matlab's numeration from 1
    vp = str2num(char(strids{1})) + 1;
    ill = str2num(char(strids{2})) + 1;
    ex = str2num(char(strids{3})) - 1; % because expecting only one expression
    
    flattened_imdata = reshape(imdata, 1, []);
    flattened_imdata = flattened_imdata(flattened_imdata ~= 0);
    if ~isequal(size(flattened_imdata), [1, assumed_size_flattened])
        disp('Error: incorrect mask')
        return
    end
    initial_tensor(person_ind, vp, ill, ex, :) = flattened_imdata;
end
size(initial_tensor)
