% INSTRUCTIONS!!!!
% Enter the data you want below.
% This program determines whether or not your cam leaves contact.
% If it does, you will have prompts in command window. 
% Heed them and enter whatever that is asked.
%%
w = 500;   %Angular velocity of cam in RPMs 
p = 2.5;   %preload in newtons.
e = 0.015; %Eccentricity between cg and centre of rotation in metres.
m = 0.9;   %Mass of follower in kg.
k = 1000;  %Spring constant in N/m.  
%Question data till here.
%%
w = w*2*pi/60;
h = 0.01;
x = 0:h:2*pi;    %Theta in radians
T = e*(p+k*e)*sin(x) + (m*w^2-k)*e^2*0.5*sin(x); 
% Torque due to contact force
plot(x,T)
Fcf = p+k*e + (m*w^2-k)*e*cos(x);
plot(x,Fcf)
grid on
if w>((p+2*k*e)/(m*e))^0.5
    A=input('From the Fcr figure get approximate values of theta from the vicinity of roots such that the slope does not become zero in between.Enter ok\n','s');
    B=input('The cam is losing contact and you need to know when it will regain it.Enter ok\n','s');
    x0 = input('Input value closer to the initial root\n');
    D = -(m*w^2-k)*e*w*sin(x0);
    X(1)=0;
    X(2)=x0;
    n=2;
    while abs(X(n)-X(n-1))>0.0000001
    X(n+1)=X(n)-f(X(n),p,k,e,m,w)/D;
    D = -(m*w^2-k)*e*w*sin(X(n+1));
    n=n+1;    
    end
    firstRoot=X(n);  firstRoot = 180*firstRoot/pi; %To degrees
     x0 = input('Input value closer to the second root\n');
    D = -(m*w^2-k)*e*w*sin(x0);
    X(1)=0;
    X(2)=x0;
    n=2;
    while abs(X(n)-X(n-1))>0.0000001
    X(n+1)=X(n)-f(X(n),p,k,e,m,w)/D;
    D = -(m*w^2-k)*e*w*sin(X(n+1));
    n=n+1;    
    end
   secondRoot=X(n);   secondRoot=180*secondRoot/pi;
   fprintf('The cam loses contact at %f degrees and regains it at %f degrees',firstRoot,secondRoot);
else 
    disp('The cam does not lose contact.');
end
% Newton-Rhapson method of numerically solving equations.
%%
function X = f(x,p,k,e,m,w)
X = p+k*e + (m*w^2-k)*e*cos(x);
end