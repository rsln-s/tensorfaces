[row,col,v] = find(imdata);
outmat = zeros(size(imdata), 'like', imdata);
% step one: build basis tensor B (see (3) of "Multilinear image analysis for
% facial recognition")
B = tmprod(S,U{2},2);
B = tmprod(B, U{3},3);
B = tmprod(B, U{4},4);
B = tmprod(B, U{5},5);

minNorm = realmax;
minInd = -1;
minIll = -1;
minVp = 1;

imdata = im2double(imread('FaceBase_warped/bruno-vp2-il1-ex2.png'));
flattened_imdata = imdata(imdata~=0);
d = flattened_imdata / norm(flattened_imdata);

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

disp(minInd);
disp(minVp);
disp(minIll);
disp(minNorm);