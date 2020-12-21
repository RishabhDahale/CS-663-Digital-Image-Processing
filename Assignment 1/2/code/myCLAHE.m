function [] = myCLAHE(parameters, names)
    tic;
%     windowSizeOne = 105; thresholdOne = 0.009;
%     windowSizeTwo = 75; thresholdTwo = 0.009;
%     windowSizeThree = 101; thresholdThree = 0.001;
%     windowSizeSix = 175; thresholdSix = 0.04;

%     window-large 750, 0.04
%     window-small 25 0.04
%     threshold-half 175 0.02
    
    one=imread('../data/barbara.png'); two=imread('../data/TEM.png');
    three=imread('../data/canyon.png'); six=imread('../data/chestXray.png');
    
    oneCLAHE = CLAHE(one, parameters(1, 1), parameters(1, 2));
    twoCLAHE = CLAHE(two, parameters(2, 1), parameters(2, 2));
    threeCLAHE1 = CLAHE(three(:,:,1), parameters(3, 1), parameters(3, 2));
    threeCLAHE2 = CLAHE(three(:,:,2), parameters(3, 1), parameters(3, 2));
    threeCLAHE3 = CLAHE(three(:,:,3), parameters(3, 1), parameters(3, 2));
    threeCLAHE = cat(3, threeCLAHE1, threeCLAHE2, threeCLAHE3);
    
    sixCLAHE = CLAHE(six, parameters(4, 1), parameters(4, 2));
    toc;
    myNumOfColors = 200;
    myColorScale = [ [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];
    
    f = figure();
    imagesc(one), title("Original Image"), colormap (myColorScale), colormap(myColorScale), daspect ([1 1 1]), colorbar;
    axis tight, truesize;
    saveas(f, strcat('../images/', names(1),'_original.png'));
    f = figure();
    imagesc(oneCLAHE), title("CLAHE"), colormap (myColorScale), colormap(myColorScale), daspect ([1 1 1]), colorbar;
    axis tight, truesize;
    saveas(f, strcat('../images/', names(1),'_CLAHE.png'));
    
    f = figure();
    imagesc(two), title("Original Image"), colormap (myColorScale), colormap(myColorScale), daspect ([1 1 1]), colorbar;
    axis tight, truesize;
    saveas(f, strcat('../images/', names(1),'_original.png'));
    f = figure();
    imagesc(twoCLAHE), title("CLAHE"), colormap (myColorScale), colormap(myColorScale), daspect ([1 1 1]), colorbar;
    axis tight, truesize;
    saveas(f, strcat('../images/', names(2),'_CLAHE.png'));
    
    f = figure();
    imagesc(three), title("Original Image"), colormap(myColorScale), colormap jet, daspect ([1 1 1]), colorbar;
    axis tight, truesize;
    saveas(f, strcat('../images/', names(1),'_original.png'));
    f = figure();
    imagesc(threeCLAHE), title("CLAHE"), colormap(myColorScale), colormap jet, daspect ([1 1 1]), colorbar;
    axis tight, truesize;
    saveas(f, strcat('../images/', names(3),'_CLAHE.png'));
    
    f = figure();
    imagesc(six), title("Original Image"), colormap (myColorScale), colormap(myColorScale), daspect ([1 1 1]), colorbar;
    axis tight, truesize;
    saveas(f, strcat('../images/', names(1),'_original.png'));
    f = figure();
    imagesc(sixCLAHE), title("CLAHE"), colormap (myColorScale), colormap(myColorScale), daspect ([1 1 1]), colorbar;
    axis tight, truesize;
    saveas(f, strcat('../images/', names(4),'_CLAHE.png'));
end

function newImg = CLAHE(img, windowSize, threshold)
    [imgI, imgJ] = size(img);
    newImg = zeros(imgI, imgJ, class(img));
    for i=1:imgI
        histMade = false;
        for j=1:imgJ
            if not(histMade)
                % Getting the region for computing histogram
                [iLow, iHigh, jLow, jHigh] = WindowCorners(img,windowSize,i,j);
                hist = imhist(img(iLow:iHigh, jLow:jHigh), 256);
                pixelsCount = (iHigh - iLow + 1)*(jHigh - jLow + 1);
                adjustedHist = hist./pixelsCount;
                excess = 0;

                % Clipping the histogram and redistributing the mass
                for histIdx=1:size(adjustedHist, 1)
                    if adjustedHist(histIdx)>threshold
                        excess = excess + adjustedHist(histIdx) - threshold;
                        adjustedHist(histIdx) = threshold;
                    end
                end
                adjustedHist = adjustedHist + (excess/size(adjustedHist,1));

                % Histogram equalization calculation
                newImg(i, j) = round(255*sum(adjustedHist(1:img(i, j)+1)));
                iLowPrev = iLow; iHighPrev = iHigh;
                jLowPrev = jLow; jHighPrev = jHigh;
                histMade = true;
            else
                [iLow, iHigh, jLow, jHigh] = WindowCorners(img,windowSize,i,j);
                newAddition = zeros(size(hist,1), size(hist,2), class(hist));
                if jLow==jLowPrev && jHigh~=jHighPrev  % No column to remove but a column to add
                    newAddition = newAddition + imhist(img(iLow:iHigh, jHigh), size(hist, 1));
                elseif jLow~=jLowPrev && jHigh==jHighPrev
                    % No column to add but a column to remove
                    newAddition = newAddition - imhist(img(iLow:iHigh, jLowPrev), size(hist, 1));
                elseif jLow~=jLowPrev && jHigh~=jHighPrev
                    % remove left most column and add rightmost one
                    colToRemove = imhist(img(iLow:iHigh, jLowPrev), size(hist, 1));
                    colToAdd = imhist(img(iLow:iHigh, jHigh), size(hist, 1));
                    newAddition = newAddition + colToAdd - colToRemove;
                end
                adjustedHist = hist + newAddition;
                hist = adjustedHist;
                pixelsCount = (iHigh - iLow + 1)*(jHigh - jLow + 1);
                adjustedHist = adjustedHist./pixelsCount;
                
                % Clipping the histogram and redistributing the mass
                excess=0;
                for histIdx=1:size(adjustedHist, 1)
                    if adjustedHist(histIdx)>threshold
                        excess = excess + adjustedHist(histIdx) - threshold;
                        adjustedHist(histIdx) = threshold;
                    end
                end
                adjustedHist = adjustedHist + (excess/size(adjustedHist,1));

                % Histogram equalization calculation
                newImg(i, j) = round(255*sum(adjustedHist(1:img(i, j)+1)));
                iLowPrev = iLow; iHighPrev = iHigh;
                jLowPrev = jLow; jHighPrev = jHigh;
            end
        end
    end
end


function [iLow, iHigh, jLow, jHigh] = WindowCorners(img, windowSize, centerI, centerJ)
    [maxI, maxJ] = size(img);
    split = floor(windowSize/2);
    iLow = max(centerI - split, 1); iHigh = min(maxI, centerI + split);
    jLow = max(centerJ - split, 1); jHigh = min(maxJ, centerJ + split);
end