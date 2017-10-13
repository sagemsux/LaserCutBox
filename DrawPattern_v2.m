function DrawPattern_v2(el1,el2,el3,sp1,sp2,sp3,n1,n2,n3,t,sSize,sLength,nWidth,nHeight)
close all

figure1 = figure;
axis equal off
hold on
kerf = .03;
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
        x1 = [eP_h(a) eP_h(b)] + [-kerf kerf];
        y1 = [0 0] + [kerf kerf];
        plot(x1+offset_x,y1+offset_y,'k')
        plot(x1+offset_x,-y1-reflect_h+offset_y,'k')
    elseif i == 2
        x2 = [eP_h(a) eP_h(a) eP_h(b) eP_h(b)] + [kerf kerf -kerf -kerf];
        y2 = [0 -t -t 0] + [kerf -kerf -kerf kerf];
        plot(x2+offset_x,y2+offset_y,'k')
        plot(x2+offset_x,y2*-1-reflect_h+offset_y,'k')
    else
        mid = eP_h(a)+spacing_h/2;
        x3 = [eP_h(a) eP_h(a) mid-sSize/2 mid-sSize/2 mid-nWidth/2 mid-nWidth/2 mid-sSize/2 mid-sSize/2 mid+sSize/2 mid+sSize/2 mid+nWidth/2 mid+nWidth/2 mid+sSize/2 mid+sSize/2 eP_h(a)+spacing_h eP_h(a)+spacing_h]...
            +[kerf kerf kerf kerf kerf kerf kerf kerf -kerf -kerf -kerf -kerf -kerf -kerf -kerf -kerf];
        y3 = [0 -t -t -t-gap1 -t-gap1 -t-gap1-nHeight -t-gap1-nHeight -t-gap1-gap2-nHeight -t-gap1-gap2-nHeight -t-gap1-nHeight -t-gap1-nHeight -t-gap1 -t-gap1 -t -t 0]...
            +[kerf kerf kerf -kerf -kerf kerf kerf kerf kerf kerf kerf -kerf -kerf kerf kerf kerf];
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
        x1 = [eP_v(a) eP_v(b)] - [-kerf kerf];
        y1 = [0 0] - [kerf kerf];

        plot(y1+t+offset_x,-x1+offset_y,'k')
        plot(-1*(y1+t)+reflect_v+offset_x,-x1+offset_y,'k')
    elseif i == 2
        x2 = [eP_v(a) eP_v(a) eP_v(b) eP_v(b)] - [kerf kerf -kerf -kerf];
        y2 = [0 -t -t 0] - [kerf -kerf -kerf kerf];

        plot(y2+t+offset_x,-x2+offset_y,'k')
        plot(-(y2+t)+reflect_v+offset_x,-x2+offset_y,'k')
    else
        mid2 = -eP_v(a)-spacing_v/2;
        x3v = [t 0 0 t t 0 0 t] -kerf;
        y3v = [-eP_v(a) -eP_v(a) mid2+sSize/2 mid2+sSize/2 mid2-sSize/2 mid2-sSize/2 -eP_v(a)-spacing_v -eP_v(a)-spacing_v]...
            + [kerf kerf -kerf -kerf kerf kerf -kerf -kerf];
        plot(x3v+offset_x,y3v+offset_y,'k');
        plot(-x3v+reflect_v+offset_x,y3v+offset_y,'k');
    end
    
    a = a + 1;
end

%Box1
plot([t t]+offset_x - kerf,[0 -t]+offset_y+[kerf -kerf],'k')
plot([t t]+offset_x - kerf,[-reflect_h -reflect_h+t]+offset_y - [kerf -kerf],'k')

plot(-1*[t t]+reflect_v+offset_x + kerf,[0 -t]+ offset_y + [kerf -kerf],'k')
plot(-1*[t t]+reflect_v+offset_x + kerf,[-reflect_h -reflect_h+t]+offset_y - [kerf -kerf],'k')

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
        x1 = [eP_h(a) eP_h(b)] + [-kerf kerf];
        y1 = [0 0] + [kerf kerf];
        plot(x1+offset_x,y1+offset_y,'k')
        plot(x1+offset_x,-y1-reflect_h+offset_y,'k')
    elseif i == 2
        x2 = [eP_h(a) eP_h(a) eP_h(b) eP_h(b)] + [kerf kerf -kerf -kerf];
        y2 = [0 -t -t 0] + [kerf -kerf -kerf kerf];
        plot(x2+offset_x,y2+offset_y,'k')
        plot(x2+offset_x,y2*-1-reflect_h+offset_y,'k')
    else
        mid = eP_h(a)+spacing_h/2;
        x3 = [eP_h(a) eP_h(a) mid-sSize/2 mid-sSize/2 mid-nWidth/2 mid-nWidth/2 mid-sSize/2 mid-sSize/2 mid+sSize/2 mid+sSize/2 mid+nWidth/2 mid+nWidth/2 mid+sSize/2 mid+sSize/2 eP_h(a)+spacing_h eP_h(a)+spacing_h]...
            +[kerf kerf kerf kerf kerf kerf kerf kerf -kerf -kerf -kerf -kerf -kerf -kerf -kerf -kerf];
        y3 = [0 -t -t -t-gap1 -t-gap1 -t-gap1-nHeight -t-gap1-nHeight -t-gap1-gap2-nHeight -t-gap1-gap2-nHeight -t-gap1-nHeight -t-gap1-nHeight -t-gap1 -t-gap1 -t -t 0]...
            +[kerf kerf kerf -kerf -kerf kerf kerf kerf kerf kerf kerf -kerf -kerf kerf kerf kerf];
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
        x1 = [eP_v(a) eP_v(b)] - [-kerf kerf];
        y1 = [0 0] - [kerf kerf];

        plot(y1+t+offset_x,-x1+offset_y,'k')
        plot(-1*(y1+t)+reflect_v+offset_x,-x1+offset_y,'k')
    elseif i == 2
        x2 = [eP_v(a) eP_v(a) eP_v(b) eP_v(b)] - [kerf kerf -kerf -kerf];
        y2 = [0 -t -t 0] - [kerf -kerf -kerf kerf];

        plot(y2+t+offset_x,-x2+offset_y,'k')
        plot(-(y2+t)+reflect_v+offset_x,-x2+offset_y,'k')
    else
        mid2 = -eP_v(a)-spacing_v/2;
        x3v = [t 0 0 t t 0 0 t] -kerf;
        y3v = [-eP_v(a) -eP_v(a) mid2+sSize/2 mid2+sSize/2 mid2-sSize/2 mid2-sSize/2 -eP_v(a)-spacing_v -eP_v(a)-spacing_v]...
            + [kerf kerf -kerf -kerf kerf kerf -kerf -kerf];
        plot(x3v+offset_x,y3v+offset_y,'k');
        plot(-x3v+reflect_v+offset_x,y3v+offset_y,'k');
    end
    
    a = a + 1;
end

%Box2
plot([t t]+offset_x - kerf,[0 -t]+offset_y+[kerf -kerf],'k')
plot([t t]+offset_x - kerf,[-reflect_h -reflect_h+t]+offset_y - [kerf -kerf],'k')

plot(-1*[t t]+reflect_v+offset_x + kerf,[0 -t]+ offset_y + [kerf -kerf],'k')
plot(-1*[t t]+reflect_v+offset_x + kerf,[-reflect_h -reflect_h+t]+offset_y - [kerf -kerf],'k')

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
        x1 = [eP_h(a) eP_h(b)] + [-kerf kerf];
        y1 = [0 0] + [kerf kerf];
        plot(x1+offset_x,y1+offset_y,'k')
        plot(x1+offset_x,-y1-reflect_h+offset_y,'k')
    elseif i == 2
        x2 = [eP_h(a) eP_h(a) eP_h(b) eP_h(b)] + [kerf kerf -kerf -kerf];
        y2 = [0 -t -t 0] + [kerf -kerf -kerf kerf];
        plot(x2+offset_x,y2+offset_y,'k')
        plot(x2+offset_x,y2*-1-reflect_h+offset_y,'k')
    else
        mid = eP_h(a)+spacing_h/2;
        x3 = [eP_h(a) eP_h(a) mid-sSize/2 mid-sSize/2 mid-nWidth/2 mid-nWidth/2 mid-sSize/2 mid-sSize/2 mid+sSize/2 mid+sSize/2 mid+nWidth/2 mid+nWidth/2 mid+sSize/2 mid+sSize/2 eP_h(a)+spacing_h eP_h(a)+spacing_h]...
            +[kerf kerf kerf kerf kerf kerf kerf kerf -kerf -kerf -kerf -kerf -kerf -kerf -kerf -kerf];
        y3 = [0 -t -t -t-gap1 -t-gap1 -t-gap1-nHeight -t-gap1-nHeight -t-gap1-gap2-nHeight -t-gap1-gap2-nHeight -t-gap1-nHeight -t-gap1-nHeight -t-gap1 -t-gap1 -t -t 0]...
            +[kerf kerf kerf -kerf -kerf kerf kerf kerf kerf kerf kerf -kerf -kerf kerf kerf kerf];
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
        x1 = [eP_v(a) eP_v(b)] - [-kerf kerf];
        y1 = [0 0] - [kerf kerf];

        plot(y1+t+offset_x,-x1+offset_y,'k')
        plot(-1*(y1+t)+reflect_v+offset_x,-x1+offset_y,'k')
    elseif i == 2
        x2 = [eP_v(a) eP_v(a) eP_v(b) eP_v(b)] - [kerf kerf -kerf -kerf];
        y2 = [0 -t -t 0] - [kerf -kerf -kerf kerf];

        plot(y2+t+offset_x,-x2+offset_y,'k')
        plot(-(y2+t)+reflect_v+offset_x,-x2+offset_y,'k')
    else
        mid2 = -eP_v(a)-spacing_v/2;
        x3v = [t 0 0 t t 0 0 t] -kerf;
        y3v = [-eP_v(a) -eP_v(a) mid2+sSize/2 mid2+sSize/2 mid2-sSize/2 mid2-sSize/2 -eP_v(a)-spacing_v -eP_v(a)-spacing_v]...
            + [kerf kerf -kerf -kerf kerf kerf -kerf -kerf];
        plot(x3v+offset_x,y3v+offset_y,'k');
        plot(-x3v+reflect_v+offset_x,y3v+offset_y,'k');
    end
    
    a = a + 1;
end

%Box3
plot([t t]+offset_x - kerf,[0 -t]+offset_y+[kerf -kerf],'k')
plot([t t]+offset_x - kerf,[-reflect_h -reflect_h+t]+offset_y - [kerf -kerf],'k')

plot(-1*[t t]+reflect_v+offset_x + kerf,[0 -t]+ offset_y + [kerf -kerf],'k')
plot(-1*[t t]+reflect_v+offset_x + kerf,[-reflect_h -reflect_h+t]+offset_y - [kerf -kerf],'k')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Box 4: h - el1, v - el2
offset_x = 11-el1;
offset_y = -11+el2;
eP_h = eP1;
eP_v = eP2;
spacing_h = eP_h(2)-eP_h(1);
spacing_v = eP_v(2)-eP_v(1);
reflect_h = el2;
reflect_v = el1;

%Spaces Horizontal Side
a = 1;
for i = v1
    %Box 4
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
    %Box 4
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

%Box4
plot([t t]+offset_x,[0 -t]+offset_y,'k')
plot([t t]+offset_x,[-reflect_h -reflect_h+t]+offset_y,'k')

plot(-1*[t t]+reflect_v+offset_x,[0 -t]+offset_y,'k')
plot(-1*[t t]+reflect_v+offset_x,[-reflect_h -reflect_h+t]+offset_y,'k')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Box 5: h - el3, v - el1
offset_x = 11-el1-el1+t;
offset_y = -11+el3;
eP_h = eP1;
eP_v = eP3;
spacing_h = eP_h(2)-eP_h(1);
spacing_v = eP_v(2)-eP_v(1);
reflect_h = el3;
reflect_v = el1;

%Spaces Horizontal Side
a = 1;
for i = v1
    %Box 5
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
        mid2 = -eP_h(a)-spacing_h/2;
        x3h = [t 0 0 t t 0 0 t];
        y3h = [-eP_h(a) -eP_h(a) mid2+sSize/2 mid2+sSize/2 mid2-sSize/2 mid2-sSize/2 -eP_h(a)-spacing_h -eP_h(a)-spacing_h];
        plot(-y3h+offset_x,-x3h+offset_y+t,'k');
        plot(-y3h+offset_x,x3h+offset_y-reflect_h-t,'k');
    end
    
    a = a + 1;
end

%Spaces Vertical Side
a = 1;
for i = v3
    %Box 5
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
        mid = eP_v(a)+spacing_v/2;
        x3 = [eP_v(a) eP_v(a) mid-sSize/2 mid-sSize/2 mid-nWidth/2 mid-nWidth/2 mid-sSize/2 mid-sSize/2 mid+sSize/2 mid+sSize/2 mid+nWidth/2 mid+nWidth/2 mid+sSize/2 mid+sSize/2 eP_v(a)+spacing_v eP_v(a)+spacing_v];
        y3 = [0 -t -t -t-gap1 -t-gap1 -t-gap1-nHeight -t-gap1-nHeight -t-gap1-gap2-nHeight -t-gap1-gap2-nHeight -t-gap1-nHeight -t-gap1-nHeight -t-gap1 -t-gap1 -t -t 0];
        plot(-y3+offset_x+t,-x3+offset_y,'k')
        plot(y3+offset_x+reflect_v-t,-x3+offset_y,'k')
    end
    
    a = a + 1;
end

%Box5
plot([t t]+offset_x,[0 -t]+offset_y,'k')
plot([t t]+offset_x,[-reflect_h -reflect_h+t]+offset_y,'k')

plot(-1*[t t]+reflect_v+offset_x,[0 -t]+offset_y,'k')
plot(-1*[t t]+reflect_v+offset_x,[-reflect_h -reflect_h+t]+offset_y,'k')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Box 6: h - el2, v - el3
offset_x = 11-el3;
offset_y = -11+el2+el2+t;
eP_h = eP3;
eP_v = eP2;
spacing_h = eP_h(2)-eP_h(1);
spacing_v = eP_v(2)-eP_v(1);
reflect_h = el2;
reflect_v = el3;

%Spaces Horizontal Side
a = 1;
for i = v3
    %Box 6
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
        mid2 = -eP_h(a)-spacing_h/2;
        x3h = [t 0 0 t t 0 0 t];
        y3h = [-eP_h(a) -eP_h(a) mid2+sSize/2 mid2+sSize/2 mid2-sSize/2 mid2-sSize/2 -eP_h(a)-spacing_h -eP_h(a)-spacing_h];
        plot(-y3h+offset_x,-x3h+offset_y+t,'k');
        plot(-y3h+offset_x,x3h+offset_y-reflect_h-t,'k');
    end
    
    a = a + 1;
end

%Spaces Vertical Side
a = 1;
for i = v2
    %Box 6
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
        mid = eP_v(a)+spacing_v/2;
        x3 = [eP_v(a) eP_v(a) mid-sSize/2 mid-sSize/2 mid-nWidth/2 mid-nWidth/2 mid-sSize/2 mid-sSize/2 mid+sSize/2 mid+sSize/2 mid+nWidth/2 mid+nWidth/2 mid+sSize/2 mid+sSize/2 eP_v(a)+spacing_v eP_v(a)+spacing_v];
        y3 = [0 -t -t -t-gap1 -t-gap1 -t-gap1-nHeight -t-gap1-nHeight -t-gap1-gap2-nHeight -t-gap1-gap2-nHeight -t-gap1-nHeight -t-gap1-nHeight -t-gap1 -t-gap1 -t -t 0];
        plot(-y3+offset_x+t,-x3+offset_y,'k')
        plot(y3+offset_x+reflect_v-t,-x3+offset_y,'k')
    end
    
    a = a + 1;
end

%Box6
plot([t t]+offset_x,[0 -t]+offset_y,'k')
plot([t t]+offset_x,[-reflect_h -reflect_h+t]+offset_y,'k')

plot(-1*[t t]+reflect_v+offset_x,[0 -t]+offset_y,'k')
plot(-1*[t t]+reflect_v+offset_x,[-reflect_h -reflect_h+t]+offset_y,'k')

saveas(figure1,'pattern2.svg')
end