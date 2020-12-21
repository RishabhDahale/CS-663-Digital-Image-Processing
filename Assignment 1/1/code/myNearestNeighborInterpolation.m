function newImg = myNearestNeighborInterpolation()
    myNumOfColors = 200;
    myColorScale = [ [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];

    img = imread('../data/barbaraSmall.png');
    [M, N] = size(img);
    newImg = zeros(3*M-2, 2*N-1, class(img));
    for i=1:3*M-2
        for j=1:2*N-1
            ii = round((i+2)/3);
            jj = round((j+1)/2);
            newImg(i, j) = img(ii, jj);
        end
    end
    figure(),
    subplot(1, 2, 1), imagesc(single(img)), title('Original Image'), daspect ([1 1 1]), colormap (myColorScale), colorbar;
    subplot(1, 2, 2), imagesc(single(newImg)), title('Nearest Neighbour Upsampling'), daspect ([1 1 1]), colormap (myColorScale), colorbar;
    axis tight;
end