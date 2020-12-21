%% MyMainScript
tic;
%% Your code here
%% Solution for 2-a
% Foreground masking is done to segment out the foreground image by
% separating the background from the image. This is done by
% distinguishing between the foreground and the background of the image
% using a threshold value, which in our case we took the mean of all
% intensity values in the image. The obtained binary mask clearly subtracts
% all the unnecessary background details from the original image and provides us a
% detailed foreground image. Using this, we obtain the masked image by
% pixel wise multiplication of the original image with the binary mask.
myForegroundMask();             % 2.a

%% Solution for 2-b
% Linear contrast streching is used to increase the contrast in the image
% by linearly streching the possibly limited intensity values to its full range, thereby
% improving the visibility of the differences in the intensity values
% between two pixels. We performed this contrast streching by mapping the
% 5% and 95% intensity values to 0 and 255 respectively. We obtain these
% values under the assumption that the intensities follow a gaussian
% distribution and hence (mean-3*std) & (mean+3*std) will provide us with
% the required intensities. This assumption was supported by the results
% obtained as they clearly show a significant increase in contrast as
% compared to the original image except for the 5th image.
% The 5th image is almmost completely dark for most of the regions and
% almost completely white for the rest. So it already has its intensity
% range to its maximum and hence the linear contrast streching did not had
% any effect on it.
myLinearContrastStretching();   % 2.b

%% Solution for 2-c
% Histogram equalisation works on the principle of uniformly distributing
% all the intensity values over its full range to obtain a clearer image.
% This equalisation is performed using a transformation which maps the
% intensities to its corresponding value on the cdf(cumulative distribution
% function). Since we have a discrete distribution, our transformstion
% results in somewhat(not exact) uniform distribution of the intensities,
% therby improving the contrast of the image. It can be seen from the results
% that the histogram equalised images are significantly better than the
% original images.
% Even for the 5th image the high and low intensities are uniformly
% distributed and hence a clearer image is obtained unlike an unaffected image
% obtained using Linear contrast streching. So clearly for improving an image 
% such as the 5th image which has intensities only very high and very low, 
% Histogram equalisation is a better choice than linear contrast streching.
myHE();                         % 2.c

%% Solution for 2-d
% Histogram Matching is used when an image is required to be in a
% standardised form to perform the analysis. In our case we require the
% image of the retina to be standardised with respect the the reference
% retina image. This matching is performed using a transformation which
% includes a cascading of the cdf function of the image and the inverse cdf 
% function of the reference image. Since we have a discrete distribution, 
% for all the intensities which are not present in the image, we obtain a 
% flat line in the cdf. For these we only take the leftmost values to 
% obtain the inverse cdf mapping. Due to this the inverse cdf function has
% some missing points, which we fill by interpolating the values at
% previous intensities. It can be observed from the results that this 
% interpolation works well as the histogram matched image is sigificantly 
% standardised. The Histogram Equalised image is also presented to show the
% importance of Histogram Matching in these type of images.
myHM();                         % 2.d

%% Solution for 2-e
% Best CLAHE
BestParameters = [105 0.009;
                   75 0.009;
                  101 0.001;
                  175 0.04];
BestNames = ["barbara_best";"TEM_best";"canyon_best";"xray_best"];
myCLAHE(BestParameters, BestNames);
% Increase window size
WLParameters = [750 0.009;
                750 0.009;
                750 0.001;
                750 0.04];
WLNames = ["barbara_large_window";"TEM_large_window";
            "canyon_large_window";"xray_large_window"];
myCLAHE(WLParameters, WLNames);
% Decrease window size
WSParameters = [25 0.009;
                25 0.009;
                25 0.001;
                25 0.04];
WSNames = ["barbara_small_window";"TEM_small_window";
            "canyon_small_window";"xray_small_window"];
myCLAHE(WSParameters, WSNames);
% Half Threshold
ThresholdParameters = [105 0.0045;
                        75 0.0045;
                       101 0.0005;
                       175 0.02];
ThresholdNames = ["barbara_threshold";"TEM_threshold";
                    "canyon_threshold";"xray_threshold"];
myCLAHE(ThresholdParameters, ThresholdNames);
% Stay tuned! Coming soon
toc;
