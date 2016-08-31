function [ thetas ] = calculate_angles( points )
%Returns the angle between the normal of the boundary at the ith point and
%the x-axis where the angle is defined over 0 to 2pi counterclockwise
%points(i), thetas(i) 


[num_rows, num_columns]=size(points); 
x_axis=[1;0];  
thetas=[]; 
for i = 1 : num_columns
    
    if i == 1
        difference_vector=points(:,2)-points(:, end); 
        %theta=abs(acos(dot(x_axis, difference_vector)/(norm(difference_vector)*norm(x_axis)))); 
        theta = get_angle( difference_vector, x_axis ); 
        temp_theta = theta+pi/2; 
        
        if temp_theta>=2*pi
            temp_theta=temp_theta-2*pi; 
        end
        
        thetas(i)=temp_theta; 
        
       
        
        
        elseif i==num_columns
        difference_vector=points(:,1) - points(:, num_columns-1);
        theta = get_angle( difference_vector, x_axis ); 
        temp_theta=theta+pi/2; 
        
        if temp_theta>=2*pi
            temp_theta=temp_theta-2*pi; 
        end
        
        thetas(i)=temp_theta; 
       
       
         
        
        
        
    else
        difference_vector=points(:, i + 1)-points(:, i-1); 
        theta = get_angle( difference_vector, x_axis ); 
        temp_theta=theta+pi/2; 
        
        if temp_theta>=2*pi
            temp_theta=temp_theta-2*pi; 
        end
        
        thetas(i)=temp_theta; 
        
         
        
end


end


end

