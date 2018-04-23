[row,col,v] = find(imdata);
outmat = zeros(size(imdata), 'like', imdata);
% step one: build basis tensor B (see (3) of "Multilinear image analysis for
% facial recognition")
B = tmprod(S,U{2},2);
B = tmprod(B, U{3},3);
B = tmprod(B, U{4},4);
B = tmprod(B, U{5},5);

% for all images in testing set

testpath = 'test/*.png';
testfiles = dir(testpath);
size(testfiles)

correct = 0;
incorrect = 0;

for file = testfiles'
    minNorm = realmax;
    minInd = -1;
    minIll = -1;
    minVp = 1;

    imdata = im2double(imread(strcat('test/', file.name)));
    if ~isequal(size(imdata), assumed_size_of_image)
        disp('Error: image of incorrect size encountered')
        return
    end
    
    flattened_imdata = imdata(imdata~=0);
    d = flattened_imdata / norm(flattened_imdata);
    
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
        disp('Error: new person encountered')
    end
    
    for ill = drange(1, num_ills)
        for vp = drange(1, num_vps)
            Bvie = B(:,vp,ill,1,:);
            Bvie = reshape(Bvie, 28, []);
            Bvieinv = pinv(Bvie');

            % iterate through all c to find the one
            % with the smallest norm of the difference

            % project d into a set of candidate vectors cvie
            cvie = Bvieinv * d;

            for i = drange(1,28)
                diff = cvie' - U{1}(i,:);
                currNorm = norm(diff);
                if currNorm < minNorm
                    minInd = i;
                    minIll = ill;
                    minVp = vp;
                    minNorm = currNorm;
                end
            end  
        end
    end
    if minInd == person_ind
        correct = correct + 1;
        disp(strcat('Correctly predicted for ', file.name))
    else
        incorrect = incorrect + 1;
        disp(strcat('Incorrectly predicted for ', file.name))
        disp(minInd)
        disp(person_ind)
    end
%     disp(minInd);
%     disp(minVp);
%     disp(minIll);
%     disp(minNorm);
end
disp(correct)
disp(incorrect)