[row,col,v] = find(imdata);
outmat = zeros(size(imdata), 'like', imdata);
% step one: build basis tensor B (see (3) of "Multilinear image analysis for
% facial recognition")
B = tmprod(S,U{2},2);
B = tmprod(B, U{3},3);
B = tmprod(B, U{4},4);
B = tmprod(B, U{5},5);
Bvie = B(:,1,1,1,:);
Bvie = reshape(Bvie, 28, []);
Bvieinv = pinv(Bvie');
size(Bvieinv)

% step two: read in the image and iterate through all c to find the one
% with the smallest norm of the difference

imdata = im2double(imread('FaceBase_warped/amir1-vp0-il0-ex2.png'));
flattened_imdata = imdata(imdata~=0);
d = flattened_imdata / norm(flattened_imdata);

% project d into a set of candidate vectors cvie
cvie = Bvieinv * d;

minNorm = realmax;
minInd = -1;
for i = drange(1,28)
    diff = cvie' - U{1}(i,:);
    currNorm = norm(diff);
    if currNorm < minNorm
        minInd = i;
        minNorm = currNorm;
    end
end

disp(minInd);
disp(minNorm);