function z = snowflake(center, r, n,a)
%   Koch Snowflake Curve
%   The snowflake created has width 1.0 units and height 1.2 units
%
%   % Examples
%   plot(snowflake(10)), axis equal

% Default n, shape of snowflake
n = 10;

if nargin < 1, n = 0; end
if nargin < 4, a = 1/2 + sqrt(-3)/6; end

% Constants
b = 1 - a;
c = 1/2 + sqrt(-3)/2;
d = 1 - c;

% Generate point sequence
z = 1;
for k = 1:n
    z = conj(z);
    z = [a*z; b*z+a];
end

% Generate snowflake
z = [0; z; 1-c*z; 1-c-d*z];
z_real = real(z);
z_img = imag(z);

% Generating multiple layers of snowflake
for x = 1:ceil(r)
    if x == 1
        z = r*[z_real z_img]/1.2;
        z(:,1) = z(:,1) + center(1);
        z(:,2) = z(:,2) + center(2);
    else
        z(:,:,x) = 0.5*z(:,:,x-1);
    end
end