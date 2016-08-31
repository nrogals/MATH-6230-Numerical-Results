function [ deriv_function ] = get_derivative_handle(fun1)
%The function returns a handle representign the derivative of the handle
%fun1
delta=0.0000001; 
deriv_function = @(x)( (fun1(x+delta) - fun1(x))/delta); 

end

