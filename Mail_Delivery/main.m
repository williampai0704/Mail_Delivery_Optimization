clc; clear all; close all;
n = 100;
A = [-1,0,1,0,0;0,-1,0,1,0];
b = [0;0];
nvars = 5;
lb = [-0.1,-0.017,-0.1,-0.017,-10];
ub = [-1e-6,-1e-6,-1e-6,-1e-6,-1e-6];
x0 = [-1e-6,-1e-6,-0.1,-0.017,-1e-6];
Aeq = [0,0,0,0,1];
p1y = linspace(-0.015,-1e-6,5);

for i = 1:length(p1y)
    beq = [p1y(i)];
    [p(i,:),fval(i)] = fmincon(@(p)objective_Deflection(p),x0,A,b,Aeq,beq,lb,ub,[]);
end

for i = 1:length(p1y)
    p2x(i) = p(i,1);
    p2y(i) = p(i,2);
    p3x(i) = p(i,3);
    p3y(i) = p(i,4);
    p1y(i) = p(i,5);
end
p1x = 0;
p4x = -0.1; 
p4y = -0.017;
n = 100;
figure(1)
for i = 1:length(p1y)
    [b_x, b_y,theta_m(i,:)] = bezier(p1x,p1y(i),p2x(i),p2y(i),p3x(i),p3y(i),p4x,p4y,n);
    plot(b_x, b_y);hold on;
end
xlim([-0.1,0]);
ylim([-0.02,0]);
title('Mail delivery path (N = 5)');
xlabel('x(m)');ylabel('y(m)');
legend(['p1y = ',num2str(p1y(1,1)),'($\epsilon$ = ',num2str(fval(1,1)),')'],...
       ['p1y = ',num2str(p1y(1,2)),'($\epsilon$ = ',num2str(fval(1,2)),')'],...
       ['p1y = ',num2str(p1y(1,3)),'($\epsilon$ = ',num2str(fval(1,3)),')'],...
       ['p1y = ',num2str(p1y(1,4)),'($\epsilon$ = ',num2str(fval(1,4)),')'],...
       ['p1y = ',num2str(p1y(1,5)),'($\epsilon$ = ',num2str(fval(1,5)),')'], ...
       'interpreter','latex','fontsize',12,'location','northwest')
hold off;
% figure(2)
% for i = 1:length(p1y)
%     plot((theta_m(i,:)/pi)*180);hold on;
% end
% hold off