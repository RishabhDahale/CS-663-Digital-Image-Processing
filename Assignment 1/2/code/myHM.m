function [] = myHM()

    myNumOfColors = 200;
    myColorScale = [ [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    A=imread('../data/retina.png');
    B=imread('../data/retinaMask.png');
    C=imread('../data/retinaRef.png');
    D=imread('../data/retinaRefMask.png');

    five=A;
    five(~B)=0;
    three=C;
    three(~D)=0;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%retinaRef

    count=0;

    cdf    = [];
    red_inv=three(:,:,1);
    hist   = imhist(red_inv);
    cdf    = zeros(1,256);
    cdf(1)= hist(1);
    for i=2:1:255+1
      cdf(i) = hist(i) + cdf(i-1);
    end
    cdf=round((cdf/cdf(256))*255);
    cdf_inv_red=zeros(1,256);
    for i=1:1:255+1
        if cdf_inv_red(cdf(i))==0
            cdf_inv_red(cdf(i))=i;
        end
    end
    for i=1:1:255+1
        if cdf_inv_red(i)==0
            if i==1
                cdf_inv_red(i)=0;
            else
                cdf_inv_red(i)=cdf_inv_red(i-1);
                count=count+1;
            end
        end
    end

    cdf    = [];
    green_inv=three(:,:,2);
    hist   = imhist(green_inv);
    cdf    = zeros(1,256);
    cdf(1)= hist(1);
    for i=2:1:255+1
      cdf(i) = hist(i) + cdf(i-1);
    end
    cdf=round((cdf/cdf(256))*255);
    cdf_inv_green=zeros(1,256);
    for i=1:1:255+1
        if cdf_inv_green(cdf(i))==0
            cdf_inv_green(cdf(i))=i;
        end
    end
    for i=1:1:255+1
        if cdf_inv_green(i)==0
            if i==1
                cdf_inv_green(i)=0;
            else
                cdf_inv_green(i)=cdf_inv_green(i-1);
                count=count+1;
            end
        end
    end

    cdf    = [];
    blue_inv=three(:,:,3);
    hist   = imhist(blue_inv);
    cdf    = zeros(1,256);
    cdf(1)= hist(1);
    for i=2:1:255+1
      cdf(i) = hist(i) + cdf(i-1);
    end
    cdf=round((cdf/cdf(256))*255);
    cdf_inv_blue=zeros(1,256);
    for i=1:1:255+1
        if cdf_inv_blue(cdf(i))==0
            cdf_inv_blue(cdf(i))=i;
        end
    end
    for i=1:1:255+1
        if cdf_inv_blue(i)==0
            if i==1
                cdf_inv_blue(i)=0;
            else
                cdf_inv_blue(i)=cdf_inv_blue(i-1);
                count=count+1;
            end
        end
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%retina
    count=0;
    counter=0;

    cdf    = [];
    red=five(:,:,1);
    hist   = imhist(red);
    cdf    = zeros(1,256);
    cdf(1)= hist(1);
    for i=2:1:255+1
      cdf(i) = hist(i) + cdf(i-1);
    end
    cdf=round((cdf/cdf(256))*255);
    [M, N] = size(red);
    temp1 = zeros(M, N, class(red));
    t1 = zeros(M, N, class(red));
    for i=1:M
        for j=1:N
            temp1(i,j)=cdf_inv_red(round(cdf(1+red(i,j))));
            t1(i,j)=round(cdf(1+red(i,j)));
        end
    end

    cdf    = [];
    green=five(:,:,2);
    hist   = imhist(green);
    cdf    = zeros(1,256);
    cdf(1)= hist(1);
    for i=2:1:255+1
      cdf(i) = hist(i) + cdf(i-1);
    end
    cdf=round((cdf/cdf(256))*255);
    [M, N] = size(green);
    temp2 = zeros(M, N, class(green));
    t2 = zeros(M, N, class(green));
    for i=1:M
        for j=1:N
            temp2(i,j)=cdf_inv_green(round(cdf(1+green(i,j))));
            t2(i,j)=round(cdf(1+green(i,j)));
        end
    end

    cdf    = [];
    blue=five(:,:,3);
    hist   = imhist(blue);
    cdf    = zeros(1,256);
    cdf(1)= hist(1);
    for i=2:1:255+1
      cdf(i) = hist(i) + cdf(i-1);
    end
    cdf=round((cdf/cdf(256))*255);
    [M, N] = size(blue);
    temp3 = zeros(M, N, class(blue));
    t3 = zeros(M, N, class(blue));
    for i=1:M
        for j=1:N
            temp3(i,j)=cdf_inv_blue(round(cdf(1+blue(i,j))));
            t3(i,j)=round(cdf(1+blue(i,j)));
        end
    end

    newfive=cat(3,temp1,temp2,temp3);
    new=cat(3,t1,t2,t3);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure()
    imagesc (five), title("Original Image"), colormap (myColorScale), colormap jet, daspect ([1 1 1]), colorbar;
    axis tight, truesize;
    f = figure();
    imagesc (newfive), title("Histogram Matched Image"), colormap (myColorScale), colormap jet, daspect ([1 1 1]), colorbar;
    axis tight, truesize;
    saveas(f, '../images/retina_histogram_matched.png');
    f = figure();
    imagesc (new), title("Histogram Equalised Image"), colormap (myColorScale), colormap jet, daspect ([1 1 1]), colorbar;
    axis tight, truesize;
    saveas(f, '../images/retina_histogram_equalized.png');
    colorbar;
end
