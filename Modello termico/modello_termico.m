clear
close all

R1=1;
R2=10;
Cr=0.1;
Cs=100;

% Variabili di stato: temperatura radiatore
% e temperatura stanza
% Ingressi: flusso termico radiatore e temperatura ambiente
% Uscite: temperatura stanza

% Prima equazione dinamica
A(1,1)=-1/(R1*Cr);
A(1,2)=-A(1,1);
B(1,1)=1/Cr;
B(1,2)=0;

% Seconda equazione dinamica
A(2,1)=1/(R1*Cs);
A(2,2)=-1/Cs*(1/R1+1/R2);
B(2,1)=0;
B(2,2)=1/(R2*Cs);

% Equazione di uscita
C=[0 1];
D=0;

% Modello nello spazio di stato
MT=ss(A,B,C,D);
G=tf(MT);
num2=G(2).Numerator{1};
den2=G(2).Denominator{1};

G2=tf(num2,den2);

poli=pole(G2);
zeri=zero(G2);