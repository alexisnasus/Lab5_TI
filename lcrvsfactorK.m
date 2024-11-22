% Umbrales en dB
thresholds_dB = [3, 5, 10, 20];
thresholds = 10.^(thresholds_dB / 10); % Convertir de dB a unidades lineales
sampling_rate = 1000; % Frecuencia de muestreo (ajustable)
 
% Inicialización para almacenar resultados de LCR
LCR_results = zeros(length(K_values), length(thresholds));
 
for i = 1:length(K_values)
    r = r_values{i}; % Señal simulada para el valor de K actual
 
    % Derivada temporal aproximada de la señal
    dr_dt = diff(r) * sampling_rate;
 
    for j = 1:length(thresholds)
        threshold = thresholds(j);
 
        % Identificar cruces en dirección ascendente
        crossings = (r(1:end-1) < threshold) & (r(2:end) >= threshold) & (dr_dt > 0);
 
        % Calcular LCR como número de cruces por segundo
        LCR_results(i, j) = sum(crossings) / (N / sampling_rate);
    end
end
 
% Gráfico de LCR vs. Factor K para cada umbral
figure;
hold on;
for j = 1:length(thresholds_dB)
    plot(K_values, LCR_results(:, j), '-o', 'DisplayName', [num2str(thresholds_dB(j)) ' dB']);
end
xlabel('Factor K (dB)');
ylabel('LCR (cruces por segundo)');
title('LCR vs. Factor K para diferentes umbrales de potencia');
legend('show');
grid on;
hold off;