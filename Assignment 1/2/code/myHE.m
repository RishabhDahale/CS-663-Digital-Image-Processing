function [] = myHE()

    myNumOfColors = 200;
    myColorScale = [ [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    A=imread('../data/statue.png');
    mean=mean2(A);
    [M, N] = size(A);
    B = zeros(M, N, class(A));
    % C = zeros(M, N, class(A));
    for i=1:M
        for j=1:N
            if A(i,j)>mean
                B(i,j)=255;
            else
                B(i,j)=0;
            end
    %         C(i,j)=A(i,j)*B(i,j);
        end
    end
    C = A;
    C(~B) = 0;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    one=imread('../data/barbara.png');
    two=imread('../data/TEM.png');
    three=imread('../data/canyon.png');
    five=imread('../data/church.png');
    six=imread('../data/chestXray.png');
    seven=C;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%barbara

    cdf    = [];
    hist   = imhist(one);
    cdf    = zeros(1,255);
    cdf(1)= hist(1);
    for i=2:1:255+1
      cdf(i) = hist(i) + cdf(i-1);
    end
    cdf=round(cdf/cdf(256)*255);
    [M, N] = size(one);
    newone = zeros(M, N, class(one));
    for i=1:M
        for j=1:N
            newone(i,j)=round(cdf(1+one(i,j)));
        end
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%TEM

    cdf    = [];
    hist   = imhist(two);
    cdf    = zeros(1,255);
    cdf(1)= hist(1);
    for i=2:1:255+1
      cdf(i) = hist(i) + cdf(i-1);
    end
    cdf=round((cdf/cdf(256))*255);
    [M, N] = size(two);
    newtwo = zeros(M, N, class(two));
    for i=1:M
        for j=1:N
            newtwo(i,j)=round(cdf(1+two(i,j)));
        end
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%canyon

    cdf    = [];
    red=three(:,:,1);
    hist   = imhist(red);
    cdf    = zeros(1,255);
    cdf(1)= hist(1);
    for i=2:1:255+1
      cdf(i) = hist(i) + cdf(i-1);
    end
    cdf=round((cdf/cdf(256))*255);
    [M, N] = size(red);
    temp1 = zeros(M, N, class(red));
    for i=1:M
        for j=1:N
            temp1(i,j)=round(cdf(1+red(i,j)));
        end
    end

    cdf    = [];
    green=three(:,:,2);
    hist   = imhist(green);
    cdf    = zeros(1,255);
    cdf(1)= hist(1);
    for i=2:1:255+1
      cdf(i) = hist(i) + cdf(i-1);
    end
    cdf=round((cdf/cdf(256))*255);
    [M, N] = size(green);
    temp2 = zeros(M, N, class(green));
    for i=1:M
        for j=1:N
            temp2(i,j)=round(cdf(1+green(i,j)));
        end
    end

    cdf    = [];
    blue=three(:,:,3);
    hist   = imhist(blue);
    cdf    = zeros(1,255);
    cdf(1)= hist(1);
    for i=2:1:255+1
      cdf(i) = hist(i) + cdf(i-1);
    end
    cdf=round((cdf/cdf(256))*255);
    [M, N] = size(blue);
    temp3 = zeros(M, N, class(blue));
    for i=1:M
        for j=1:N
            temp3(i,j)=round(cdf(1+blue(i,j)));
        end
    end

    newthree=cat(3,temp1,temp2,temp3);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%church

    cdf    = [];
    red=five(:,:,1);
    hist   = imhist(red);
    cdf    = zeros(1,255);
    cdf(1)= hist(1);
    for i=2:1:255+1
      cdf(i) = hist(i) + cdf(i-1);
    end
    cdf=round((cdf/cdf(256))*255);
    [M, N] = size(red);
    temp1 = zeros(M, N, class(red));
    for i=1:M
        for j=1:N
            temp1(i,j)=round(cdf(1+red(i,j)));
        end
    end

    cdf    = [];
    green=five(:,:,2);
    hist   = imhist(green);
    cdf    = zeros(1,255);
    cdf(1)= hist(1);
    for i=2:1:255+1
      cdf(i) = hist(i) + cdf(i-1);
    end
    cdf=round((cdf/cdf(256))*255);
    [M, N] = size(green);
    temp2 = zeros(M, N, class(green));
    for i=1:M
        for j=1:N
            temp2(i,j)=round(cdf(1+green(i,j)));
        end
    end

    cdf    = [];
    blue=five(:,:,3);
    hist   = imhist(blue);
    cdf    = zeros(1,255);
    cdf(1)= hist(1);
    for i=2:1:255+1
      cdf(i) = hist(i) + cdf(i-1);
    end
    cdf=round((cdf/cdf(256))*255);
    [M, N] = size(blue);
    temp3 = zeros(M, N, class(blue));
    for i=1:M
        for j=1:N
            temp3(i,j)=round(cdf(1+blue(i,j)));
        end
    end

    newfive=cat(3,temp1,temp2,temp3);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%chestXray

    cdf    = [];
    hist   = imhist(six);
    cdf    = zeros(1,255);
    cdf(1)= hist(1);
    for i=2:1:255+1
      cdf(i) = hist(i) + cdf(i-1);
    end
    cdf=round((cdf/cdf(256))*255);
    [M, N] = size(six);
    newsix = zeros(M, N, class(six));
    for i=1:M
        for j=1:N
            newsix(i,j)=round(cdf(1+six(i,j)));
        end
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%Statue

    cdf    = [];
    hist   = imhist(seven);
    cdf    = zeros(1,255);
    cdf(1)= hist(1);
    for i=2:1:255+1
      cdf(i) = hist(i) + cdf(i-1);
    end
    cdf=round((cdf/cdf(256))*255);
    [M, N] = size(seven);
    newseven = zeros(M, N, class(seven));
    for i=1:M
        for j=1:N
            newseven(i,j)=round(cdf(1+seven(i,j)));
        end
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%     figure(),
%     subplot(1, 2, 1), imagesc (single (one)), title("Original Image"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
%     subplot(1, 2, 2), imagesc (single (newone)), title("Histogram Equalised Image"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
%     axis tight;
% %     truesize;
%     figure()
%     subplot(1, 2, 1), imagesc (single (two)), title("Original Image"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
%     subplot(1, 2, 2), imagesc (single (newtwo)), title("Histogram Equalised Image"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
%     axis tight;
% %     truesize;
%     figure()
%     subplot(1, 2, 1), imagesc (three), title("Original Image"), colormap (myColorScale), colormap jet, daspect ([1 1 1]), colorbar;
%     subplot(1, 2, 2), imagesc (newthree), title("Histogram Equalised Image"), colormap (myColorScale), colormap jet, daspect ([1 1 1]), colorbar;
%     axis tight;
% %     truesize;
%     figure()
%     subplot(1, 2, 1), imagesc (five), title("Original Image"), colormap (myColorScale), colormap jet, daspect ([1 1 1]), colorbar;
%     subplot(1, 2, 2), imagesc (newfive), title("Histogram Equalised Image"), colormap (myColorScale), colormap jet, daspect ([1 1 1]), colorbar;
%     axis tight;
% %     truesize;
%     figure()
%     subplot(1, 2, 1), imagesc (single (six)), title("Original Image"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
%     subplot(1, 2, 2), imagesc (single (newsix)), title("Histogram Equalised Image"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
%     axis tight;
% %     truesize;
%     figure()
%     subplot(1, 2, 1), imagesc (single (seven)), title("Original Image"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
%     subplot(1, 2, 2), imagesc (single (newseven)), title("Histogram Equalised Image"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
%     axis tight;
% %     truesize;

    figure();
    imagesc(single(one)), title("Original Image"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
    axis tight; truesize;
    figure();
    imagesc(single(newone)), title("Histogram Equalised Image"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
    axis tight; truesize;
    
    figure();
    imagesc(single(two)), title("Original Image"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
    axis tight; truesize;
    figure();
    imagesc(single(newtwo)), title("Histogram Equalised Image"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
    axis tight; truesize;
    
    figure();
    imagesc (three), title("Original Image"), colormap (myColorScale), colormap jet, daspect ([1 1 1]), colorbar;
    axis tight; truesize;
    figure();
    imagesc (newthree), title("Histogram Equalised Image"), colormap(myColorScale), colormap jet, daspect ([1 1 1]), colorbar;
    axis tight; truesize;
    
    figure();
    imagesc (five), title("Original Image"), colormap (myColorScale), colormap jet, daspect ([1 1 1]), colorbar;
    axis tight; truesize;
    figure();
    imagesc (newfive), title("Histogram Equalised Image"), colormap (myColorScale), colormap jet, daspect ([1 1 1]), colorbar;
    axis tight; truesize;

    figure();
    imagesc (single (six)), title("Original Image"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
    axis tight; truesize;
    figure();
    imagesc (single (newsix)), title("Histogram Equalised Image"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
    axis tight; truesize;
    
    figure();
    imagesc (single (seven)), title("Original Image"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
    axis tight; truesize;
    figure();
    imagesc (single (newseven)), title("Histogram Equalised Image"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
    axis tight; truesize;
end