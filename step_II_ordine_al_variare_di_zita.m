clear
close all

zita=0.1:0.2:1.5;
omegan=1;
tfin=40;
t=0:tfin/1000:tfin;

for i=1:length(zita)
    num=1; den=[1 2*zita(i)*omegan omegan^2];
    G{i}=tf(num,den);
    y(:,i)=step(G{i},t);
end

plot(t,y,'LineWidth',2);
xlabel('[sec]');ylabel('y');
title('Risposta al gradino sistema II ordine al variare di \zeta')
legend(num2str(zita'))
grid
