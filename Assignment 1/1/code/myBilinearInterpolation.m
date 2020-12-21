function new_img = myBilinearInterpolation()
    img = imread('../data/barbaraSmall.png');
    p = 3;
    q = 2;
    [M, N] = size(img);
    M_new = p*M - p + 1;
    N_new = q*N - q + 1;
    new_img = zeros(M_new, N_new);

    for i = 1:M-1
        for j = 1:N-1
            x = p*i - p + 1;
            y = q*j - q + 1;
            for k = 0:p
                for m = 0:q
                    pixelValue = BilinearInterpolation(img, i, i+1, j, j+1, i+k/p, j+m/q);
                    new_img(x+k,y+m) = pixelValue;
                end
            end
        end
    end
    myNumOfColors = 200;
    myColorScale = [ [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];
    
    figure()
    imagesc (img), title("Original Image"), colormap (myColorScale), colormap(myColorScale), daspect ([1 1 1]), colorbar;
    axis tight, truesize;
    f = figure();
    imagesc (new_img), title("Bilinear Interpolation"), colormap (myColorScale), colormap(myColorScale), daspect ([1 1 1]), colorbar;
    axis tight, truesize;
end

function [val] = BilinearInterpolation(img, x1, x2, y1, y2, x, y)
    img = double(img);
    D = (x1-x2)*(y1-y2);
    q1 = img(x1,y1)*(x2-x)*((y2-y)/D);
    q2 = img(x1,y2)*(x2-x)*((y-y1)/D);
    q3 = img(x2,y1)*(x-x1)*((y2-y)/D);
    q4 = img(x2,y2)*(x-x1)*((y-y1)/D);
    val = q1 + q2 + q3 + q4;
end