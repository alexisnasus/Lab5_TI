% Parámetros
N = 10000; % Número de muestras
K_values = [0, 10, 100]; % Factores K
sigma = 1; % Desviación estándar del componente difuso
 
% Vector de amplitud dominante A en función de K
A_values = sqrt(2 * K_values * sigma^2);
 
% Inicialización para almacenar datos
r_values = cell(1, length(K_values));
 
for i = 1:length(K_values)
    % Componente dominante (LOS) con amplitud A
    A = A_values(i);
 
    % Componente difuso (sin línea de vista - NLOS)
    n_I = sigma * randn(1, N); % Componente en fase
    n_Q = sigma * randn(1, N); % Componente en cuadratura
 
    % Señal recibida (envolvente de Rice)
    r = sqrt((A + n_I).^2 + n_Q.^2);
    r_values{i} = r;
end
 
% Gráficos de la CDF
figure;
hold on;
for i = 1:length(K_values)
    [f, x] = ecdf(r_values{i});
    plot(x, f, 'DisplayName', ['K = ' num2str(K_values(i))]);
end
 
xlabel('Amplitud de la señal recibida');
ylabel('CDF');
title('CDF de la señal recibida para diferentes valores de K');
legend('show');
grid on;
hold off;