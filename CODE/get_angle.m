function [ theta ] = get_angle( difference_vector, x_axis )
%Returns the angle theta between the vector difference vector and x_axis
%   Detailed explanation goes here

theta=abs(acos(dot(x_axis, difference_vector)/(norm(difference_vector)*norm(x_axis)))); 


if difference_vector(2,1)>0
    theta=theta; 
else
    theta=2*pi-theta; 



end

