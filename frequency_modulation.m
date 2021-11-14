% INTRODUCTION INTO FREQUENCY MODULATION
clear; clc; close all;

%% I. Variable
fs = 10000;     % sampling frequency       
t = 0:1/fs:1;   % time
N = fs;  

% configurable input parameters
vm = 2;         % message signal amplitude
vc = 2;         % carrier signal amplitude
fm = 10;        % message signal frequency
fc = 100;       % carrier signal frequency
kf = 10;        % sensitivity constant 

% visualization settings
msg_mod = 1;    % set to 0: just plot the modulated signal
                % set to 1: plot modulated & message together (overlap)
                
%% II. Message signal generation
% message signal
vmt = vm*cos(2*pi*fm*t);  

% plotting message signal
figure(1);
subplot(3,1,1);
plot(t,vmt);
x0=10; y0=10; width=1000; height=400;
set(gcf,'position',[x0,y0,width,height]);
title('message signal');
xlabel('time (s)');
ylabel('amplitude');

%% III. Carrier signal generation
% carrier signal
vct = vc*cos(2*pi*fc*t);

% plotting carrier signal
subplot(3,1,2);
plot(t,vct);
title('carrier signal');
xlabel('time (s)');
ylabel('amplitude');
            
%% IV. Frequency deviation, modulation index and bandwidth
dfc = kf*vm;        % frequency deviation
beta = dfc/fm;      % modulation index
bw = 2*(dfc+fm);    % bandwidth (carson rule)

% printing resulting parameters
fprintf('frequency deviation :   %d \n', dfc);
fprintf('modulation index    :   %d \n', beta);
fprintf('bandwidth (carson)  :   %d \n\n', bw);

%% V. FM modulated signal
vst = vc*cos(2*pi*fc*t+beta*sin(2*pi*fm*t));

% plotting FM modulated signal
subplot(3,1,3);
plot(t,vst);
if msg_mod == 1
    hold on;
    plot(t,vmt,'--r');
    hold off;
    legend('FM signal','message signal');
end
title('FM modulated signal');
xlabel('time (s)');
ylabel('amplitude');

%% VI. Spectrum of FM signal
z = fftshift(fft(vst))/N;
f = (-N/2:N/2-1)*(fs/N);

% plotting spectrum of FM signal
figure(2)
plot(f,abs(z(1,1:length(z)-1)));
x0=10; y0=10; width=1000; height=400;
set(gcf,'position',[x0,y0,width,height]);
title('spectrum of modulated signal');
xlabel('frequency (Hz)');
ylabel('normalized amplitude');
xlim([-2*fc 2*fc]);
xticks([-2*fc:20:2*fc]);
grid on;