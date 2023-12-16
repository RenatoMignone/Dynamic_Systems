clear
close all

% Parametri circuito RLC con carico R2
R1=1;
L=100e-3;
Cap=50e-6;
R2=10;

% Si suppone di partire da una rappresentazione nello spazio di stato
A=[-R1/L -1/L;1/Cap -1/(R2*Cap)];
B=[1/L; 0];
C=[0 1];
D=0;

% Condizione iniziale
x0=[0.1;4];
yl1=0;
yl2=0;

% Campionamento temporle
tfin=0.05;
t=0:tfin/1000:tfin;

%% Evoluzione libera
% Funzione di trasferimento "fittizia"
Gl=tf(ss(A,x0,C,0));
[rl,pl,kl]=residue(Gl.num{1},Gl.den{1});

% Caso di poli reali e distinti
yl1=rl(1)*exp(pl(1)*t);     % Primo modo
yl2=rl(2)*exp(pl(2)*t);     % Secondo modo
yl=yl1+yl2;



%% Evoluzione forzata
% Funzione di trasferimento
Gf=tf(ss(A,B,C,D));

% Trasformata di Laplace dell'ingresso
s = tf('s');  H = exp(-s)*(s+1)/(s^2+3*s+1)
U1=1/s;             % Gradino u1(t)=1(t)
U2=tf(1,[1 60]);     % Esponenziale u2(t)=exp(-40*t)
U=U1+U2;

Yf=Gf*U;
[rf,pf,kf]=residue(Yf.num{1},Yf.den{1});

% Caso di poli reali e distinti
yf1=rf(1)*exp(pf(1)*t);     % Primo modo
yf2=rf(2)*exp(pf(2)*t);     % Secondo modo
yf3=rf(3)*exp(pf(3)*t);     % Secondo modo
yf4=rf(4)*exp(pf(4)*t);     % Secondo modo
yf=yf1+yf2+yf3+yf4;


%% Altra tecnica per il calcolo dell'evoluzione forzata
u_ex2=exp(-45*t)+3*(t>=tfin/2);
y_ex2=lsim(Gf,u_ex2,t)';

%% Rappresentazioni grafiche
figure(10)
plot(t,yl1,'--r',t,yl2,'--g',t,yl,'k','LineWidth',2);
xlabel('[sec]');ylabel('yl');
title('Evoluzione libera: modi e risposta complessiva')
grid

figure(20)
plot(t,yf1,'--r',t,yf2,'--b',t,yf3,'--c',t,yf4,'--y',t,yf,'k','LineWidth',2);
xlabel('[sec]');ylabel('yf');
title('Evoluzione forzata: modi e risposta complessiva')
grid

figure(30)
plot(t,yf,'--r',t,yl,'--b',t,yl+yf,'k',t,1+exp(-40*t),'--k','LineWidth',2);
xlabel('[sec]');ylabel('y');
title('Risposta')
legend('Forzata','Libera','Complessiva','Ingresso')
grid

figure(40)
plot(t,y_ex2,'--r',t,yl,'--b',t,yl+y_ex2,'k',t,u_ex2,'--k','LineWidth',2);
xlabel('[sec]');ylabel('y');
title('Risposta a u=exp(-45*t)+3*1(t-tfin/2)')
legend('Forzata','Libera','Complessiva','Ingresso')
grid