function [] = myImageRotation()
    img = imread('../data/barbaraSmall.png');
    img = double(img);
    [M, N] = size(img);
    rot_img = zeros(size(img));
    
    originX = (N+1)/2;
    originY = (M+1)/2;
    
    maxX = N - originX;
    maxY = M - originY;
    
    theta = 30*(pi/180);
    cosine = cos(theta);
    sine = sin(theta);
    
    for i = 1:M
        for j = 1:N
            X = (j - originX);
            Y = (originY - i);
            x = cosine*X - sine*Y;
            y = sine*X + cosine*Y;
            if abs(x) > maxX || abs(y) > maxY
                pixelValue = 0;
            else
                x1 = floor(x);
                x2 = x1 + 1;
                y1 = floor(y);
                y2 = y1 + 1;
                pixelValue = BilinearInterpolation(img, x1+originX, x2+originX, originY-y1, originY-y2, x+originX, originY-y);
            end
            rot_img(i, j) = pixelValue;
        end
    end
    myNumOfColors = 200;
    myColorScale = [ [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];
    figure();
    subplot(1, 2, 1), imagesc(single(img)), title('Original Image'), daspect ([1 1 1]), colormap (myColorScale), colorbar;
    subplot(1, 2, 2), imagesc(single(rot_img)), title('30 degree Rotated Image'), daspect ([1 1 1]), colormap (myColorScale), colorbar;
end

function [val] = BilinearInterpolation(img, x1, x2, y1, y2, x, y)
    img = double(img);
    D = (y1-y2)*(x1-x2);
    q1 = img(y1,x1)*(y2-y)*((x2-x)/D);
    q2 = img(y1,x2)*(y2-y)*((x-x1)/D);
    q3 = img(y2,x1)*(y-y1)*((x2-x)/D);
    q4 = img(y2,x2)*(y-y1)*((x-x1)/D);
    val = q1 + q2 + q3 + q4;
end