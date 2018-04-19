[row,col,v] = find(imdata);
outmat = zeros(size(imdata), 'like', imdata);
tensorface = tmprod(S,U{2},2);
tensorface = tmprod(tensorface, U{5},5);
% tensorface = U{5};
flattened_outmat = reshape(tensorface(1,1,1,1,:), 1, []);
% flattened_outmat = reshape(tensorface(:,5), 1, []);
for k = 1 : length(row)
     outmat(row(k),col(k)) = -(40.0 / norm(flattened_outmat)) * flattened_outmat(k);
%     outmat(row(k),col(k)) = 40 * tensorface(1,2,1,1,k);
end
imshow(outmat)