%Test_Get_derivative. Provides tests for get_derivative

%{
fun=@(x)(1-x^2); 

derivative = get_derivative_handle(fun); 

f_prime_2=derivative(2);

display(f_prime_2); 

integrand_top = @(x)(1+(derivative(x))^2);

starting_x=0.2; 
ending_x=0.3; 


delta=0.0000001; 
deriv_function = @(x)( (fun1(x+delta) - fun1(x))/delta); 


starting_x=0.2; 
ending_x=0.3; 
integrand_top= @(x) x^2; 

arc_length=integral(integrand_top, starting_x, ending_x, 'ArrayValued', true); 

%}



integrand_top = @(x)sqrt(1+(derivative_top_half(x))^2); 
arc_length=integral(integrand_top, starting_x, ending_x, 'ArrayValued', true);
