%% PID-Based Temperature Control System

clear; clc; close all;

K = 1.0;
tau = 10.0;
s = tf('s');
G = K / (tau*s + 1);

controllers = {
    'P',   pid(0.8, 0,    0)
    'PI',  pid(0.5, 0.05, 0)
    'PID', pid(0.8, 0.08, 0.5, 0.1)
    };

t = (0:0.05:80)';
r = ones(size(t));
d = zeros(size(t));
d(t >= 30) = -0.2;
r_variable = ones(size(t));
r_variable(t >= 40) = 1.5;

results = struct([]);
figure('Name','Setpoint response'); hold on; grid on;
figure('Name','Disturbance response'); hold on; grid on;
figure('Name','Changing setpoint'); hold on; grid on;

for k = 1:size(controllers,1)
    name = controllers{k,1};
    C = controllers{k,2};
    T = feedback(C*G, 1);
    S = feedback(1, C*G);
    Gd = G*S;

    y_step = step(T, t);
    y_step = y_step(:);
    y_disturbance = lsim(T, r, t) + lsim(Gd, d, t);
    y_variable = lsim(T, r_variable, t);
    info = stepinfo(y_step, t, 1);

    results(k).Controller = name; %#ok<SAGROW>
    results(k).RiseTime_s = info.RiseTime;
    results(k).SettlingTime_s = info.SettlingTime;
    results(k).Overshoot_percent = info.Overshoot;
    results(k).SteadyStateError_C = abs(1 - y_step(end));

    figure(1); plot(t, y_step, 'DisplayName', name);
    figure(2); plot(t, y_disturbance, 'DisplayName', name);
    figure(3); plot(t, y_variable, 'DisplayName', name);
end

figure(1); yline(1, '--k', 'Target');
xlabel('Time (s)'); ylabel('Temperature rise (°C)');
title('Closed-loop unit setpoint step'); legend('Location','best');
figure(2); yline(1, '--k', 'Target before disturbance'); xline(30, ':r', 'Disturbance');
xlabel('Time (s)'); ylabel('Temperature rise (°C)');
title('Response to heater-side disturbance'); legend('Location','best');
figure(3); plot(t, r_variable, '--k', 'DisplayName', 'Setpoint');
xlabel('Time (s)'); ylabel('Temperature rise (°C)');
title('Response to changing setpoint'); legend('Location','best');

metrics = struct2table(results);
disp('Controller comparison metrics:');
disp(metrics);
writetable(metrics, 'controller_metrics.csv');
fprintf('\nSaved controller_metrics.csv in the current folder.\n');
