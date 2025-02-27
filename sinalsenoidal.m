% Parâmetros do sinal
f = 50;            % Frequência do sinal (Hz)
fs = 1000;         % Frequência de amostragem (Hz)
t = 0:1/fs:0.4;    % Vetor de tempo de 0 a 0,4 segundos
A = 1;             % Amplitude do sinal senoidal

% Sinal senoidal
sinal_senoidal = A * sin(2 * pi * f * t);

% Gerando ruído (ruído gaussiano branco)
ruido = 0.1 * randn(size(t));  % Desvio padrão do ruído ajustável

% Sinal com ruído
sinal_com_ruido = sinal_senoidal + ruido;

% Filtros de médias móveis
filtro3 = ones(1, 3) / 3;  % Filtro de média móvel de tamanho 3
filtro5 = ones(1, 5) / 5;  % Filtro de média móvel de tamanho 5
filtro7 = ones(1, 7) / 7;  % Filtro de média móvel de tamanho 7

% Aplicando os filtros de média móvel
sinal_filtrado_3 = filter(filtro3, 1, sinal_com_ruido);
sinal_filtrado_5 = filter(filtro5, 1, sinal_com_ruido);
sinal_filtrado_7 = filter(filtro7, 1, sinal_com_ruido);

% Aplicando os filtros de mediana móvel
sinal_mediana_3 = movmedian(sinal_com_ruido, 3);
sinal_mediana_5 = movmedian(sinal_com_ruido, 5);
sinal_mediana_7 = movmedian(sinal_com_ruido, 7);

% Implementando a moda móvel
movmoda = @(x, k) arrayfun(@(i) mode(x(max(1, i-floor(k/2)):min(length(x), i+floor(k/2)))), 1:length(x));

sinal_moda_3 = movmoda(sinal_com_ruido, 3);
sinal_moda_5 = movmoda(sinal_com_ruido, 5);
sinal_moda_7 = movmoda(sinal_com_ruido, 7);

% Função para calcular o SNR (em dB)
SNR = @(sinal_original, sinal_ruido) 10 * log10(sum(sinal_original.^2) / sum((sinal_ruido).^2));

% Calculando o SNR para cada filtro
SNR_senoidal = SNR(sinal_senoidal, ruido);
SNR_3 = SNR(sinal_filtrado_3, ruido);
SNR_5 = SNR(sinal_filtrado_5, ruido);
SNR_7 = SNR(sinal_filtrado_7, ruido);
SNR_mediana_3 = SNR(sinal_mediana_3, ruido);
SNR_mediana_5 = SNR(sinal_mediana_5, ruido);
SNR_mediana_7 = SNR(sinal_mediana_7, ruido);
SNR_moda_3 = SNR(sinal_moda_3, ruido);
SNR_moda_5 = SNR(sinal_moda_5, ruido);
SNR_moda_7 = SNR(sinal_moda_7, ruido);

% Salvando cada gráfico separadamente
figure;
plot(t, sinal_senoidal);
title(['Sinal Senoidal | SNR =', num2str(SNR_senoidal, '%.2f'), 'dB']);
xlabel('Tempo (s)');
ylabel('Amplitude');
saveas(gcf, 'sinal_senoidal.png');

figure;
plot(t, sinal_com_ruido);
title(['Sinal com Ruído | SNR = 1.00dB']) ;
xlabel('Tempo (s)');
ylabel('Amplitude');
saveas(gcf, 'sinal_com_ruido.png');

figure;
plot(t, sinal_filtrado_3);
title(['Sinal Filtrado - Média Móvel (Tamanho 3) | SNR = ', num2str(SNR_3, '%.2f'), ' dB']);
xlabel('Tempo (s)');
ylabel('Amplitude');
saveas(gcf, 'sinal_filtrado_mm_3.png');

figure;
plot(t, sinal_filtrado_5);
title(['Sinal Filtrado - Média Móvel (Tamanho 5) | SNR = ', num2str(SNR_5, '%.2f'), ' dB']);
xlabel('Tempo (s)');
ylabel('Amplitude');
saveas(gcf, 'sinal_filtrado_mm_5.png');

figure;
plot(t, sinal_filtrado_7);
title(['Sinal Filtrado - Média Móvel (Tamanho 7) | SNR = ', num2str(SNR_7, '%.2f'), ' dB']);
xlabel('Tempo (s)');
ylabel('Amplitude');
saveas(gcf, 'sinal_filtrado_mm_7.png');

figure;
plot(t, sinal_mediana_3);
title(['Sinal Filtrado - Mediana Móvel (Tamanho 3) | SNR =', num2str(SNR_mediana_3, '%.2f'), 'dB']);
xlabel('Tempo (s)');
ylabel('Amplitude');
saveas(gcf, 'sinal_filtrado_mediana_3.png');

figure;
plot(t, sinal_mediana_5);
title(['Sinal Filtrado - Mediana Móvel (Tamanho 5) | SNR =', num2str(SNR_mediana_5, '%.2f'), 'dB']);
xlabel('Tempo (s)');
ylabel('Amplitude');
saveas(gcf, 'sinal_filtrado_mediana_5.png');

figure;
plot(t, sinal_mediana_7);
title(['Sinal Filtrado - Mediana Móvel (Tamanho 7) | SNR =', num2str(SNR_mediana_7, '%.2f'), 'dB']);
xlabel('Tempo (s)');
ylabel('Amplitude');
saveas(gcf, 'sinal_filtrado_mediana_7.png');

figure;
plot(t, sinal_moda_3);
title(['Sinal Filtrado - Moda Móvel (Tamanho 3) | SNR =', num2str(SNR_moda_3, '%.2f'), 'dB']);
xlabel('Tempo (s)');
ylabel('Amplitude');
saveas(gcf, 'sinal_filtrado_moda_3.png');

figure;
plot(t, sinal_moda_5);
title(['Sinal Filtrado - Moda Móvel (Tamanho 5) | SNR =', num2str(SNR_moda_5, '%.2f'), 'dB']);
xlabel('Tempo (s)');
ylabel('Amplitude');
saveas(gcf, 'sinal_filtrado_moda_5.png');

figure;
plot(t, sinal_moda_7);
title(['Sinal Filtrado - Moda Móvel (Tamanho 7) | SNR =', num2str(SNR_moda_7, '%.2f'), 'dB']);
xlabel('Tempo (s)');
ylabel('Amplitude');
saveas(gcf, 'sinal_filtrado_moda_7.png');

% Exibindo o SNR para todos os filtros no terminal
disp('--- Relação Sinal-Ruído (SNR) ---');
disp(['SNR do filtro de tamanho 3: ', num2str(SNR_3, '%.2f'), ' dB']);
disp(['SNR do filtro de tamanho 5: ', num2str(SNR_5, '%.2f'), ' dB']);
disp(['SNR do filtro de tamanho 7: ', num2str(SNR_7, '%.2f'), ' dB']);
disp(['SNR da mediana móvel de tamanho 3: ', num2str(SNR_mediana_3, '%.2f'), ' dB']);
disp(['SNR da mediana móvel de tamanho 5: ', num2str(SNR_mediana_5, '%.2f'), ' dB']);
disp(['SNR da mediana móvel de tamanho 7: ', num2str(SNR_mediana_7, '%.2f'), ' dB']);
disp(['SNR da moda móvel de tamanho 3: ', num2str(SNR_moda_3, '%.2f'), ' dB']);
disp(['SNR da moda móvel de tamanho 5: ', num2str(SNR_moda_5, '%.2f'), ' dB']);
disp(['SNR da moda móvel de tamanho 7: ', num2str(SNR_moda_7, '%.2f'), ' dB']);
