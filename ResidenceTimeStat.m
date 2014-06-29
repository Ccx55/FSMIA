function count = ResidenceTimeStat(traj,varargin)
% RESIDENCETIMESTAT calculate the distribution of residence time.
%   Output include:
%       residence_time: residence time.
%       count: number of trajectories corresponding to specific residence time.
%   Parameters include:
%       traj: input trajectory data.
N = length(traj);
reside = zeros(N,1);
for i = 1:N
    reside(i) = length(traj(i).trajectory);
end
% default bin edges
edges = (min(reside)-0.5):1:(max(reside)+0.5);

for pair = reshape(varargin,2,[])
    if strcmpi(pair{1},'ExposureTime')
        exposure = pair{2};
    end
    if strcmpi(pair{1},'Bin')
        edges = pair{2};
    end
end

count = histc(reside,edges);