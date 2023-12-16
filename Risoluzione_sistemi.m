%Metodologia di risoluzione di un sistema in Matlab

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%definizione variabile complessa
syms s;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%definizione del numeratore
num = [1 1];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%definizione del denominatore come vettore
%den = [1 0 1];
den = [1 2 2 0];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%definizione lasso di tempo
tfin=20; %tempo finale
t=0:tfin/1000:tfin; % da t = 0, procedendo di tfin/1000 fino a 40

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%definizione funzione di trasferimento con funzione tf
FDT = tf(num,den);
%definizione funzione di trasferimento con la variabile complessa
FDT2 = (s+1)/(s^3+2*s^2+2*s);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%definisco il numero di righe e di colonne per la griglia del subplot per
%costruire un grafico con più grafici
righe = 1;colonne =6;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%calcolo dell'antitrasformata di laplace di una funzione di trasferimento
%con la funzione ilaplace, scritta con variabile complessa
antitrasformata = ilaplace(FDT2);
antitrasformata

risultato_tempo = double(subs(antitrasformata, t));

% Creazione del grafico
figure;

% Grafico dell'antitrasformata nel tempo
subplot(righe, colonne, 5);
plot(t, risultato_tempo, 'LineWidth', 2);
title('Antitrasformata nel tempo');
xlabel('Tempo');
ylabel('Amplitude');
grid on;

% Grafico della risposta impulsiva
subplot(righe, colonne, 6);
impulse(FDT); % Grafico della risposta impulsiva
title('Risposta impulsiva');
grid on;

% antitrasformata_fun = matlabFunction(antitrasformata);
% 
% % Evaluate the function numerically
% response = antitrasformata_fun(t);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% subplot(righe,colonne,5);
% plot(t,response,'LineWidth',2);
% xlabel('tempo');ylabel('risposta');
% title('Risposta del sistema al gradino')
% grid on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%calcolo della risposta al gradino (unitario) del mio sistema 
risposta_gradino=step(FDT,t);
risposta_gradino;

%rappresentazione grafica della risposta al gradino del mio sistema
subplot(righe,colonne,1);
plot(t,risposta_gradino,'LineWidth',2);
xlabel('tempo');ylabel('risposta');
title('Risposta del sistema al gradino')
grid on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%calcolo della risposta ad una rampa del sistema
risposta_rampa = lsim(FDT, t, t);

%rappresentazione grafica della risposta ad una rampa del sistema
subplot(righe,colonne,2);
plot(t,risposta_rampa,'LineWidth', 2);
xlabel('tempo');
ylabel('risposta');
title('Risposta del sistema ad una rampa');
grid on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%data la mia FDT, calcolo di residui poli e costanti
[residui,poli,costanti] =residue(num,den);
residui

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%rappresentazione della risposta in frequenza del mio sistema con i
%diagrammi di bode
subplot(righe,colonne,3);
diabramma_bode = bodeplot(FDT);
grid on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%segno l'antitrasformata di laplace sul grafico
annotation('textbox', [0, 0.6, 0.4, 0.4], 'String',...
    ['Antitrasformata: ' char(antitrasformata)], 'FitBoxToText', 'on');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
segnale1 = t;
segnale2 = -t.*(t>=5);
segnale_tot = segnale1 + segnale2;

risposta_saturazione = lsim(FDT,segnale_tot,t);
subplot(righe,colonne,4);
plot(t,risposta_saturazione,"LineWidth",2);
grid on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
