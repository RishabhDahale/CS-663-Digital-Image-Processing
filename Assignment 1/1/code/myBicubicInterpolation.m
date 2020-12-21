function newImg = myBicubicInterpolation()
    img = imread('../data/barbaraSmall.png');
    img = double(img);
    [M, N] = size(img);
    p=3; q=2;           % Scaling factor for different dimensions
    newImg = zeros(p*M - (p-1), q*N - (q-1));
    for i=1:M-1
        for j=1:N-1
%             ref: https://en.wikipedia.org/wiki/Bicubic_interpolation
            A = [1 0 0 0;
                0 0 1 0;
                -3 3 -2 -1;
                2 -2 1 1];
            B = [1 0 -3 2;
                0 0 3 -2;
                0 1 -2 1;
                0 0 -1 1];
            X = [img(i, j)                      img(i, j+1)                       partialDerivativeJ(img, i, j)    partialDerivativeJ(img, i, j+1);
                img(i+1, j)                     img(i+1, j+1)                     partialDerivativeJ(img, i+1, j)  partialDerivativeJ(img, i+1, j+1);
                partialDerivativeI(img, i, j)   partialDerivativeI(img, i, j+1)   partialDerivativeIJ(img, i, j)   partialDerivativeIJ(img, i, j+1);
                partialDerivativeI(img, i+1, j) partialDerivativeI(img, i+1, j+1) partialDerivativeIJ(img, i+1, j) partialDerivativeIJ(img, i+1, j+1);];
            coeff = A*X*B;
            ii = p*(i-1) + 1; jj = q*(j-1)+1;
            newImg(ii, jj) = img(i, j); newImg(ii, jj+q) = img(i, j+1);
            newImg(ii+p, jj) = img(i+1, j); newImg(ii+p, jj+q) = img(i+1, j+1);
            for pi=0:p
                for qj=0:q
                    if not((pi==0 && qj==0) || (pi==p && qj==0) || (pi==0 && qj==q) || (pi==p && qj==q))
                        xVec = [1 (pi/p) (pi/p)^2 (pi/p)^3]; yVec = [1;(qj/q);(qj/q)^2;(qj/q)^3];
                        newImg(ii+pi, jj+qj) = xVec*coeff*yVec;
                    end
                end
            end
        end
    end
    myNumOfColors = 200;
    myColorScale = [ [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];
    figure(),
    subplot(1, 2, 1), imagesc (single(img)), title('Original Image'), daspect ([1 1 1]), colormap (myColorScale), colorbar;
    subplot(1, 2, 2), imagesc (single(newImg)), title('Bicubic Interpolation'), daspect ([1 1 1]), colormap (myColorScale), colorbar;
    axis tight;
end

function [der] = partialDerivativeI(img, i, j)
%     if we are in first or last row then taking forward/backward finite
%     difference approximations. Or else taking central approximation
    imgSize = size(img);
    if i==1
        der = img(i+1, j) - img(i, j);
    elseif i==imgSize(1)
        der = img(i, j) - img(i-1, j);
    else
        der = 0.5*(img(i+1, j) - img(i-1, j));
    end
end

function [der] = partialDerivativeJ(img, i, j)
%     if in first/last column, then taking forward/backward approximation
%     or else taking cental appriximation
    imgSize = size(img);
    if j==1
        der = img(i, j+1) - img(i, j);
    elseif j==imgSize(1)
        der = img(i, j) - img(i, j-1);
    else
        der = 0.5*(img(i, j+1) - img(i, j-1));
    end
end

function [der] = partialDerivativeIJ(img, i, j)
%     if in first/last row/column then the partial derivative is calculated
%     with taking forward/backward difference, or else taking central
%     difference to approximate the partial derivative
    imgSize = size(img);
    if i==1
        if j==1
            der = img(i+1, j+1) - img(i, j+1) - img(i+1, j) + img(i, j);
        elseif j==imgSize(2)
            der = img(i+1, j) - img(i, j) - img(i+1, j-1) + img(i, j-1);
        else
            der = 0.5*( img(i+1, j+1) - img(i, j+1) - img(i+1, j-1) + img(i, j-1) );
        end
    elseif i==imgSize(1)
        if j==1
            der = img(i, j+1) - img(i-1, j+1) - img(i, j) + img(i-1, j);
        elseif j==imgSize(2)
            der = img(i, j) - img(i-1, j) - img(i, j-1) + img(i-1, j-1);
        else
            der = 0.5*( img(i, j+1) - img(i-1, j+1) - img(i, j-1) + img(i-1, j-1) );
        end
    else
        if j==1
            der = (0.5*(img(i+1, j+1) - img(i-1, j+1))) - (0.5*(img(i+1, j) - img(i-1, j)));
        elseif j==imgSize(2)
            der = (0.5*(img(i+1, j) - img(i-1, j))) - (0.5*(img(i+1, j-1) - img(i-1, j-1)));
        else
            der = 0.25*(img(i+1, j+1) + img(i-1, j-1) - img(i+1, j-1) - img(i-1, j+1));
        end
    end
end
