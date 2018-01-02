%1
[soundDada,sampleRate] = audioread('xtichy26.wav');
sampleCount=length(soundDada);
time=sampleCount/sampleRate;
%2
FourierTransformationOriginal = fft(soundDada); 
vector = (0:sampleCount-1)*sampleRate/sampleCount; 
moduleOriginal = abs(FourierTransformationOriginal);
plot(vector(1:sampleCount/2), moduleOriginal(1:sampleCount/2));
xlabel('f [Hz]');
ylabel('H [z]');
%3
[maxModuleOriginal, maxIndexOriginal] = max(sym(moduleOriginal));
maxOriginalHertz = vector(maxIndexOriginal);

%4
a = [1 0.2289 0.4662];
b = [0.2324 -0.4112 0.2324];
zplane(b,a);

%5
freq=(0:sampleCount-1) / sampleCount * sampleRate / 2;
H = freqz(b,a,sampleCount); 

plot(freq, abs(H));
grid;
xlabel('f [Hz]');
ylabel('H [z]');

%6
filtered=filter(b,a,soundDada);
fourierTransformationFiltered=fft(filtered);
moduleFiltered=abs(fourierTransformationFiltered);

grid;
plot(vector(1:sampleCount/2), moduleFiltered(1:sampleCount/2));
xlabel('f [Hz]');
ylabel('H [z]');
%7
[maxModuleFiltered, maxIndexFiltered] = max(sym(moduleFiltered));
maxFilteredHertz = vector(maxIndexFiltered);

%8 TODO

%9
[Rv, lag] = xcorr(soundDada, 'biased');
plot(lag, Rv);
xlim([-50 50]);

%10
Rv10 = Rv(10 + sampleCount);

%11
x = linspace(min(soundDada), max(soundDada), 100);
[h,p,r] = hist2opt(soundDada(1:sampleCount-10), soundDada(11:sampleCount), x);
imagesc(-x,x,p);
axis xy;
colorbar;

%12 viz vystup hist2opt - 2d integral should be 1 and is 1

%13 viz vystup hist2opt -0.0230
disp(r);