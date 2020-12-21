function [] = myLinearContrastStretching()

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

    [M, N] = size(one);
    newone = zeros(M, N, class(one));
    std=std2(one);
    mean=mean2(one);
    h=min(255,mean+(3*std));
    l=max(0,mean-(3*std));
    m=255/(h-l);
    c=255-(m*h);
    for i=1:M
        for j=1:N
            if one(i,j)<l
                newone(i,j)=0;
            elseif one(i,j)>h
                newone(i,j)=255;
            else
                newone(i,j)=(m*one(i,j))+c;
            end
        end
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%TEM

    [M, N] = size(two);
    newtwo = zeros(M, N, class(two));
    std=std2(two);
    mean=mean2(two);
    h=min(255,mean+(3*std));
    l=max(0,mean-(3*std));
    m=255/(h-l);
    c=255-(m*h);
    for i=1:M
        for j=1:N
            if two(i,j)<l
                newtwo(i,j)=0;
            elseif two(i,j)>h
                newtwo(i,j)=255;
            else
                newtwo(i,j)=(m*two(i,j))+c;
            end
        end
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%canyon

    red=three(:,:,1);
    [M, N] = size(red);
    temp1 = zeros(M, N, class(red));
    std=std2(red);
    mean=mean2(red);
    h=min(255,mean+(3*std));
    l=max(0,mean-(3*std));
    m=255/(h-l);
    c=255-(m*h);
    for i=1:M
        for j=1:N
            if red(i,j)<l
                temp1(i,j)=0;
            elseif red(i,j)>h
                temp1(i,j)=255;
            else
                temp1(i,j)=(m*red(i,j))+c;
            end
        end
    end

    green=three(:,:,2);
    [M, N] = size(green);
    temp2 = zeros(M, N, class(green));
    std=std2(green);
    mean=mean2(green);
    h=min(255,mean+(3*std));
    l=max(0,mean-(3*std));
    m=255/(h-l);
    c=255-(m*h);
    for i=1:M
        for j=1:N
            if green(i,j)<l
                temp2(i,j)=0;
            elseif green(i,j)>h
                temp2(i,j)=255;
            else
                temp2(i,j)=(m*green(i,j))+c;
            end
        end
    end

    blue=three(:,:,3);
    [M, N] = size(blue);
    temp3 = zeros(M, N, class(blue));
    std=std2(blue);
    mean=mean2(blue);
    h=min(255,mean+(3*std));
    l=max(0,mean-(3*std));
    m=255/(h-l);
    c=255-(m*h);
    for i=1:M
        for j=1:N
            if blue(i,j)<l
                temp3(i,j)=0;
            elseif blue(i,j)>h
                temp3(i,j)=255;
            else
                temp3(i,j)=(m*blue(i,j))+c;
            end
        end
    end

    newthree=cat(3,temp1,temp2,temp3);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%church

    red=five(:,:,1);
    [M, N] = size(red);
    temp1 = zeros(M, N, class(red));
    std=std2(red);
    mean=mean2(red);
    h=min(255,mean+(3*std));
    l=max(0,mean-(3*std));
    m=255/(h-l);
    c=255-(m*h);
    for i=1:M
        for j=1:N
            if red(i,j)<l
                temp1(i,j)=0;
            elseif red(i,j)>h
                temp1(i,j)=255;
            else
                temp1(i,j)=(m*red(i,j))+c;
            end
        end
    end

    green=five(:,:,2);
    [M, N] = size(green);
    temp2 = zeros(M, N, class(green));
    std=std2(green);
    mean=mean2(green);
    h=min(255,mean+(3*std));
    l=max(0,mean-(3*std));
    m=255/(h-l);
    c=255-(m*h);
    for i=1:M
        for j=1:N
            if green(i,j)<l
                temp2(i,j)=0;
            elseif green(i,j)>h
                temp2(i,j)=255;
            else
                temp2(i,j)=(m*green(i,j))+c;
            end
        end
    end

    blue=five(:,:,3);
    [M, N] = size(blue);
    temp3 = zeros(M, N, class(blue));
    std=std2(blue);
    mean=mean2(blue);
    h=min(255,mean+(3*std));
    l=max(0,mean-(3*std));
    m=255/(h-l);
    c=255-(m*h);
    for i=1:M
        for j=1:N
            if blue(i,j)<l
                temp3(i,j)=0;
            elseif blue(i,j)>h
                temp3(i,j)=255;
            else
                temp3(i,j)=(m*blue(i,j))+c;
            end
        end
    end

    newfive=cat(3,temp1,temp2,temp3);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%chestXray

    [M, N] = size(six);
    newsix = zeros(M, N, class(six));
    std=std2(six);
    mean=mean2(six);
    h=min(255,mean+(3*std));
    l=max(0,mean-(3*std));
    m=255/(h-l);
    c=255-(m*h);
    for i=1:M
        for j=1:N
            if six(i,j)<l
                newsix(i,j)=0;
            elseif six(i,j)>h
                newsix(i,j)=255;
            else
                newsix(i,j)=(m*six(i,j))+c;
            end
        end
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%Statue

    [M, N] = size(seven);
    newseven = zeros(M, N, class(seven));
    std=std2(seven);
    mean=mean2(seven);
    h=min(255,mean+(3*std));
    l=max(0,mean-(3*std));
    m=255/(h-l);
    c=255-(m*h);
    for i=1:M
        for j=1:N
            if seven(i,j)<l
                newseven(i,j)=0;
            elseif seven(i,j)>h
                newseven(i,j)=255;
            else
                newseven(i,j)=(m*seven(i,j))+c;
            end
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%     figure()
%     subplot(3, 4, 1), imagesc (single (one)), title("Original Image"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
%     subplot(3, 4, 2), imagesc (single (newone)), title("Contrast Enhanced Image"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
%     subplot(3, 4, 3), imagesc (single (two)), title("Original Image"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
%     subplot(3, 4, 4), imagesc (single (newtwo)), title("Contrast Enhanced Image"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
%     subplot(3, 4, 5), imagesc (three), title("Original Image"), colormap (myColorScale), colormap jet, daspect ([1 1 1]), colorbar;
%     subplot(3, 4, 6), imagesc (newthree), title("Contrast Enhanced Image"), colormap (myColorScale), colormap jet, daspect ([1 1 1]), colorbar;
%     subplot(3, 4, 7), imagesc (five), title("Original Image"), colormap (myColorScale), colormap jet, daspect ([1 1 1]), colorbar;
%     subplot(3, 4, 8), imagesc (newfive), title("Contrast Enhanced Image"), colormap (myColorScale), colormap jet, daspect ([1 1 1]), colorbar;
%     subplot(3, 4, 9), imagesc (single (six)), title("Original Image"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
%     subplot(3, 4, 10), imagesc (single (newsix)), title("Contrast Enhanced Image"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
%     subplot(3, 4, 11), imagesc (single (seven)), title("Original Image"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
%     subplot(3, 4, 12), imagesc (single (newseven)), title("Contrast Enhanced Image"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
%     axis tight;
%     truesize;

%     figure() 
%     subplot(1, 2, 1), imagesc (single (one)), title("Original Image"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
%     truesize;
%     figure()
%     subplot(1, 2, 2), imagesc (single (newone)), title("Contrast Enhanced Image"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
%     truesize;
%     figure()
%     subplot(1, 2, 1), imagesc (single (two)), title("Original Image"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
%     subplot(1, 2, 2), imagesc (single (newtwo)), title("Contrast Enhanced Image"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
%     truesize;
%     figure()
%     subplot(1, 2, 1), imagesc (three), title("Original Image"), colormap (myColorScale), colormap jet, daspect ([1 1 1]), colorbar;
%     subplot(1, 2, 2), imagesc (newthree), title("Contrast Enhanced Image"), colormap (myColorScale), colormap jet, daspect ([1 1 1]), colorbar;
%     truesize;
%     figure()
%     subplot(1, 2, 1), imagesc (five), title("Original Image"), colormap (myColorScale), colormap jet, daspect ([1 1 1]), colorbar;
%     subplot(1, 2, 2), imagesc (newfive), title("Contrast Enhanced Image"), colormap (myColorScale), colormap jet, daspect ([1 1 1]), colorbar;
%     truesize;
%     figure() 
%     subplot(1, 2, 1), imagesc (single (six)), title("Original Image"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
%     subplot(1, 2, 2), imagesc (single (newsix)), title("Contrast Enhanced Image"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
%     truesize;
%     figure() 
%     subplot(1, 2, 1), imagesc (single (seven)), title("Original Image"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
%     subplot(1, 2, 2), imagesc (single (newseven)), title("Contrast Enhanced Image"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
%     truesize;
%     axis tight;

    figure();
    imagesc(single(one)), title("Original Image"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
    axis tight; truesize;
    figure();
    imagesc(single(newone)), title("Contrast Enhanced Image"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
    axis tight; truesize;
    
    figure();
    imagesc(single(two)), title("Original Image"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
    axis tight; truesize;
    figure();
    imagesc(single(newtwo)), title("Contrast Enhanced Image"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
    axis tight; truesize;
    
    figure();
    imagesc(three), title("Original Image"), colormap (myColorScale), colormap jet, daspect ([1 1 1]), colorbar;
    axis tight; truesize;
    figure();
    imagesc(newthree), title("Contrast Enhanced Image"), colormap (myColorScale), colormap jet, daspect ([1 1 1]), colorbar;
    axis tight; truesize;
    
    figure();
    imagesc(five), title("Original Image"), colormap (myColorScale), colormap jet, daspect ([1 1 1]), colorbar;
    axis tight; truesize;
    figure();
    imagesc(newfive), title("Contrast Enhanced Image"), colormap (myColorScale), colormap jet, daspect ([1 1 1]), colorbar;
    axis tight; truesize;
    
    figure(); 
    imagesc(single(six)), title("Original Image"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
    axis tight; truesize;
    figure();
    imagesc(single(newsix)), title("Contrast Enhanced Image"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
    axis tight; truesize;
    
    figure();
    imagesc(single(seven)), title("Original Image"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
    axis tight; truesize;
    figure();
    imagesc(single(newseven)), title("Contrast Enhanced Image"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
    axis tight; truesize;
end
