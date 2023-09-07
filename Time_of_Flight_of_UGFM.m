
clc
clear all
close all


T = 8E-3; % Pulse width (s)
Fs = 192E+3; % Sampling rate (Hz)
f0 = 1E+3; % Initial and final pulse frequency (Hz)
f1 = 5E+3;
t = (0:1/Fs:T)'; % Time vector
yc = chirp(t,f0,t(end),f1);
w = hanning(numel(t));
y = yc.*w;


% Plot the signal
figure
subplot(3,1,1)
plot(t,y) 
grid on
xlabel("Time (s)")
title("Echo Pulse")
subplot(3,1,2)
ysq = (y.^2);
title("Energy of Pulse")
plot(t,ysq,'--')
hold on
[up,lo] = envelope(ysq,1,'peak');
plot(t,up)
legend('Energy','envelope')


n = length(ysq)
rate = zeros(1,n);
rate1 = zeros(1,n);

for l = 4:n
    k = l-3;
    rate(l) = ysq(l)/ysq(k);
    rate1(l) = up(l)/up(k);
end

[up1,lo1] = envelope(rate,1,'peak');


subplot(3,1,3)
plot(t,rate1)
title('Rate of change of energy')
hold on
plot(t,up1,'--')

figure
u = up1*(0.407547785*10^(-29));
plot(t,u)
hold on
plot(t,y,'-')

figure
plot(t,u)
hold on
plot(t,ysq)
legend('envelope of rate of change','Energy')

max(u)
i = find(max(u) == u)
ysq(i)
disp('Time at with feature point is obtained');
time = i*(8*10^-3)/1537

