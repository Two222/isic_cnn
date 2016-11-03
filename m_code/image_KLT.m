% usage: [output_image] = image_KLT(input_image, num_eig_vectors)
% 
% This function takes the KLT and keeps only the first k eigen-vectors 

% input_image expects a numpy array that is going to be processed
% num_eig_vectors expects an integer
% output_image is the same size as original
% Example:
% 
%  image_KLT_150 = image_KLT(input_image, 150);
%  imshow(image_KLT_150);

function [output_image] = image_KLT(input_image,k) 

I = double(input_image);
for n = 1:3 %have to do it for each RGB channel
    X = I(:,:,n);
    [M,N] = size(X); 
    u = mean(X,2); %takes the mean for each row
    U = repmat(u,1,N); %repeats the mean column (u) N times
    Y = X-U; %calculate the difference matrix
    R = Y*Y'/N; % constructs the autocorrelation matrix from Y
    [V D] = svd(R); %eigenvalue decomposition to get the vector matrix, V.
    A = zeros(M,N);
    A(:,1:k) = V(:,1:k); % Makes the transformation matrix 
    output_image(:,:,n) = A'*Y; %takes the KL-transform of the image
end

end 