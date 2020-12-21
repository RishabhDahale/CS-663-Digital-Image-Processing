function [] = myShrinkImageByFactorD()
    myNumOfColors = 200;
    myColorScale = [ [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];

    A=imread('../data/circles_concentric.png');
    B = A(1:2:end, 1:2:end);
    C = A(1:3:end, 1:3:end);

    figure();
    imagesc (single (A)), title("d=1"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
    axis tight; truesize;

    figure();
    imagesc (single (B)), title("d=2"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
    axis tight; truesize;

    figure();
    imagesc (single (C)), title("d=3"), daspect ([1 1 1]), colormap (myColorScale), colorbar;
    axis tight; truesize;
end