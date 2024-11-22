% Parámetros
r = linspace(0, 2, 1000); % Rango bajo de amplitud de señal
sigma = 1; % Desviación estándar del componente difuso
K_values = [0, 10, 100]; % Valores de K
 
% Cálculo y graficación de la pendiente de la CDF para cada K en gráficos separados
for i = 1:length(K_values)
    K = K_values(i);
    A = sqrt(2 * K) * sigma; % Amplitud de la componente directa
 
    % Cálculo de la CDF y su derivada (pendiente)
    F_r = 1 - marcumq(A/sigma, r/sigma, 1); % CDF usando la función de Marcum Q
    dF_dr = (1/sigma) * exp(-(A^2 + r.^2) / (2 * sigma^2)) .* besseli(0, (A * r) / sigma^2); % Derivada de la CDF
 
    % Crear una nueva figura para cada valor de K
    figure;
    plot(r, dF_dr, '-o');
 
    % Etiquetas y título del gráfico
    xlabel('Amplitud de la señal recibida (r)');
    ylabel('Pendiente de la CDF');
    title(['Cambio de Pendiente de la CDF para K = ' num2str(K)]);
    grid on;
end