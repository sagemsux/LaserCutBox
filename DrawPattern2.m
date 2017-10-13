function DrawPattern2(el1,el2,el3,sp1,sp2,sp3,n1,n2,n3,t,sSize,sLength,nWidth,nHeight)
close all
fid1 = fopen('cutme_sheet1.svg','w');
fid2 = fopen('cutme_sheet2.svg','w');
fprintf(fid1,'<svg xmlns="http://www.w3.org/2000/svg" width="1000" height="1000" viewBox = "-2 -2 25 25" version="1.1">\n');
fprintf(fid2,'<svg xmlns="http://www.w3.org/2000/svg" width="1000" height="1000" viewBox = "-2 -2 25 25" version="1.1">\n');

%Getting Lipson's face
Irgb = imread('Lipson_2.jpg'); 

Igray = 0.2989*Irgb(:,:,1)+0.5870*Irgb(:,:,2)+0.1140*Irgb(:,:,3);

I = double(Igray); 
classType = class(Igray);                 
scalingFactor = double(intmax(classType));  
I = I/scalingFactor;      
Gx = [-1 1];
Gy = Gx';
Ix = conv2(I,Gx,'same');
Iy = conv2(I,Gy,'same');

edgeFIS = newfis('edgeDetection');
edgeFIS = addvar(edgeFIS,'input','Ix',[-1 1]);
edgeFIS = addvar(edgeFIS,'input','Iy',[-1 1]);
sx = 0.1; sy = 0.1;
edgeFIS = addmf(edgeFIS,'input',1,'zero','gaussmf',[sx 0]);
edgeFIS = addmf(edgeFIS,'input',2,'zero','gaussmf',[sy 0]);
edgeFIS = addvar(edgeFIS,'output','Iout',[0 1]); 
wa = 0.1; wb = 1; wc = 1;
ba = 0; bb = 0; bc = .7;
edgeFIS = addmf(edgeFIS,'output',1,'white','trimf',[wa wb wc]);
edgeFIS = addmf(edgeFIS,'output',1,'black','trimf',[ba bb bc]);
r1 = 'If Ix is zero and Iy is zero then Iout is white';
r2 = 'If Ix is not zero or Iy is not zero then Iout is black';
r = char(r1,r2);
edgeFIS = parsrule(edgeFIS,r);
showrule(edgeFIS)
for ii = 1:size(I,1)
    Ieval(ii,:) = evalfis([(Ix(ii,:));(Iy(ii,:));]',edgeFIS);
end
figure2 = figure; image(Ieval,'CDataMapping','scaled'); colormap('gray');
axis off
saveas(figure2,'lipson_edge.png');
rgbImage = imread('lipson_edge.png');
rgbImage = imresize(rgbImage,0.0001)
I = imbinarize(I);
imshow(I)
bin = I;
R   = 1;  % Value in range [0, 1]
G   = 0;
B   = 0;
RGB = cat(3, bin * R, bin * G, bin * B);
imshow(RGB)
I = RGB;
M = repmat(all(~I,3),[1 1 3]);
I(M) = 255;
imshow(I)
imagesc([2 el1-2], [-2 -el2+2], I);
figure1 = figure;
axis equal off
hold on

%Total Number of Spacings
eP1 = linspace(t,el1-t,sp1+1);
eP2 = linspace(t,el2-t,sp2+1);
eP3 = linspace(t,el3-t,sp3+1);

gap1 = (sLength - nHeight - t)*1/3;
gap2 = (sLength - nHeight - t)*2/3;

v1 = FeatureMapping(sp1,n1);
v2 = FeatureMapping(sp2,n2);
v3 = FeatureMapping(sp3,n3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Box 1: h - el1, v - el2
offset_x = 0;
offset_y = 0;
eP_h = eP1;
eP_v = eP2;
spacing_h = eP_h(2)-eP_h(1);
spacing_v = eP_v(2)-eP_v(1);
reflect_h = el2;
reflect_v = el1;

%Spaces Horizontal Side
a = 1;
for i = v1
    %Box 1
    b = a + 1;
    if i == 0
        x1 = [eP_h(a) eP_h(b)];
        y1 = [0 0];
        plot(x1+offset_x,y1+offset_y,'k')
        plot(x1+offset_x,-y1-reflect_h+offset_y,'k')
    elseif i == 2
        x2 = [eP_h(a) eP_h(a) eP_h(b) eP_h(b)];
        y2 = [0 -t -t 0];
        plot(x2+offset_x,y2+offset_y,'k')
        plot(x2+offset_x,y2*-1-reflect_h+offset_y,'k')
    else
        mid = eP_h(a)+spacing_h/2;
        x3 = [eP_h(a) eP_h(a) mid-sSize/2 mid-sSize/2 mid-nWidth/2 mid-nWidth/2 mid-sSize/2 mid-sSize/2 mid+sSize/2 mid+sSize/2 mid+nWidth/2 mid+nWidth/2 mid+sSize/2 mid+sSize/2 eP_h(a)+spacing_h eP_h(a)+spacing_h];
        y3 = [0 -t -t -t-gap1 -t-gap1 -t-gap1-nHeight -t-gap1-nHeight -t-gap1-gap2-nHeight -t-gap1-gap2-nHeight -t-gap1-nHeight -t-gap1-nHeight -t-gap1 -t-gap1 -t -t 0];
        plot(x3+offset_x,y3+offset_y,'k')
        plot(x3+offset_x,y3*-1-reflect_h+offset_y,'k')
    end
    
    a = a + 1;
end

%Spaces Vertical Side
a = 1;
for i = v2
    %Box 1
    b = a + 1;
    if i == 0
        x1 = [eP_v(a) eP_v(b)];
        y1 = [0 0];

        plot(y1+t+offset_x,-x1+offset_y,'k')
        plot(-1*(y1+t)+reflect_v+offset_x,-x1+offset_y,'k')
    elseif i == 2
        x2 = [eP_v(a) eP_v(a) eP_v(b) eP_v(b)];
        y2 = [0 -t -t 0];

        plot(y2+t+offset_x,-x2+offset_y,'k')
        plot(-(y2+t)+reflect_v+offset_x,-x2+offset_y,'k')
    else
        mid2 = -eP_v(a)-spacing_v/2;
        x3v = [t 0 0 t t 0 0 t];
        y3v = [-eP_v(a) -eP_v(a) mid2+sSize/2 mid2+sSize/2 mid2-sSize/2 mid2-sSize/2 -eP_v(a)-spacing_v -eP_v(a)-spacing_v];
        plot(x3v+offset_x,y3v+offset_y,'k');
        plot(-x3v+reflect_v+offset_x,y3v+offset_y,'k');
    end
    
    a = a + 1;
end

%Box1
plot([t t]+offset_x,[0 -t]+offset_y,'k')
plot([t t]+offset_x,[-reflect_h -reflect_h+t]+offset_y,'k')

plot(-1*[t t]+reflect_v+offset_x,[0 -t]+offset_y,'k')
plot(-1*[t t]+reflect_v+offset_x,[-reflect_h -reflect_h+t]+offset_y,'k')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Box 2: h - el3, v - el1
offset_x = el1;
offset_y = 0;
eP_h = eP3;
eP_v = eP1;
spacing_h = eP_h(2)-eP_h(1);
spacing_v = eP_v(2)-eP_v(1);
reflect_h = el1;
reflect_v = el3;

%Spaces Horizontal Side
a = 1;
for i = v3
    %Box 2
    b = a + 1;
    if i == 0
        x1 = [eP_h(a) eP_h(b)];
        y1 = [0 0];
        plot(x1+offset_x,y1+offset_y,'k')
        plot(x1+offset_x,-y1-reflect_h+offset_y,'k')
    elseif i == 2
        x2 = [eP_h(a) eP_h(a) eP_h(b) eP_h(b)];
        y2 = [0 -t -t 0];
        plot(x2+offset_x,y2+offset_y,'k')
        plot(x2+offset_x,y2*-1-reflect_h+offset_y,'k')
    else
        mid = eP_h(a)+spacing_h/2;
        x3 = [eP_h(a) eP_h(a) mid-sSize/2 mid-sSize/2 mid-nWidth/2 mid-nWidth/2 mid-sSize/2 mid-sSize/2 mid+sSize/2 mid+sSize/2 mid+nWidth/2 mid+nWidth/2 mid+sSize/2 mid+sSize/2 eP_h(a)+spacing_h eP_h(a)+spacing_h];
        y3 = [0 -t -t -t-gap1 -t-gap1 -t-gap1-nHeight -t-gap1-nHeight -t-gap1-gap2-nHeight -t-gap1-gap2-nHeight -t-gap1-nHeight -t-gap1-nHeight -t-gap1 -t-gap1 -t -t 0];
        plot(x3+offset_x,y3+offset_y,'k')
        plot(x3+offset_x,y3*-1-reflect_h+offset_y,'k')
    end
    
    a = a + 1;
end

%Spaces Vertical Side
a = 1;
for i = v1
    %Box 2
    b = a + 1;
    if i == 0
        x1 = [eP_v(a) eP_v(b)];
        y1 = [0 0];

        plot(y1+t+offset_x,-x1+offset_y,'k')
        plot(-1*(y1+t)+reflect_v+offset_x,-x1+offset_y,'k')
    elseif i == 2
        x2 = [eP_v(a) eP_v(a) eP_v(b) eP_v(b)];
        y2 = [0 -t -t 0];

        plot(y2+t+offset_x,-x2+offset_y,'k')
        plot(-(y2+t)+reflect_v+offset_x,-x2+offset_y,'k')
    else
        mid2 = -eP_v(a)-spacing_v/2;
        x3v = [t 0 0 t t 0 0 t];
        y3v = [-eP_v(a) -eP_v(a) mid2+sSize/2 mid2+sSize/2 mid2-sSize/2 mid2-sSize/2 -eP_v(a)-spacing_v -eP_v(a)-spacing_v];
        plot(x3v+offset_x,y3v+offset_y,'k');
        plot(-x3v+reflect_v+offset_x,y3v+offset_y,'k');
    end
    
    a = a + 1;
end

%Box2
plot([t t]+offset_x,[0 -t]+offset_y,'k')
plot([t t]+offset_x,[-reflect_h -reflect_h+t]+offset_y,'k')

plot(-1*[t t]+reflect_v+offset_x,[0 -t]+offset_y,'k')
plot(-1*[t t]+reflect_v+offset_x,[-reflect_h -reflect_h+t]+offset_y,'k')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Box 3: h - el2, v - el3
offset_x = 0;
offset_y = -el2;
eP_h = eP2;
eP_v = eP3;
spacing_h = eP_h(2)-eP_h(1);
spacing_v = eP_v(2)-eP_v(1);
reflect_h = el3;
reflect_v = el2;

%Spaces Horizontal Side
a = 1;
for i = v2
    %Box 3
    b = a + 1;
    if i == 0
        x1 = [eP_h(a) eP_h(b)];
        y1 = [0 0];
        plot(x1+offset_x,y1+offset_y,'k')
        plot(x1+offset_x,-y1-reflect_h+offset_y,'k')
    elseif i == 2
        x2 = [eP_h(a) eP_h(a) eP_h(b) eP_h(b)];
        y2 = [0 -t -t 0];
        plot(x2+offset_x,y2+offset_y,'k')
        plot(x2+offset_x,y2*-1-reflect_h+offset_y,'k')
    else
        mid = eP_h(a)+spacing_h/2;
        x3 = [eP_h(a) eP_h(a) mid-sSize/2 mid-sSize/2 mid-nWidth/2 mid-nWidth/2 mid-sSize/2 mid-sSize/2 mid+sSize/2 mid+sSize/2 mid+nWidth/2 mid+nWidth/2 mid+sSize/2 mid+sSize/2 eP_h(a)+spacing_h eP_h(a)+spacing_h];
        y3 = [0 -t -t -t-gap1 -t-gap1 -t-gap1-nHeight -t-gap1-nHeight -t-gap1-gap2-nHeight -t-gap1-gap2-nHeight -t-gap1-nHeight -t-gap1-nHeight -t-gap1 -t-gap1 -t -t 0];
        plot(x3+offset_x,y3+offset_y,'k')
        plot(x3+offset_x,y3*-1-reflect_h+offset_y,'k')
    end
    
    a = a + 1;
end

%Spaces Vertical Side
a = 1;
for i = v3
    %Box 3
    b = a + 1;
    if i == 0
        x1 = [eP_v(a) eP_v(b)];
        y1 = [0 0];

        plot(y1+t+offset_x,-x1+offset_y,'k')
        plot(-1*(y1+t)+reflect_v+offset_x,-x1+offset_y,'k')
    elseif i == 2
        x2 = [eP_v(a) eP_v(a) eP_v(b) eP_v(b)];
        y2 = [0 -t -t 0];

        plot(y2+t+offset_x,-x2+offset_y,'k')
        plot(-(y2+t)+reflect_v+offset_x,-x2+offset_y,'k')
    else
        mid2 = -eP_v(a)-spacing_v/2;
        x3v = [t 0 0 t t 0 0 t];
        y3v = [-eP_v(a) -eP_v(a) mid2+sSize/2 mid2+sSize/2 mid2-sSize/2 mid2-sSize/2 -eP_v(a)-spacing_v -eP_v(a)-spacing_v];
        plot(x3v+offset_x,y3v+offset_y,'k');
        plot(-x3v+reflect_v+offset_x,y3v+offset_y,'k');
    end
    
    a = a + 1;
end

%Box3
plot([t t]+offset_x,[0 -t]+offset_y,'k')
plot([t t]+offset_x,[-reflect_h -reflect_h+t]+offset_y,'k')

plot(-1*[t t]+reflect_v+offset_x,[0 -t]+offset_y,'k')
plot(-1*[t t]+reflect_v+offset_x,[-reflect_h -reflect_h+t]+offset_y,'k')


imagesc([5*t el1-5*t], [-5*t -el2+5*t], I);
end