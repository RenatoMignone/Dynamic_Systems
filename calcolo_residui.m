clear 
close all

num=[1 -2 -3];
den=[1 0.5 6 0.7 1];
[r,p,k]=residue(num,den);

instabile=(sum(real(p)>0)>=1)
% Calcolo del minimo e massimo 
% costanti di tempo e periodi dei modi naturali 
min_cost_tempo=min(-1./real(p));
max_cost_tempo=max(-1./real(p));
max_omega=max(imag(p));
min_omega=abs(min(imag(p)));
min_periodo=2*pi/max_omega;
max_periodo=2*pi/min_omega;

passo=min(min_cost_tempo,min_periodo)/30;
t_finale=10*max(max_cost_tempo,max_periodo);


tempo=0:passo:t_finale;
x=0;

for i=1:length(p)
    x=x+r(i)*exp(p(i)*tempo);
end

figure(2)
plot(tempo,x,'LineWidth',3), grid
xlabel('[sec]'),ylabel('[V]');
axis([0, max(tempo), min(x)-0.1, max(x+0.1)])