%% *Question 3*


%% Code for Part-d
% Convert the image to grayscale for simplicity
im1 = imread('../data/q3.png');
im = rgb2gray(im1);

[m,n] = size(im);
im_min = double(min(im,[],'all'));
im_max = double(max(im,[],'all'));
%%
% Get histogram
h = zeros(1,im_max+1);
for i=1:m
    for j=1:n
        h(im(i,j)+1)=h(im(i,j)+1)+1;
    end
end
%%
% Normalize the histogram 
h = double(h);
h = h./sum(h);
%%
% Let r = point to break histogram('r' fraction of probability mass) 
% Set r=0.5 for median
r=0.5;
hist_break = im_max;
prob_sum = h(end);
while(prob_sum<r)
    prob_sum = prob_sum + h(hist_break);
    hist_break = hist_break - 1;
end
%%
% Now break the histogram into two parts a and b
h_a = h(1:hist_break);
h_b = h(hist_break+1:end);
%%
% Normalize the two histograms
% Note: this is necessary since the intensity must be mapped to a 'correct'
% value. To see why this is the case, consider the example of an image with
% the corner case that h_b is of length 1, with weight 0.5 at im_max. If we
% do not normalize, the peak (in this case just the one value) will be
% retained but this intensity will get mapped to im_max/2, which is not
% what we desire. 
%%
h_a = h_a./sum(h_a);
h_b = h_b./sum(h_b);
%%
% Now get CDFs of the two parts
cdf_a = zeros(1,length(h_a));
cdf_a(1)= h_a(1);
i=2;
while(i<=length(h_a))
  cdf_a(i) = h_a(i) + cdf_a(i-1);
  i=i+1;
end
%%
cdf_b = zeros(1,length(h_b));
cdf_b(1)= h_b(1);
i=2;
while(i<=length(h_b))
  cdf_b(i) = h_b(i) + cdf_b(i-1);
  i=i+1;
end
%%
% Final transformation to be applied is obtained by combining the individual CDFs.
cdf = [cdf_a cdf_b];
%%
% Apply transformation to get the new image
newim = zeros(m,n);
for i = 1:m
    for j = 1:n
        newim(i,j) = 0.005*im_max*cdf(im(i,j)+1);
    end
end
figure()
subplot(1,2,1),imshow(histeq(im)), title("Vanilla Histogram Equalization");
subplot(1,2,2),imshow(newim), title("Piece-wise Histogram Equalization");

