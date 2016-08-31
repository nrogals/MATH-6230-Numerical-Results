%The following script is for Math 6230: Differential Games and Optimal
%Control. The script solves the first numerical problem. The problem is
%implement the Marker/Particle Method in a programming enviorment of your
%choice. Use it to advance (A) the curve y=sin(x) moving upwards with F=1 ;
%(B) a unit circle expanding with F(x,n)=F(x,theta)=( (2-sin(2*theta))/3 )
%^0.5 and (C) a unit circle expanding with
%F(x,n)=F(x,theta)=1.5+cos(4*theta). Experiemnt with differnt M and delta t
%to check convergence

%There will be two functions given as input to the program the first
%function specifies the shape of the TAU_0 in the upper half of the plane
%and the second function specifies the shape of TAU_0 in the lower half o
%the plane. They are defined so that their first zeros touch the x-axis and
%define the ending of the plane. 




closed_shape_indicator=0; 
%1 indicates that the shape TAU_0 is closed. 0 indicates that the shape
%TAU_0 is not closed. 
top_half=@(x)((1-x^2)^0.5);
%Represents the function of the top half of TAU_0
bottom_half=@(x)(-1*((1-x^2))^0.5);
%Represents the function of the bottom half of TAU_0
F=@(x)@(theta)1; 
%Represents the speed function 

%(1.5+cos(4*theta)); 
tolerance = 0.00000001; 
%Represents the tolerance of the derivative
M=200; 
%Represents the number of markers on the boudary of the shape
zeros=[-1, 1]; 
delta_t=0.001;
%The small ammount of time during which the boundary is advanced
number_of_simulated_steps=1000; 
%Number of steps taken. 
number_iterates = 10000;
%The number of steps the x-interval is divided into to calculate the
%accumulated arc length function. 



derivative_top_half=get_derivative_handle(top_half); 


derivative_bottom_half=get_derivative_handle(bottom_half); 




non_closed_shape=@(x)(sin(x)); 
non_closed_shape_derivative=get_derivative_handle(non_closed_shape); 
wave_front_x_endpoints=[-3.14, 3.14]; 
assert (wave_front_x_endpoints(1)<wave_front_x_endpoints(2)); 
%Indicator 0 if not closed shape 1 if closed shape. 
%Number of endpoints


check_epsilon=0.001; 


points=[]; 

if (closed_shape_indicator==1) 
    %Acquire endpoints 
    left_zero=zeros(1); 
    display(left_zero); 
    right_zero=zeros(2); 
    assert(top_half(left_zero)==0);
    assert (top_half(right_zero)==0);
    assert(top_half(left_zero+check_epsilon)>0);
    assert(top_half(right_zero-check_epsilon)>0); 
    assert(bottom_half(left_zero)==0);
    assert(bottom_half(right_zero)==0);
    assert(bottom_half(left_zero+check_epsilon)<0);
    assert(bottom_half(right_zero-check_epsilon)<0); 
    
    
    
    
    length_of_interval=abs(left_zero-right_zero); 
    x_step=length_of_interval / number_iterates; 
    
    cumulative_arc_length_top=0; 
    starting_x=left_zero; 
    cumulative_arc_length_list_top=[]; 
    arc_lengths_top=[]; 
    x_interval_partitions_top=[]; 
    for i = 1 : number_iterates 
        ending_x=starting_x+x_step; 
        %display(starting_x); 
        %display(ending_x); 
        integrand_top = @(x)sqrt(1+(derivative_top_half(x))^2); 
        arc_length=integral(integrand_top, starting_x, ending_x, 'ArrayValued', true); 
        %display(arc_length);
        cumulative_arc_length_list_top(i)=cumulative_arc_length_top+arc_length; 
        arc_lengths_top(i)=arc_length; 
        cumulative_arc_length_top=cumulative_arc_length_top+arc_length; 
        x_interval_partitions_top(i)=(ending_x+starting_x)/2; 
        starting_x=starting_x+x_step; 
    end
   
    
   
    
    cumulative_arc_length_bottom=0; 
    starting_x=right_zero-x_step; 
    cumulative_arc_length_list_bottom=[]; 
    arc_lengths_bottom=[]; 
    x_interval_partitions_bottom=[]; 
    for i = 1 : number_iterates 
        ending_x=starting_x+x_step; 
        
        integrand_bottom = @(x)(sqrt(1+(derivative_bottom_half(x))^2)); 
        arc_length=integral(integrand_bottom, starting_x, ending_x, 'ArrayValued', true); 
        cumulative_arc_length_list_bottom(i)=cumulative_arc_length_bottom+arc_length; 
        arc_lengths_bottom(i)=arc_length; 
        cumulative_arc_length_bottom=cumulative_arc_length_bottom+arc_length; 
        x_interval_partitions_bottom(i)=(ending_x+starting_x)/2;
        starting_x=starting_x-x_step; 
    end
    
    
    %{
    display(cumulative_arc_length_list_top);
    display(cumulative_arc_length_list_bottom); 
    display(arc_lengths_bottom); 
    display(arc_lengths_top); 
    
    assert (1<0); 
    
    %}
    
    
    
    total_arc_length=cumulative_arc_length_top+cumulative_arc_length_bottom; 
    arc_step=total_arc_length/M; 
    
    space_elements=linspace(0,total_arc_length,M); 
    
    
    
    
    index_last_top=real(floor(cumulative_arc_length_top/arc_step)); 
    
    %extra_length=cumulative_arc_length_top-space_elements(index_last_top); 
    
    
    %IMPORTANT PARAMETER, needs to be large enough to terminate. Would be
    %helpful if there are a lot of arc length points. So increase that
    %pareamter, to ensure while loop terminates for each point. 
    
    
    display(index_last_top); 
    
    
    epsilon=0.01; 
    
    top_points=[]; 
    start=1; 
    for i = 1 : index_last_top
        %iterates through points to be placed
        point_not_found=true; 
        
        point_arc_length=space_elements(i); 
        while point_not_found 
            if abs(cumulative_arc_length_list_top(start)>point_arc_length) 
                x=x_interval_partitions_top(start); 
                y=top_half(x); 
                top_points=[top_points [x ; y] ]; 
                start=start+1; 
                point_not_found=false; 
            else
                start=start+1; 
            end
        end
    end
    
    
    
    
    
    %extra_length
    
    bottom_points=[]; 
    start=1; 
    for i = 1 : M-index_last_top-1
        display(index_last_top); 
        point_arc_length=space_elements(index_last_top+i); 
        point_not_found=true; 
        
        while point_not_found 
            if (abs(cumulative_arc_length_list_bottom(start)+cumulative_arc_length_top>(point_arc_length)))
                x=x_interval_partitions_bottom(start); 
                y=bottom_half(x); 
                
                bottom_points=[bottom_points [x ; y] ]; 
                start=start+1; 
                point_not_found=false; 
            else
                start=start+1; 
            end
        end
        
    end
    
   display(top_points); 
   display(bottom_points); 
   scatter(top_points(1, :), top_points(2, :)); hold on ; 
   scatter(bottom_points(1, :), bottom_points(2, :));
   
   
   points=[top_points, bottom_points]; 
   
   
else
    
    
    left_zero=wave_front_x_endpoints(1); 
    right_zero=wave_front_x_endpoints(2); 
    
    
    number_iterates = 100; 
    length_of_interval=abs(left_zero-right_zero); 
    x_step=length_of_interval /number_iterates; 
    
    cumulative_arc_length_top=0; 
    starting_x=left_zero; 
    cumulative_arc_length_list_top=[]; 
    arc_lengths_top=[]; 
    x_interval_partitions_top=[]; 
    
    derivative_top_half=non_closed_shape_derivative; 
    
    
    for i = 1 : number_iterates 
        ending_x=starting_x+x_step; 
        %display(starting_x); 
        %display(ending_x); 
        integrand_top = @(x)sqrt(1+(derivative_top_half(x))^2); 
        arc_length=integral(integrand_top, starting_x, ending_x, 'ArrayValued', true); 
        %display(arc_length);
        cumulative_arc_length_list_top(i)=cumulative_arc_length_top+arc_length; 
        arc_lengths_top(i)=arc_length; 
        cumulative_arc_length_top=cumulative_arc_length_top+arc_length; 
        x_interval_partitions_top(i)=(ending_x+starting_x)/2; 
        starting_x=starting_x+x_step; 
    end
    
    
    
    
    total_arc_length=cumulative_arc_length_top; 
    
    space_elements=linspace(0,total_arc_length,M); 
   
    
    
    
    
    
    
    
    top_points=[]; 
    start=1; 
    for i = 1 : M-1
        %iterates through points to be placed
        point_not_found=true; 
        
        point_arc_length=space_elements(i); 
        while point_not_found 
            try
                if (cumulative_arc_length_list_top(start)>point_arc_length)
                    x=x_interval_partitions_top(start); 
                    y=non_closed_shape(x); 
                    top_points=[top_points [x ; y] ]; 
                    start=start+1; 
                    point_not_found=false; 
                else
                    start=start+1; 
                end
            catch 
                r=2; 
                
            end
        end
    end
    
    points=top_points;
    scatter(points(1, :), points(2, :));
    %scatter(x_interval_partitions_top, cumulative_arc_length_list_top);
   
end


display(points); 

[num_rows, num_columns]=size(points); 

for i = 1 : number_of_simulated_steps
    [ angles_of_normal ] = calculate_angles( points ); 
    for i = 1 : num_columns
        angle_point_x_axis=angles_of_normal(i); 
        unit_normal=[cos(angle_point_x_axis); sin(angle_point_x_axis)]; 
        point=points(:, i); 
        speed_handle=F(point); 
        speed=speed_handle(angle_point_x_axis); 
        updated_point=point+speed*unit_normal*delta_t; 
        points(:, i)=updated_point;
    end
    
    scatter(points(1, :), points(2, :)); hold on 
    
    
end




