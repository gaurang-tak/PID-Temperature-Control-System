%% Generate a graphical Simulink temperature-control model
% Requires Simulink. Re-running replaces the generated model file.

clear; clc;

controllerType = 'PI'; % Change to 'P' or 'PID' and rerun to compare
Kp = 0.5;
Ki = 0.05;
Kd = 0.0;
if strcmpi(controllerType, 'P')
    Kp = 0.8; Ki = 0; Kd = 0;
elseif strcmpi(controllerType, 'PID')
    Kp = 0.8; Ki = 0.08; Kd = 0.5;
end

model = 'temperature_control';
if bdIsLoaded(model)
    close_system(model, 0);
end
new_system(model);

add_block('simulink/Sources/Step', [model '/Setpoint'], ...
    'Position', [40 70 70 100], 'Time', '0', 'Before', '0', 'After', '1');
add_block('simulink/Math Operations/Sum', [model '/Error'], ...
    'Position', [130 65 155 105], 'Inputs', '+-');
add_block('simulink/Continuous/PID Controller', [model '/Controller'], ...
    'Position', [205 65 280 105], 'P', 'Kp', 'I', 'Ki', 'D', 'Kd');
add_block('simulink/Sources/Step', [model '/Disturbance'], ...
    'Position', [205 160 235 190], 'Time', '30', 'Before', '0', 'After', '-0.2');
add_block('simulink/Math Operations/Sum', [model '/Heater input'], ...
    'Position', [330 75 355 125], 'Inputs', '++');
add_block('simulink/Continuous/Transfer Fcn', [model '/Thermal plant'], ...
    'Position', [415 80 500 120], 'Numerator', '[1]', 'Denominator', '[10 1]');
add_block('simulink/Sinks/Scope', [model '/Temperature scope'], ...
    'Position', [570 75 600 105]);

set_param(model, 'StopTime', '80');
add_line(model, 'Setpoint/1', 'Error/1');
add_line(model, 'Error/1', 'Controller/1');
add_line(model, 'Controller/1', 'Heater input/1');
add_line(model, 'Disturbance/1', 'Heater input/2');
add_line(model, 'Heater input/1', 'Thermal plant/1');
add_line(model, 'Thermal plant/1', 'Error/2', 'autorouting', 'on');
add_line(model, 'Thermal plant/1', 'Temperature scope/1', 'autorouting', 'on');

save_system(model, fullfile(pwd, [model '.slx']));
open_system(model);
fprintf('Created %s.slx with a %s controller.\n', model, controllerType);
