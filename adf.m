% Parámetros iniciales
thresholds_dB = [3, 5, 10, 20]; % Umbrales en dB
thresholds = 10.^(thresholds_dB / 10); % Convertir de dB a unidades lineales
sampling_rate = 1000; % Frecuencia de muestreo (ajustable)
time_step = 1 / sampling_rate; % Intervalo de tiempo entre muestras
 
% Inicialización para almacenar resultados de AFD
AFD_results = zeros(length(K_values), length(thresholds));
 
for i = 1:length(K_values)
    r = r_values{i}; % Señal simulada para el valor de K actual
 
    for j = 1:length(thresholds)
        threshold = thresholds(j);
 
        % Identificar intervalos donde la señal está por debajo del umbral
        below_threshold = r < threshold;
 
        % Encontrar la duración de cada "fade" o intervalo continuo por debajo del umbral
        fade_durations = [];
        current_fade_duration = 0;
 
        for k = 1:length(below_threshold)
            if below_threshold(k)
                % Acumula la duración si estamos en un fade
                current_fade_duration = current_fade_duration + time_step;
            else
                % Si el fade termina, almacenar la duración y resetear
                if current_fade_duration > 0
                    fade_durations = [fade_durations, current_fade_duration];
                    current_fade_duration = 0;
                end
            end
        end
        % Agregar la última duración si el fade termina al final de la señal
        if current_fade_duration > 0
            fade_durations = [fade_durations, current_fade_duration];
        end
 
        % Calcular el AFD para el umbral actual
        if isempty(fade_durations)
            AFD_results(i, j) = 0; % No hay fades por debajo del umbral
        else
            AFD_results(i, j) = mean(fade_durations); % Promedio de las duraciones de fades
        end
    end
end
 
% Umbrales en dB
thresholds_dB = [3, 5, 10, 20];
 
for j = 1:length(thresholds_dB)
    % Crear una nueva figura para cada umbral
    figure;
    plot(K_values, AFD_results(:, j), '-o');
 
    % Etiquetas y título
    xlabel('Factor K (dB)');
    ylabel('AFD (duración promedio de fade en segundos)');
    title(['AFD vs. Factor K para umbral de potencia ', num2str(thresholds_dB(j)), ' dB']);
 
    % Configuración de la cuadrícula
    grid on;
end