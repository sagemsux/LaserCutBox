%calculate max no. of spacings and max no. of screws
function [sp,ns] = max_screws(el,sDia)
    sp = floor(el/sDia);
    if rem(sp,2)==0
        sp = sp - 1;
    end
    sp = sp - 1;
    ns = sp/2 - 1;
    sp = sp - 1;
end