function [] = myForegroundMask()

    myNumOfColors = 200;
    myColorScale = [ [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];

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
    
    figure();
    imagesc(single(A)), title("Original Image"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
    axis tight;
    truesize;
    figure();
    imagesc(single(B)), title("Binary Mask"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
    axis tight;
    truesize;
    figure();
    imagesc(single(C)), title("Masked Image"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
    axis tight;
    truesize;

%     figure();
%     subplot(1, 3, 1), imagesc(single(A)), title("Original Image"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
%     subplot(1, 3, 2), imagesc(single(B)), title("Binary Mask"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
%     subplot(1, 3, 3), imagesc(single(C)), title("Masked Image"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
%     axis tight;
%     truesize;
end
