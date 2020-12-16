%% notes 
% GOP must include all powers

%% Welcome Message
disp("Welcome to 'The General Signal Generator' project.");

%% Sampling Frequency
sampling_ferq = input(sprintf("Define sampling frequency: \t"));
if sampling_ferq <= 0
    while sampling_ferq <= 0
         fprintf("\t*** Invalid Input ***\t\n");
         sampling_ferq = input(sprintf("Define sampling frequency: \t"));
    end
end

%% Start & End time
start_time = input(sprintf("Define start time: \t"));
end_time = input(sprintf("Define end time: \t"));
if (end_time - start_time) * sampling_ferq < 2                  % make sure there will be at least 3 samples
    while (end_time - start_time) * sampling_ferq < 2
        fprintf("\t*** Invalid Input ***\t\n");
        end_time = input(sprintf("Define end time  : \t"));
    end
end

%% Break Points
bp_number = input(sprintf("Break points number: \t"));
if is_not_valid_bpnum( bp_number, start_time, end_time, sampling_ferq)
    while is_not_valid_bpnum( bp_number, start_time, end_time, sampling_ferq)
        fprintf("\t*** Invalid Input ***\t\n");
        bp_number = input(sprintf("Break points number: \t"));
    end
end

bp_times = start_time * ones(1, bp_number);
t_prev = start_time;
for j = 1: bp_number
    t_bp_time = input(sprintf("Break point #%d time: \t", j));
    t_bp_time = allign_to_sample_point(t_bp_time, sampling_ferq);
    if is_not_valid_pbtime(t_bp_time, t_prev, end_time, sampling_ferq, bp_number-j)
        while is_not_valid_pbtime(t_bp_time, t_prev, end_time, sampling_ferq, bp_number-j)
            fprintf("\t*** Invalid Input ***\t\n");
            t_bp_time = input(sprintf("Break point #%d time: \t", j));
            t_bp_time = allign_to_sample_point(t_bp_time, sampling_ferq);
        end
    end
    bp_times(j) = t_bp_time;
    t_prev = t_bp_time;
end
time_points = [ start_time      bp_times     end_time];

%% Signal Definitions
fprintf("\n\t++++ Signal Definition Rules ++++\t\n");
lin_spaces = cell(1,length(time_points)-1) ;                                                                                       % to hold t linspace for each definition
function_points = cell(1,length(time_points)-1) ;                                                                                % to hold x[t] values for each definition

for j = 1 : length(time_points)-1
    % create linspace
    t_start = time_points(j);
    t_end = time_points(j+1);
    lin_spaces{j} = linspace(t_start , t_end, ( t_end - t_start ) * sampling_ferq + 1); 
    
    % get definition rule
    fprintf("\nChoose a definition rule for region #%d , [ %d , %d ]\n", j ,t_start ,t_end);
    fprintf("1)\t DC Signal. \n");
    fprintf("2)\t Ramp Signal. \n");
    fprintf("3)\t GOP Signal. \n");
    fprintf("4)\t Exponential Signal. \n");
    fprintf("5)\t Sinusoidal Signal. \n");
    t_select = input(sprintf("Choose [1 ~ 5]:\t"));
    if t_select < 1 | t_select > 5 | round(t_select) ~= t_select
        while t_select < 1 | t_select > 5 | round(t_select) ~= t_select
            fprintf("\t*** Invalid Input ***\t\n");
            t_select = input(sprintf("Choose [1 ~ 5]:\t"));
        end
    end
    
    % get definition rule parameters
    switch t_select
        case 1
            t_A = input(sprintf("DC Signal Amplitude:\t"));
            function_points{j} = t_A + 0 * lin_spaces{j};
        case 2
            t_M = input(sprintf("Ramp Signal Slope:\t"));
            t_B = input(sprintf("Ramp Signal Intercept:\t"));
            function_points{j} = t_M * lin_spaces{j} + t_B;
        case 3
            t_O = input(sprintf("GOP Signal Order:\t"));
            if t_O < 1 | t_O ~= round(t_O)
                while t_O < 1 | t_O ~= round(t_O)
                    fprintf("\t*** Invalid Input ***\t\n");
                    t_O = input(sprintf("GOP Signal Order:\t"));
                end
            end
            function_points{j} = zeros(1, length(lin_spaces{j}));
            for k = t_O:-1:1
                t_A = input(sprintf("t^%d Amplitude:\t", k));
                function_points{j} = function_points{j} + t_A * lin_spaces{j} .^ k ;
            end
            t_B = input(sprintf("GOP Signal Intercept:\t"));
            function_points{j} = function_points{j} + t_B;
        case 4
            t_A = input(sprintf("Exponential Signal Amplitude:\t"));
            t_E = input(sprintf("Exponential Signal Exponent:\t"));
            function_points{j} = t_A * exp( t_E * lin_spaces{j});
        case 5
            t_A = input(sprintf("Sinusoidal Signal Amplitude:\t"));
            t_F = input(sprintf("Sinusoidal Signal Frequency:\t"));
            if t_F <=0
                while t_F <=0
                    fprintf("\t*** Invalid Input ***\t\n");
                    t_F = input(sprintf("Sinusoidal Signal Frequency:\t"));
                end
            end
            t_P = input(sprintf("Sinusoidal Signal Phase:\t"));
            function_points{j} = t_A * sin( 2 * pi * t_F * lin_spaces{j} + t_P);
    end
end

%% Draw and Display
t = [ ];
for j = 1 : length(lin_spaces)
    t = [ t lin_spaces{j}(1:end-1) ];
end
 t = [ t lin_spaces{end}(end) ];
 
x = [ ];
for j = 1 : length(function_points)
    x = [ x function_points{j}(1:end-1) ];
end
x = [ x function_points{end}(end) ];

figure('NumberTitle', 'off', 'Name', 'Original Signal');
plot(t, x); hold on; stem(t,x);

%% Signal Operations
fprintf("\n\t++++ Signal Operations ++++\t\n");
fprintf("\nChoose a  signal operation to be performed: \n");
fprintf("1)\t Amplitude Scaling. \n");
fprintf("2)\t Time Reversal. \n");
fprintf("3)\t Time shift. \n");
fprintf("4)\t Expanding the signal. \n");
fprintf("5)\t Compressing the signal. \n");
fprintf("6)\t None. \n");
t_select = input(sprintf("Choose [1 ~ 6]:\t"));
if t_select < 1 | t_select > 6 | round(t_select) ~= t_select
    while t_select < 1 | t_select > 6 | round(t_select) ~= t_select
        fprintf("\t*** Invalid Input ***\t\n");
        t_select = input(sprintf("Choose [1 ~ 6]:\t"));
    end
end

draw_new = 1;                                                   % a flag to rise if user asks for new modified signal
switch t_select
    case 1
        t_S = input(sprintf("Scale Value:\t"));
        x = t_S * x;
    case 2
        t = -t;
    case 3
        t_SH = input(sprintf("Shift Value 'X[ t - T ]':\t"));
        t = t + t_SH ;
    case 4
        t_E = input(sprintf("Expanding Value ']0 , 1[' :\t"));
        if t_E <=0 | t_E >=1
            while t_E <=0 | t_E >=1
                fprintf("\t*** Invalid Input ***\t\n");
                t_E = input(sprintf("Expanding Value ']0 , 1[' :\t"));
            end
        end
        t = t / t_E ;
    case 5
        t_C = input(sprintf("Compressing Value ']1 , inf[' :\t"));
        if t_C <=0 | t_C >=1
            while t_C <=1
                fprintf("\t*** Invalid Input ***\t\n");
                t_C = input(sprintf("Compressing Value ']1 , inf[' :\t"));
            end
        end
        t = t / t_C ;
    case 6
        draw_new = 0;
end

if draw_new == 1
    figure('NumberTitle', 'off', 'Name', 'Modified Signal');
    plot(t, x); hold on; stem(t, x);
end


%% Local Functons
function y = is_not_valid_bpnum(bpnum, start, end_, sf)
    y =  bpnum < 0 ...                                                        % negative
          | round(bpnum) ~= bpnum...                                % non integer
          | bpnum > (1/3 * (sf * (end_ - start) +1) -1);        % exceeds max value 
end

function y = allign_to_sample_point(pbtime, sf)
     y = pbtime;
    if pbtime * sf ~= round(pbtime * sf)
        y = ceil(pbtime * sf) / sf;
    end
    fprintf("|| Alligned to sample point at time %d\n", y);
end

function y = is_not_valid_pbtime( pbtime, prev_time, end_, sf, lpn)             % lpn: later points number
    y =  pbtime <= prev_time | pbtime >= end_...          % out of range
         | (pbtime - prev_time) * sf < 3 ...                           % not enough sample before
         | ( end_ - pbtime) * sf +1 < (lpn + 1) * 3  ...           % not enough samle after
            ;
end