function DrawPattern(el1,el2,el3,sp1,sp2,sp3,n1,n2,n3,t,sSize,sLength,nWidth,nHeight)
close all
fid = fopen('cutme.svg','w');
fprintf(fid,'<svg xmlns="http://www.w3.org/2000/svg" width="1000" height="1000" viewBox = "-2 -2 25 25" version="1.1">\n');
figure1 = figure;
axis equal off
hold on
kerf = .00;
%kerf = 0;
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
        y1 = [0 0] + kerf;
        plot(x1+offset_x,y1+offset_y,'k')
        plot(x1+offset_x,-y1-reflect_h+offset_y,'k')
        
        %writing to svg
        temp = horzcat(x1+offset_x,-(y1+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;" />\n', temp);
        
        temp_a = horzcat(x1+offset_x,-(-y1-reflect_h+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;" />\n', temp_a);
    elseif i == 2
        x2 = [eP_h(a) eP_h(a) eP_h(b) eP_h(b)] + [kerf kerf -kerf -kerf];
        y2 = [0 -t -t 0] + kerf;
        plot(x2+offset_x,y2+offset_y,'k')
        plot(x2+offset_x,y2*-1-reflect_h+offset_y,'k')
        
        %writing to svg
        temp2 = horzcat(x2+offset_x,-(y2+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f" style="stroke:black;fill:none;stroke-width:.01;" />\n', temp2);
        
        temp2_a = horzcat(x2+offset_x,-(y2*-1-reflect_h+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f" style="stroke:black;fill:none;stroke-width:.01;" />\n', temp2_a);
    else
        mid = eP_h(a)+spacing_h/2;
        x3 = [eP_h(a) eP_h(a) mid-sSize/2 mid-sSize/2 mid-nWidth/2 mid-nWidth/2 mid-sSize/2 mid-sSize/2 mid+sSize/2 mid+sSize/2 mid+nWidth/2 mid+nWidth/2 mid+sSize/2 mid+sSize/2 eP_h(a)+spacing_h eP_h(a)+spacing_h]...
            +[kerf kerf kerf kerf kerf kerf kerf kerf -kerf -kerf -kerf -kerf -kerf -kerf -kerf -kerf];
        y3 = [0 -t -t -t-gap1 -t-gap1 -t-gap1-nHeight -t-gap1-nHeight -t-gap1-gap2-nHeight -t-gap1-gap2-nHeight -t-gap1-nHeight -t-gap1-nHeight -t-gap1 -t-gap1 -t -t 0]...
            +[kerf kerf kerf -kerf -kerf kerf kerf kerf kerf kerf kerf -kerf -kerf kerf kerf kerf];
        plot(x3+offset_x,y3+offset_y,'k')
        plot(x3+offset_x,y3*-1-reflect_h+offset_y,'k')
        
        %writing to svg
        temp3 = horzcat(x3+offset_x,-(y3+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp3);
        
        temp3_a = horzcat(x3+offset_x,-(y3*-1-reflect_h+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp3_a);
    
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
        y1 = [0 0] - kerf;

        plot(y1+t+offset_x,-x1+offset_y,'k')
        plot(-1*(y1+t)+reflect_v+offset_x,-x1+offset_y,'k')
        
        %writing to svg
        temp4 = horzcat(y1+t+offset_x,-(-x1+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp4);
        
        temp4_a = horzcat(-1*(y1+t)+reflect_v+offset_x,-(-x1+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp4_a);
    elseif i == 2
        x2 = [eP_v(a) eP_v(a) eP_v(b) eP_v(b)] - [kerf kerf -kerf -kerf];
        y2 = [0 -t -t 0] - kerf;

        plot(y2+t+offset_x,-x2+offset_y,'k')
        plot(-(y2+t)+reflect_v+offset_x,-x2+offset_y,'k')
        
        %writing to svg
        temp5 = horzcat(y2+t+offset_x,-(-x2+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none" />\n', temp5);
        
        temp5_a = horzcat(-(y2+t)+reflect_v+offset_x,-(-x2+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp5_a);
        
    else
        mid2 = -eP_v(a)-spacing_v/2;
        x3v = [t 0 0 t t 0 0 t] -kerf;
        y3v = [-eP_v(a) -eP_v(a) mid2+sSize/2 mid2+sSize/2 mid2-sSize/2 mid2-sSize/2 -eP_v(a)-spacing_v -eP_v(a)-spacing_v]...
            + [kerf kerf -kerf -kerf kerf kerf -kerf -kerf];
        plot(x3v+offset_x,y3v+offset_y,'k');
        plot(-x3v+reflect_v+offset_x,y3v+offset_y,'k');
        
        %writing to svg
        temp6 = horzcat(x3v+offset_x,-(y3v+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f " style="stroke:black;stroke-width:.01;fill:none;" />\n', temp6);
        
        temp6_a = horzcat(-x3v+reflect_v+offset_x,-(y3v+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp6_a);
        
    end
    
    a = a + 1;
end

%Box1
plot([t t]+offset_x - kerf,[0 -t]+offset_y+[kerf -kerf],'k')
plot([t t]+offset_x - kerf,[-reflect_h -reflect_h+t]+offset_y - [kerf -kerf],'k')

%writing to svg
temp7 = horzcat([t t]+offset_x - kerf,-([0 -t]+offset_y+[kerf -kerf]));
fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp7);

temp7_a = horzcat([t t]+offset_x - kerf,-([-reflect_h -reflect_h+t]+offset_y - [kerf -kerf]));
fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp7_a);

plot(-1*[t t]+reflect_v+offset_x + kerf,[0 -t]+ offset_y + [kerf -kerf],'k')
plot(-1*[t t]+reflect_v+offset_x + kerf,[-reflect_h -reflect_h+t]+offset_y - [kerf -kerf],'k')

%writing to svg
temp7_b = horzcat(-1*[t t]+reflect_v+offset_x + kerf,-([0 -t]+ offset_y + [kerf -kerf]));
fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp7_b);

temp7_c = horzcat(-1*[t t]+reflect_v+offset_x + kerf,-([-reflect_h -reflect_h+t]+offset_y - [kerf -kerf]));
fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp7_c);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Box 2: h - el3, v - el1
offset_x = el1 + 2*kerf;
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
        y1 = [0 0] + kerf;
        plot(x1+offset_x,y1+offset_y,'k')
        plot(x1+offset_x,-y1-reflect_h+offset_y,'k')
        
        %writing to svg
        temp8 = horzcat(x1+offset_x,-(y1+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp8);
        
        temp8_a = horzcat(x1+offset_x,-(-y1-reflect_h+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp8_a);
        
    elseif i == 2
        x2 = [eP_h(a) eP_h(a) eP_h(b) eP_h(b)] + [kerf kerf -kerf -kerf];
        y2 = [0 -t -t 0] + kerf;
        plot(x2+offset_x,y2+offset_y,'k')
        plot(x2+offset_x,y2*-1-reflect_h+offset_y,'k')
        
        %writing to svg
        temp9 = horzcat(x2+offset_x,-(y2+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp9);
        
        temp9_a = horzcat(x2+offset_x,-(-y2-reflect_h+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp9_a);
        
    else
        mid = eP_h(a)+spacing_h/2;
        x3 = [eP_h(a) eP_h(a) mid-sSize/2 mid-sSize/2 mid-nWidth/2 mid-nWidth/2 mid-sSize/2 mid-sSize/2 mid+sSize/2 mid+sSize/2 mid+nWidth/2 mid+nWidth/2 mid+sSize/2 mid+sSize/2 eP_h(a)+spacing_h eP_h(a)+spacing_h]...
            +[kerf kerf kerf kerf kerf kerf kerf kerf -kerf -kerf -kerf -kerf -kerf -kerf -kerf -kerf];
        y3 = [0 -t -t -t-gap1 -t-gap1 -t-gap1-nHeight -t-gap1-nHeight -t-gap1-gap2-nHeight -t-gap1-gap2-nHeight -t-gap1-nHeight -t-gap1-nHeight -t-gap1 -t-gap1 -t -t 0]...
            +[kerf kerf kerf -kerf -kerf kerf kerf kerf kerf kerf kerf -kerf -kerf kerf kerf kerf];
        plot(x3+offset_x,y3+offset_y,'k')
        plot(x3+offset_x,y3*-1-reflect_h+offset_y,'k')
        
        %writing to svg
        temp10 = horzcat(x3+offset_x,-(y3+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp10);
        
        temp10_a = horzcat(x3+offset_x,-(-y3-reflect_h+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp10_a);
        
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
        y1 = [0 0] - kerf;

        plot(y1+t+offset_x,-x1+offset_y,'k')
        plot(-1*(y1+t)+reflect_v+offset_x,-x1+offset_y,'k')
        
        %writing to svg
        temp11 = horzcat(y1+t+offset_x,-(-x1+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp11);
        
        temp11_a = horzcat(-1*(y1+t)+reflect_v+offset_x,-(-x1+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp11_a);
        
    elseif i == 2
        x2 = [eP_v(a) eP_v(a) eP_v(b) eP_v(b)] - [kerf kerf -kerf -kerf];
        y2 = [0 -t -t 0] - kerf;

        plot(y2+t+offset_x,-x2+offset_y,'k')
        plot(-(y2+t)+reflect_v+offset_x,-x2+offset_y,'k')
        
        %writing to svg
        temp12 = horzcat(y2+t+offset_x,-(-x2+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp12);
        
        temp12_a = horzcat(-(y2+t)+reflect_v+offset_x,-(-x2+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp12_a);
        
    else
        mid2 = -eP_v(a)-spacing_v/2;
        x3v = [t 0 0 t t 0 0 t] -kerf;
        y3v = [-eP_v(a) -eP_v(a) mid2+sSize/2 mid2+sSize/2 mid2-sSize/2 mid2-sSize/2 -eP_v(a)-spacing_v -eP_v(a)-spacing_v]...
            + [kerf kerf -kerf -kerf kerf kerf -kerf -kerf];
        plot(x3v+offset_x,y3v+offset_y,'k');
        plot(-x3v+reflect_v+offset_x,y3v+offset_y,'k');
        
        %writing to svg
        temp13 = horzcat(x3v+offset_x,-(y3v+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp13);
        
        temp13_a = horzcat(-x3v+reflect_v+offset_x,-(y3v+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp13_a);
        
    end
    
    a = a + 1;
end

%Box2
plot([t t]+offset_x - kerf,[0 -t]+offset_y+[kerf -kerf],'k')
plot([t t]+offset_x - kerf,[-reflect_h -reflect_h+t]+offset_y - [kerf -kerf],'k')

plot(-1*[t t]+reflect_v+offset_x + kerf,[0 -t]+ offset_y + [kerf -kerf],'k')
plot(-1*[t t]+reflect_v+offset_x + kerf,[-reflect_h -reflect_h+t]+offset_y - [kerf -kerf],'k')

%writing to svg
temp14 = horzcat([t t]+offset_x - kerf,-([0 -t]+offset_y+[kerf -kerf]));
fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp14);
        
temp14_a = horzcat([t t]+offset_x - kerf,-([-reflect_h -reflect_h+t]+offset_y - [kerf -kerf]));
fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp14_a);

temp14_b = horzcat(-1*[t t]+reflect_v+offset_x + kerf,-([0 -t]+ offset_y + [kerf -kerf]));
fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp14_b);
        
temp14_c = horzcat(-1*[t t]+reflect_v+offset_x + kerf,-([-reflect_h -reflect_h+t]+offset_y - [kerf -kerf]));
fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp14_c);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Box 3: h - el2, v - el3
offset_x = 0;
offset_y = -el2 - 2*kerf;
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
        y1 = [0 0] + kerf;
        plot(x1+offset_x,y1+offset_y,'k')
        plot(x1+offset_x,-y1-reflect_h+offset_y,'k')
        
        %writing to svg
        temp15 = horzcat(x1+offset_x,-(y1+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp15);

        temp15_a = horzcat(x1+offset_x,-(-y1-reflect_h+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp15_a);

    elseif i == 2
        x2 = [eP_h(a) eP_h(a) eP_h(b) eP_h(b)] + [kerf kerf -kerf -kerf];
        y2 = [0 -t -t 0] + kerf;
        plot(x2+offset_x,y2+offset_y,'k')
        plot(x2+offset_x,y2*-1-reflect_h+offset_y,'k')
        
        %writing to svg
        temp16 = horzcat(x2+offset_x,-(y2+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp16);

        temp16_a = horzcat(x2+offset_x,-(-y2-reflect_h+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp16_a);
        
    else
        mid = eP_h(a)+spacing_h/2;
        x3 = [eP_h(a) eP_h(a) mid-sSize/2 mid-sSize/2 mid-nWidth/2 mid-nWidth/2 mid-sSize/2 mid-sSize/2 mid+sSize/2 mid+sSize/2 mid+nWidth/2 mid+nWidth/2 mid+sSize/2 mid+sSize/2 eP_h(a)+spacing_h eP_h(a)+spacing_h]...
            +[kerf kerf kerf kerf kerf kerf kerf kerf -kerf -kerf -kerf -kerf -kerf -kerf -kerf -kerf];
        y3 = [0 -t -t -t-gap1 -t-gap1 -t-gap1-nHeight -t-gap1-nHeight -t-gap1-gap2-nHeight -t-gap1-gap2-nHeight -t-gap1-nHeight -t-gap1-nHeight -t-gap1 -t-gap1 -t -t 0]...
            +[kerf kerf kerf -kerf -kerf kerf kerf kerf kerf kerf kerf -kerf -kerf kerf kerf kerf];
        plot(x3+offset_x,y3+offset_y,'k')
        plot(x3+offset_x,y3*-1-reflect_h+offset_y,'k')
        
        %writing to svg
        temp17 = horzcat(x3+offset_x,-(y3+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp17);

        temp17_a = horzcat(x3+offset_x,-(-y3-reflect_h+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp17_a);
        
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
        y1 = [0 0] - kerf;

        plot(y1+t+offset_x,-x1+offset_y,'k')
        plot(-1*(y1+t)+reflect_v+offset_x,-x1+offset_y,'k')
        
        %writing to svg
        temp18 = horzcat(y1+t+offset_x,-(-x1+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp18);

        temp18_a = horzcat(-1*(y1+t)+reflect_v+offset_x,-(-x1+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp18_a);
        
    elseif i == 2
        x2 = [eP_v(a) eP_v(a) eP_v(b) eP_v(b)] - [kerf kerf -kerf -kerf];
        y2 = [0 -t -t 0] - kerf;

        plot(y2+t+offset_x,-x2+offset_y,'k')
        plot(-(y2+t)+reflect_v+offset_x,-x2+offset_y,'k')
        
        %writing to svg
        temp19 = horzcat(y2+t+offset_x,-(-x2+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp19);

        temp19_a = horzcat(-(y2+t)+reflect_v+offset_x,-(-x2+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp19_a);
        
    else
        mid2 = -eP_v(a)-spacing_v/2;
        x3v = [t 0 0 t t 0 0 t] -kerf;
        y3v = [-eP_v(a) -eP_v(a) mid2+sSize/2 mid2+sSize/2 mid2-sSize/2 mid2-sSize/2 -eP_v(a)-spacing_v -eP_v(a)-spacing_v]...
            + [kerf kerf -kerf -kerf kerf kerf -kerf -kerf];
        plot(x3v+offset_x,y3v+offset_y,'k');
        plot(-x3v+reflect_v+offset_x,y3v+offset_y,'k');
        
        %writing to svg
        temp20 = horzcat(x3v+offset_x,-(y3v+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp20);

        temp20_a = horzcat(-x3v+reflect_v+offset_x,-(y3v+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp20_a);
        
    end
    
    a = a + 1;
end

%Box3
plot([t t]+offset_x - kerf,[0 -t]+offset_y+[kerf -kerf],'k')
plot([t t]+offset_x - kerf,[-reflect_h -reflect_h+t]+offset_y - [kerf -kerf],'k')

plot(-1*[t t]+reflect_v+offset_x + kerf,[0 -t]+ offset_y + [kerf -kerf],'k')
plot(-1*[t t]+reflect_v+offset_x + kerf,[-reflect_h -reflect_h+t]+offset_y - [kerf -kerf],'k')

%writing to svg
temp21 = horzcat([t t]+offset_x-kerf,-([0 -t]+offset_y+[kerf -kerf]));
fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp21);

temp21_a = horzcat([t t]+offset_x-kerf,-([-reflect_h -reflect_h+t]+offset_y - [kerf -kerf]));
fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp21_a);

temp21_b = horzcat(-1*[t t]+reflect_v+offset_x+kerf,-([0 -t]+ offset_y + [kerf -kerf]));
fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp21_b);

temp21_c = horzcat(-1*[t t]+reflect_v+offset_x+kerf,-([-reflect_h -reflect_h+t]+offset_y - [kerf -kerf]));
fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp21_c);

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
        x1 = [eP_h(a) eP_h(b)] + [-kerf kerf];
        y1 = [0 0] + kerf;
        plot(x1+offset_x,y1+offset_y,'k')
        plot(x1+offset_x,-y1-reflect_h+offset_y,'k')
        
        %writing to svg
        temp = horzcat(x1+offset_x,-(y1+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;" />\n', temp);
        
        temp_a = horzcat(x1+offset_x,-(-y1-reflect_h+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;" />\n', temp_a);
    elseif i == 2
        x2 = [eP_h(a) eP_h(a) eP_h(b) eP_h(b)] + [kerf kerf -kerf -kerf];
        y2 = [0 -t -t 0] + kerf;
        plot(x2+offset_x,y2+offset_y,'k')
        plot(x2+offset_x,y2*-1-reflect_h+offset_y,'k')
        
        %writing to svg
        temp2 = horzcat(x2+offset_x,-(y2+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f" style="stroke:black;fill:none;stroke-width:.01;" />\n', temp2);
        
        temp2_a = horzcat(x2+offset_x,-(y2*-1-reflect_h+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f" style="stroke:black;fill:none;stroke-width:.01;" />\n', temp2_a);
    else
        mid = eP_h(a)+spacing_h/2;
        x3 = [eP_h(a) eP_h(a) mid-sSize/2 mid-sSize/2 mid-nWidth/2 mid-nWidth/2 mid-sSize/2 mid-sSize/2 mid+sSize/2 mid+sSize/2 mid+nWidth/2 mid+nWidth/2 mid+sSize/2 mid+sSize/2 eP_h(a)+spacing_h eP_h(a)+spacing_h]...
            +[kerf kerf kerf kerf kerf kerf kerf kerf -kerf -kerf -kerf -kerf -kerf -kerf -kerf -kerf];
        y3 = [0 -t -t -t-gap1 -t-gap1 -t-gap1-nHeight -t-gap1-nHeight -t-gap1-gap2-nHeight -t-gap1-gap2-nHeight -t-gap1-nHeight -t-gap1-nHeight -t-gap1 -t-gap1 -t -t 0]...
            +[kerf kerf kerf -kerf -kerf kerf kerf kerf kerf kerf kerf -kerf -kerf kerf kerf kerf];
        plot(x3+offset_x,y3+offset_y,'k')
        plot(x3+offset_x,y3*-1-reflect_h+offset_y,'k')
        
        %writing to svg
        temp3 = horzcat(x3+offset_x,-(y3+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp3);
        
        temp3_a = horzcat(x3+offset_x,-(y3*-1-reflect_h+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp3_a);
    
    end
    
    a = a + 1;
end

%Spaces Vertical Side
a = 1;
for i = v2
    %Box 4
    b = a + 1;
    if i == 0
        x1 = [eP_v(a) eP_v(b)] - [-kerf kerf];
        y1 = [0 0] - kerf;

        plot(y1+t+offset_x,-x1+offset_y,'k')
        plot(-1*(y1+t)+reflect_v+offset_x,-x1+offset_y,'k')
        
        %writing to svg
        temp4 = horzcat(y1+t+offset_x,-(-x1+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp4);
        
        temp4_a = horzcat(-1*(y1+t)+reflect_v+offset_x,-(-x1+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp4_a);
    elseif i == 2
        x2 = [eP_v(a) eP_v(a) eP_v(b) eP_v(b)] - [kerf kerf -kerf -kerf];
        y2 = [0 -t -t 0] - kerf;

        plot(y2+t+offset_x,-x2+offset_y,'k')
        plot(-(y2+t)+reflect_v+offset_x,-x2+offset_y,'k')
        
        %writing to svg
        temp5 = horzcat(y2+t+offset_x,-(-x2+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none" />\n', temp5);
        
        temp5_a = horzcat(-(y2+t)+reflect_v+offset_x,-(-x2+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp5_a);
        
    else
        mid2 = -eP_v(a)-spacing_v/2;
        x3v = [t 0 0 t t 0 0 t] -kerf;
        y3v = [-eP_v(a) -eP_v(a) mid2+sSize/2 mid2+sSize/2 mid2-sSize/2 mid2-sSize/2 -eP_v(a)-spacing_v -eP_v(a)-spacing_v]...
            + [kerf kerf -kerf -kerf kerf kerf -kerf -kerf];
        plot(x3v+offset_x,y3v+offset_y,'k');
        plot(-x3v+reflect_v+offset_x,y3v+offset_y,'k');
        
        %writing to svg
        temp6 = horzcat(x3v+offset_x,-(y3v+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f " style="stroke:black;stroke-width:.01;fill:none;" />\n', temp6);
        
        temp6_a = horzcat(-x3v+reflect_v+offset_x,-(y3v+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp6_a);
        
    end
    
    a = a + 1;
end

%Box4
plot([t t]+offset_x - kerf,[0 -t]+offset_y+[kerf -kerf],'k')
plot([t t]+offset_x - kerf,[-reflect_h -reflect_h+t]+offset_y - [kerf -kerf],'k')

plot(-1*[t t]+reflect_v+offset_x + kerf,[0 -t]+ offset_y + [kerf -kerf],'k')
plot(-1*[t t]+reflect_v+offset_x + kerf,[-reflect_h -reflect_h+t]+offset_y - [kerf -kerf],'k')

%writing to svg
temp28 = horzcat([t t]+offset_x,-([0 -t]+offset_y));
fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp28);

temp28_a = horzcat([t t]+offset_x,-([-reflect_h -reflect_h+t]+offset_y));
fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp28_a);

temp28_b = horzcat(-1*[t t]+reflect_v+offset_x,-([0 -t]+offset_y));
fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp28_b);

temp28_c = horzcat(-1*[t t]+reflect_v+offset_x,-([-reflect_h -reflect_h+t]+offset_y));
fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp28_c);
        

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Box 5: h - el3, v - el1
offset_x = 11-el1-el1-2*kerf;
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
        x1 = [eP_h(a) eP_h(b)] - [-kerf kerf];
        y1 = [0 0] + kerf -t;

        plot(x1+offset_x,y1+offset_y,'k')
        plot(x1+offset_x,-y1-reflect_h+offset_y,'k')
        
        %writing to svg
        temp = horzcat(x1+offset_x,-(y1+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;" />\n', temp);
        
        temp_a = horzcat(x1+offset_x,-(-y1-reflect_h+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;" />\n', temp_a);
    elseif i == 2
        x2 = [eP_h(a) eP_h(a) eP_h(b) eP_h(b)] - [kerf kerf -kerf -kerf];
        y2 = -[0 -t -t 0] + kerf -t;
        plot(x2+offset_x,y2+offset_y,'k')
        plot(x2+offset_x,y2*-1-reflect_h+offset_y,'k')
        
        %writing to svg
        temp2 = horzcat(x2+offset_x,-(y2+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f" style="stroke:black;fill:none;stroke-width:.01;" />\n', temp2);
        
        temp2_a = horzcat(x2+offset_x,-(y2*-1-reflect_h+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f" style="stroke:black;fill:none;stroke-width:.01;" />\n', temp2_a);
    else
        mid2 = -eP_h(a)-spacing_h/2;
        x3h = [t 0 0 t t 0 0 t] - kerf +t;
        y3h = [-eP_h(a) -eP_h(a) mid2+sSize/2 mid2+sSize/2 mid2-sSize/2 mid2-sSize/2 -eP_h(a)-spacing_h -eP_h(a)-spacing_h]...
            + [kerf kerf -kerf -kerf kerf kerf -kerf -kerf];
        plot(-y3h+offset_x,-x3h+offset_y+t,'k');
        plot(-y3h+offset_x,x3h+offset_y-reflect_h-t,'k');
        
        %writing to svg
        temp31 = horzcat(-y3h+offset_x,-(-x3h+offset_y+t));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp31);

        temp31_a = horzcat(-y3h+offset_x,-(x3h+offset_y-reflect_h-t));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp31_a);
        
    end
    
    a = a + 1;
end

%Spaces Vertical Side
a = 1;
for i = v3
    %Box 5
    b = a + 1;
    if i == 0
        x1 = [eP_v(a) eP_v(b)] + [-kerf kerf];
        y1 = [0 0] - kerf;
        
        plot(y1+offset_x,-x1+offset_y,'k')
        plot(-y1+reflect_v+offset_x,-x1+offset_y,'k')
        
        %writing to svg
        temp4 = horzcat(y1+offset_x,-(-x1+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp4);
        
        temp4_a = horzcat(-y1+reflect_v+offset_x,-(-x1+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp4_a);
    elseif i == 2
        x2 = [eP_v(a) eP_v(a) eP_v(b) eP_v(b)] + [kerf kerf -kerf -kerf];
        y2 = -[0 -t -t 0] - kerf;

        plot(y2+offset_x,-x2+offset_y,'k')
        plot(-y2+reflect_v+offset_x,-x2+offset_y,'k')
        
        %writing to svg
        temp5 = horzcat(y2+t+offset_x,-(-x2+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none" />\n', temp5);
        
        temp5_a = horzcat(-y2+reflect_v+offset_x,-(-x2+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp5_a);
        
    else
        mid = eP_v(a)+spacing_v/2;
        x3 = [eP_v(a) eP_v(a) mid-sSize/2 mid-sSize/2 mid-nWidth/2 mid-nWidth/2 mid-sSize/2 mid-sSize/2 mid+sSize/2 mid+sSize/2 mid+nWidth/2 mid+nWidth/2 mid+sSize/2 mid+sSize/2 eP_v(a)+spacing_v eP_v(a)+spacing_v]...
            +[kerf kerf kerf kerf kerf kerf kerf kerf -kerf -kerf -kerf -kerf -kerf -kerf -kerf -kerf];
        y3 = [0 -t -t -t-gap1 -t-gap1 -t-gap1-nHeight -t-gap1-nHeight -t-gap1-gap2-nHeight -t-gap1-gap2-nHeight -t-gap1-nHeight -t-gap1-nHeight -t-gap1 -t-gap1 -t -t 0]...
            +[kerf kerf kerf -kerf -kerf kerf kerf kerf kerf kerf kerf -kerf -kerf kerf kerf kerf];
        plot(-y3+offset_x,-x3+offset_y,'k')
        plot(y3+offset_x+reflect_v,-x3+offset_y,'k')
        
        %writing to svg
        temp34 = horzcat(-y3+offset_x,-(-x3+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp34);

        temp34_a = horzcat(y3+offset_x+reflect_v,-(-x3+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp34_a);
        
    end
    
    a = a + 1;
end

%Box5
plot([0 t]+offset_x +[-kerf kerf],[kerf kerf]-t+offset_y,'k')
plot([reflect_v reflect_v-t]+offset_x -[-kerf kerf],[kerf kerf]-t+offset_y,'k')

plot([0 t]+offset_x +[-kerf kerf],[t t]-reflect_h+offset_y-kerf,'k')
plot([reflect_v reflect_v-t]+offset_x -[-kerf kerf],[t t]-reflect_h+offset_y-kerf,'k')

%writing to svg
temp35 = horzcat([0 t]+offset_x +[-kerf kerf],-([kerf kerf]-t+offset_y));
fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp35);

temp35_a = horzcat([reflect_v reflect_v-t]+offset_x -[-kerf kerf],-([kerf kerf]-t+offset_y));
fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp35_a);

temp35_b = horzcat([0 t]+offset_x +[-kerf kerf],-([t t]-reflect_h+offset_y-kerf));
fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp35_b);

temp35_c = horzcat([reflect_v reflect_v-t]+offset_x -[-kerf kerf],-([t t]-reflect_h+offset_y-kerf));
fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp35_c);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Box 6: h - el2, v - el3
offset_x = 11-el3;
offset_y = -11+el2+el2+2*kerf;
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
        x1 = [eP_h(a) eP_h(b)] - [-kerf kerf];
        y1 = [0 0] + kerf -t;

        plot(x1+offset_x,y1+offset_y,'k')
        plot(x1+offset_x,-y1-reflect_h+offset_y,'k')
        
        %writing to svg
        temp = horzcat(x1+offset_x,-(y1+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;" />\n', temp);
        
        temp_a = horzcat(x1+offset_x,-(-y1-reflect_h+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;" />\n', temp_a);
    elseif i == 2
        x2 = [eP_h(a) eP_h(a) eP_h(b) eP_h(b)] - [kerf kerf -kerf -kerf];
        y2 = -[0 -t -t 0] + kerf -t;
        plot(x2+offset_x,y2+offset_y,'k')
        plot(x2+offset_x,y2*-1-reflect_h+offset_y,'k')
        
        %writing to svg
        temp2 = horzcat(x2+offset_x,-(y2+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f" style="stroke:black;fill:none;stroke-width:.01;" />\n', temp2);
        
        temp2_a = horzcat(x2+offset_x,-(y2*-1-reflect_h+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f" style="stroke:black;fill:none;stroke-width:.01;" />\n', temp2_a);
    else
        mid2 = -eP_h(a)-spacing_h/2;
        x3h = [t 0 0 t t 0 0 t] - kerf +t;
        y3h = [-eP_h(a) -eP_h(a) mid2+sSize/2 mid2+sSize/2 mid2-sSize/2 mid2-sSize/2 -eP_h(a)-spacing_h -eP_h(a)-spacing_h]...
            + [kerf kerf -kerf -kerf kerf kerf -kerf -kerf];
        plot(-y3h+offset_x,-x3h+offset_y+t,'k');
        plot(-y3h+offset_x,x3h+offset_y-reflect_h-t,'k');
        
        %writing to svg
        temp31 = horzcat(-y3h+offset_x,-(-x3h+offset_y+t));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp31);

        temp31_a = horzcat(-y3h+offset_x,-(x3h+offset_y-reflect_h-t));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp31_a);
        
    end
    
    a = a + 1;
end

%Spaces Vertical Side
a = 1;
for i = v2
    %Box 6
    b = a + 1;
    if i == 0
        x1 = [eP_v(a) eP_v(b)] + [-kerf kerf];
        y1 = [0 0] - kerf;
        
        plot(y1+offset_x,-x1+offset_y,'k')
        plot(-y1+reflect_v+offset_x,-x1+offset_y,'k')
        
        %writing to svg
        temp4 = horzcat(y1+offset_x,-(-x1+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp4);
        
        temp4_a = horzcat(-y1+reflect_v+offset_x,-(-x1+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp4_a);
    elseif i == 2
        x2 = [eP_v(a) eP_v(a) eP_v(b) eP_v(b)] + [kerf kerf -kerf -kerf];
        y2 = -[0 -t -t 0] - kerf;

        plot(y2+offset_x,-x2+offset_y,'k')
        plot(-y2+reflect_v+offset_x,-x2+offset_y,'k')
        
        %writing to svg
        temp5 = horzcat(y2+t+offset_x,-(-x2+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none" />\n', temp5);
        
        temp5_a = horzcat(-y2+reflect_v+offset_x,-(-x2+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp5_a);
        
    else
        mid = eP_v(a)+spacing_v/2;
        x3 = [eP_v(a) eP_v(a) mid-sSize/2 mid-sSize/2 mid-nWidth/2 mid-nWidth/2 mid-sSize/2 mid-sSize/2 mid+sSize/2 mid+sSize/2 mid+nWidth/2 mid+nWidth/2 mid+sSize/2 mid+sSize/2 eP_v(a)+spacing_v eP_v(a)+spacing_v]...
            +[kerf kerf kerf kerf kerf kerf kerf kerf -kerf -kerf -kerf -kerf -kerf -kerf -kerf -kerf];
        y3 = [0 -t -t -t-gap1 -t-gap1 -t-gap1-nHeight -t-gap1-nHeight -t-gap1-gap2-nHeight -t-gap1-gap2-nHeight -t-gap1-nHeight -t-gap1-nHeight -t-gap1 -t-gap1 -t -t 0]...
            +[kerf kerf kerf -kerf -kerf kerf kerf kerf kerf kerf kerf -kerf -kerf kerf kerf kerf];
        plot(-y3+offset_x,-x3+offset_y,'k')
        plot(y3+offset_x+reflect_v,-x3+offset_y,'k')
        
        %writing to svg
        temp34 = horzcat(-y3+offset_x+t,-(-x3+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp34);

        temp34_a = horzcat(y3+offset_x+reflect_v-t,-(-x3+offset_y));
        fprintf(fid,'<path d="M%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp34_a);
        
    end
    
    a = a + 1;
end

%Box6
plot([0 t]+offset_x +[-kerf kerf],[kerf kerf]-t+offset_y,'k')
plot([reflect_v reflect_v-t]+offset_x -[-kerf kerf],[kerf kerf]-t+offset_y,'k')

plot([0 t]+offset_x +[-kerf kerf],[t t]-reflect_h+offset_y-kerf,'k')
plot([reflect_v reflect_v-t]+offset_x -[-kerf kerf],[t t]-reflect_h+offset_y-kerf,'k')

%writing to svg
temp42 = horzcat([0 t]+offset_x +[-kerf kerf],-([kerf kerf]-t+offset_y));
fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp42);

temp42_a = horzcat([reflect_v reflect_v-t]+offset_x -[-kerf kerf],-([kerf kerf]-t+offset_y));
fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp42_a);

temp42_b = horzcat([0 t]+offset_x +[-kerf kerf],-([t t]-reflect_h+offset_y-kerf));
fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp42_b);

temp42_c = horzcat([reflect_v reflect_v-t]+offset_x -[-kerf kerf],-([t t]-reflect_h+offset_y-kerf));
fprintf(fid,'<path d="M%f %f L%f %f" style="stroke:black;stroke-width:.01;fill:none;" />\n', temp42_c);

fprintf(fid,'</svg> \n');
fclose(fid);
end