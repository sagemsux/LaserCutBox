while true %to get sides
    l1_cond = false;
    while l1_cond == false
        prompt = 'Input 1st edge length (in inches) of the desired box (Smallest size is 1.5 inches):';
        l1 = input(prompt);
        if isnumeric(l1)==0
            display('Please enter a number')
        end
        if isscalar(l1)==0
            display('Please enter a scalar quantity')
        end
        if isreal(l1)==0
            display('No complex numbers!')
        end
        if l1<3/2
            display('Size too small... Will cause interference between screws')
        end
        if isnumeric(l1)==1 && isscalar(l1)==1 && isreal(l1)==1 && l1>=3/2
             l1_cond = true;    
        end
    end
    l2_cond = false;
    while l2_cond == false
        prompt = 'Input 2nd edge length (in inches) of the desired box (Smallest size is 1.5 inches):';
        l2 = input(prompt);
        if isnumeric(l2)==0
            display('Please enter a number')
        end
        if isscalar(l2)==0
            display('Please enter a scalar quantity')
        end
        if isreal(l2)==0
            display('No complex numbers!')
        end
        if l2<3/2
            display('Size too small... Will cause interference between screws')
        end
        if isnumeric(l2)==1 && isscalar(l2)==1 && isreal(l2)==1 && l2>=3/2
             l2_cond = true;
        end
    end
    l3_cond = false;
    while l3_cond == false
        prompt = 'Input 3rd edge length (in inches) of the desired box (Smallest size is 1.5 inches):';
        l3 = input(prompt);
        if isnumeric(l3)==0
            display('Please enter a number')
        end
        if isscalar(l3)==0
            display('Please enter a scalar quantity')
        end
        if isreal(l3)==0
            display('No complex numbers!')
        end
        if l3<3/2
            display('Size too small... Will cause interference between screws')
        end
        if isnumeric(l3)==1 && isscalar(l3)==1 && isreal(l3)==1 && l3>=3/2
             l3_cond = true;
        end
    end
    if l1_cond == true && l2_cond == true && l3_cond == true
        el = [l1 l2 l3];
        el = sort(el,'descend');
        el1 = el(1);
        el2 = el(2);
        el3 = el(3);
    end
    if el1+el2<=11
        break;
    else
        clc
        display('The box cannot be made with two acrylic sheets. Please try a fresh set of dimensions')
    end
end

%getting screw size
s1_cond = false;
while s1_cond == false
    prompt = 'Input Screw Size (4/6):';
    s1 = input(prompt);
    if s1 == 4 || s1 == 6
         s1_cond = true;
         if s1 == 4
            sDia = 0.2130;
            sShaftDia = 0.112;
         else
            sDia = 0.2620;
            sShaftDia = 0.138;
         end
    else
        clc
        display('Invalid Input, try again.');
    end
end

%getting screw length
s2_cond = false;
while s2_cond == false
    prompt = 'Input Screw Length in inches(0.25/0.375/0.5/0.675):';
    s2 = input(prompt);
    if s2 == 0.25 || s2 == 0.375 || s2 == 0.5 || s2 == 0.675
         s2_cond = true;
         sLength = s2;
    else
        clc
        display('Invalid Input, try again.');
    end
end

%material thickness
t_cond = false;
while t_cond == false
    prompt = 'Input Material Thickness in inches(0.125/0.1875/0.25):';
    t = input(prompt);
    if sLength > 0.25 && (t == 0.125 || t == 0.1875 || t == 0.25)
        t_cond = true;
    elseif sLength == 0.25 && t == 0.125
        t_cond = true;
    elseif sLength == 0.25 && t > 0.125
        clc
        display('Material too thick for selected length of screw');
    else
        clc
        display('Invalid Input, try again.');
    end
end

%number of screws
ns_cond = false;
while ns_cond == false
    ns1_cond = false;
    while ns1_cond == false
        [sp1,ns1] = max_screws(el1,sDia);
        fprintf('\n Max no. of screws possible for edge of length %f is %d \n',el1,ns1);
        prompt = 'Enter no. of screws on edges of this length:';
        n1 = input(prompt);
        if isscalar(n1) == 1 && n1 <= ns1
            ns1_cond = true;
        else
            fprintf('\n Invalid input. Please enter an integer that is less than %d \n',ns1);
        end
    end
        
    
    ns2_cond = false;
    while ns2_cond == false
        [sp2,ns2] = max_screws(el2,sDia);
        fprintf('\n Max no. of screws possible for edge of length %f is %d \n',el2,ns2);
        prompt = 'Enter no. of screws on edges of this length:';
        n2 = input(prompt);
        if isscalar(n2) == 1 && n2 <= ns2
            ns2_cond = true;
        else
            fprintf('\n Invalid input. Please enter an integer that is less than %d \n',ns2);
        end
    end
        
    ns3_cond = false;
    while ns3_cond == false
        [sp3,ns3] = max_screws(el3,sDia);
        fprintf('\n Max no. of screws possible for edge of length %f is %d\n',el3,ns3);
        prompt = 'Enter no. of screws on edges of this length:';
        n3 = input(prompt);
        if isscalar(n3) == 1 && n3 <= ns3
            ns3_cond = true;
        else
            fprintf('\n Invalid input. Please enter an integer that is less than %d \n',ns3);
        end
    end
    
    if ns1_cond == true && ns2_cond == true && ns3_cond == true
        break;
    end
end

%re-calculating spacings based on no. of screws
sp_cond = [xor(rem(ns1,2),rem(n1,2)) xor(rem(ns2,2),rem(n2,2)) xor(rem(ns3,2),rem(n3,2))];

if sp_cond(1) == 1 && rem(ns1,2) == 0
    sp1 = sp1 - 2;
end
if sp_cond(2) == 1 && rem(ns2,2) == 0
    sp2 = sp2 - 2;
end
if sp_cond(3) == 1 && rem(ns3,2) == 0
    sp3 = sp3 - 2;
end

%calculating Nut Dimensions
if sShaftDia == 0.112
    nutHeight = 3/32;
    nutWidth = 1/4;
else
    nutHeight = 7/64;
    nutWidth = 5/16;
end

%drawing based on whether one or two sheets are required
if el1+el2+el3 > 11
    DrawPattern2(el1,el2,el3,sp1,sp2,sp3,n1,n2,n3,t,sShaftDia,sLength,nutWidth,nutHeight)
else
    DrawPattern(el1,el2,el3,sp1,sp2,sp3,n1,n2,n3,t,sShaftDia,sLength,nutWidth,nutHeight)
end