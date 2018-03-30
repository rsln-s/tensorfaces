dirpath = 'FaceBase_warped/*.png';
assumed_size_of_image = [110,115];

imfiles = dir(dirpath);
for file = imfiles'
    imdata = imread(strcat('FaceBase_warped/', file.name));
    if ~isequal(size(imdata), assumed_size_of_image)
        disp('Error: image of incorrect size encountered')
        return
    end
    idents = strsplit(file.name, {'-', '.'});
    ident = idents(1);
    
    strids = regexp(idents(2:end-1),'[0-9]+', 'match');
    if ~isequal(size(strids), [1,3])
        disp('Error: incorrect file name')
        return
    end
    vp = str2num(char(strids{1}))
    ill = str2num(char(strids{2}))
    ex = str2num(char(strids{3}))
    
%     imshow(imdata)
    break
end
