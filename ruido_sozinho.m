% Carregar o áudio ruidoso
[ruido, fs] = audioread('ruido.wav'); 

% Selecionar apenas 1 segundo do áudio a partir de 0,1s
duracao_segundos = 1;
amostras = fs * duracao_segundos;
ruido = ruido(fs*0.1+1:fs*0.1+amostras); 

% Aplicar filtro de médias móveis com janela de tamanho 3
janela3 = ones(3,1) / 3;
sinal_filtrado_3 = filter(janela3, 1, ruido);

% Aplicar filtro de médias móveis com janela de tamanho 5
janela5 = ones(5,1) / 5;
sinal_filtrado_5 = filter(janela5, 1, ruido);

% Aplicar filtro de mediana móvel
sinal_mediana_3 = movmedian(ruido, 3);
sinal_mediana_5 = movmedian(ruido, 5);

% Implementando a moda móvel manualmente
movmode_manual = @(x, k) arrayfun(@(i) mode(x(max(1, i-floor(k/2)):min(length(x), i+floor(k/2)))), 1:length(x));

sinal_moda_3 = movmode_manual(ruido, 3);
sinal_moda_5 = movmode_manual(ruido, 5);

% Estimativa da potência do sinal (suavizado) e do ruído
potencia_total = var(ruido); % Potência total do sinal ruidoso
potencia_ruido_3 = var(ruido - sinal_filtrado_3);
potencia_ruido_5 = var(ruido - sinal_filtrado_5);
potencia_ruido_mediana_3 = var(ruido - sinal_mediana_3);
potencia_ruido_mediana_5 = var(ruido - sinal_mediana_5);
potencia_ruido_moda_3 = var(ruido - sinal_moda_3);
potencia_ruido_moda_5 = var(ruido - sinal_moda_5);

% Calcular SNR antes e depois da filtragem
snr_original = 10 * log10( potencia_total / potencia_total );
snr_filtro_3 = 10 * log10( potencia_total / potencia_ruido_3 );
snr_filtro_5 = 10 * log10( potencia_total / potencia_ruido_5 );
snr_mediana_3 = 10 * log10( potencia_total / potencia_ruido_mediana_3 );
snr_mediana_5 = 10 * log10( potencia_total / potencia_ruido_mediana_5 );
snr_moda_3 = 10 * log10( potencia_total / potencia_ruido_moda_3 );
snr_moda_5 = 10 * log10( potencia_total / potencia_ruido_moda_5 );

% Exibir resultados
fprintf('SNR original: %.2f dB\n', snr_original);
fprintf('SNR após filtro com janela 3: %.2f dB\n', snr_filtro_3);
fprintf('SNR após filtro com janela 5: %.2f dB\n', snr_filtro_5);
fprintf('SNR após filtro de mediana com janela 3: %.2f dB\n', snr_mediana_3);
fprintf('SNR após filtro de mediana com janela 5: %.2f dB\n', snr_mediana_5);
fprintf('SNR após filtro de moda com janela 3: %.2f dB\n', snr_moda_3);
fprintf('SNR após filtro de moda com janela 5: %.2f dB\n', snr_moda_5);

% Plot dos sinais
t = (0:length(ruido)-1) / fs; % Eixo de tempo

figure;
plot(t, ruido);
title('Sinal Ruidoso Original (1s)');
xlabel('Tempo (s)'); ylabel('Amplitude');
saveas(gcf, 'sinal_ruidoso.png');

figure;
plot(t, sinal_filtrado_3);
title('Sinal Após Filtro de Médias Móveis (Janela 3)');
xlabel('Tempo (s)'); ylabel('Amplitude');
saveas(gcf, 'sinal_filtro_3.png');

figure;
plot(t, sinal_filtrado_5);
title('Sinal Após Filtro de Médias Móveis (Janela 5)');
xlabel('Tempo (s)'); ylabel('Amplitude');
saveas(gcf, 'sinal_filtro_5.png');

figure;
plot(t, sinal_mediana_3);
title('Sinal Após Filtro de Mediana Móvel (Janela 3)');
xlabel('Tempo (s)'); ylabel('Amplitude');
saveas(gcf, 'sinal_mediana_3.png');

figure;
plot(t, sinal_mediana_5);
title('Sinal Após Filtro de Mediana Móvel (Janela 5)');
xlabel('Tempo (s)'); ylabel('Amplitude');
saveas(gcf, 'sinal_mediana_5.png');

figure;
plot(t, sinal_moda_3);
title('Sinal Após Filtro de Moda Móvel (Janela 3)');
xlabel('Tempo (s)'); ylabel('Amplitude');
saveas(gcf, 'sinal_moda_3.png');

figure;
plot(t, sinal_moda_5);
title('Sinal Após Filtro de Moda Móvel (Janela 5)');
xlabel('Tempo (s)'); ylabel('Amplitude');
saveas(gcf, 'sinal_moda_5.png');
