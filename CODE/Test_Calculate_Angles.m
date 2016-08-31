%Test calculate angles

%{
points=[1 cos(pi/3) cos(2*pi/3) -1 ,  cos(4*pi/3) ,  cos(5*pi/3) ; 
        0, sin(pi/3)   sin(2*pi/3)  0 ,  sin(4*pi/3) , sin(5*pi/3)]; 
%}
    
points=[-1  cos(2*pi/3) cos(pi/3) 1 cos(5*pi/3) cos(4*pi/3) ; 
         0  sin(2*pi/3) sin(pi/3) 0 sin(5*pi/3) sin(4*pi/3)] ; 
         
         
    plot(points(1, : ) , points(2 , :)); 
    
    
    [ angles_of_normal ] = calculate_angles( points ); 
    
    [num_rows, num_columns]=size(angles_of_normal); 
   
        
    
    display(angles_of_normal); 
    
    