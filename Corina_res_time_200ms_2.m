n = count; % Data is the experimental data vector - you might need to use the "load" function to load the file
frames = 298; % Number of frames in the video
n = [n;zeros(frames-2-length(n),1)]';   
exp_time = 0.2; % Exposure time, in seconds
L = frames*exp_time; % Total movie time, in seconds
time_vec = (1:frames)*0.2; 
time_vec = time_vec(2:end-1); % Truncates the time vector to exclude the first and last frames
P = zeros(length(time_vec),1);
Z = sum(n.*(1./(1-time_vec/L))); % Normalization factor

for i = 1:length(time_vec)
P(i) = sum(n(i:end).*(1./(1-time_vec(i:end)/L)))/Z;
end

P = P(1:length(count));